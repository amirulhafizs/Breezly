///
/// Code generated by jsonToDartModel https://ashamp.github.io/jsonToDartModel/
///
class ForecastWeatherDataCityCoord {
/*
{
  "lat": 5,
  "lon": 103
} 
*/

  int? lat;
  int? lon;

  ForecastWeatherDataCityCoord({
    this.lat,
    this.lon,
  });
  ForecastWeatherDataCityCoord.fromJson(Map<String, dynamic> json) {
    lat = json['lat']?.toInt();
    lon = json['lon']?.toInt();
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['lat'] = lat;
    data['lon'] = lon;
    return data;
  }
}

class ForecastWeatherDataCity {
/*
{
  "id": 1733036,
  "name": "Terengganu",
  "coord": {
    "lat": 5,
    "lon": 103
  },
  "country": "MY",
  "population": 0,
  "timezone": 28800,
  "sunrise": 1642202474,
  "sunset": 1642245171
} 
*/

  int? id;
  String? name;
  ForecastWeatherDataCityCoord? coord;
  String? country;
  int? population;
  int? timezone;
  int? sunrise;
  int? sunset;

  ForecastWeatherDataCity({
    this.id,
    this.name,
    this.coord,
    this.country,
    this.population,
    this.timezone,
    this.sunrise,
    this.sunset,
  });
  ForecastWeatherDataCity.fromJson(Map<String, dynamic> json) {
    id = json['id']?.toInt();
    name = json['name']?.toString();
    coord = (json['coord'] != null)
        ? ForecastWeatherDataCityCoord.fromJson(json['coord'])
        : null;
    country = json['country']?.toString();
    population = json['population']?.toInt();
    timezone = json['timezone']?.toInt();
    sunrise = json['sunrise']?.toInt();
    sunset = json['sunset']?.toInt();
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    if (coord != null) {
      data['coord'] = coord!.toJson();
    }
    data['country'] = country;
    data['population'] = population;
    data['timezone'] = timezone;
    data['sunrise'] = sunrise;
    data['sunset'] = sunset;
    return data;
  }
}

class ForecastWeatherDataListSys {
/*
{
  "pod": "d"
} 
*/

  String? pod;

  ForecastWeatherDataListSys({
    this.pod,
  });
  ForecastWeatherDataListSys.fromJson(Map<String, dynamic> json) {
    pod = json['pod']?.toString();
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['pod'] = pod;
    return data;
  }
}

class ForecastWeatherDataListRain {
/*
{
  "3h": 0.25
} 
*/

  double? the3h;

  ForecastWeatherDataListRain({
    this.the3h,
  });
  ForecastWeatherDataListRain.fromJson(Map<String, dynamic> json) {
    the3h = json['3h']?.toDouble();
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['3h'] = the3h;
    return data;
  }
}

class ForecastWeatherDataListWind {
/*
{
  "speed": 2.66,
  "deg": 47,
  "gust": 3.1
} 
*/

  double? speed;
  int? deg;
  double? gust;

  ForecastWeatherDataListWind({
    this.speed,
    this.deg,
    this.gust,
  });
  ForecastWeatherDataListWind.fromJson(Map<String, dynamic> json) {
    speed = json['speed']?.toDouble();
    deg = json['deg']?.toInt();
    gust = json['gust']?.toDouble();
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['speed'] = speed;
    data['deg'] = deg;
    data['gust'] = gust;
    return data;
  }
}

class ForecastWeatherDataListClouds {
/*
{
  "all": 95
} 
*/

  int? all;

  ForecastWeatherDataListClouds({
    this.all,
  });
  ForecastWeatherDataListClouds.fromJson(Map<String, dynamic> json) {
    all = json['all']?.toInt();
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['all'] = all;
    return data;
  }
}

class ForecastWeatherDataListWeather {
/*
{
  "id": 500,
  "main": "Rain",
  "description": "light rain",
  "icon": "10d"
} 
*/

  int? id;
  String? main;
  String? description;
  String? icon;

