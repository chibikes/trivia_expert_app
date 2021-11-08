import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:repo_packages/repo_packakges.dart' as repo;
import 'models/gamestate.dart';
import 'models/models.dart';

class UserRepository {
  Stream<repo.User?> getUser(
      String id, repo.AuthenticationRepository _authenticationRepository) {
    try {
      return FirebaseFirestore.instance
          .collection('users')
          .doc(id)
          .snapshots()
          .map((event) => User.fromMap(event.data()!));
    } catch (e) {
      print('Error : $e');
      return _authenticationRepository.user;
    }
  }

  Future<void> updateUser(repo.User user) {
    return FirebaseFirestore.instance
        .collection('users')
        .doc(user.id)
        .update(user.toMap());
  }
}

class GameStateRepository {
  final gameStateCollection =
      FirebaseFirestore.instance.collection('gamestates');

  Stream<List<GameState?>> getGameStates(repo.User user) {
    try {
      return gameStateCollection
          .where('sessionID', whereIn: [user.gameIds])
          .snapshots()
          .map((snapshot) {
            checkForRequestedGameSess(user);
            return snapshot.docs
                .map((e) => GameState.fromMap(e.data()))
                .toList();
          });
    } catch (e) {
      print('Error : $e');
      return Stream.value(List.filled(5, GameState.empty));
    }
  }

  Stream<GameState?> startNewGameSession(repo.User user) {
    try {
      GameState gameState = GameState.name(
          sessionID: null,
          creatorId: user.id,
          timeCreated: DateTime.now().toUtc().toString(),
          player1:
              repo.Player(id: user.id, name: user.name, photo: user.photo)); /// player 2 becomes null, what to do?
      gameStateCollection.add(gameState.toMap()).then((value) => gameState.copyWith(sessionId: value.id));
      return gameStateCollection
          .where('creatorId', isEqualTo: user.id)
          .where('requestAccepted', isEqualTo: false)
          .orderBy('timeCreated')
          .limit(1)
          .snapshots()
          .map((snapshot) {
        snapshot.docs.map((e) {
          gameState = GameState.fromMap(e.data());
        });
        return gameState;
      });
    } catch (e) {
      print('Error : $e');
      return Stream.value(GameState.name());
    }
  }

  Future<GameState> createNewGameSession(repo.User user) async {
    User user2 = await searchForAvailablePlayer();
    Player player2 = Player(id: user2.id, name: user2.name, photo: user2.photo);
    GameState gameState = GameState.name(
      creatorId: user.id,
      timeCreated: DateTime.now().toUtc().toString(),
      player1: Player(id: user.id, name: user.name, photo: user.photo),
      player2: player2,
    );
    gameStateCollection.add(gameState.toMap()).then((value) =>
        gameState.copyWith(sessionId: value.id));
    return gameState;
  }

  Future<void> updateGameState(GameState state) {
    return gameStateCollection
        .doc(state.sessionID)
        .update(state.toMap())
        .onError((error, stackTrace) => throw (''));
  }

  Future<GameState> searchAvailableGameSessions(
      repo.User user, int gameNo) async {
    GameState gameState = GameState.empty;
    try {
      await gameStateCollection
          .where('creatorId', isNotEqualTo: user.id)
          .where('requestAccepted', isEqualTo: false)
          .limit(50)
          .get()
          .then((snapshot) {
        for (int i = 0; i < snapshot.docs.length; i++) {
          try {
            String id = snapshot.docs[i].id;
            Map<String, dynamic> docs = snapshot.docs[i] as Map<String,
                dynamic>;

            gameState = GameState.fromMap(docs);
            gameState.copyWith(
                requestAccepted: true,
                player2: Player(
                    id: user.id, name: user.name, photo: user.photo),
                sessionId: id);
            updateGameState(gameState).then((value) {
              return gameState;
            });
          } catch (e) {
            if (i == snapshot.docs.length - 1) {
              break;
            }
          }
        }
      });
      return gameState;
    } catch (e) {
      return gameState;
    }
  }

  Future<void> checkForRequestedGameSess(repo.User user) { // all you have to do is add usergameIds here. c'est fini. so what listens to you?
    return gameStateCollection
        .where('playerTwo', isEqualTo: user.id)
        .orderBy('timeCreated')
        .where('requestAccepted', isEqualTo: false)
        .limit(10)
        .get()
        .then((QuerySnapshot snapshot) {
      snapshot.docs.forEach((doc) {
        if (user.gameIds!.length != 5 && !user.gameIds!.contains(doc.id)) {
          GameState gameState = GameState.name(
            rounds: doc["rounds"],
            tTL: doc["tTL"],
            player1: doc["playerOne"],
            player2: Player(
              id: user.id,
              name: user.name,
              photo: user.photo,
            ),
            sessionID: doc.id,
          );
          updateGameState(gameState).then((value) {
            for(int i=0;  i< user.gameIds!.length; i++) {
              if(user.gameIds![i] == '') user.gameIds![i] = gameState.sessionID!;
              break;
            }

            /// update the time
          });
        }
      });
      UserRepository().updateUser(user);
    });
  }

  Future<User> searchForAvailablePlayer() async {
    User user = User.empty;
    await FirebaseFirestore.instance
        .collection('users')
        // .orderBy('lastOnlineInteraction')
        // .where('maxGamesReached', isEqualTo: false)
        // .where('id', isNotEqualTo: user.id)
        .limit(1)
        .get()
        .then((value) {
      value.docs.forEach((doc) {
        user = User.fromMap(doc.data());
      });
    });
    return user;
  }

  Future<void> deleteGameState(GameState gameState) {
    return gameStateCollection
        .doc(gameState.sessionID)
        .delete();
  }
  Future<void> updateUserGameStats(GameState gameState) {
    return gameStateCollection
        .doc(gameState.sessionID)
        .update(gameState.toMap());
  }
}
