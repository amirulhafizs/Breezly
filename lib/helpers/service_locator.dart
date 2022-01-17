import 'package:breezly/data/data_sources/weather_data_source.dart';
import 'package:get_it/get_it.dart';

final locator = GetIt.instance;

void setup(){
  locator.registerLazySingleton<WeatherDataSource>(
    () => WeatherDataSourceImpl(),
  );
}