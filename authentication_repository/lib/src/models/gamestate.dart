import 'dart:ffi';

import 'package:equatable/equatable.dart';

import '../../authentication_repository.dart';

/// [GameState.rounds] indicates the round clients are currently playing.
/// Total no of rounds is three
///
/// [GameState.tTL] -> Turn based session, when a gaming session hasn't
/// ended and the TTL(time to live) has expired, the player whose turn it is
/// to play loses that session
class GameState extends Equatable {
  final int? rounds;
  final String? tTL;
  final String? sessionID;
  final String? timeCreated, creatorId;
  final bool requestAccepted;
  final Player? player1, player2;

  static GameState empty = GameState.name();

  GameState.name({
    this.creatorId,
    this.rounds = 0,
    this.tTL = '',
    this.timeCreated,
    this.sessionID = '',
    this.requestAccepted = false,
    this.player1 = Player.empty,
    this.player2 = Player.empty,
  });

  GameState copyWith(
      {int? rounds,
        String? tTL,
        String? sessionId,
        bool? requestAccepted,
        String? timeCreated,
        Player? player1,
        Player? player2, String? creatorId}) {
    return GameState.name(
      sessionID: this.sessionID ?? sessionId,
      rounds: rounds ?? this.rounds,
      tTL: tTL ?? this.tTL,
      requestAccepted: requestAccepted ?? this.requestAccepted,
      player1: player1 ?? this.player1,
      player2: player2 ?? this.player2,
      creatorId: creatorId ?? this.creatorId,
      timeCreated: timeCreated ?? this.timeCreated,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'rounds': rounds,
      'tTL': tTL,
      'sessionID': sessionID,
      'player1': player1!.id == creatorId ? player1!.toMap() : player2!.toMap(),
      'player2': player1!.id != creatorId ? player1!.toMap() : player2!.toMap(),
      'timeCreated': timeCreated,
      'requestAccepted': requestAccepted,
      'creatorId' : creatorId,
    };
  }

  static GameState fromMap(Map<String, dynamic> data,{required User? user}) {
    return GameState.name(
      sessionID: data['sessionID'],
      rounds: data['rounds'],
      tTL: data['tTL'],
      player1: Player.fromMap(data[data['creatorId'] == user!.id ? 'player1' : 'player2']),
      player2: Player.fromMap(data[data['creatorId'] == user.id ? 'player2' : 'player1']),
      timeCreated: data['timeCreated'],
      creatorId: data['creatorId'],
    );
  }

  @override
  // TODO: implement props
  List<Object?> get props => [player1, player2, sessionID, requestAccepted, rounds, tTL];
}

class Player extends User implements Equatable{
  final int? score;
  final int? round;
  final bool? turn;

  const Player(
      {this.round,
        this.turn,
        String? id,
        String? name,
        String? photo,
        this.score = 0})
      : super(id: id, name: name, photoUrl: photo);
  @override
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'photo': photoUrl,
      'score': score,
    };
  }

  @override
  List<Object?> get props => [id, score, round, turn, name, photoUrl, score];

  Player copy({int? score, int? round, bool? turn, String? name, String? photo, String? id}) {
    return Player(
      score: score! + this.score!,
      round: round ?? this.round,
      turn: turn ?? this.turn,
      name: name ?? this.name,
      photo: photo ?? this.photoUrl,
      id: id ?? this.id,

    );
}
  static Player? fromMap(Map<String, dynamic>? data) {
    if(data != null) {
      return Player(
        id: data['id'],
        name: data['name'],
        photo: data['photo'],
        score: data['score'],
      );
    }
    // return Player.empty;
    return null;
  }

  static const empty = Player(id: null, name: null, photo: null, score: 0);
}