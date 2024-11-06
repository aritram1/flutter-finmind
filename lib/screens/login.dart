// ignore_for_file: prefer_const_constructors

import 'package:finmind/util/constants.dart';
import 'package:finmind/home.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

class AppLoginPage extends StatefulWidget {
  const AppLoginPage({
    super.key, 
    this.message = Constants.LOGIN_PAGE_DEFAULT_MESSAGE, 
    this.buttonNameSalesforce = Constants.LOGIN_PAGE_BUTTON_LOGIN_WITH_SALESFORCE,
    this.buttonNameGoogle = Constants.LOGIN_PAGE_BUTTON_LOGIN_WITH_GOOGLE, 
    this.buttonNameOTP = Constants.LOGIN_PAGE_BUTTON_LOGIN_WITH_OTP, 
    this.showLoginButton = true
  });

  final String message;
  final String buttonNameSalesforce;
  final String buttonNameGoogle;
  final String buttonNameOTP;

  final bool showLoginButton;

  @override
  AppLoginPageState createState() => AppLoginPageState();
}

class AppLoginPageState extends State<AppLoginPage> {

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('FinMind'),
      ),
      body: 
      isLoading ? const CircularProgressIndicator() 
      : Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 48),
                child: Text(
                  widget.message, 
                  style: const TextStyle(fontSize: 16), 
                  softWrap: true,
                  textAlign: TextAlign.center
                ),
              ),
            ),
            const SizedBox(height: 24.0),
            Visibility(
              visible: widget.showLoginButton,
              child: 
              Column(
                children: [
                  ElevatedButton( // Login With Salesforce button
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(widget.buttonNameSalesforce),
                        const SizedBox(width: 8), // Add spacing between the icon and text
                        Image.asset(
                          'assets/loginPage/salesforceIcon.jpeg',
                          width: 32,
                          height: 32,
                        ),
                      ],
                    ),
                    onPressed: () async {
                      BuildContext currentContext = context;
                      Logger().d('Token call not started yet!');
                      
                      setState(() {
                        isLoading = true;
                      });
                  
                      String? token;
                      // try{
                      //   token = await SalesforceAuthService.authenticate(context);
                      //   if(token == null) throw FinPlanException('Token is null in FinPlanLoginPage build');
                      // }
                      // catch(error, stacktrace){
                      //   Logger().d('Error occurred in Login Page build : $error, stacktrace : $stacktrace}');
                      // }
                     
                      setState(() {
                        isLoading = false;
                      });
                            
                      Logger().d('Token is $token');
                  
                      if (token != null) {
                        Navigator.pushReplacement(
                          currentContext,
                          MaterialPageRoute(
                            builder: (currentContext) => const HomePage(),
                          ),
                        );
                      } else {
                        // Send to Login
                        Logger().d('Error');
                        Navigator.pushReplacement(
                          currentContext,
                          MaterialPageRoute(
                            builder: (currentContext) => const AppLoginPage(),
                          ),
                        );
                      }
                    }
                  ),
                  ElevatedButton( // Login With Google button
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(widget.buttonNameGoogle),
                        const SizedBox(width: 8), // Add spacing between the icon and text
                        Image.asset(
                          'assets/loginPage/googleIcon.jpeg',
                          width: 32,
                          height: 32,
                        ),
                      ],
                    ),
                    onPressed: () async {
                      BuildContext currentContext = context;
                      
                      setState(() {
                        isLoading = true;
                      });
                  
                      String? token;
                      
                      // try{
                      //   token = await SalesforceAuthService.authenticate(context);
                      //   if(token == null) throw FinPlanException('Token is null in FinPlanLoginPage build');
                      // }
                      // catch(e, stacktrace){
                      //   Logger().d('Error occurred in Login Page build : ${e.toString()}, stacktrace  :$stacktrace');
                      // }

                      await Future.delayed(Duration(seconds: 1));
                     
                      setState(() {
                        isLoading = false;
                      });
                            
                      Logger().d('Token is $token');
                  
                      if (token != null) {
                        Navigator.pushReplacement(
                          currentContext,
                          MaterialPageRoute(
                            builder: (currentContext) => const HomePage(),
                          ),
                        );
                      } else {
                        // Send to Login
                        Logger().d('Error');
                        Navigator.pushReplacement(
                          currentContext,
                          MaterialPageRoute(
                            builder: (currentContext) => const AppLoginPage(),
                          ),
                        );
                      }
                    }
                  ),
                  ElevatedButton( // Login With OTP
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(widget.buttonNameOTP),
                        const SizedBox(width: 8), // Add spacing between the icon and text
                        Image.asset(
                          'assets/loginPage/dialerIcon.jpeg',
                          width: 32,
                          height: 32,
                        ),
                      ],
                    ),
                    onPressed: () async {
                      BuildContext currentContext = context;
                      Logger().d('Token call not started yet!');
                      
                      setState(() {
                        isLoading = true;
                      });
                  
                      String? token;
                      // try{
                      //   token = await SalesforceAuthService.authenticate(context);
                      //   if(token == null) throw FinPlanException('Token is null in FinPlanLoginPage build');
                      // }
                      // catch(e, stacktrace){
                      //   Logger().d('Error occurred in Login Page build : ${e.toString()}, stacktrace : $stacktrace');
                      // }

                      await Future.delayed(Duration(seconds: 1));

                      setState(() {
                        isLoading = false;
                      });
                            
                      Logger().d('Token is $token');
                  
                      if(!mounted) return;

                      if (token != null) {
                        Navigator.pushReplacement(
                          currentContext,
                          MaterialPageRoute(
                            builder: (currentContext) => const HomePage(),
                          ),
                        );
                      } else {
                        // Send to Login
                        Logger().d('Error');
                        Navigator.pushReplacement(
                          currentContext,
                          MaterialPageRoute(
                            builder: (currentContext) => const AppLoginPage(),
                          ),
                        );
                      }
                      
                    }
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}