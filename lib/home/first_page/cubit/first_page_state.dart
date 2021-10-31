
import 'package:equatable/equatable.dart';

enum Status{idle, start_game, change_profile}
class FirstPageState extends Equatable {
  final Status status;

  FirstPageState({this.status = Status.idle});
  @override
  List<Object?> get props => [];

}