abstract class UserAgreementState {}

class UserAgreementInitial extends UserAgreementState {}

class UserAgreementLoading extends UserAgreementState {}

class UserAgreementLoaded extends UserAgreementState {
  final String title;
  final String content;

  UserAgreementLoaded({required this.title, required this.content});
}

class UserAgreementError extends UserAgreementState {
  final String message;
  UserAgreementError(this.message);
}
