import 'package:flutter/material.dart';


import 'package:google_fonts/google_fonts.dart';

import 'package:officeflow/widgets/category_grid.dart';

class AddCategoryScreen extends StatelessWidget {
  const AddCategoryScreen({super.key});
  

  @override
  Widget build(BuildContext context) {
 
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Color.fromRGBO(246, 241, 247, 1),
      body: WillPopScope(
        onWillPop: () async{
               return false;
        },
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
                      Text(
                        'Add Category',
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
              height: height * 0.030,
            ),
            Padding(
              padding: EdgeInsets.only(left: width * 0.055),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    'Categories',
                    style: GoogleFonts.inter(
                      color: Color.fromRGBO(114, 49, 153, 1),
                      fontWeight: FontWeight.w700,
                      fontSize: width * 0.060,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: height * 0.040,
            ),
           
            Expanded(
              child: CategoryGrid(),
            ),
          ],
        ),
      ),
    );
  }
}
