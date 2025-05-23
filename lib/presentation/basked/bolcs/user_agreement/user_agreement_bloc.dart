import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stroy_baza/logic/repository/user_agreement_repository.dart';
import 'package:stroy_baza/presentation/basked/bolcs/user_agreement/user_agreement_event.dart';
import 'package:stroy_baza/presentation/basked/bolcs/user_agreement/user_agreement_state.dart';

class UserAgreementBloc extends Bloc<UserAgreementEvent, UserAgreementState> {
  final UserAgreementRepository repository;

  UserAgreementBloc(this.repository) : super(UserAgreementInitial()) {
    on<LoadUserAgreement>((event, emit) async {
      emit(UserAgreementLoading());
      try {
        final agreement = await repository.fetchAgreement(event.locale);
        emit(UserAgreementLoaded(title: agreement.title, content: agreement.content));
      } catch (e) {
        emit(UserAgreementError('Xatolik: ${e.toString()}'));
      }
    });
  }
}
