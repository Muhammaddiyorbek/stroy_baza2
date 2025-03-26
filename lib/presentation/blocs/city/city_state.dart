import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:stroy_baza/models/city_select.dart';

class CityState extends Equatable {
  final List<City> cities;
  final City? selectedCity;
  final FormzSubmissionStatus cityStatus;
  final String errorMsg;

  const CityState({
    this.cities = const [],
    this.selectedCity,
    this.cityStatus = FormzSubmissionStatus.initial,
    this.errorMsg = '',
  });

  CityState copyWith({
    List<City>? cities,
    City? selectedCity,
    FormzSubmissionStatus? cityStatus,
    String? errorMsg,
  }) {
    return CityState(
      cities: cities ?? this.cities,
      selectedCity: selectedCity ?? this.selectedCity,
      cityStatus: cityStatus ?? this.cityStatus,
      errorMsg: errorMsg ?? this.errorMsg,
    );
  }

  @override
  List<Object?> get props => [cities, selectedCity, cityStatus, errorMsg];
}
