import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:officeflow/controller/app_controller.dart';
import 'package:officeflow/widgets/custom_elevated_button.dart';
import 'package:officeflow/widgets/custom_textformfield.dart';

import 'main_screen.dart';

// ignore: must_be_immutable
class ChangePassword extends StatelessWidget {
  ChangePassword({super.key});
  TextEditingController currentPasscontroller = TextEditingController();
  TextEditingController newPasscontroller = TextEditingController();
  TextEditingController confirmPasscontroller = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    AppController controller = Get.find<AppController>();
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Form(
        key: _formKey,
        child: Column(
          children: [
            Container(
              height: height * 0.15,
              decoration: BoxDecoration(
                color: Color.fromRGBO(114, 49, 153, 1),
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(30),
                  bottomRight: Radius.circular(30),
                ),
              ),
              child: Align(
                alignment: Alignment.bottomLeft,
                child: Padding(
                  padding: EdgeInsets.only(
                    left: width * 0.045,
                    right: width * 0.055,
                    bottom: height * 0.020,
                  ),
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          Get.off(() => MainScreen());
                        },
                        child: const FaIcon(
                          FontAwesomeIcons.chevronLeft,
                          color: Color.fromRGBO(255, 255, 255, 1),
                        ),
                      ),
                      SizedBox(width: width * 0.01),
                      Text(
                        'Change Password',
                        style: GoogleFonts.inter(
                          fontSize: width * 0.050,
                          color: const Color.fromRGBO(255, 255, 255, 1),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              height: height * 0.035,
            ),
            Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: EdgeInsets.only(left: width * 0.045),
                child: Text(
                  'Your new password must be unique from those previously used.',
                  style: GoogleFonts.inter(
                    fontWeight: FontWeight.w400,
                    color: Color.fromRGBO(0, 0, 0, 1),
                    fontSize: width * 0.050,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: height * 0.040,
            ),
            Obx(
              () => CustomTextFormField(
                label: 'Current Password*',
                controller: currentPasscontroller,
                isPassword: true,
                obscureText: controller.obscureText.value,
                onToggleVisibility: controller.toggleObscureText,
                validator: (value) {
                  if (currentPasscontroller.text.isEmpty) {
                    return 'Please enter current password';
                  }
                  return null;
                },
              ),
            ),
            SizedBox(
              height: height * 0.020,
            ),
            Obx(
              () => CustomTextFormField(
                controller: newPasscontroller,
                label: 'New Password*',
                isPassword: true,
                obscureText: controller.obscureTextSec.value,
                onToggleVisibility: controller.toggleConfirmObscureText,
                validator: (value) {
                  if (newPasscontroller.text.isEmpty) {
                    return 'Please enter new password';
                  }
                  return null;
                },
              ),
            ),
            SizedBox(
              height: height * 0.020,
            ),
            Obx(
              () => CustomTextFormField(
                controller: confirmPasscontroller,
                label: 'Confirm New Password*',
                isPassword: true,
                obscureText: controller.obscureTextSec.value,
                onToggleVisibility: controller.toggleConfirmObscureText,
                validator: (value) {
                  if (confirmPasscontroller.text.isEmpty) {
                    return 'Please enter confirm password';
                  }
                  return null;
                },
              ),
            ),
            SizedBox(
              height: height * 0.020,
            ),
            SizedBox(
              height: height * 0.050,
              width: width * 0.8,
              child: CustomElevatedButton(
                text: 'Create New Password',
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    controller.changePass(currentPasscontroller.text,
                        newPasscontroller.text, confirmPasscontroller.text);
                  }
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
