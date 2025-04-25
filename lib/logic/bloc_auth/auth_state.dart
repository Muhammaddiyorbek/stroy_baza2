part of 'auth_bloc.dart';

abstract class AuthState {}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class CodeSentState extends AuthState {
  final String phoneNumber;
  CodeSentState({required this.phoneNumber});
}

class AuthenticatedState extends AuthState {
  final UserModel user;
  final String accessToken;
  final String refreshToken;
  
  AuthenticatedState({
    required this.user,
    required this.accessToken,
    required this.refreshToken,
  });
}

class UnauthenticatedState extends AuthState {}

class AuthError extends AuthState {
  final String message;
  AuthError({required this.message});
}

class VerificationSuccessState extends AuthState {
  final String phoneNumber;
  final String message;
  final String? accessToken;
  final String? refreshToken;
  final int? id;

  VerificationSuccessState({
    required this.phoneNumber,
    required this.message,
    this.accessToken,
    this.refreshToken,
    this.id,
  });
}

class ProfileUpdateSuccess extends AuthState {}