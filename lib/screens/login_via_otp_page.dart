import 'package:finmind/sf/salesforce_oauth2_controller.dart';
import 'package:finmind/widgets/wavy_clipper.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

class LoginViaOTPPage extends StatelessWidget {
  final TextEditingController phoneController = TextEditingController();

  LoginViaOTPPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Blue Background
          Container(
            color: Colors.blue,
            child: Column(
              children: [
                // Wavy Clip Path
                ClipPath(
                  clipper: WavyClipper(),
                  child: Container(
                    height: 300,
                    color: Colors.purple,
                  ),
                ),
              ],
            ),
          ),
          // Content Section (Positioned over the purple part)
          Positioned.fill(
            top: 200, // Adjust to align below the wavy curve
            child: Container(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Phone Input Field
                  TextField(
                    controller: phoneController,
                    decoration: InputDecoration(
                      // labelText: "Phone",
                      hintText: "Enter your phone number",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      filled: true,
                      fillColor: Colors.white,
                      contentPadding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16), // Added padding
                    ),
                    keyboardType: TextInputType.phone,
                  ),
                  const SizedBox(height: 16.0),
                  // Submit Button
                  ElevatedButton(
                    onPressed: () async {
                      Logger().d('Phone: ${phoneController.text}');
                      await handleLoginViaOTP(phoneController.text);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blueAccent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                    child: const Text(
                      "Submit",
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                  const SizedBox(height: 24.0),
                  // Terms and Conditions
                  Center(
                    child: GestureDetector(
                      onTap: () {
                        // Handle terms and conditions navigation
                        print("Terms and Conditions clicked");
                      },
                      child: const Text(
                        "Terms and Conditions",
                        style: TextStyle(
                          color: Colors.white,
                          decoration: TextDecoration.underline,
                        ),
                      ),
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
  
  Future<void> handleLoginViaOTP(String phone) async{
    final result = await SalesforceAuth2Controller.loginViaOTP();
    Logger().d('inside handleLoginViaOTP method, result=> $result');
  }
}
