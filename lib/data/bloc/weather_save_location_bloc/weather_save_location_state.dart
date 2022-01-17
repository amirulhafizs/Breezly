part of 'weather_save_location_bloc.dart';

@immutable
abstract class WeatherSaveLocationState {}

class WeatherSaveLocationInitial extends WeatherSaveLocationState {}

class WeatherSavedLocationLoaded extends WeatherSaveLocationState {
  final List<WeatherModel> weatherDatas;
  final List<String> savedCity;
  WeatherSavedLocationLoaded(
    this.weatherDatas,
    this.savedCity,
  );

  List<dynamic> get props => [weatherDatas, savedCity];
  @override
  String toString() => 'Weather data loaded successfully - $props';
}

class WeatherSaveLocationError extends WeatherSaveLocationState {
  final String errorMsg;
  final List<String> city;
  WeatherSaveLocationError(this.city, this.errorMsg);

  List get props => [city, errorMsg];
  @override
  String toString() => 'Failed to load data for $city - reason: $errorMsg';
}
