
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PieChartCategories extends StatelessWidget {
  final Color color;
  final String label;

  const PieChartCategories({required this.color, required this.label});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          height: height * 0.015,
          width: width * 0.035,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.rectangle,
          ),
        ),
        SizedBox(width: 4),
        Text(
          label,
          style: GoogleFonts.inter(
              color: Color.fromRGBO(0, 0, 0, 1),
              fontWeight: FontWeight.w700,
              fontSize: width * 0.030),
        ),
      ],
    );
  }
}
