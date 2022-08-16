import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:repo_packages/repo_packakges.dart';
import 'package:trivia_expert_app/high_score_repo/high_score_repo.dart';
import 'leaderboard_event.dart';
import 'leaderboard_state.dart';

class LeaderBoardBloc extends Bloc<LeaderBoardEvent, LeaderBoardState> {
  LeaderBoardBloc({required GameRepository gameRepository,}) :
        _highScoreRepo = gameRepository,
        super(LeaderBoardState()) {
    _streamGameScores = _highScoreRepo.getLeaderBoard().listen((event) {
      add(CreateLeaderBoard(event));
    });
  }
  StreamSubscription? _streamGameScores;
  GameRepository _highScoreRepo;

  @override
  Stream<LeaderBoardState> mapEventToState(LeaderBoardEvent event) async* {
    if (event is CreateLeaderBoard) {
      yield _createLeaderBoard(event);
    }
    if (event is GetUserId) {
      yield _getPosition(event.id);
    }


  }

  LeaderBoardState _createLeaderBoard(CreateLeaderBoard event) {

    return state.copyWith(gameScores: event.gameScores, leaderBoardStatus: event.gameScores.isNotEmpty ? LeaderBoardStatus.fetched : LeaderBoardStatus.failed);
  }

  LeaderBoardState _getPosition(String id) {
    var gamers = state.gameScores;
    var position = 0;
    if (gamers.isNotEmpty) for(int i = 0; i < gamers.length; i++) {
      if (gamers[i]['id'] == id) position =  i + 1;
    }
    return state.copyWith(position: position);
  }



  @override
  Future<Function> close() {
    _streamGameScores?.cancel();
    return super.close().then((value) => value as Function);
  }
}