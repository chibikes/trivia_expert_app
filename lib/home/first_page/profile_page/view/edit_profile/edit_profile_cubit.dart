import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:trivia_expert_app/authentication/models/models.dart';
import 'package:trivia_expert_app/home/first_page/profile_page/view/edit_profile/edit_profile.dart';

part 'edit_profile_state.dart';

class EditProfileCubit extends Cubit<EditProfileState> {
  EditProfileCubit(EditProfileState initialState) : super(initialState);

}