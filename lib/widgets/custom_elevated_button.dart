import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomElevatedButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  const CustomElevatedButton({
    required this.text,
    required this.onPressed,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor:
            Color.fromRGBO(114, 49, 153, 1), // Button background color
        foregroundColor: Color.fromRGBO(255, 255, 255, 1), // Text color
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(84), // Rounded corners
        ),
      ),
      child: Text(
        text,
        style: GoogleFonts.inter(
          fontWeight: FontWeight.w700,
          fontSize: 18,
        ),
      ),
    );
  }
}
