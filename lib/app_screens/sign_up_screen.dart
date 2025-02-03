import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:officeflow/controller/app_controller.dart';
import 'package:officeflow/app_screens/sign_in_screen.dart';
import 'package:officeflow/widgets/custom_elevated_button.dart';
import 'package:officeflow/widgets/custom_textformfield.dart';

class SignUpScreen extends StatelessWidget {
  SignUpScreen({super.key});
  final appController = Get.find<AppController>();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    void onRegisterButton() async {
      if (_formKey.currentState!.validate()) {
        appController.validateName(appController.nameController.text);
        appController.validateEmail(appController.regEmailController.text,
            isRegistration: true);
        appController.validatePassword(appController.regPassController.text,
            isRegistration: true);

        if (appController.nameValidationMsg.value.isEmpty &&
            appController.regEmailValidationMsg.value.isEmpty &&
            appController.regPasswordValidationMsg.value.isEmpty) {
          if (!appController.isChecked.value) {
            Get.snackbar("Error", "You must agree to the Terms and Conditions.",
                backgroundColor: Colors.red);
            return;
          }
          await appController.signUp();
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
              Image.asset(
                'assets/images/signup-logo.png',
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
                            'Sign Up',
                            style: GoogleFonts.inter(
                              color: const Color.fromRGBO(114, 49, 153, 1),
                              fontWeight: FontWeight.w700,
                              fontSize: width * 0.075,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Lets get Started',
                            textAlign: TextAlign.center,
                            style: GoogleFonts.inter(
                              color: const Color.fromRGBO(114, 49, 153, 1),
                              fontWeight: FontWeight.w500,
                              fontSize: width * 0.043,
                            ),
                          ),
                          SizedBox(height: height * 0.035),
                          CustomTextFormField(
                            label: 'Full Name',
                            controller: appController.nameController,
                          ),
                          Obx(
                            () => Padding(
                              padding: EdgeInsets.only(left: width * 0.085),
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  appController.nameValidationMsg.value,
                                  style: GoogleFonts.inter(
                                    fontSize: 11,
                                    color: const Color.fromRGBO(255, 3, 3, 1),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: height * 0.01),
                          CustomTextFormField(
                            label: 'Email',
                            controller: appController.regEmailController,
                          ),
                          Obx(
                            () => Padding(
                              padding: EdgeInsets.only(left: width * 0.085),
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  appController.regEmailValidationMsg.value,
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
                              controller: appController.regPassController,
                              onToggleVisibility:
                                  appController.toggleObscureText,
                            ),
                          ),
                          SizedBox(height: height * 0.02),
                          Obx(
                            () => CustomTextFormField(
                              label: 'Confirm Password',
                              isPassword: true,
                              obscureText: appController.obscureTextSec.value,
                              controller: appController.confirmPassController,
                              onToggleVisibility:
                                  appController.toggleConfirmObscureText,
                            ),
                          ),
                          Obx(
                            () => Padding(
                              padding: EdgeInsets.only(left: width * 0.085),
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  appController.regPasswordValidationMsg.string,
                                  style: GoogleFonts.inter(
                                    fontSize: 11,
                                    color: const Color.fromRGBO(255, 3, 3, 1),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: width * 0.040),
                            child: Row(
                              children: [
                                Obx(
                                  () => Checkbox(
                                      checkColor: Colors.white,
                                      activeColor:
                                          const Color.fromRGBO(114, 49, 153, 1),
                                      value: appController.isChecked.value,
                                      onChanged: (value) {
                                        appController.isCheckBoxChecked(value);
                                      }),
                                ),
                                RichText(
                                  text: TextSpan(
                                    children: [
                                      TextSpan(
                                        text: 'Agree with ',
                                        style: GoogleFonts.poppins(
                                          color: Colors.black,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                      TextSpan(
                                        text: 'Terms and Conditions',
                                        style: GoogleFonts.poppins(
                                          color: Color.fromRGBO(255, 3, 3, 1),
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: height * 0.055,
                            width: width * 0.7,
                            child: Obx(
                              () => appController.isLoading.value
                                  ? Center(
                                      child: CircularProgressIndicator(),
                                    )
                                  : CustomElevatedButton(
                                      text: 'Sign Up',
                                      onPressed: onRegisterButton,
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
                              Get.to(() => SignInScreen());
                            },
                            child: RichText(
                              text: TextSpan(
                                children: [
                                  TextSpan(
                                    text: 'Already have an account? ',
                                    style: GoogleFonts.poppins(
                                      color: const Color.fromRGBO(0, 0, 0, 0.5),
                                      fontSize: width * 0.040,
                                    ),
                                  ),
                                  TextSpan(
                                    text: 'Sign In',
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
