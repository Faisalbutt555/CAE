import 'package:cae/Constants/Constants.dart';
import 'package:cae/Provider/AppConstants.dart';
import 'package:cae/Screens/forgot_password_screen.dart';
import 'package:cae/Screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class OpenForgotMail extends StatelessWidget {
  const OpenForgotMail({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
   return Consumer<AppConstants>(builder: (context,appPro,_){
     return Scaffold(
       body: Container(
         padding:
         EdgeInsets.only(left: Get.width * 0.05, right: Get.width * 0.05),
         height: Get.height,
         width: Get.width,
         decoration: BoxDecoration(
           //color: Colors.white
             image: DecorationImage(
                 fit: BoxFit.cover,
                 image: AssetImage('assets/images/background.png'))),
         child: Center(
           child: Column(
             mainAxisAlignment: MainAxisAlignment.center,
             children: [
               Container(
                 height: Get.height * 0.25,
                 width: Get.height * 0.25,
                 decoration: BoxDecoration(
                   // shape: BoxShape.circle,
                     image: DecorationImage(
                       //fit: BoxFit.cover,
                         image: AssetImage('assets/images/letter.png'))),
               ),
               SizedBox(
                 height: Get.height * 0.05,
               ),
               Text(
                 'Check your mail',
                 style: TextStyle(
                     color: Colors.white,
                     fontSize: Get.height * 0.03,
                     fontWeight: FontWeight.bold),
               ),
               SizedBox(
                 height: Get.height * 0.025,
               ),
               Text(
                 'We have sent a confirmation mail to',
                 style: TextStyle(
                   color: Colors.white60,
                   fontSize: Get.height * 0.018,
                 ),
               ),
               SizedBox(
                 height: Get.height * 0.005,
               ),
               Text(
                 'your registered email please confirm it',
                 style: TextStyle(
                   color: Colors.white60,
                   fontSize: Get.height * 0.018,
                 ),
               ),
               SizedBox(
                 height: Get.height * 0.05,
               ),
               InkWell(
                 onTap: () {
                   Get.offAll(const LoginScreen());
                   // launchURL("mohsinkhalid2021297@gmail.com");
                 },
                 child: Container(
                   alignment: Alignment.center,
                   height: Get.height * 0.06,
                   width: Get.width * 0.45,
                   decoration: BoxDecoration(
                       color: Colors.white,
                       borderRadius: BorderRadius.circular(12)),
                   child: Text(
                     'Login Now',
                     style: TextStyle(
                         color: Colors.black,
                         fontSize: Get.height * 0.02,
                         fontWeight: FontWeight.bold),
                   ),
                 ),
               ),
               SizedBox(
                 height: Get.height * 0.04,
               ),
               // Row(
               //   mainAxisAlignment: MainAxisAlignment.center,
               //   children: [
               //     Text(
               //       'Do not receive the email? ',
               //       style: TextStyle(
               //         color: Colors.white,
               //         fontSize: Get.height * 0.018,
               //       ),
               //     ),
               //     InkWell(
               //       onTap: () {
               //         Get.offAll(ForgotPassword());
               //       },
               //       child: Text(
               //         'Resend it',
               //         style: TextStyle(
               //           decoration: TextDecoration.underline,
               //           color: Colors.red,
               //           fontSize: Get.height * 0.018,
               //         ),
               //       ),
               //     )
               //   ],
               // )
             ],
           ),
         ),
       ),
     );
   });
  }
}
