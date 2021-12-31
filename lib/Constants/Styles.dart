import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'Constants.dart';
// ignore_for_file: file_names






TextStyle textStyleHeading1(double width, {int? whiteColor}) {
  return GoogleFonts.poppins(
          textStyle: TextStyle(
           color: whiteColor==1? white : whiteColor==0 ? black: primaryColor,
           fontSize: width * 0.06,
           fontWeight: FontWeight.bold,
          ),
          );
}
TextStyle textStyleHeading13Italic(double width, {int? whiteColor}) {
  return GoogleFonts.poppins(
          textStyle: TextStyle(
           color: whiteColor==1? white : whiteColor==0 ? black: primaryColor,
           fontSize: width * 0.04,
           fontWeight: FontWeight.bold,
           fontStyle: FontStyle.italic
          ),
          );
}


TextStyle textStyleHeading2(double width, {int? whiteColor}) {
  return GoogleFonts.poppins(
          textStyle:TextStyle(
    color: whiteColor==1? white : whiteColor==0 ? black: whiteColor==3? greyColor: primaryColor,
    fontSize: width * 0.045,
    fontWeight: FontWeight.normal,
  )
  );
}

TextStyle textStyleHeading3(double width) {
  return GoogleFonts.poppins(
          textStyle:TextStyle(
    color: white,
    fontSize: width * 0.04,
    fontWeight: FontWeight.normal,
  ));
}
TextStyle textStyleHeading4(double width) {
  return TextStyle(
    color: primaryColor,
    fontSize: width * 0.03,
    fontWeight: FontWeight.normal,
  );
}

TextStyle smallTextBoldBlackColor(double width) {
  return TextStyle(
    color: black.withOpacity(0.4),
    fontSize: width * 0.032,
    fontWeight: FontWeight.bold,
  );
}

TextStyle smallTextBoldWhiteLessColor(double width, {int? underLine}) {
  return TextStyle(
    color: white.withOpacity(0.4),
    fontSize: width * 0.032,
    fontWeight: FontWeight.normal,
    decoration: underLine ==1? TextDecoration.underline : TextDecoration.none
  );
}
  
