import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../app/resources/app_colors.dart';

class AppTextField extends StatelessWidget {
  final TextEditingController controller;
  final String label, hint;
  final IconData iconData;
  final TextInputType inputType;
  final bool? obscureText;
  final EdgeInsetsGeometry padding;
  final TextInputAction? textInputAction;
  final Function(String value)? onChanged;

  const AppTextField(
      {Key? key,
        required this.controller,
        required this.label,
        required this.hint,
        required this.iconData,
        required this.inputType,
        this.obscureText, required this.padding, this.textInputAction, this.onChanged})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      child: TextFormField(
        obscureText: obscureText ?? false,
        controller: controller,
        cursorColor: Colors.grey,
        keyboardType: inputType,
        textInputAction: textInputAction,
        style: GoogleFonts.roboto(color: Colors.black, fontSize: 17),
        onChanged: onChanged,
        decoration: InputDecoration(
          isDense: true,
          contentPadding: const EdgeInsets.all(5),
          prefixIcon: Icon(iconData, color: AppColors.primary, size: 25,),
          hintText: hint,
          hintStyle: GoogleFonts.lato(color: Colors.grey, fontSize: 15),
          labelText: label,
          labelStyle: GoogleFonts.lato(
              color: Colors.black54,
              fontSize: 17,
              fontWeight: FontWeight.bold),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: Colors.black, width: 1)),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: AppColors.primary, width: 1)),
        ),
      ),
    );
  }
}