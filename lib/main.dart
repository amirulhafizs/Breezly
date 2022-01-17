import 'package:breezly/data/bloc/connectivity_bloc/connectivity_bloc.dart';
import 'package:breezly/data/bloc/weather_bloc/weather_bloc.dart';
import 'package:breezly/data/bloc/weather_save_location_bloc/weather_save_location_bloc.dart';
import 'package:breezly/helpers/constant.dart';
import 'package:breezly/screen/home.dart';
import 'package:flutter/material.dart';
import 'package:breezly/helpers/service_locator.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';


//Replace your api key here:
const String apiKey = '-----INSERT API KEY-----';

Future<void> main() async {
  // Setting up Get IT DI
  setup();
  //Disable orientation


  runApp(MultiBlocProvider(
    providers: [
      BlocProvider<ConnectivityBloc>(
        create: (BuildContext context) =>
            ConnectivityBloc()..add(CheckConnectivity())
      ),
       BlocProvider<WeatherBloc>(
        create: (BuildContext context) =>
            WeatherBloc()
      ),
       BlocProvider<WeatherSaveLocationBloc>(
        create: (BuildContext context) =>
            WeatherSaveLocationBloc()..add(LoadSavedLocation())
      ),
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: appName,
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
        primarySwatch: Colors.blue,
         textTheme: GoogleFonts.dmSansTextTheme(),
        ),
        home: const Home());
  }
}
