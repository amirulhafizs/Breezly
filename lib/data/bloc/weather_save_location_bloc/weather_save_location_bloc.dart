import 'package:bloc/bloc.dart';
import 'package:breezly/data/data_sources/weather_data_source.dart';
import 'package:breezly/data/model/api_model.dart';
import 'package:breezly/data/model/weather_model.dart';

import 'package:breezly/helpers/function.dart';
import 'package:breezly/helpers/service_locator.dart';
import 'package:meta/meta.dart';


part 'weather_save_location_event.dart';
part 'weather_save_location_state.dart';

class WeatherSaveLocationBloc
    extends Bloc<WeatherSaveLocationEvent, WeatherSaveLocationState> {
  WeatherSaveLocationBloc() : super(WeatherSaveLocationInitial()) {
    on<LoadSavedLocation>(_onLoadSavedLocation);
  }

  void _onLoadSavedLocation(event, emit) async {
  
    List<String> cities = await getSavedCities();
    try {
      List<WeatherModel> allData = await fetchAllCities(cities);
      emit(WeatherSavedLocationLoaded(allData, cities));
    } catch (e) {
      emit(WeatherSaveLocationError(cities, e.toString()));
    }
  }

  Future<List<WeatherModel>> fetchAllCities(List<String> cities) async {
    List<WeatherModel> _data = [];
    await Future.forEach(cities, (element) async {
      ApiModel results = await locator
          .get<WeatherDataSource>()
          .getWeatherFromCity(element.toString());
      if (results.success == true) {
        var data = WeatherModel.fromJson(results.data);
        _data.add(data);
      } 
    });
    return _data;
  }
}
