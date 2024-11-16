// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:finmind/util/constants.dart';
import 'package:flutter/material.dart';

class AppHomePage extends StatefulWidget {
  const AppHomePage({super.key});
  
  final String title = Constants.HOME_PAGE_TITLE;
  
  @override
  State<AppHomePage> createState() => _HomePageState();
}

class _HomePageState extends State<AppHomePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
         
          ],
        ),
      ),
    );
  }
}