import 'package:cae/Constants/Constants.dart';
import 'package:cae/Constants/Styles.dart';
import 'package:flutter/material.dart';
class CAECircularButton extends StatelessWidget {

  const CAECircularButton({
    Key? key,
    required this.width,
    this.title,
    required this.onPressed,
    this.backGroundColor,
    this.textColor,
    this.height
  }) : super(key: key);

 final double width;
 final double? height;
 final String? title;
 final VoidCallback? onPressed;
 final Color? backGroundColor;
 final int? textColor;




  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
           child: Center(
             child: Padding(
               padding: const EdgeInsets.symmetric(vertical: 14.0),
               child: FittedBox(child: Text("$title", style: textStyleHeading1(width*0.75, whiteColor: textColor))),
             ),
           ),
              style: ElevatedButton.styleFrom(
               primary: backGroundColor,
               side: BorderSide(color: primaryColor, width: textColor==2?2:0),
               shape: const StadiumBorder()
                // shape: RoundedRectangleBorder(
                // borderRadius: BorderRadius.circular(width*0.03), // <-- Radius
              //  
             ),
           onPressed: onPressed);
  }
}