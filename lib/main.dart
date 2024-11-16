// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:finmind/screens/login_via_otp_page.dart';
import 'package:finmind/util/constants.dart';
import 'package:finmind/screens/app_splash_page.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    Logger().d('Oh hello!');
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'FiNest Main App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      // home: LoginViaOTPPage()
      home: AppSplashPage()
    );
  }
}


