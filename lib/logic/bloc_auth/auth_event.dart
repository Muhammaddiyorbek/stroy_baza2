part of 'auth_bloc.dart';

abstract class AuthEvent {}

class SendPhoneEvent extends AuthEvent {
  final String phoneNumber;
  final bool isLogin;
  
  SendPhoneEvent({
    required this.phoneNumber,
    required this.isLogin,
  });
}

class VerifyPhoneEvent extends AuthEvent {
  final String phoneNumber;
  final String code;
  final bool isLogin;

  VerifyPhoneEvent({
    required this.phoneNumber, 
    required this.code,
    required this.isLogin,
  });
}

class CheckAuthEvent extends AuthEvent {}

class LogoutEvent extends AuthEvent {}

class UpdateUserEvent extends AuthEvent {
  final String firstName;
  final String lastName;

  UpdateUserEvent({required this.firstName, required this.lastName});
}