// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:finmind/constants.dart';
import 'package:finmind/splash.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'FiNest Main App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const SplashPage(title: Constants.SPLASH_PAGE_TITLE)
    );
  }
}


