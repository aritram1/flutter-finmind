import 'package:finmind/widgets/wavy_clipper.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:finmind/screens/login_via_otp_page.dart';
import 'package:finmind/screens/login_via_salesforce_page.dart';
import 'package:finmind/util/constants.dart';
import 'package:finmind/widgets/login_provider_card.dart';

class AppLoginPage extends StatefulWidget {
  const AppLoginPage({
    super.key,
    this.message = Constants.LOGIN_PAGE_DEFAULT_MESSAGE,
    this.buttonNameSalesforce = Constants.LOGIN_PAGE_BUTTON_LOGIN_WITH_SALESFORCE,
    this.buttonNameGoogle = Constants.LOGIN_PAGE_BUTTON_LOGIN_WITH_GOOGLE,
    this.buttonNameOTP = Constants.LOGIN_PAGE_BUTTON_LOGIN_WITH_OTP,
    this.showLoginButton = true,
  });

  final String message;
  final String buttonNameSalesforce;
  final String buttonNameGoogle;
  final String buttonNameOTP;
  final bool showLoginButton;

  @override
  LoginPageState createState() => LoginPageState();
}

class LoginPageState extends State<AppLoginPage> {
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Blue Background
          Container(
            color: Colors.blue,
          ),
          // Wavy Purple Section
          ClipPath(
            clipper: WavyClipper(),
            child: Container(
              height: 300,
              color: Colors.purple,
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 48),
                  child: Text(
                    widget.message,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
          ),
          // Content Section (Owl Image and Buttons)
          Positioned.fill(
            top: 220, // Adjust this to place content below the wavy section
            child: Container(
              color: Colors.transparent, // Let the blue background show through
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Image Container
                  Container(
                    height: 200,
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.primary,
                      image: const DecorationImage(
                        image: NetworkImage(
                          'https://flutter.github.io/assets-for-api-docs/assets/widgets/owl-2.jpg',
                        ),
                        fit: BoxFit.cover,
                      ),
                      border: Border.all(
                        width: 2,
                        color: Colors.white,
                      ),
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  const SizedBox(height: 24.0),
                  // Text: Login With
                  Center(
                    child: Text(
                      'Login With',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 24.0),
                  // Login Buttons
                  Visibility(
                    visible: widget.showLoginButton,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        LoginProviderCard(
                          name: widget.buttonNameSalesforce,
                          image: 'assets/appLoginPage/salesforceIcon.png',
                          onTap: loginWithSalesforce,
                        ),
                        LoginProviderCard(
                          name: widget.buttonNameGoogle,
                          image: 'assets/appLoginPage/googleIcon.png',
                          onTap: loginWithGoogle,
                        ),
                        LoginProviderCard(
                          name: widget.buttonNameOTP,
                          image: 'assets/appLoginPage/dialerIcon.png',
                          onTap: loginWithOTP,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void loginWithSalesforce() {
    Logger().d('Trying to login via Salesforce!');
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => LoginViaOTPPage()), // Replace with your actual page
    );
  }

  void loginWithGoogle() {
    Logger().d('Trying to login via Google!');
    // Implement Google login or navigation logic here
  }

  void loginWithOTP() {
    Logger().d('Trying to login via OTP!');
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => LoginViaOTPPage()), // Replace with your actual page
    );
  }
}