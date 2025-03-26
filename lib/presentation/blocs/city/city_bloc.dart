import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:stroy_baza/logic/repository/city_responsitory.dart';
import 'package:stroy_baza/presentation/blocs/city/city_event.dart';
import 'package:stroy_baza/presentation/blocs/city/city_state.dart';

class CityBloc extends Bloc<CityEvent, CityState> {
  final CityRepository repository;

  CityBloc(this.repository) : super(const CityState()) {
    on<LoadCities>(_getCities);
    on<SelectCity>(_selectCity);
  }

  FutureOr<void> _getCities(LoadCities event, Emitter<CityState> emit) async {
    emit(state.copyWith(cityStatus: FormzSubmissionStatus.inProgress));

    try {
      final res = await repository.fetchCities();
      if (res.isNotEmpty) {
        emit(state.copyWith(cityStatus: FormzSubmissionStatus.success, cities: res));
      } else {
        emit(state.copyWith(cityStatus: FormzSubmissionStatus.failure, errorMsg: "Shaharlar topilmadi"));
      }
    } catch (e) {
      emit(state.copyWith(cityStatus: FormzSubmissionStatus.failure, errorMsg: "Xatolik: $e"));
    }
  }

  FutureOr<void> _selectCity(SelectCity event, Emitter<CityState> emit) {
    emit(state.copyWith(selectedCity: event.city));
  }
}
