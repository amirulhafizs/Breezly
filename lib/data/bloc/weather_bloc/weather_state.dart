part of 'weather_bloc.dart';

@immutable
abstract class WeatherState {}

class WeatherInitial extends WeatherState {}

class WeatherLoaded extends WeatherState {
  final WeatherModel weatherData;
 final ForecastWeatherData forecastData;
  WeatherLoaded(this.weatherData, this.forecastData);

  List<dynamic> get props => [weatherData, forecastData];
  @override
  String toString() => 'Weather data loaded successfully - $props';
}

class WeatherError extends WeatherState {
  final String errorMsg;
  final String city;
  WeatherError(this.city, this.errorMsg);

  List get props => [city, errorMsg];
  @override
  String toString() => 'Failed to load data for $city - reason: $errorMsg';
}
