part of 'weather_save_location_bloc.dart';

@immutable
abstract class WeatherSaveLocationEvent {}

class LoadSavedLocation extends WeatherSaveLocationEvent {
  LoadSavedLocation();
  List<Object> get props => [];

  @override
  String toString() => 'Saved city initiated - $props';
}

