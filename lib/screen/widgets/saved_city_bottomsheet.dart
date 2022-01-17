import 'package:breezly/data/bloc/weather_save_location_bloc/weather_save_location_bloc.dart';
import 'package:breezly/data/data_sources/cities.dart';
import 'package:breezly/helpers/colors.dart';
import 'package:breezly/helpers/function.dart';
import 'package:breezly/helpers/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

Widget updateSavedCity(
    BuildContext context, StateSetter stateSetter, List<String> savedCities) {
  return SizedBox(
    height: MediaQuery.of(context).size.height,
    child: Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 22),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Save Location', style: mediumBoldFont()),
          const Text('Min 3 must be selected. Maximum 5'),
          const SizedBox(height: 8),
          // const Text('Selected'),
          Wrap(children: savedCities.map((name) =>  Padding(
            padding: const EdgeInsets.only(top: 4.0, right: 4),
            child: Container(
              decoration: circleRadius(8).copyWith( color: blueAccent,),
             
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(name, style: smallFont().copyWith(fontSize: 12, color: blueColor),),
              )),
          )).toList(),),
          
          const SizedBox(height: 8),
           savedCities.length == 3 ? Text('*At least 3 city must be selected', style: smallFont().copyWith(fontSize: 8, color: Colors.grey),) : Container(),
          savedCities.length == 5 ? Text('*You have reached maximum city allowed', style: smallFont().copyWith(fontSize: 8, color: Colors.grey),) : Container(),
          const Divider(),
          Expanded(
            child: ListView.builder(
                itemCount: cities.length,
                itemBuilder: (ctxt, i) {
                  bool isSelected = savedCities.contains(cities[i]);

                  return GestureDetector(
                      onTap: () {
                        stateSetter(() {
                          var sc = cities[i];

                          if (savedCities.contains(sc)) {
                            // Only remove if city > 3
                            if (savedCities.length <= 3) {
                            } else {
                              savedCities.remove(sc);
                              isSelected = false;
                            }
                          } else {
                            // Only allow 5
                            if (savedCities.length <= 4) {
                              savedCities.add(sc);
                              isSelected = true;
                            }
                          }
                        });
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 4.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              cities[i],
                              style:
                                  isSelected ? smallMediumFont() : smallFont(),
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
          Center(
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              child: TextButton(
                style: TextButton.styleFrom(
                    backgroundColor: blueColor, primary: blueAccent),
                onPressed: () async {
                  await updateSavedCities(savedCities).then((_) {
                    BlocProvider.of<WeatherSaveLocationBloc>(context)
                        .add(LoadSavedLocation());
                    Navigator.of(context).pop();
                  });
                },
                child: const Text('Save'),
              ),
            ),
          )
        ],
      ),
    ),
  );
}
