part of 'password_bloc.dart';

abstract class PasswordEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class GeneratePasswordEvent extends PasswordEvent {
  final int length;
  final bool includeNumbers;
  final bool includeSymbols;
  final bool includeLowercase;
  final bool includeUppercase;

  GeneratePasswordEvent({
    required this.length,
    required this.includeNumbers,
    required this.includeSymbols,
    required this.includeLowercase,
    required this.includeUppercase,
  });

  @override
  List<Object> get props => [length, includeNumbers, includeSymbols, includeLowercase, includeUppercase];
}

class CheckPasswordStrengthEvent extends PasswordEvent {
  final String password;

  CheckPasswordStrengthEvent(this.password);

  @override
  List<Object> get props => [password];
}

class SavePasswordEvent extends PasswordEvent {
  final PasswordData passwordData;

  SavePasswordEvent(this.passwordData);

  @override
  List<Object> get props => [passwordData];
}
class DeletePasswordEvent extends PasswordEvent {
  final int id;

  DeletePasswordEvent(this.id);

  @override
  List<Object> get props => [id];
}
class UpdatePasswordEvent extends PasswordEvent {
  final PasswordData updatedPassword;

  UpdatePasswordEvent(this.updatedPassword);

  @override
  List<Object> get props => [updatedPassword];
}


class LoadPasswordsEvent extends PasswordEvent {}

class ResetPasswordEvent extends PasswordEvent {}
