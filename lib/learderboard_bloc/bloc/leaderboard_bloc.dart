import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:trivia_expert_app/high_score_repo/high_score_repo.dart';
import 'leaderboard_event.dart';
import 'leaderboard_state.dart';

class LeaderBoardBloc extends Bloc<LeaderBoardEvent, LeaderBoardState> {
  LeaderBoardBloc({required GameRepository gameRepository}) :
        _highScoreRepo = gameRepository,
        super(LeaderBoardState()) {
    _streamGameScores = _highScoreRepo.getLeaderBoard().listen((event) {
      add(GetLeaderBoard(event));
    });
  }
  StreamSubscription? _streamGameScores;
  GameRepository _highScoreRepo;

  @override
  Stream<LeaderBoardState> mapEventToState(LeaderBoardEvent event) async* {
    if (event is GetLeaderBoard) {
      yield state.copyWith(gameScores: event.gameScores);
    }

  }
  void getScores() {
    _streamGameScores;
  }

  @override
  Future<Function> close() {
    _streamGameScores?.cancel();
    return super.close().then((value) => value as Function);
  }
}