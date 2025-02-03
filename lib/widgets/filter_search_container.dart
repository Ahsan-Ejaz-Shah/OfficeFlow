import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:google_fonts/google_fonts.dart';

class FilterSearchContainer extends StatelessWidget {
  const FilterSearchContainer({super.key, required this.pickedDate});
  final String pickedDate;

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Container(
      height: height * 0.060,
      width: width * 0.85,
      decoration: BoxDecoration(
        border: Border.all(
          color: Color.fromRGBO(114, 49, 153, 1),
        ),
        borderRadius: BorderRadius.circular(2),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: EdgeInsets.all(width * 0.015),
            child: Text(
              pickedDate,
              style: GoogleFonts.inter(
                  fontSize: 14,
                  color: Color.fromRGBO(0, 0, 0, 0.73),
                  fontWeight: FontWeight.w500),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(right: width * 0.015),
            child: Container(
              height: height * 0.050,
              width: width * 0.115,
              decoration: BoxDecoration(
                color: Color.fromRGBO(114, 49, 153, 1),
                borderRadius: BorderRadius.circular(3),
              ),
              child: Center(
                child: FaIcon(
                  FontAwesomeIcons.calendar,
                  color: Color.fromRGBO(255, 255, 255, 1),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
