import 'dart:convert';
import 'package:breezly/data/model/api_model.dart';
import 'package:breezly/helpers/constant.dart';
import 'package:breezly/main.dart';
import 'package:http/http.dart' as http;

abstract class WeatherDataSource {
  Future<ApiModel> getWeatherFromCity(String city);
  Future<ApiModel> getWeatherFromLatLon(double lat, double lon);
  Future<ApiModel> getFiveDaysWeatherFromCity(String city);
  Future<ApiModel> getFiveDaysWeatherFromLatLon(double lat, double lon);
}

class WeatherDataSourceImpl implements WeatherDataSource {
  WeatherDataSourceImpl();


  @override
  Future<ApiModel> getWeatherFromCity(String city) => _getWeatherFromCity(city);

  @override
  Future<ApiModel> getWeatherFromLatLon(double lat, double lon) =>
      _getWeatherFromLatLon(lat, lon);

    @override
  Future<ApiModel> getFiveDaysWeatherFromCity(String city) => _getFiveDaysWeatherFromCity(city);
  
    @override
  Future<ApiModel> getFiveDaysWeatherFromLatLon(double lat, double lon) =>
      _getFiveDaysWeatherFromLatLon(lat, lon);

  /////////////////
  


  Future<ApiModel> _getWeatherFromCity(String cityName) async {
    var url = Uri.https(mainUrl, weatherUrl, {'q': cityName, 'appid': apiKey});
    ApiModel apiModel = await _getData(url);
    return apiModel;
  }

  Future<ApiModel> _getWeatherFromLatLon(double lat, double lon) async {
    var url = Uri.https(mainUrl, weatherUrl,
        {'lat': lat.toString(), 'lon': lon.toString(), 'appid': apiKey});
    ApiModel apiModel = await _getData(url);
    return apiModel;
  }

  Future<ApiModel> _getFiveDaysWeatherFromCity(String cityName) async {
    var url = Uri.https(mainUrl, forecast, {'q': cityName, 'appid': apiKey});
    ApiModel apiModel = await _getData(url);
    return apiModel;
  }

    Future<ApiModel> _getFiveDaysWeatherFromLatLon(double lat, double lon) async {
    var url = Uri.https(mainUrl, forecast,
        {'lat': lat.toString(), 'lon': lon.toString(), 'appid': apiKey});
    ApiModel apiModel = await _getData(url);
    return apiModel;
  }

  Future<ApiModel> _getData(Uri uri) async {
    ApiModel apiModel = ApiModel().initApiModel();
    try {
      final response = await http
          .get(uri)
          .timeout(const Duration(seconds: timeout), onTimeout: () {
        return http.Response('Error', 408);
      });
      var data = json.decode(response.body);
      if (response.statusCode == 200) {
        apiModel.success = true;
        apiModel.data = data;
      } else {
        apiModel.success = false;
        apiModel.message =
            data['message'] ?? 'Failed to get data for this city';
      }
      return apiModel;
    } catch (e) {
      apiModel.success = false;
      apiModel.message = 'Unknown error. Error: ${e.toString()}';
      return apiModel;
    }
  }
}
