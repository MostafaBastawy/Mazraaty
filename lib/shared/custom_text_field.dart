import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    Key? key,
    this.validator,
    this.controller,
    this.prefixIcon,
    this.suffixIcon,
    this.hintColor = Colors.grey,
    this.obscureText=false,
    this.label,
    this.textInputType,
    this.lines=1, this.onChanged,

  }) : super(key: key);
  final String? Function(String?)? validator;
  final Function(String?)? onChanged;
  final TextEditingController? controller;
  final Icon? prefixIcon;
  final Color? hintColor;
  final IconButton? suffixIcon;
  final bool obscureText;
  final String? label;
  final TextInputType? textInputType;
  final int? lines;



  @override
  Widget build(BuildContext context) {
    return TextFormField(
      maxLines:lines ,
      keyboardType: textInputType,
      cursorColor: Color(0xFF00BC86),
      controller: controller,
      validator:  validator,
      obscureText: obscureText ,
      onChanged:  onChanged,
      decoration: InputDecoration(
          hintText: label,
          hintStyle: TextStyle(color: hintColor),
          prefixIcon: prefixIcon,
          suffixIcon: suffixIcon,
          contentPadding: EdgeInsets.all(10),
          fillColor: Colors.grey.withOpacity(0.3),
          filled: true,
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.circular(5)),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.circular(5)),
          errorBorder: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.circular(5)),
          focusedErrorBorder: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.circular(5))
      ),
    );
  }
}
