import 'package:flutter/material.dart';
import 'package:weather_api/homePage.dart';
import 'package:weather_api/splash.dart';

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        '/':(context)=>SplashPage(),
        '/myscreen':(context)=>HomePage(),
      },
      theme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: Colors.white,
      ),
    ),
  );
}


