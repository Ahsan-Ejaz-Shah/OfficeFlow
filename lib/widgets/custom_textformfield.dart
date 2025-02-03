import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomTextFormField extends StatelessWidget {
  final bool isEnabled;
  final String label;
  final bool isPassword;
  final TextEditingController? controller;
  final bool obscureText;
  final VoidCallback? onToggleVisibility;
  final String? Function(String?)? validator; 
  final TextInputType keyboardType; // Added keyboard type
  final int? maxLines; // Added maxLines property
  final int? minLines; // Added minLines property
  final TextCapitalization textCapitalization; // Added text capitalization

  CustomTextFormField({
    Key? key,
    required this.label,
    this.isPassword = false,
    this.isEnabled = true,
    this.controller,
    this.obscureText = false,
    this.onToggleVisibility,
    this.validator,
    this.keyboardType = TextInputType.text,
    this.maxLines = 1,
    this.minLines,
    this.textCapitalization = TextCapitalization.none,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Padding(
      padding: EdgeInsets.only(left: width * 0.075, right: width * 0.075),
      child: TextFormField(
        
        controller: controller,
        obscureText: isPassword ? obscureText : false,
        keyboardType: keyboardType, // Set keyboard type
        maxLines: maxLines, // Set maxLines
        minLines: minLines, // Set minLines
        textCapitalization: textCapitalization, // Set text capitalization
        decoration: InputDecoration(
          enabled: isEnabled,
          label: Text(
            label,
            style: GoogleFonts.poppins(
              color: const Color.fromRGBO(0, 0, 0, 0.87),
              fontWeight: FontWeight.w700,
              fontSize: width * 0.040,
            ),
          ),
          
          border: OutlineInputBorder(
            borderSide: const BorderSide(
              color: Colors.grey,
            ),
            borderRadius: BorderRadius.circular(12),
          ),
          contentPadding: const EdgeInsets.symmetric(
            vertical: 15,
            horizontal: 15,
          ),
          suffixIcon: isPassword
              ? GestureDetector(
                  onTap: onToggleVisibility,
                  child: Icon(
                    obscureText ? Icons.visibility_off : Icons.visibility,
                    color: Colors.black,
                  ),
                )
              : null,
        ),
        validator: validator, // Add validator property
      ),
    );
  }
}
