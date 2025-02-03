import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';

import 'package:officeflow/app_screens/main_screen.dart';
import 'package:officeflow/app_screens/sign_in_screen.dart';
import 'package:officeflow/controller/app_controller.dart';

import 'package:officeflow/onboard_screens/onboard_view.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final controller = Get.find<AppController>();
  final secureStorage = FlutterSecureStorage();

  @override
  void initState() {
    super.initState();

    Timer(
      const Duration(seconds: 4),
      () {
        _navigateBasedOnOnboardingStatus();
      },
    );
  }

 void _navigateBasedOnOnboardingStatus() async {
  final hasSeenOnboarding = await hasCompletedOnboarding();
  final token = await secureStorage.read(key: "token_key");

  // Only navigate to MainScreen if the user has signed in (i.e., the token exists and is valid).
  if (hasSeenOnboarding) {
    if (token != null) {
      // You can make an additional API call to verify token validity if needed
      // Before navigating to MainScreen, check if the token is valid
      final isLoggedIn = controller.isLoggedIn();

      if (isLoggedIn) {
        Get.offAll(() => MainScreen());
      } else {
        // Token exists but is not valid, so show SignInScreen
        Get.off(() => SignInScreen());
      }
    } else {
      // If token doesn't exist, direct user to the SignInScreen
      Get.off(() => SignInScreen());
    }
  } else {
    // If the onboarding has not been completed, show the Onboarding screen
    Get.off(() => OnboardView());
  }
}


  Future<bool> hasCompletedOnboarding() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    return sp.getBool('hasSeenOnboarding') ?? false;
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Stack(
          children: [
            Positioned(
              bottom: -height * 0.9,
              left: -width * 0.9,
              child: Container(
                width: width * 1.5,
                height: height * 1.7,
                decoration: BoxDecoration(
                  color: const Color.fromRGBO(114, 49, 153, 1),
                  shape: BoxShape.circle,
                ),
              ),
            ),
            Positioned(
              top: 0,
              right: 0,
              child: Container(
                width: width * 0.4,
                height: height * 0.2,
                decoration: const BoxDecoration(
                  color: Color.fromRGBO(114, 49, 153, 1),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(400),
                  ),
                ),
              ),
            ),
            Center(
              child: Image.asset(
                'assets/images/logo.png',
                width: width * 0.5,
                height: height * 0.3,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
