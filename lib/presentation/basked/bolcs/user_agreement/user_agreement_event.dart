abstract class UserAgreementEvent {}

class LoadUserAgreement extends UserAgreementEvent {
  final String locale;
  LoadUserAgreement(this.locale);
}
