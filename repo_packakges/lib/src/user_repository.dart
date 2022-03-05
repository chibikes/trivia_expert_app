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
        .update(user.toMap())
        .onError((error, stackTrace) => print('error occured'));
        
  }

  const UserRepository();
}

class GameStateRepository {
  final gameStateCollection =
      FirebaseFirestore.instance.collection('gamestates');

  // Stream<List<GameState?>> getGameStates(repo.User user) {
  //   try {
  //     return gameStateCollection
  //         .where('sessionID', whereIn: [user.gameIds])
  //         .snapshots()
  //         .map((snapshot) {
  //           checkForRequestedGameSess(user);
  //           return snapshot.docs
  //               .map((e) => GameState.fromMap(e.data(), user: user))
  //               .toList();
  //         });
  //   } catch (e) {
  //     print('Error : $e');
  //     return Stream.value(List.filled(5, GameState.empty));
  //   }
  // }

  // Stream<GameState?> startNewGameSession(String id, repo.User user) {
  //   try {
  //       return gameStateCollection /// yield tells it not to close the function
  //       // .where('creatorId', isEqualTo: user.id)
  //       // .where('requestAccepted', isEqualTo: false)
  //       // .orderBy('timeCreated', descending: true)
  //       // .limit(1)
  //       //TODO: remove the above indexes on trivia-ex firebase firestore
  //           .doc(id)
  //           .snapshots()
  //           .map((event) => GameState.fromMap(event.data()!, user: user),);
  //   } catch (e) {
  //     print('Error : $e');
  //     return Stream.value(GameState.name());
  //   }
  // }

  // Future<GameState> FindNewUser(repo.User user) async {
  //   User user2 = await searchForAvailablePlayer();
  //   Player player2 = Player(id: user2.id, name: user2.name, photo: user2.photo);
  //   GameState gameState = GameState.name(
  //     creatorId: user.id,
  //     timeCreated: DateTime.now().toUtc().toString(),
  //     player1: Player(id: user.id, name: user.name, photo: user.photo),
  //     player2: player2,
  //   );
  //   gameStateCollection.add(gameState.toMap()).then((value) =>
  //       gameState.copyWith(sessionId: value.id));
  //   return gameState;
  // }

  Future<void> updateGameState(GameState state) {
    return gameStateCollection
        .doc(state.sessionID)
        .update(state.toMap())
        .onError((error, stackTrace) => throw ('this is an error'));
  }

  // Future<GameState> searchAvailableGameSessions(
  //     repo.User user, int gameNo) async {
  //   GameState gameState = GameState.empty;
  //   try {
  //     await gameStateCollection
  //         // .orderBy('timeCreated')
  //         .where('creatorId', isNotEqualTo: user.id)
  //         .where('requestAccepted', isEqualTo: false)
  //         // .limit(50)
  //         .limit(5)
  //         .get()
  //         .then((snapshot) {
  //         for (int i = 0; i < snapshot.docs.length; i++) {
  //           try {
  //             String id = snapshot.docs[i].id;
  //             Map<String, dynamic> docs = snapshot.docs[i].data();
  //
  //             gameState = GameState.fromMap(docs, user: user);
  //             updateGameState(gameState.copyWith(
  //                 requestAccepted: true,
  //                 player2: Player(
  //                     id: user.id, name: user.name, photo: user.photo),
  //                 sessionId: id)).then((value) {
  //               return gameState;
  //             });
  //           } catch (e) {
  //             print('print *** $e');
  //             if (i == snapshot.docs.length - 1) {
  //               break;
  //             }
  //           }
  //         }
  //     });
  //     return gameState;
  //   } catch (e) {
  //     print('this is the exception ***** $e');
  //     return gameState;
  //   }
  // }

  // Future<void> checkForRequestedGameSess(repo.User user) {
  //   return gameStateCollection
  //       .where('playerTwo', isEqualTo: user.id)
  //       .orderBy('timeCreated')
  //       .where('requestAccepted', isEqualTo: false)
  //       .limit(10)
  //       .get()
  //       .then((QuerySnapshot snapshot) {
  //     snapshot.docs.forEach((doc) {
  //       if (user.gameIds.length != 5 && !user.gameIds.contains(doc.id)) {
  //         GameState gameState = GameState.name(
  //           rounds: doc["rounds"],
  //           tTL: doc["tTL"],
  //           player1: doc["playerOne"],
  //           player2: Player(
  //             id: user.id,
  //             name: user.name,
  //             photo: user.photo,
  //           ),
  //           sessionID: doc.id,
  //         );
  //         updateGameState(gameState).then((value) {
  //           for(int i=0;  i< user.gameIds.length; i++) {
  //             if(user.gameIds[i] == '') user.gameIds[i] = gameState.sessionID!;
  //             break;
  //           }
  //
  //           /// update the time
  //         });
  //       }
  //     });
  //     UserRepository().updateUser(user);
  //   });
  // }

  // Future<User> searchForAvailablePlayer() async {
  //   User user = User.empty;
  //   await FirebaseFirestore.instance
  //       .collection('users')
  //       .orderBy('lastOnlineInteraction', descending: true)
  //       // .where('maxGamesReached', isEqualTo: false)
  //       // .where('id', isNotEqualTo: user.id)
  //       .limit(1)
  //       .get()
  //       .then((value) {
  //     value.docs.forEach((doc) {
  //       user = User.fromMap(doc.data());
  //     });
  //   });
  //   return user;
  // }

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

  Future<String> stubbedFunc(GameState gameState) async{
    return gameStateCollection.add(gameState.toMap()).then((value) => value.id);
  }
}
