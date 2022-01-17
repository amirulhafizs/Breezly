part of 'weather_bloc.dart';

@immutable
abstract class WeatherEvent {
   const WeatherEvent();

  List<Object> get props => [];
}

class LoadWeatherCity extends WeatherEvent {
final String city;
final double lat;
final double lon;
final int type; // 0 = city | 1 = lat lon
const LoadWeatherCity(this.city, this.lat, this.lon, this.type);

@override
  List<Object> get props => [city, lat, lon, type];

@override
String toString() => 'Loaded city - $city';
}
