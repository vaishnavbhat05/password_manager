import 'dart:math';
import 'dart:ui';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import '../model/password_data.dart';
import '../services/my_database.dart';
part 'password_event.dart';
part 'password_state.dart';

class PasswordBloc extends Bloc<PasswordEvent, PasswordState> {
  final DatabaseHelper dbHelper = DatabaseHelper.instance;
  PasswordBloc() : super(PasswordInitial()) {
    on<GeneratePasswordEvent>(_onGeneratePassword);
    on<CheckPasswordStrengthEvent>(_onCheckPasswordStrength);
    on<SavePasswordEvent>(_onSavePassword);
    on<DeletePasswordEvent>(_onDeletePassword);
    on<LoadPasswordsEvent>(_onLoadPasswords);
    on<UpdatePasswordEvent>(_onUpdatePassword);
    on<ResetPasswordEvent>(_onResetPassword);
  }

  void _onResetPassword(ResetPasswordEvent event, Emitter<PasswordState> emit) {
    emit(PasswordGenerated('', 0.0, Colors.grey));
  }

  void _onGeneratePassword(
      GeneratePasswordEvent event, Emitter<PasswordState> emit) {
    const String lowercaseLetters = 'abcdefghijklmnopqrstuvwxyz';
    const String uppercaseLetters = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';
    const String numbers = '0123456789';
    const String symbols = '!@#\$%^&*()_+-=[]{}|;:,.<>?/';

    String allowedChars = '';
    if (event.includeNumbers) allowedChars += numbers;
    if (event.includeSymbols) allowedChars += symbols;
    if (event.includeLowercase) allowedChars += lowercaseLetters;
    if (event.includeUppercase) allowedChars += uppercaseLetters;

    if (allowedChars.isEmpty) {
      allowedChars = lowercaseLetters;
    }

    Random random = Random();
    String newPassword = List.generate(event.length,
        (index) => allowedChars[random.nextInt(allowedChars.length)]).join();

    double strength = _calculatePasswordStrength(newPassword);

    Color strengthColor;

    if (strength <= 0.3) {
      strengthColor = Colors.red;
    } else if (strength <= 0.7) {
      strengthColor = Colors.orange;
    } else {
      strengthColor = Colors.green;
    }

    emit(PasswordGenerated(newPassword, strength, strengthColor));
  }

  void _onCheckPasswordStrength(
      CheckPasswordStrengthEvent event, Emitter<PasswordState> emit) {
    double strength = _calculatePasswordStrength(event.password);
    Color strengthColor;

    if (strength <= 0.3) {
      strengthColor = Colors.red;
    } else if (strength <= 0.7) {
      strengthColor = Colors.orange;
    } else {
      strengthColor = Colors.green;
    }

    emit(PasswordStrengthUpdated(strength, strengthColor));
  }

  Future<void> _onSavePassword(
      SavePasswordEvent event, Emitter<PasswordState> emit) async {
    await dbHelper.insertPassword(event.passwordData);
    emit(PasswordSaved());
  }

  Future<void> _onDeletePassword(
      DeletePasswordEvent event, Emitter<PasswordState> emit) async {
    await dbHelper.deletePassword(event.id);
    emit(PasswordDeleted());
    final passwords = await dbHelper.getAllPasswords();
    emit(PasswordLoaded(passwords)); // Reload passwords after deletion
  }

  Future<void> _onUpdatePassword(
      UpdatePasswordEvent event, Emitter<PasswordState> emit) async {
    await dbHelper.updatePassword(event.updatedPassword);
    emit(PasswordUpdated());
    final passwords = await dbHelper.getAllPasswords();
    emit(PasswordLoaded(passwords)); // Reload passwords after update
  }

  Future<void> _onLoadPasswords(
      LoadPasswordsEvent event, Emitter<PasswordState> emit) async {
    final passwords = await dbHelper.getAllPasswords();
    emit(PasswordLoaded(passwords));
  }

  double _calculatePasswordStrength(String password) {
    if (password.isEmpty) return 0.0;

    int score = 0;
    if (password.length >= 6) score++;
    if (password.contains(RegExp(r'[A-Z]'))) score++;
    if (password.contains(RegExp(r'[a-z]'))) score++;
    if (password.contains(RegExp(r'[0-9]'))) score++;
    if (password.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) score++;

    return score / 5.0;
  }


}
