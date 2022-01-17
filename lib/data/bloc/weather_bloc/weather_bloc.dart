import 'package:bloc/bloc.dart';
import 'package:breezly/data/data_sources/forecast_weather_data_source.dart';
import 'package:breezly/data/data_sources/weather_data_source.dart';
import 'package:breezly/data/model/api_model.dart';
import 'package:breezly/data/model/weather_model.dart';
import 'package:breezly/helpers/service_locator.dart';
import 'package:meta/meta.dart';

part 'weather_event.dart';
part 'weather_state.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  WeatherBloc() : super(WeatherInitial()) {
    on<LoadWeatherCity>(_onLoadWeatherCity);
  }

  void _onLoadWeatherCity(event, emit) async {
    WeatherModel weatherData = WeatherModel();
    ForecastWeatherData forecastWeatherData = ForecastWeatherData();

    try {
      List<ApiModel> results;

      if (event.type == 0) {
        results = await Future.wait([
          locator.get<WeatherDataSource>().getWeatherFromCity(event.city),
          locator
              .get<WeatherDataSource>()
              .getFiveDaysWeatherFromCity(event.city)
        ]);
      } else {
        results = await Future.wait([
          locator
              .get<WeatherDataSource>()
              .getWeatherFromLatLon(event.lat, event.lon),
          locator
              .get<WeatherDataSource>()
              .getFiveDaysWeatherFromLatLon(event.lat, event.lon)
        ]);
      }

      for (var i = 0; i < results.length; i++) {
        var element = results[i];

        if (element.success == true) {
          if (i == 0) {
            var data = WeatherModel.fromJson(element.data);
            weatherData = data;
          } else {
            var data = ForecastWeatherData.fromJson(element.data);
            forecastWeatherData = data;
          }
        }
      }
      emit(WeatherLoaded(weatherData, forecastWeatherData));
    } catch (e) {
      emit(WeatherError(event.city, e.toString()));
    }
  }
}
