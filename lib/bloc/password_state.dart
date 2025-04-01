part of 'password_bloc.dart';

abstract class PasswordState extends Equatable {
  @override
  List<Object> get props => [];
}

class PasswordInitial extends PasswordState {}

class PasswordGenerated extends PasswordState {
  final String password;
  final double strength;
  final Color strengthColor;

  PasswordGenerated(this.password, this.strength, this.strengthColor);

  @override
  List<Object> get props => [password, strength];
}

class PasswordStrengthUpdated extends PasswordState {
  final double strength;
  final Color strengthColor;

  PasswordStrengthUpdated(this.strength, this.strengthColor);

  @override
  List<Object> get props => [strength, strengthColor];
}

class PasswordLoaded extends PasswordState {
  final List<PasswordData> passwords;

  PasswordLoaded(this.passwords);

  @override
  List<Object> get props => [passwords];
}

class PasswordSaved extends PasswordState {}


class PasswordDeleted extends PasswordState {}

class PasswordUpdated extends PasswordState {}

