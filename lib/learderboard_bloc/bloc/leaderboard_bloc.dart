import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:trivia_expert_app/high_score_repo/high_score_repo.dart';
import 'leaderboard_event.dart';
import 'leaderboard_state.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class LeaderBoardBloc extends Bloc<LeaderBoardEvent, LeaderBoardState> {
  LeaderBoardBloc({
    required GameRepository gameRepository,
  })  : _highScoreRepo = gameRepository,
        super(LeaderBoardState()) {
    _streamGameScores = _highScoreRepo.getLeaderBoard().listen((event) {
      add(CreateLeaderBoard(event));
    });
    _leaderboardTime = _emitTime().listen((event) {
      add(LeaderBoardTime(event));
    });
  }
  StreamSubscription? _streamGameScores;
  StreamSubscription? _leaderboardTime;

  GameRepository _highScoreRepo;

  @override
  Stream<LeaderBoardState> mapEventToState(LeaderBoardEvent event) async* {
    if (event is CreateLeaderBoard) {
      yield* _createLeaderBoard(event);
    } else if (event is GetUserId) {
      yield* _getPosition(event.id);
    }
    if (event is LeaderBoardTime) {
      yield state.copyWith(time: event.time);
    }
  }

  Stream<LeaderBoardState> _createLeaderBoard(CreateLeaderBoard event) async* {
    try {
      yield state.copyWith(
          gameScores: event.gameScores,
          leaderBoardStatus: LeaderBoardStatus.fetched);
    } catch (e) {
      yield state.copyWith(leaderBoardStatus: LeaderBoardStatus.failed);
    }
  }

  Stream<String> _emitTime() async* {
    var utcTime = DateTime.utc(DateTime.now().year);
    String time = '';

    yield* Stream.periodic(Duration(seconds: 1), (int x) {
      //TODO: use server year as anchor
      utcTime = DateTime.now().toUtc();
      if (utcTime.day % 4 == 0) {
        utcTime = utcTime.copyWith(
            hour: 23 - utcTime.hour,
            minute: 59 - utcTime.minute,
            second: 59 - utcTime.second);
        time = utcTime.toIso8601String();
        time = time.substring(11, 19);
      } else {
        var nextLeaderBoard = DateTime.now().toUtc();
        for (int i = 1; i < 10; i++) {
          if (nextLeaderBoard.day % 4 == 0) {
            /// leaderboard ends few days from now
            break;
          }
          nextLeaderBoard = nextLeaderBoard.add(Duration(days: 1));
        }
        int daysLeft = nextLeaderBoard.day - utcTime.day;
        daysLeft == 1 ? time = '1 day' : time = '$daysLeft days';
      }
      return time;
    });
  }

  Stream<LeaderBoardState> _getPosition(String id) async* {
    var gamers = state.gameScores;
    var position = 0;
    if (gamers.isNotEmpty)
      for (int i = 0; i < gamers.length; i++) {
        if (gamers[i]['userId'] == id) {
          position = i + 1;
          break;
        }
      }
    yield state.copyWith(position: position);
  }

  @override
  Future<Function> close() {
    _streamGameScores?.cancel();
    _leaderboardTime?.cancel();
    return super.close().then((value) => value as Function);
  }
}
