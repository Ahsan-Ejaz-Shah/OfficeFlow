import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:officeflow/app_screens/add_category.dart';
import 'package:officeflow/app_screens/add_expense.dart';
import 'package:officeflow/app_screens/home_screen.dart';
import 'package:officeflow/app_screens/settings.dart';

import 'package:officeflow/widgets/custom_navbar.dart';
import 'package:officeflow/app_screens/summary.dart';

import '../controller/app_controller.dart';

class MainScreen extends StatefulWidget {
  MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final controller = Get.find<AppController>();
  final secureStorage = FlutterSecureStorage();
  @override
  void initState() {
    // tokenVerification();
    super.initState();
  }

  // void tokenVerification() async {
  //   final storedToken = await secureStorage.read(key: "token_key");
  //   if (storedToken != null) {
  //     controller.loadUserDetails();
  //   } else {
  //     Get.off(() => SignInScreen());
  //   }
  // }

  final List<Widget> _screens = [
    HomeScreen(),
    AddCategoryScreen(),
    SummaryScreen(),
    SettingsScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(
        () => IndexedStack(
          index: controller.selectedIndex.value,
          children: _screens,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        shape: CircleBorder(),
        backgroundColor: Color.fromRGBO(114, 49, 153, 1),
        foregroundColor: Colors.white,
        onPressed: () {
      
          Get.to(() => AddExpense());
        },
        child: FaIcon(FontAwesomeIcons.plus),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: Obx(
        () => CustomBottomNavBar(
          onItemTapped: controller.onItemTapped,
          selectedIndex: controller.selectedIndex.value,
        ),
      ),
    );
  }
}
