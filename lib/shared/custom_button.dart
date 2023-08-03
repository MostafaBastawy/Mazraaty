import 'package:flutter/material.dart';

import 'constants.dart';

class CustomButton extends StatelessWidget {
  final void Function()? onPressed;
  final String? text;
  final Color textColor;
  final double buttonSize;
  final Color color;

  CustomButton(
      {this.onPressed,
      this.text,
      this.textColor = Colors.white,
      this.buttonSize = double.maxFinite,
      this.color= kAppColor});
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
        decoration: BoxDecoration(
            color: color,
            // boxShadow: [
            //   BoxShadow(color: Colors.black38, spreadRadius: 0, blurRadius: 10),
            // ],
            borderRadius: BorderRadius.circular(5)
        ),
      child: MaterialButton(
        height: 40,
        onPressed: onPressed,
        child: Text(
          text!,
          style: TextStyle(color: textColor, fontSize: 16,fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
