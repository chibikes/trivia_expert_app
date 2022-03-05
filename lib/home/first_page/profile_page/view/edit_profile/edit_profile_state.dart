part of 'edit_profile_cubit.dart';

class EditProfileState extends Equatable {
  final Email email;
  final Password password;
  final String firstName;
  final String lastName;
  final FormzStatus status;

  EditProfileState(this.email, this.password, this.firstName, this.lastName, this.status);

  @override
  List<Object?> get props => [];





}