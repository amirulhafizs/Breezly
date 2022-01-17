import 'package:flutter/material.dart';

const smallFontSize = 16.0;
const multiplier = 4;

TextStyle smallFont() {
  return const TextStyle(
      fontSize: smallFontSize, fontWeight: FontWeight.normal);
}

TextStyle smallMediumFont() {
  return const TextStyle(fontSize: smallFontSize, fontWeight: FontWeight.w600);
}

TextStyle smallBoldFont() {
  return const TextStyle(fontSize: smallFontSize, fontWeight: FontWeight.w800);
}

TextStyle mediumFont() {
  return const TextStyle(
      fontSize: smallFontSize + multiplier, fontWeight: FontWeight.normal);
}

TextStyle mediumMediumFont() {
  return const TextStyle(
      fontSize: smallFontSize + multiplier, fontWeight: FontWeight.w600);
}

TextStyle mediumBoldFont() {
  return const TextStyle(
      fontSize: smallFontSize + multiplier, fontWeight: FontWeight.w800);
}

TextStyle bigFont() {
  return const TextStyle(
      fontSize: smallFontSize + (multiplier * 2), fontWeight: FontWeight.normal);
}

TextStyle bigMediumFont() {
  return const TextStyle(
      fontSize: smallFontSize + (multiplier * 2), fontWeight: FontWeight.w600);
}

TextStyle bigBoldFont() {
  return const TextStyle(
      fontSize: smallFontSize + (multiplier * 2), fontWeight: FontWeight.w800);
}



BoxDecoration circleRadius(double radius){
  return BoxDecoration( borderRadius: BorderRadius.all(Radius.circular(radius)));
}