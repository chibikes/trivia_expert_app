// part of 'game_play_cubit.dart';
//
// enum GameStatus {
//   online_single_player,
//   multi_player,
//   offline_single_player,
//   game_end,
// }
//
// class GamePlayState extends Equatable {
//   final GameStatus gameStatus;
//   final GameState? gameState;
//   // final Timer? timer;
//   final int? secondsRemaining;
//   final int? totalTime;
//   final List<Color> colors;
//   final String? correctAnswer;
//   final int? qAnswered;
//   final listBol = [true, true, true, true];
//   final bool? isButtonTapped;
//   final int? index;
//
//   GamePlayState copyWith(
//       {GameStatus? gameStatus,
//       GameState? gameState,
//       Timer? timer,
//       int? secondsRemaining,
//       int? totalTime,
//       String? correctAnswer,
//       int? index,
//       List<Color>? colors,
//       int? qAnswered,
//       bool? isButtonTapped,
//       List? listBol,}) {
//     return GamePlayState(
//       gameStatus: gameStatus ?? this.gameStatus,
//       gameState: gameState ?? this.gameState,
//       secondsRemaining: secondsRemaining ?? this.secondsRemaining,
//       correctAnswer: correctAnswer ?? this.correctAnswer,
//       totalTime: totalTime ?? this.totalTime,
//       qAnswered: qAnswered! + this.qAnswered!,
//       index: index! + this.index!,
//       colors: colors ?? this.colors,
//       isButtonTapped: isButtonTapped ?? this.isButtonTapped,
//       listBol: listBol ?? this.listBol,
//     );
//   }
//
//   GamePlayState({
//     this.index = 0,
//     this.secondsRemaining = 30,
//     this.totalTime = 30,
//     this.correctAnswer,
//     this.qAnswered = 0,
//     this.gameStatus = GameStatus.online_single_player,
//     this.gameState,
//     this.colors = const [
//       Colors.blue,
//       Colors.blue,
//       Colors.blue,
//       Colors.blue,
//     ],
//     this.isButtonTapped = false,
//     List? listBol,
//   });
//   @override
//   List<Object?> get props => [gameState, gameStatus, secondsRemaining, totalTime, index, isButtonTapped];
// }
