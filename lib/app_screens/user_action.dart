import 'dart:io';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:officeflow/controller/app_controller.dart';
import 'package:officeflow/widgets/custom_elevated_button.dart';
import 'package:officeflow/widgets/custom_textformfield.dart';

import 'main_screen.dart';

class UserAction extends StatefulWidget {
  UserAction({super.key});

  @override
  State<UserAction> createState() => _UserActionState();
}

class _UserActionState extends State<UserAction> {
  @override
  void initState() {
    userNameController = TextEditingController(text: controller.userName.value);
    userEmailController =
        TextEditingController(text: controller.userEmail.value);
    super.initState();
  }

  final controller = Get.find<AppController>();

  final _formKey = GlobalKey<FormState>();
  late TextEditingController userNameController;
  late TextEditingController userEmailController;

  @override
  void dispose() {
    userNameController.dispose();
    userEmailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
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
                      'User Profile',
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
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.topLeft,
                    child: Padding(
                      padding: EdgeInsets.only(left: width * 0.045),
                      child: Text(
                        'General',
                        style: GoogleFonts.inter(
                          fontWeight: FontWeight.w500,
                          color: Color.fromRGBO(0, 0, 0, 1),
                          fontSize: width * 0.050,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: height * 0.3,
                    width: width * 0.5,
                    child: GestureDetector(
                      onTap: () => _showImageSourceDialog(context),
                      child: Obx(
                        () => CircleAvatar(
                          radius: 60,
                          backgroundColor: Colors.grey[200],
                          backgroundImage: controller.selectedImage.value
                                  is String
                              ? NetworkImage(controller.selectedImage.value
                                  as String) // If it's a URL
                              : controller.selectedImage.value is File
                                  ? FileImage(controller.selectedImage.value
                                      as File) // If it's a local file
                                  : AssetImage("assets/images/boy.png")
                                      as ImageProvider, // Default image
                          child: controller.selectedImage.value == null
                              ? const Icon(
                                  Icons.camera_alt,
                                  size: 40,
                                  color: Colors.grey,
                                )
                              : null,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: height * 0.035,
                  ),
                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        CustomTextFormField(
                          label: 'Full Name',
                          controller: userNameController,
                          validator: (value) {
                            if (userNameController.text.isEmpty) {
                              return 'Please enter name';
                            }
                            return null;
                          },
                        ),
                        SizedBox(
                          height: height * 0.020,
                        ),
                        CustomTextFormField(
                          isEnabled: false,
                          label: 'Email',
                          controller: userEmailController,
                          validator: (value) {
                            if (userEmailController.text.isEmpty) {
                              return 'Please enter email';
                            }
                            return null;
                          },
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: height * 0.020,
                  ),
                  SizedBox(
                    height: height * 0.050,
                  ),
                  SizedBox(
                    height: height * 0.050,
                    width: width * 0.8,
                    child: CustomElevatedButton(
                      text: 'Save Details',
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          await controller.updateUserProfile(
                            userNameController.text,
                            userEmailController.text,
                            controller.selectedImage.value,
                          );
                        } else {
                          Get.snackbar(
                            'Error',
                            'Please fill in all required fields.',
                            snackPosition: SnackPosition.BOTTOM,
                            backgroundColor: Colors.red,
                            colorText: Colors.white,
                            icon:
                                const Icon(Icons.error, color: Colors.white),
                          );
                        }
                      },
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

  void _showImageSourceDialog(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return SafeArea(
          child: Wrap(
            children: [
              ListTile(
                leading: const Icon(Icons.camera_alt),
                title: const Text("Take Photo"),
                onTap: () =>
                    controller.pickImage(context, source: ImageSource.camera),
              ),
              ListTile(
                leading: const Icon(Icons.photo_library),
                title: const Text("Choose from Gallery"),
                onTap: () =>
                    controller.pickImage(context, source: ImageSource.gallery),
              ),
            ],
          ),
        );
      },
    );
  }
}
