import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:officeflow/api_services.dart';
import 'package:officeflow/app_screens/categories.dart';
import 'package:officeflow/app_screens/change_password.dart';
import 'package:officeflow/app_screens/export_csv.dart';
import 'package:officeflow/app_screens/user_action.dart';
import 'package:officeflow/controller/app_controller.dart';
import 'package:officeflow/widgets/custom_container.dart';

class SettingsScreen extends StatelessWidget {
  SettingsScreen({super.key});
  final AppController controller = Get.find<AppController>();
  final apiService = ApiServices();

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      body: WillPopScope(
        onWillPop: () async{
         
          return false;
        },
        child: Column(
          //crossAxisAlignment: CrossAxisAlignment.start,
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
                      Text(
                        'More Actions',
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
              height: height * 0.040,
            ),
            Container(
              height: height * 0.13,
              width: width * 0.9,
              decoration: BoxDecoration(
                color: Color.fromRGBO(241, 218, 255, 1),
                borderRadius: BorderRadius.circular(19),
              ),
              child: Padding(
                padding: EdgeInsets.all(width * 0.025),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: EdgeInsets.all(width * 0.025),
                      child: Column(
                        children: [
                          FaIcon(
                            FontAwesomeIcons.crown,
                            color: Color.fromRGBO(248, 189, 0, 1),
                            size: 45,
                          ),
                          //Image.asset('assets/images/premium-logo.png'),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(width * 0.025),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'OfficeFlow Premium',
                            style: GoogleFonts.inter(
                                color: Color.fromRGBO(0, 0, 0, 1),
                                fontWeight: FontWeight.w600,
                                fontSize: width * 0.050),
                          ),
                          Text(
                            'Expense like a pro with Officeflow \nPremium',
                            style: GoogleFonts.inter(
                              color: Color.fromRGBO(0, 0, 0, 1),
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: height * 0.015,
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: width * 0.055),
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          'More Features',
                          style: GoogleFonts.inter(
                            color: Color.fromRGBO(0, 0, 0, 1),
                            fontWeight: FontWeight.w200,
                            fontSize: width * 0.050,
                          ),
                        ),
                      ),
                    ),
                    Divider(
                      indent: 15,
                      color: Color.fromRGBO(114, 49, 153, 0.1),
                      endIndent: 15,
                    ),
                    SizedBox(
                      height: height * 0.015,
                    ),
                    SettingsContainer(
                        title: 'Categories',
                        subTitle: 'Create and manage custom categories',
                        prefixIcon: Icons.category,
                        suffixIcon: FontAwesomeIcons.chevronRight,
                        onTap: () {
                          Get.to(() => Categories());
                        }),
                    Divider(
                      indent: 15,
                      color: Color.fromRGBO(114, 49, 153, 0.1),
                      endIndent: 15,
                    ),
                    SettingsContainer(
                        title: 'Export Expenses',
                        subTitle: 'Export Expenses as a CSV file',
                        prefixIcon: Icons.upload_file,
                        suffixIcon: FontAwesomeIcons.chevronRight,
                        onTap: () {
                          Get.to(()=> ExportCsv());
                        }),
                    Divider(
                      indent: 15,
                      color: Color.fromRGBO(114, 49, 153, 0.1),
                      endIndent: 15,
                    ),
                    SettingsContainer(
                        title: 'User Profile',
                        subTitle: 'Change Profile Name, Logout and Delete Data',
                        prefixIcon: FontAwesomeIcons.user,
                        suffixIcon: FontAwesomeIcons.chevronRight,
                        onTap: () {
                          Get.to(() => UserAction());
                        }),
                    Divider(
                      indent: 15,
                      color: Color.fromRGBO(114, 49, 153, 0.1),
                      endIndent: 15,
                    ),
                    SettingsContainer(
                        title: 'Change Password',
                        subTitle: 'Update your password securely',
                        prefixIcon: FontAwesomeIcons.key,
                        suffixIcon: FontAwesomeIcons.chevronRight,
                        onTap: () {
                          Get.to(() => ChangePassword());
                        }),
                    Divider(
                      indent: 15,
                      color: Color.fromRGBO(114, 49, 153, 0.1),
                      endIndent: 15,
                    ),
                    SettingsContainer(
                        title: 'Titles',
                        subTitle: 'Edit your title in one step',
                        prefixIcon: FontAwesomeIcons.t,
                        suffixIcon: FontAwesomeIcons.chevronRight,
                        onTap: () {}),
                    SizedBox(
                      height: height * 0.015,
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: width * 0.055),
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          'Other Settings',
                          style: GoogleFonts.inter(
                            color: Color.fromRGBO(0, 0, 0, 1),
                            fontWeight: FontWeight.w200,
                            fontSize: width * 0.050,
                          ),
                        ),
                      ),
                    ),
                    Divider(
                      indent: 15,
                      color: Color.fromRGBO(114, 49, 153, 0.1),
                      endIndent: 15,
                    ),
                    SizedBox(
                      height: height * 0.015,
                    ),
                    SettingsContainer(
                        title: 'Rate Us',
                        subTitle: 'Please take a moment to rate us on store',
                        prefixIcon: FontAwesomeIcons.star,
                        suffixIcon: FontAwesomeIcons.chevronRight,
                        onTap: () {}),
                    SizedBox(
                      height: height * 0.015,
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: width * 0.055),
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          'Privacy and Security',
                          style: GoogleFonts.inter(
                            color: Color.fromRGBO(0, 0, 0, 1),
                            fontWeight: FontWeight.w200,
                            fontSize: width * 0.050,
                          ),
                        ),
                      ),
                    ),
                    Divider(
                      indent: 15,
                      color: Color.fromRGBO(114, 49, 153, 0.1),
                      endIndent: 15,
                    ),
                    SizedBox(
                      height: height * 0.015,
                    ),
                    SettingsContainer(
                        title: 'Personal Data & Privacy',
                        subTitle: 'Review and manage your settings',
                        prefixIcon: FontAwesomeIcons.shield,
                        suffixIcon: FontAwesomeIcons.chevronRight,
                        onTap: () {}),
                    Divider(
                      indent: 15,
                      color: Color.fromRGBO(114, 49, 153, 0.1),
                      endIndent: 15,
                    ),
                    SettingsContainer(
                        title: 'FAQS',
                        subTitle: 'Answers to your queries and concerns',
                        prefixIcon: FontAwesomeIcons.message,
                        suffixIcon: FontAwesomeIcons.chevronRight,
                        onTap: () {}),
                    Divider(
                      indent: 15,
                      color: Color.fromRGBO(114, 49, 153, 0.1),
                      endIndent: 15,
                    ),
                    SettingsContainer(
                        title: 'Logout',
                        subTitle: 'Answers to your queries and concerns',
                        prefixIcon: FontAwesomeIcons.signOut,
                        suffixIcon: FontAwesomeIcons.chevronRight,
                        onTap: () {
                          apiService.logout();
                        }),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
