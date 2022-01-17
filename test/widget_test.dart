// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:breezly/helpers/function.dart';

import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Check asset name', () {
    test('1 hour + scattered clouds - asset should = cloudy', () {
      int hour = 1;
      String desc = 'Scattered Clouds';
      var asset = getAssets(desc, hour: hour);
      expect(asset, 'cloudy');
    });

    test('18 hour + scattered clouds - asset should = cloudy_night', () {
      int hour = 18;
      String desc = 'Scattered Clouds';
      var asset = getAssets(desc, hour: hour);
      expect(asset, 'cloudy_night');
    });

    test('5 hour + thunderstorm - asset should = rain', () {
      int hour = 5;
      String desc = 'rainy';
      var asset = getAssets(desc, hour: hour);
      expect(asset, 'rainy');
    });

    test('20 hour + thunderstorm - asset should = thunder_night', () {
      int hour = 18;
      String desc = 'thunderstorm';
      var asset = getAssets(desc, hour: hour);
      expect(asset, 'thunder_night');
    });
  });
}
