import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:petshopdashboard/core/app_colors.dart';

class PrimaryTextfield extends StatelessWidget {
  const PrimaryTextfield({
    super.key,
    this.suffixIcon,
    this.hintText,
    this.controller,
    this.keyboardType,
    this.obscureText,
  });

  final Widget? suffixIcon;
  final String? hintText;
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final bool? obscureText;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 295,
        height: 55,
        padding: const EdgeInsets.symmetric(vertical: 12),
        child: TextField(
          controller: controller,
          keyboardType: keyboardType ?? TextInputType.text,
          obscureText: obscureText ?? false,
          decoration: InputDecoration(
            hintText: hintText ?? 'Enter text',
            suffixIcon: suffixIcon,
            hintStyle: GoogleFonts.dmSans(
              fontSize: 16,
              fontWeight: FontWeight.w400,
              height: 20.83 / 16,
              color: AppColors.minimalBlack,
            ),
            enabledBorder: const UnderlineInputBorder(
              borderSide: BorderSide(
                color: AppColors.minimalGray,
              ), // Customize color as needed
            ),
            focusedBorder: const UnderlineInputBorder(
              borderSide: BorderSide(
                color: AppColors.minimalGray,
              ), // Customize color as needed
            ),
          ),
        ),
      ),
    );
  }
}
