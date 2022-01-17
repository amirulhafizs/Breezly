import 'dart:collection';

import 'package:breezly/data/bloc/connectivity_bloc/connectivity_bloc.dart';
import 'package:breezly/data/bloc/weather_bloc/weather_bloc.dart';
import 'package:breezly/data/bloc/weather_save_location_bloc/weather_save_location_bloc.dart';
import 'package:breezly/data/data_sources/cities.dart';
import 'package:breezly/data/data_sources/forecast_weather_data_source.dart';
import 'package:breezly/data/model/weather_model.dart';
import 'package:breezly/helpers/colors.dart';
import 'package:breezly/helpers/constant.dart';
import 'package:breezly/helpers/function.dart';
import 'package:breezly/helpers/style.dart';
import 'package:breezly/screen/widgets/greeting_widget.dart';
import 'package:breezly/screen/widgets/offline_widget.dart';
import 'package:breezly/screen/widgets/saved_city_bottomsheet.dart';
import 'package:breezly/screen/widgets/shimmering_saved_loc_widget.dart';
import 'package:breezly/screen/widgets/table_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String city = 'Kuala Lumpur';
  double lat = 0.00;
  double lon = 0.00;

  late LocationPermission serviceLocationPermission;
  WeatherModel weatherData = WeatherModel();
  ForecastWeatherData forecastWeatherData = ForecastWeatherData();

  List<WeatherModel> savedCityWeather = [];

  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();
    await checkCurrentLoc();
    setState(() {});
    BlocProvider.of<ConnectivityBloc>(context).add(CheckConnectivity());
    BlocProvider.of<WeatherBloc>(context)
        .add(LoadWeatherCity(city, lat, lon, 0));
    serviceLocationPermission = await Geolocator.checkPermission();
  }

  Future<void> checkCurrentLoc() async {
    try {
      await getUserCurrentLocation().then((value) {
        lat = value.latitude;
        lon = value.longitude;
      });
    } catch (e) {
      return;
    }
  }

  Future<void> _showMyDialog(String title, String message, Function fx) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(message),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Dismiss'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Approve'),
              onPressed: () async {
                fx();
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget changeSelectedCity(StateSetter stateSetter) {
      var _cities = List.from(cities);

      _cities.insert(0, 'Current Location');

      void updateData(int i, bool isCurrentLocation) {
        stateSetter(() {
          city = _cities[i];
        });
        BlocProvider.of<WeatherBloc>(context).add(
            LoadWeatherCity(_cities[i], lat, lon, isCurrentLocation ? 1 : 0));
      }

      return SizedBox(
        height: MediaQuery.of(context).size.height,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 22),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Location', style: mediumBoldFont()),
              const Text('Select any city to display the weather info'),
              const SizedBox(height: 16),
              Expanded(
                child: ListView.builder(
                    itemCount: _cities.length,
                    itemBuilder: (ctxt, i) {
                      bool isSelected = city == _cities[i];
                      bool isCurrentLocation = _cities[i] == 'Current Location';

                      return GestureDetector(
                          onTap: () {
                            // Seems like the plugin are not able to detect locationpermission denied forever

                            if (isCurrentLocation &&
                                serviceLocationPermission ==
                                    LocationPermission.denied) {
                              _showMyDialog('Location Permission Disabled',
                                  'Please enable the location permission',
                                  () async {
                                await checkCurrentLoc().then((value) async {
                                  updateData(i, isCurrentLocation);
                                  serviceLocationPermission =
                                      await Geolocator.checkPermission();
                                });
                              });
                            } else {
                              updateData(i, isCurrentLocation);
                            }
                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 4.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  _cities[i],
                                  style: isSelected
                                      ? smallMediumFont()
                                      : smallFont(),
                                ),
                                isSelected
                                    ? Container(
                                        decoration: const BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: blueAccent),
                                        child: const Padding(
                                          padding: EdgeInsets.all(2.0),
                                          child: Icon(
                                            Icons.check,
                                            color: blueColor,
                                            size: 16,
                                          ),
                                        ))
                                    : Container()
                              ],
                            ),
                          ));
                    }),
              ),
            ],
          ),
        ),
      );
    }

    Widget currentLocWidget() {
      var temp = convertKevinToCelcius(weatherData.main?.temp ?? 0.00)
          .toStringAsFixed(2);
      var asset =
          getAssets(weatherData.weather?[0].description.toString() ?? '');

      List<ForecastWeatherDataList?> forecastData =
          forecastWeatherData.list ?? [];

      List<String> dates = [];
      Map<String, List> mainData = {};
      Map<String, List> todayData = {};
      for (var element in forecastData) {
        var dt = element!.dt;

        if (dt != null) {
          var date = DateTime.fromMillisecondsSinceEpoch(dt * 1000);
          var stdDate = DateFormat('dd MMM').format(date);
          var today = DateFormat('dd MMM').format(DateTime.now());
          var time = DateFormat('kk:mm').format(date);

          var temp = element.main?.temp;
          var celTemp = convertKevinToCelcius(temp ?? 0).toStringAsFixed(0);
          var desc = element.weather?[0]?.description;

          // String data = '$stdDate|$time';
          String data = '$celTemp|$desc|$stdDate';
          if (stdDate != today) {
            dates.add(stdDate);
            mainData.update(
              time,
              (existingValue) => existingValue + [data],
              ifAbsent: () => [data],
            );
            mainData = SplayTreeMap<String, List<dynamic>>.from(
                mainData, (a, b) => a.compareTo(b));
          } else {
            todayData.update(
              time,
              (existingValue) => existingValue + [data],
              ifAbsent: () => [data],
            );
          }
        }
      }

      List<Widget> todayWidget = [];
      for (var e in todayData.entries) {
        String key = e.key;
        var data = todayData[key].toString().split('|');
        var xtemp = data[0].replaceAll('[', '');
        var asset = getAssets(data[1].toString());
        var widget = Expanded(
            child: Column(children: [
          Text(key,
              style: smallBoldFont()
                  .copyWith(fontSize: todayData.length >= 6 ? 10 : 12)),
          Transform.scale(
            scale: todayData.length >= 6 ? 0.6 : 0.9,
            child: Align(
              alignment: Alignment.center,
              child: SvgPicture.asset('assets/$asset.svg'),
            ),
          ),
          Text(xtemp + ' °C',
              style: smallMediumFont().copyWith(
                  fontSize: todayData.length >= 6 ? 10 : 12,
                  color: purpleColor))
        ]));

        todayWidget.add(widget);
      }

      return Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8),
            child: GestureDetector(
              onTap: () {
                showModalBottomSheet(
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(8),
                            topRight: Radius.circular(8))),
                    context: context,
                    builder: (context) {
                      return StatefulBuilder(builder:
                          (BuildContext context, StateSetter modalState) {
                        return changeSelectedCity(modalState);
                      });
                    });
              },
              child: Row(
                children: [
                  const Icon(
                    Icons.location_pin,
                    color: orangeRedColor,
                  ),
                  Text(
                    ' ${weatherData.name}',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: mediumBoldFont().copyWith(color: darkBlueColor),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(left: 8.0),
                    child: Icon(
                      Icons.edit,
                      color: Colors.black,
                      size: 14,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Container(
              width: MediaQuery.of(context).size.width,
              decoration: circleRadius(16).copyWith(color: blueAccent),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 16.0, horizontal: 22),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text('Today'),
                            Text(
                              temp + ' °C',
                              style: bigBoldFont()
                                  .copyWith(fontSize: 40, color: Colors.black),
                            ),
                            Text(
                              weatherData.weather?[0].description
                                      .toString()
                                      .capitalize() ??
                                  '',
                              style: smallMediumFont()
                                  .copyWith(color: purpleColor),
                            ),
                          ],
                        ),
                        Transform.scale(
                            scale: 1.4,
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(top: 16, right: 16.0),
                              child: SvgPicture.asset(
                                'assets/$asset.svg',
                              ),
                            )),
                      ],
                    ),
                    todayWidget.length > 1
                        ? Padding(
                            padding: const EdgeInsets.symmetric(vertical: 0.0),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    const Expanded(
                                        child: Divider(
                                      thickness: 2,
                                      color: purpleColor,
                                    )),
                                    Text('>',
                                        style: bigBoldFont()
                                            .copyWith(color: purpleColor)),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [...todayWidget],
                                ),
                              ],
                            ),
                          )
                        : Container(),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16.0),
                      child: Container(
                          width: MediaQuery.of(context).size.width,
                          color: darkBlueColor,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 2.0, horizontal: 8),
                            child: Text(
                              'Next 5 days',
                              style: smallMediumFont()
                                  .copyWith(fontSize: 14, color: Colors.white),
                            ),
                          )),
                    ),
                    TableWidget(
                      dates: dates.toSet().toList(),
                      data: mainData,
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      );
    }

    Widget savedLocWidget() {
      return BlocBuilder<WeatherSaveLocationBloc, WeatherSaveLocationState>(
        builder: (context, state) {
          Widget widget = const CircularProgressIndicator();
          if (state is WeatherSavedLocationLoaded) {
            savedCityWeather = state.weatherDatas;
            widget = Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 18.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Saved Location',
                            style: bigBoldFont().copyWith(fontSize: 16),
                          ),
                          Text(
                              'Weather data for ${savedCityWeather.length.toString()} city'),
                        ],
                      ),
                      TextButton(
                          style: TextButton.styleFrom(
                              backgroundColor: blueAccent,
                              primary: darkBlueColor),
                          onPressed: () {
                            showModalBottomSheet(
                                shape: const RoundedRectangleBorder(
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(8),
                                        topRight: Radius.circular(8))),
                                context: context,
                                builder: (context) {
                                  return StatefulBuilder(builder:
                                      (BuildContext context,
                                          StateSetter modalState) {
                                    return updateSavedCity(
                                        context, modalState, state.savedCity);
                                  });
                                });
                          },
                          child: const Text('Edit'))
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 16.0, bottom: 22),
                  child: SizedBox(
                    height: 100,
                    child: ListView.builder(
                        padding: const EdgeInsets.only(left: 16),
                        itemCount: savedCityWeather.length,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (ctxt, i) {
                          WeatherModel weather = savedCityWeather[i];

                          var name = weather.name;
                          var temp =
                              convertKevinToCelcius(weather.main?.temp ?? 0.00)
                                  .toStringAsFixed(2);
                          var asset = getAssets(
                              weather.weather?[0].description.toString() ?? '');
                          return Padding(
                            padding: const EdgeInsets.only(right: 8.0),
                            child: Container(
                                width: 150,
                                decoration: circleRadius(8)
                                    .copyWith(color: darkBlueColor),
                                child: Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child: Stack(
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(name ?? '',
                                              style: smallFont().copyWith(
                                                  color: Colors.white)),
                                          Text(temp + ' °C',
                                              style: mediumMediumFont()
                                                  .copyWith(color: blueAccent)),
                                        ],
                                      ),
                                      Align(
                                        alignment: Alignment.centerRight,
                                        child: SvgPicture.asset(
                                            'assets/$asset.svg'),
                                      )
                                    ],
                                  ),
                                )),
                          );
                        }),
                  ),
                )
              ],
            );
          } else if (state is WeatherSaveLocationError) {
            widget = const Center(
              child: Text('Error'),
            );
          } else {
            widget = Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Column(
                    children: [
                      Text(
                        'Saved Location',
                        style: bigBoldFont().copyWith(fontSize: 16),
                      ),
                      const Text('You can add up to 5 places'),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                const ShimmeringSavedLocWidget()
              ],
            );
          }

          return AnimatedSwitcher(
            switchInCurve: Curves.ease,
            switchOutCurve: Curves.easeInOut,
            duration: const Duration(milliseconds: 500),
            child: widget,
          );
        },
      );
    }

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: Text(
          appName,
          style: smallMediumFont().copyWith(color: Colors.black),
        ),
      ),
      body: BlocBuilder<ConnectivityBloc, ConnectivityState>(
        builder: (context, state) {
          if (state is Connected) {
            return BlocBuilder<WeatherBloc, WeatherState>(
              builder: (context, weatherState) {
                String errorMsg = '';

                Widget mainWidget =
                    const Center(child: CircularProgressIndicator());
                if (weatherState is WeatherLoaded) {
                  weatherData = weatherState.weatherData;
                  forecastWeatherData = weatherState.forecastData;

                  mainWidget = SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const GreetingWidget(),
                              currentLocWidget(),
                              savedLocWidget()
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 20.0),
                          child: Center(
                            child: Column(
                              children: [
                                Text(
                                  'Weather data from openweathermap.org',
                                  style: smallFont().copyWith(
                                      fontSize: 8, color: Colors.grey),
                                ),
                                Text(
                                  'Dev by Amirul',
                                  style: smallFont().copyWith(
                                      fontSize: 8, color: Colors.grey),
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  );
                }

                if (weatherState is WeatherError) {
                  errorMsg = weatherState.errorMsg;
                  city = weatherState.city;
                  mainWidget = Text(errorMsg);
                }

                return AnimatedSwitcher(
                  switchInCurve: Curves.ease,
                  switchOutCurve: Curves.easeInOut,
                  duration: const Duration(milliseconds: 500),
                  child: mainWidget,
                );
              },
            );
          } else {
            return const OfflineWidget();
          }
        },
      ),
    );
  }
}
