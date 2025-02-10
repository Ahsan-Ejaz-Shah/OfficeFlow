import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:officeflow/app_screens/sign_in_screen.dart';

import 'package:officeflow/controller/app_controller.dart';

import 'package:officeflow/onboard_screens/onboard_item.dart';
import 'package:officeflow/app_screens/sign_up_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnboardView extends StatefulWidget {
  @override
  State<OnboardView> createState() => _OnboardViewState();
}

class _OnboardViewState extends State<OnboardView> {
  @override
  void initState() {
    super.initState();
  }

  Future<void> setOnboardingComplete() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    await sp.setBool('hasSeenOnboarding', true);
  }

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<AppController>();
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final onBoardController = OnboardItem();
    final pageController = PageController();

    return Scaffold(
      backgroundColor: Colors.white,
      body: PageView.builder(
        itemCount: onBoardController.items.length,
        controller: pageController,
        onPageChanged: (index) {
          controller.currentPage.value = index;
        },
        itemBuilder: (context, index) {
          if (index == 3) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Image.asset(
                  'assets/images/finance-four.png',
                  width: width * 0.50,
                  height: height * 0.30,
                ),
                Container(
                  width: double.infinity,
                  height: height * 0.5,
                  decoration: BoxDecoration(
                    color: Color.fromRGBO(114, 49, 153, 1),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(40),
                      topRight: Radius.circular(40),
                    ),
                  ),
                  padding: EdgeInsets.symmetric(
                    vertical: height * 0.04,
                    horizontal: width * 0.05,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Welcome to OfficeFlow',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.inter(
                          color: Color.fromRGBO(250, 249, 249, 1),
                          fontSize: width * 0.07,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: height * 0.01),
                      Text(
                        'Your all-in-one solution for managing office tasks effortlessly.',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.inter(
                          color: Colors.white70,
                          fontSize: width * 0.045,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      SizedBox(height: height * 0.03),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          SizedBox(
                            width: width * 0.4,
                            child: ElevatedButton(
                              onPressed: () async {
                                setOnboardingComplete();

                                Get.off(() => SignInScreen());
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.white,
                                foregroundColor:
                                    Color.fromRGBO(114, 49, 153, 1),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                padding: EdgeInsets.symmetric(
                                  vertical: height * 0.02,
                                  horizontal: width * 0.1,
                                ),
                              ),
                              child: Text(
                                'Sign In',
                                style: GoogleFonts.inter(
                                  fontSize: width * 0.04,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: width * 0.4,
                            child: OutlinedButton(
                              onPressed: () {
                                setOnboardingComplete();
                                Get.off(() => SignUpScreen());
                              },
                              style: OutlinedButton.styleFrom(
                                side: BorderSide(
                                  color: Colors.white,
                                  width: width * 0.005,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                padding: EdgeInsets.symmetric(
                                  vertical: height * 0.02,
                                  horizontal: width * 0.1,
                                ),
                              ),
                              child: Text(
                                'Sign Up',
                                style: GoogleFonts.inter(
                                  color: Colors.white,
                                  fontSize: width * 0.04,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            );
          }

          
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                onBoardController.items[index].imagePath,
                width: width * 0.50,
                height: height * 0.30,
              ),
              Text(
                onBoardController.items[index].title,
                textAlign: TextAlign.center,
                style: GoogleFonts.inter(
                    color: Color.fromRGBO(114, 49, 153, 1),
                    fontSize: width * 0.080,
                    fontWeight: FontWeight.w700),
              ),
              Text(
                onBoardController.items[index].description,
                textAlign: TextAlign.center,
                style: GoogleFonts.inter(
                    color: Color.fromRGBO(0, 0, 0, 0.8),
                    fontSize: width * 0.050,
                    fontWeight: FontWeight.w300),
              ),
              SizedBox(
                height: height * 0.080,
              ),
              SmoothPageIndicator(
                controller: pageController,
                count: onBoardController.items.length,
                effect: ExpandingDotsEffect(
                  dotHeight: width * 0.03,
                  dotWidth: width * 0.03,
                  activeDotColor: Color.fromRGBO(114, 49, 153, 1),
                  dotColor: Color.fromRGBO(228, 182, 255, 1),
                  expansionFactor: 2,
                ),
              ),
              SizedBox(
                height: height * 0.080,
              ),
              SizedBox(
                width: width * 0.5,
                height: height * 0.060,
                child: ElevatedButton(
                  onPressed: () {
                    pageController.nextPage(
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeInOut,
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color.fromRGBO(114, 49, 153, 1),
                    foregroundColor: Colors.white,
                  ),
                  child: Text(
                    'Let\'s go',
                    style: GoogleFonts.inter(),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
