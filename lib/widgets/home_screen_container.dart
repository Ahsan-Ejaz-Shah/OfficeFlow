import 'dart:io';

import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:officeflow/controller/app_controller.dart';

class HomeScreenContainer extends StatefulWidget {
  const HomeScreenContainer({super.key});

  @override
  State<HomeScreenContainer> createState() => _HomeScreenContainerState();
}

class _HomeScreenContainerState extends State<HomeScreenContainer> {
  final controller = Get.find<AppController>();
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.loadUserDetails();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Container(
      height: height * 0.15,
      width: double.infinity,
      decoration: BoxDecoration(
        color: const Color.fromRGBO(114, 49, 153, 1),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(30),
          bottomRight: Radius.circular(30),
        ),
      ),
      child: Align(
        alignment: Alignment.bottomCenter,
        child: Padding(
          padding: EdgeInsets.only(
              left: width * 0.045,
              right: width * 0.055,
              bottom: height * 0.020),
          child: Row(
            children: [
              Obx(
                () => Text(
                  'Hi, ${controller.userName.value}',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.inder(
                    color: Color.fromRGBO(255, 255, 255, 1),
                    fontSize: width * 0.050,
                  ),
                ),
              ),
              Spacer(),
              Obx(
                () => CircleAvatar(
                  radius: 20,
                  backgroundColor: Colors.grey[200],
                  backgroundImage: controller.selectedImage.value != null
                      ? (controller.selectedImage.value is String
                          ? NetworkImage(
                              controller.selectedImage.value as String)
                          : FileImage(controller.selectedImage.value as File))
                      : AssetImage("assets/images/boy.png") as ImageProvider,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
