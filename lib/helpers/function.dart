import 'package:breezly/helpers/constant.dart';
import 'package:geolocator/geolocator.dart';
import 'package:shared_preferences/shared_preferences.dart';

double convertKevinToCelcius(double kevin) {
  return kevin - 273.15;
}

Future<Position> getUserCurrentLocation() async {
  bool serviceEnabled;
  LocationPermission permission;

  // Test if location services are enabled.
  serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!serviceEnabled) {
    // Location services are not enabled don't continue
    // accessing the position and request users of the
    // App to enable the location services.
    return Future.error('Location services are disabled.');
  }

  permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      // Permissions are denied, next time you could try
      // requesting permissions again (this is also where
      // Android's shouldShowRequestPermissionRationale
      // returned true. According to Android guidelines
      // your App should show an explanatory UI now.
      return Future.error('Location permissions are denied');
    }
  }

  if (permission == LocationPermission.deniedForever) {
    // Permissions are denied forever, handle appropriately.
    return Future.error(
        'Location permissions are permanently denied, we cannot request permissions.');
  }

  // When we reach here, permissions are granted and we can
  // continue accessing the position of the device.
  return await Geolocator.getCurrentPosition();
}

String greeting({int? getHour}) {
  int hour = getHour ?? DateTime.now().hour;
  if (hour < 12) {
    return 'Morning';
  }
  if (hour < 17) {
    return 'Afternoon';
  }
  return 'Evening';
}

extension StringExtension on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${substring(1)}";
  }
}

String getAssets(String desc, {int? hour}) {
  String assetName = '';
  String currentTime = greeting(getHour: hour);
  bool isNight = false;

  if (currentTime == 'Morning' || currentTime == 'Afternoon') {
    isNight = false;
  } else {
    isNight = true;
  }

  if (desc.toLowerCase().contains('rain')) {
    assetName = 'rainy';
  } else if (desc.toLowerCase().contains('cloud')) {
    assetName = 'cloudy';
  } else if (desc.toLowerCase().contains('sun')) {
    assetName = 'sunny';
  } else if (desc.toLowerCase().contains('thunder')) {
    assetName = 'thunder';
  } else {
    assetName = 'cloudy';
  }

  if (isNight) {
    assetName = assetName + '_night';
  }

  return assetName;
}

Future<List<String>> getSavedCities() async {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  return await _prefs.then((SharedPreferences prefs) {
    return prefs.getStringList(citySharedPrefs) ??
        [
          'Shah Alam',
          'Petaling Jaya',
          'Johor Bahru',
        ];
  });
}

Future<void> updateSavedCities(List<String> updateString) async {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  await _prefs.then((SharedPreferences prefs) {
    prefs.setStringList(citySharedPrefs, updateString);
  });
  return;
}
