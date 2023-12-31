import 'package:flutter/material.dart';
import 'package:flutter_advanced_topics/src/domain/entities/auth/sign_in_response.dart';

@immutable
abstract class LoginState {}

class LoginInitial extends LoginState {}

class LoginEmailNotValidState extends LoginState {
  final String errorMassage;

  LoginEmailNotValidState({required this.errorMassage});
}

class LoginEmailValidState extends LoginState {}

class LoginPasswordNotValidState extends LoginState {
  final String errorMassage;

  LoginPasswordNotValidState({required this.errorMassage});
}

class LoginPasswordValidState extends LoginState {}

class LoginPasswordEmptyState extends LoginState {
  String errorMassage;
  LoginPasswordEmptyState({required this.errorMassage});
}

class LoginPasswordHasLowerCaseState extends LoginState {}

class LoginPasswordHasUpperCaseState extends LoginState {}

class LoginPasswordHasNumberState extends LoginState {}

class LoginPasswordHasSpecialCharactersState extends LoginState {}

class LoginPasswordHasMinLengthState extends LoginState {}

class LoginPasswordNotEmptyState extends LoginState {
  String errorMassage;
  LoginPasswordNotEmptyState({required this.errorMassage});
}

class LoginPasswordNotHasLowerCaseState extends LoginState {}

class LoginPasswordNotHasUpperCaseState extends LoginState {}

class LoginPasswordNotHasNumberState extends LoginState {}

class LoginPasswordNotHasSpecialCharactersState extends LoginState {}

class LoginPasswordNotHasMinLengthState extends LoginState {}

class LoginPopState extends LoginState {}

class LoginNavigateToForgetPasswordState extends LoginState {}

class SignInLoadingState extends LoginState {}

class SignInSuccessState extends LoginState {
  SignIn signIn;
  SignInSuccessState({required this.signIn});
}

class SignInFailApiState extends LoginState {
  final String errorMassage;

  SignInFailApiState({required this.errorMassage});
}