  ForecastWeatherDataListWeather({
    this.id,
    this.main,
    this.description,
    this.icon,
  });
  ForecastWeatherDataListWeather.fromJson(Map<String, dynamic> json) {
    id = json['id']?.toInt();
    main = json['main']?.toString();
    description = json['description']?.toString();
    icon = json['icon']?.toString();
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['main'] = main;
    data['description'] = description;
    data['icon'] = icon;
    return data;
  }
}

class ForecastWeatherDataListMain {
/*
{
  "temp": 302.21,
  "feels_like": 304.6,
  "temp_min": 300.64,
  "temp_max": 302.21,
  "pressure": 1011,
  "sea_level": 1011,
  "grnd_level": 1007,
  "humidity": 62,
  "temp_kf": 1.57
} 
*/

  double? temp;
  double? feelsLike;
  double? tempMin;
  double? tempMax;
  int? pressure;
  int? seaLevel;
  int? grndLevel;
  int? humidity;
  double? tempKf;

  ForecastWeatherDataListMain({
    this.temp,
    this.feelsLike,
    this.tempMin,
    this.tempMax,
    this.pressure,
    this.seaLevel,
    this.grndLevel,
    this.humidity,
    this.tempKf,
  });
  ForecastWeatherDataListMain.fromJson(Map<String, dynamic> json) {
    temp = json['temp']?.toDouble();
    feelsLike = json['feels_like']?.toDouble();
    tempMin = json['temp_min']?.toDouble();
    tempMax = json['temp_max']?.toDouble();
    pressure = json['pressure']?.toInt();
    seaLevel = json['sea_level']?.toInt();
    grndLevel = json['grnd_level']?.toInt();
    humidity = json['humidity']?.toInt();
    tempKf = json['temp_kf']?.toDouble();
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['temp'] = temp;
    data['feels_like'] = feelsLike;
    data['temp_min'] = tempMin;
    data['temp_max'] = tempMax;
    data['pressure'] = pressure;
    data['sea_level'] = seaLevel;
    data['grnd_level'] = grndLevel;
    data['humidity'] = humidity;
    data['temp_kf'] = tempKf;
    return data;
  }
}

class ForecastWeatherDataList {
/*
{
  "dt": 1642237200,
  "main": {
    "temp": 302.21,
    "feels_like": 304.6,
    "temp_min": 300.64,
    "temp_max": 302.21,
    "pressure": 1011,
    "sea_level": 1011,
    "grnd_level": 1007,
    "humidity": 62,
    "temp_kf": 1.57
  },
  "weather": [
    {
      "id": 500,
      "main": "Rain",
      "description": "light rain",
      "icon": "10d"
    }
  ],
  "clouds": {
    "all": 95
  },
  "wind": {
    "speed": 2.66,
    "deg": 47,
    "gust": 3.1
  },
  "visibility": 10000,
  "pop": 0.36,
  "rain": {
    "3h": 0.25
  },
  "sys": {
    "pod": "d"
  },
  "dt_txt": "2022-01-15 09:00:00"
} 
*/

  int? dt;
  ForecastWeatherDataListMain? main;
  List<ForecastWeatherDataListWeather?>? weather;
  ForecastWeatherDataListClouds? clouds;
  ForecastWeatherDataListWind? wind;
  int? visibility;
  double? pop;
  ForecastWeatherDataListRain? rain;
  ForecastWeatherDataListSys? sys;
  String? dtTxt;

