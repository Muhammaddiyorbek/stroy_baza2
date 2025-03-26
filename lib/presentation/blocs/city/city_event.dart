import 'package:equatable/equatable.dart';
import 'package:stroy_baza/models/city_select.dart';

abstract class CityEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoadCities extends CityEvent {}

class SelectCity extends CityEvent {
  final City city;

  SelectCity(this.city);

  @override
  List<Object?> get props => [city];
}
