import 'package:flutter/material.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';


class SettingsContainer extends StatelessWidget {
  SettingsContainer({
    super.key,
    required this.title,
    required this.subTitle,
    required this.prefixIcon,
    required this.suffixIcon,
    required this.onTap,
  });
  final String title;
  final String subTitle;
  final IconData prefixIcon;
  final IconData suffixIcon;
  final void Function() onTap;


  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: height * 0.055,
        width: width * 0.9,
        decoration: BoxDecoration(
          color: Colors.white,
        ),
        child: Row(
          children: [
            Padding(
              padding: EdgeInsets.all(width * 0.025),
              child: Column(
                children: [
                  Icon(
                    prefixIcon,
                    color: Color.fromRGBO(0, 0, 0, 0.46),
                    size: 20,
                  ),
                  //Image.asset('assets/images/premium-logo.png'),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: GoogleFonts.inter(
                      color: Color.fromRGBO(0, 0, 0, 1),
                      fontWeight: FontWeight.w600,
                      fontSize: width * 0.035),
                ),
                Text(
                  subTitle,
                  style: GoogleFonts.inter(
                    color: Color.fromRGBO(0, 0, 0, 1),
                    fontWeight: FontWeight.w200,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
            Spacer(),
            Padding(
              padding: EdgeInsets.all(width * 0.025),
              child: Column(
                children: [
                  FaIcon(
                    suffixIcon,
                    color: Color.fromRGBO(114, 49, 153, 1),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
