import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:google_fonts/google_fonts.dart';

class ExportCsv extends StatelessWidget {
  const ExportCsv({super.key});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Export CSV File',
              style: GoogleFonts.inter(
                fontWeight: FontWeight.w600,
                fontSize: width * 0.090,
                color: Color.fromRGBO(114, 49, 153, 1),
              ),
            ),
            Container(
              height: height * 0.15,
              width: width * 0.9,
              decoration: BoxDecoration(
                color: Color.fromRGBO(246, 165, 52, 1),
                borderRadius: BorderRadius.circular(17),
                border: Border.all(
                  color: Color.fromRGBO(0, 0, 0, 1),
                ),
              ),
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                      left: width * 0.025,
                      right: width * 0.025,
                      top: height * 0.025,
                    ),
                    child: Row(
                      children: [
                        FaIcon(
                          FontAwesomeIcons.cloudArrowUp,
                          size: 30,
                        ),
                        Text(
                          'Data Backup',
                          style: GoogleFonts.inter(
                            color: Color.fromRGBO(0, 0, 0, 1),
                            fontWeight: FontWeight.w600,
                            fontSize: width * 0.065,
                          ),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      left: width * 0.025,
                      bottom: height * 0.025,
                      right: width * 0.025,
                    ),
                    child: Row(
                      children: [
                        Text(
                          'Exporting to CSV should not be used as a backup of data. Budgets and \ndetailed app data is not exported in the CSV! Please use Google Drive or the \nImport and Export data settings below.',
                          overflow: TextOverflow.ellipsis,
                          style: GoogleFonts.inter(
                              color: Color.fromRGBO(0, 0, 0, 1),
                              fontSize: width * 0.020),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: height * 0.030,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  height: height * 0.15,
                  width: width * 0.4,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: Colors.black,
                      )),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      FaIcon(
                        FontAwesomeIcons.calendar,
                        size: 43,
                      ),
                      SizedBox(
                        height: height * 0.010,
                      ),
                      Text(
                        'All Time',
                        style: GoogleFonts.inter(
                            color: Colors.black,
                            fontWeight: FontWeight.w700,
                            fontSize: width * 0.050),
                      ),
                    ],
                  ),
                ),
                Container(
                  height: height * 0.15,
                  width: width * 0.4,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: Colors.black,
                      )),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      FaIcon(
                        FontAwesomeIcons.calendar,
                        size: 43,
                      ),
                      SizedBox(
                        height: height * 0.010,
                      ),
                      Text(
                        'Date Range',
                        style: GoogleFonts.inter(
                            color: Colors.black,
                            fontWeight: FontWeight.w700,
                            fontSize: width * 0.050),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
