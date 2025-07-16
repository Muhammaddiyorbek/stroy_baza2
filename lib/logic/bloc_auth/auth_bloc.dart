import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stroy_baza/core/services/local_storage_helper.dart';
import 'package:stroy_baza/logic/repository/auth_repository.dart';
import 'package:stroy_baza/models/auth_model.dart';

part 'auth_event.dart';

part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final repository = AuthRepository();

  AuthBloc() : super(AuthInitial()) {
    on<SendPhoneEvent>(_onSendPhone);
    on<VerifyPhoneEvent>(_onVerifyPhone);
    on<CheckAuthEvent>(_onCheckAuth);
    on<LogoutEvent>(_onLogout);
    on<UpdateUserEvent>(_onUpdateUser);
  }

  Future<void> _onSendPhone(SendPhoneEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    final result = await repository.sendPhoneNumber(event.phoneNumber, event.isLogin);

    if (result['success']) {
      emit(CodeSentState(phoneNumber: event.phoneNumber));
    } else {
      emit(AuthError(message: result['message']));
    }
  }

  Future<void> _onVerifyPhone(VerifyPhoneEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    final result = await repository.verifyPhone(event.phoneNumber, event.code, event.isLogin);

    if (result['success']) {
      final auth = result['data'] as AuthModel;
      print("salom ${auth.accessToken}");
      if (event.isLogin) {
        final userResult = await repository.getUserInfo();
        if (userResult['success']) {
          log("Storage repo save data: ${auth.accessToken}");
          await StorageRepository.putString("token", "${auth.accessToken}");
          await StorageRepository.putString("refresh", "${auth.refreshToken}");

          if (auth.accessToken == null || auth.refreshToken == null) {
            await repository.clearAuthData();
            emit(UnauthenticatedState());
            return;
          }

          emit(AuthenticatedState(
            user: userResult['data'],
            accessToken: auth.accessToken!,
            refreshToken: auth.refreshToken!,
          ));
        } else {
          emit(AuthError(message: userResult['message']));
        }
      } else {
        emit(VerificationSuccessState(
          phoneNumber: event.phoneNumber,
          message: result['message'],
          accessToken: auth.accessToken,
          refreshToken: auth.refreshToken,
          id: auth.userId,
        ));
      }
    } else {
      emit(AuthError(message: result['message']));
    }
  }

  Future<void> _onCheckAuth(CheckAuthEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    final isAuth = await repository.isAuthenticated();
    if (isAuth) {
      final userResult = await repository.getUserInfo();
      if (userResult['success']) {
        final accessToken = await repository.getAccessToken();
        final refreshToken = await repository.getRefreshToken();

        if (accessToken == null || refreshToken == null) {
          await repository.clearAuthData();
          emit(UnauthenticatedState());
          return;
        }

        emit(AuthenticatedState(
          user: userResult['data'],
          accessToken: accessToken,
          refreshToken: refreshToken,
        ));
      } else {
        emit(UnauthenticatedState());
      }
    } else {
      emit(UnauthenticatedState());
    }
  }

  Future<void> _onLogout(LogoutEvent event, Emitter<AuthState> emit) async {
    await repository.clearAuthData();
    emit(UnauthenticatedState());
  }

  Future<void> _onUpdateUser(UpdateUserEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    final result = await repository.updateUserProfile(
      firstName: event.firstName,
      lastName: event.lastName,
    );

    if (result['success']) {
      emit(ProfileUpdateSuccess());
    } else {
      emit(AuthError(message: result['message']));
    }
  }
}
