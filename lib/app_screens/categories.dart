import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:officeflow/app_screens/main_screen.dart';

import 'package:officeflow/widgets/manage_category_listview.dart';

class Categories extends StatelessWidget {
  const Categories({super.key});

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
                      'Categories',
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
                'Manage Categories',
                style: GoogleFonts.inter(
                  fontWeight: FontWeight.w500,
                  color: Color.fromRGBO(0, 0, 0, 1),
                  fontSize: width * 0.050,
                ),
              ),
            ),
          ),
          Expanded(
            child: ManageCategoryListview(),
          ),
        ],
      ),
    );
  }
}
