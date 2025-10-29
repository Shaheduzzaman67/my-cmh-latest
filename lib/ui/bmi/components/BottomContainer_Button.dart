import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../constants.dart';

class BottomContainer extends StatelessWidget {
  final String? text;
  final VoidCallback? onTap;

  BottomContainer({this.text, this.onTap});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        color: kactiveCardColor,
        margin: EdgeInsets.only(top: 10.0),
        width: double.infinity,
        height: kbottomContainerHeight,
        child: Center(
          child: Text(
            text!,
            style: GoogleFonts.nunitoSans(
                fontWeight: FontWeight.bold,
                color: Colors.white,
                fontSize: 30.0),
          ),
        ),
      ),
    );
  }
}
