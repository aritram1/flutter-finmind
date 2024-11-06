// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:finmind/Login.dart';
import 'package:finmind/home.dart';
import 'package:flutter/material.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key, required this.title});
  final String title;
  @override
  State<SplashPage> createState() => _MySplashPageState();
}

class _MySplashPageState extends State<SplashPage> {
  
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getToken(), 
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          // Show a loading spinner while waiting for the future to complete
          return Center(
            child: CircularProgressIndicator(),
          );
        } else if (snapshot.hasError) {
          // Show an error message if something went wrong
          return Center(
            child: Text('Error: ${snapshot.error}'),
          );
        } else {
          // Check if token is available
          final String? token = snapshot.data;
          if (token != null && token.isNotEmpty) {
            // If token is available, navigate to HomePage
            return const HomePage();
          } else {
            // If no token, show SplashPage
            return const LoginPage();
          }
        }
      },
    );
  }
  

  Future<String?> getToken () async{
    String? token = '';
    await Future.delayed(Duration(seconds: 1));
    // token = await SecureFileManager.getAccessToken();
    // if(token != null){
    //   setToken(token);
    // }
    return Future.value(token);
  }

  Future<void> setToken (String token) async{
    await Future.delayed(Duration(seconds: 1));
  }
  
}



