import 'dart:ui';

import 'package:cae/Models/credit_card_model.dart';
import 'package:cae/Models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:url_launcher/url_launcher.dart';

String imageBaseAddress = 'assets/images/';
UserModel userModelObj=UserModel();
GetCreditCardDetailModel creditCardModelObj=GetCreditCardDetailModel();

Color primaryColor = const Color(0XFFFF347A);
Color black = Colors.black;
Color bottomSheetColor = const Color(0XFF303336);
Color payScreenUperColor = const Color(0XFF1C1C1E);
Color competeAtBackGroundColor = const Color(0XFF201948);
Color competeAtBackGreenColor = const Color(0XFF09EC91);


Color backgroundColor = const Color(0XFF292929);

Color white = Colors.white;
Color transparentColor = Colors.transparent;
Color redColor = Colors.redAccent;
Color primaryColorGrey = const Color(0XFFEAE9E9);
Color greyColor = Colors.grey;

Color backGoundColor = black.withOpacity(0.8);
Color containerBackGoundColor = const Color(0XFF717171);
Color containerBackGoundColorWhite = const Color(0XFFA5A3A3);


loader() {
  double _sigmaX = 0.0; // from 0-10
  double _sigmaY = 0.0; // from 0-10
  double _opacity = 0.1; // from 0-1.0
  return BackdropFilter(
    filter: ImageFilter.blur(sigmaX: _sigmaX, sigmaY: _sigmaY),
    child: Shimmer.fromColors(
        baseColor: Colors.white,
        highlightColor: Colors.red,
        child: Image.asset(
          "assets/images/splash1.png",
          width: 90,
          height: 90,
        )),
  );
}

void launchURL(String url) async {
  if (!await launch(url)) throw 'Could not launch $url';
}