  ForecastWeatherDataList({
    this.dt,
    this.main,
    this.weather,
    this.clouds,
    this.wind,
    this.visibility,
    this.pop,
    this.rain,
    this.sys,
    this.dtTxt,
  });
  ForecastWeatherDataList.fromJson(Map<String, dynamic> json) {
    dt = json['dt']?.toInt();
    main = (json['main'] != null)
        ? ForecastWeatherDataListMain.fromJson(json['main'])
        : null;
    if (json['weather'] != null) {
      final v = json['weather'];
      final arr0 = <ForecastWeatherDataListWeather>[];
      v.forEach((v) {
        arr0.add(ForecastWeatherDataListWeather.fromJson(v));
      });
      weather = arr0;
    }
    clouds = (json['clouds'] != null)
        ? ForecastWeatherDataListClouds.fromJson(json['clouds'])
        : null;
    wind = (json['wind'] != null)
        ? ForecastWeatherDataListWind.fromJson(json['wind'])
        : null;
    visibility = json['visibility']?.toInt();
    pop = json['pop']?.toDouble();
    rain = (json['rain'] != null)
        ? ForecastWeatherDataListRain.fromJson(json['rain'])
        : null;
    sys = (json['sys'] != null)
        ? ForecastWeatherDataListSys.fromJson(json['sys'])
        : null;
    dtTxt = json['dt_txt']?.toString();
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['dt'] = dt;
    if (main != null) {
      data['main'] = main!.toJson();
    }
    if (weather != null) {
      final v = weather;
      final arr0 = [];
      for (var v in v!) {
        arr0.add(v!.toJson());
      }
      data['weather'] = arr0;
    }
    if (clouds != null) {
      data['clouds'] = clouds!.toJson();
    }
    if (wind != null) {
      data['wind'] = wind!.toJson();
    }
    data['visibility'] = visibility;
    data['pop'] = pop;
    if (rain != null) {
      data['rain'] = rain!.toJson();
    }
    if (sys != null) {
      data['sys'] = sys!.toJson();
    }
    data['dt_txt'] = dtTxt;
    return data;
  }
}

class ForecastWeatherData {
/*
{
  "cod": "200",
  "message": 0,
  "cnt": 40,
  "list": [
    {
      "dt": 1642237200,
      "main": {
        "temp": 302.21,
        "feels_like": 304.6,
        "temp_min": 300.64,
        "temp_max": 302.21,
        "pressure": 1011,
        "sea_level": 1011,
        "grnd_level": 1007,
        "humidity": 62,
        "temp_kf": 1.57
      },
      "weather": [
        {
          "id": 500,
          "main": "Rain",
          "description": "light rain",
          "icon": "10d"
        }
      ],
      "clouds": {
        "all": 95
      },
      "wind": {
        "speed": 2.66,
        "deg": 47,
        "gust": 3.1
      },
      "visibility": 10000,
      "pop": 0.36,
      "rain": {
        "3h": 0.25
      },
      "sys": {
        "pod": "d"
      },
      "dt_txt": "2022-01-15 09:00:00"
    }
  ],
  "city": {
    "id": 1733036,
    "name": "Terengganu",
    "coord": {
      "lat": 5,
      "lon": 103
    },
    "country": "MY",
    "population": 0,
    "timezone": 28800,
    "sunrise": 1642202474,
    "sunset": 1642245171
  }
} 
*/

  String? cod;
  int? message;
  int? cnt;
  List<ForecastWeatherDataList?>? list;
  ForecastWeatherDataCity? city;

  ForecastWeatherData({
    this.cod,
    this.message,
    this.cnt,
    this.list,
    this.city,
  });
  ForecastWeatherData.fromJson(Map<String, dynamic> json) {
    cod = json['cod']?.toString();
    message = json['message']?.toInt();
    cnt = json['cnt']?.toInt();
    if (json['list'] != null) {
      final v = json['list'];
      final arr0 = <ForecastWeatherDataList>[];
      v.forEach((v) {
        arr0.add(ForecastWeatherDataList.fromJson(v));
      });
      list = arr0;
    }
    city = (json['city'] != null)
        ? ForecastWeatherDataCity.fromJson(json['city'])
        : null;
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['cod'] = cod;
    data['message'] = message;
    data['cnt'] = cnt;
    if (list != null) {
      final v = list;
      final arr0 = [];
      for (var v in v!) {
        arr0.add(v!.toJson());
      }
      data['list'] = arr0;
    }
    if (city != null) {
      data['city'] = city!.toJson();
    }
    return data;
  }
}
