import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:officeflow/controller/app_controller.dart';

import 'package:officeflow/app_screens/sign_up_screen.dart';
import 'package:officeflow/widgets/custom_elevated_button.dart';
import 'package:officeflow/widgets/custom_textformfield.dart';



class SignInScreen extends StatefulWidget {
  SignInScreen({super.key});


  @override
  State<SignInScreen> createState() => _SignInScreenState();
}


class _SignInScreenState extends State<SignInScreen> {
  final appController = Get.find<AppController>();
  @override
  void initState() {
    
    super.initState();
  }

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    void _onLoginButton() async {
      if (_formKey.currentState!.validate()) {
        // Ensure validation messages are updated

        appController
            .validateEmail(appController.emailAddressController.value.text);
        appController
            .validatePassword(appController.passwordController.value.text);

        // Check if there are no observable validation messages
        if (appController.emailValidationMsg.value.isEmpty &&
            appController.passwordValidationMsg.value.isEmpty) {
          await appController.signIn();
        }
      }
    }

    Widget _buildSocialButton({
      required double width,
      required String icon,
      required VoidCallback onTap,
    }) {
      return GestureDetector(
        onTap: onTap,
        child: Container(
          width: width,
          height: width,
          decoration: BoxDecoration(
            border: Border.all(
              color: const Color.fromRGBO(114, 49, 153, 0.33),
              width: 1.5,
            ),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Center(
            child: Image.asset(
              icon,
              width: width * 0.5,
              height: width * 0.5,
            ),
          ),
        ),
      );
    }

    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.white,
      body: WillPopScope(
        onWillPop: () async {
          appController.clearValidationMessages();
          return true;
        },
        child: Container(
          decoration: const BoxDecoration(
            color: Color.fromRGBO(114, 49, 153, 1),
          ),
          child: Column(
            children: [
              SizedBox(
                height: height * 0.040,
              ),
              Center(
                child: Image.asset(
                  'assets/images/signin-logo.png',
                ),
              ),
              SizedBox(
                height: height * 0.040,
              ),
              Form(
                key: _formKey,
                child: Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(45),
                        topRight: Radius.circular(45),
                      ),
                    ),
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          Text(
                            'Sign In',
                            style: GoogleFonts.inter(
                              color: const Color.fromRGBO(114, 49, 153, 1),
                              fontWeight: FontWeight.w700,
                              fontSize: width * 0.075,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Hi welcome back. you’ve been missed',
                            textAlign: TextAlign.center,
                            style: GoogleFonts.inter(
                              color: const Color.fromRGBO(114, 49, 153, 1),
                              fontWeight: FontWeight.w500,
                              fontSize: width * 0.043,
                            ),
                          ),
                          SizedBox(height: height * 0.035),
                          CustomTextFormField(
                            label: 'Email',
                            controller: appController.emailAddressController,
                            //validator: appController.validateEmail,
                          ),
                          Obx(
                            () => Padding(
                              padding: EdgeInsets.only(left: width * 0.085),
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  appController.emailValidationMsg.value,
                                  style: GoogleFonts.inter(
                                    fontSize: 11,
                                    color: const Color.fromRGBO(255, 3, 3, 1),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: height * 0.01),
                          Obx(
                            () => CustomTextFormField(
                              label: 'Password',
                              isPassword: true,
                              obscureText: appController.obscureText.value,
                              controller: appController.passwordController,
                              onToggleVisibility:
                                  appController.toggleObscureText,
                              //validator: appController.validatePassword,
                            ),
                          ),
                          Obx(
                            () => Padding(
                              padding: EdgeInsets.only(left: width * 0.085),
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  appController.passwordValidationMsg.value,
                                  style: GoogleFonts.inter(
                                    fontSize: 11,
                                    color: const Color.fromRGBO(255, 3, 3, 1),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(right: width * 0.050),
                            child: Align(
                              alignment: Alignment.centerRight,
                              child: TextButton(
                                onPressed: () {},
                                child: Text(
                                  'Forgot Password?',
                                  style: GoogleFonts.poppins(
                                    fontWeight: FontWeight.w700,
                                    color: const Color.fromRGBO(255, 3, 3, 1),
                                    decoration: TextDecoration.underline,
                                    decorationColor:
                                        const Color.fromRGBO(255, 3, 3, 1),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: height * 0.055,
                            width: width * 0.7,
                            child: Obx(
                              () => appController.isLoading.value
                                  ? Center(child: CircularProgressIndicator())
                                  : CustomElevatedButton(
                                      text: 'Sign In',
                                      onPressed: _onLoginButton,
                                      // () {
                                      //   //Get.to(() => LanguagesScreen());
                                      // },
                                    ),
                            ),
                          ),
                          SizedBox(height: height * 0.025),
                          Row(
                            children: [
                              Expanded(
                                child: Divider(
                                  indent: 30,
                                  thickness: 1.5,
                                  color: const Color.fromRGBO(114, 49, 153, 1),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  'OR',
                                  style: GoogleFonts.inter(
                                    fontWeight: FontWeight.w500,
                                    fontSize: width * 0.040,
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Divider(
                                  endIndent: 30,
                                  thickness: 1.5,
                                  color: const Color.fromRGBO(114, 49, 153, 1),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: height * 0.025),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              _buildSocialButton(
                                width: width * 0.15,
                                icon: 'assets/images/apple-logo.png',
                                onTap: () {},
                              ),
                              SizedBox(width: width * 0.040),
                              _buildSocialButton(
                                width: width * 0.15,
                                icon: 'assets/images/google-logo.png',
                                onTap: () {},
                              ),
                              SizedBox(width: width * 0.040),
                              _buildSocialButton(
                                width: width * 0.15,
                                icon: 'assets/images/facebook-logo.png',
                                onTap: () {},
                              ),
                            ],
                          ),
                          SizedBox(height: height * 0.025),
                          TextButton(
                            onPressed: () {
                              Get.off(() => SignUpScreen());
                            },
                            child: RichText(
                              text: TextSpan(
                                children: [
                                  TextSpan(
                                    text: 'Don’t have an account? ',
                                    style: GoogleFonts.poppins(
                                      color: const Color.fromRGBO(0, 0, 0, 0.5),
                                      fontSize: width * 0.040,
                                    ),
                                  ),
                                  TextSpan(
                                    text: 'Sign Up',
                                    style: GoogleFonts.poppins(
                                      color:
                                          const Color.fromRGBO(114, 49, 153, 1),
                                      fontWeight: FontWeight.w700,
                                      fontSize: width * 0.040,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
