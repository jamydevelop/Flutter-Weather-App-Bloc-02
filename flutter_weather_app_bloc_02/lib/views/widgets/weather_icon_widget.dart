import 'package:flutter/material.dart';

class WeatherIconWidget extends StatelessWidget {
  final int code;
  const WeatherIconWidget({super.key, required this.code});

  @override
  Widget build(BuildContext context) {
    String assetPath;

    if (code >= 200 && code < 300) {
      assetPath = 'assets/1.png';
    } else if (code >= 300 && code < 400) {
      assetPath = 'assets/2.png';
    } else if (code >= 500 && code < 600) {
      assetPath = 'assets/3.png';
    } else if (code >= 600 && code < 700) {
      assetPath = 'assets/4.png';
    } else if (code >= 700 && code < 800) {
      assetPath = 'assets/5.png';
    } else if (code == 800) {
      assetPath = 'assets/6.png';
    } else if (code > 800 && code <= 804) {
      assetPath = 'assets/7.png';
    } else {
      assetPath = 'assets/7.png';
    }

    return Image.asset(assetPath);
  }
}
