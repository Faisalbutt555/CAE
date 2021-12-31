import 'package:cae/Constants/Constants.dart';
import 'package:cae/Constants/Styles.dart';
import 'package:cae/Provider/AppConstants.dart';
import 'package:cae/Provider/auth_provider.dart';
import 'package:cae/Screens/login_screen.dart';
import 'package:cae/Screens/openforgotmail.dart';
import 'package:cae/Widgets/text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:provider/provider.dart';

class ForgotPassword extends StatelessWidget {
  const ForgotPassword({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Consumer<AppConstants>(builder: (context, appCon, _) {
      return Consumer<AuthProvider>(builder: (context, authCon, _) {
        return Scaffold(
          body: ModalProgressHUD(
            dismissible: false,
            inAsyncCall: authCon.loading,
            progressIndicator: loader(),
           child:Form(
             key: appCon.forgotFormKey,
             child: Container(
               padding: EdgeInsets.only(
                   left: Get.width * 0.05, right: Get.width * 0.05),
               height: Get.height,
               width: Get.width,
               decoration: const BoxDecoration(
                   image: DecorationImage(
                       fit: BoxFit.cover,
                       image: AssetImage('assets/images/background.png'))),
               child: ListView(
                 // crossAxisAlignment: CrossAxisAlignment.start,
                 // mainAxisAlignment: MainAxisAlignment.start,
                 children: [
                   SizedBox(
                     height: Get.height * 0.04,
                   ),
                   Row(
                     mainAxisAlignment: MainAxisAlignment.start,
                     children: [
                       // GestureDetector(
                       //   onTap: () => Navigator.pop(context),
                       //   child: const CircleAvatar(
                       //     radius: 20,
                       //     backgroundColor: Color(0xff707070),
                       //     child: Icon(Icons.arrow_back),
                       //   ),
                       // ),
                       SizedBox(
                         width: Get.width * 0.17,
                       ),
                       Text(
                         'Recover Your Password',
                         style: TextStyle(
                             color: Colors.white,
                             fontSize: Get.height * 0.025,
                             fontWeight: FontWeight.bold),
                       )
                     ],
                   ),
                   SizedBox(
                     height: Get.height * 0.04,
                   ),
                   // Column(
                   //   mainAxisAlignment: MainAxisAlignment.center,
                   //   crossAxisAlignment: CrossAxisAlignment.center,
                   //   children: [
                   //     Text(
                   //       'Enter the email associated with your account',
                   //       style: TextStyle(
                   //           color: Colors.blue,
                   //           fontSize: Get.height * 0.018,
                   //           fontWeight: FontWeight.bold),
                   //     ),
                   //     SizedBox(
                   //       height: Get.height * 0.005,
                   //     ),
                   //     Text(
                   //       'and we’ll send an confirmation email to reset',
                   //       style: TextStyle(
                   //           color: Colors.blue,
                   //           fontSize: Get.height * 0.018,
                   //           fontWeight: FontWeight.bold),
                   //     ),
                   //     SizedBox(
                   //       height: Get.height * 0.005,
                   //     ),
                   //     Text(
                   //       'your password.',
                   //       style: TextStyle(
                   //           color: Colors.blue,
                   //           fontSize: Get.height * 0.018,
                   //           fontWeight: FontWeight.bold),
                   //     ),
                   //   ],
                   // ),
                   SizedBox(
                     height: Get.height * 0.06,
                   ),
                   TextFormFieldCustom(
                       textInputType: TextInputType.emailAddress,
                       obscure: false,
                       enable: true,
                       image: Image.asset('assets/images/category.png'),
                       text: '  Enter your register email',
                       errors: "this no a valid email",
                       controller: appCon.emailController),
                   SizedBox(
                     height: Get.height * 0.04,
                   ),
                   TextFormFieldCustom(
                       onTap: (){
                         appCon.setForgotEye();
                       },
                       iconData: appCon.forgotEye?Icons.visibility:Icons.visibility_off,
                       textInputType: TextInputType.text,
                       obscure: appCon.forgotEye?false:true,
                       enable: true,
                       image: Image.asset('assets/images/category.png'),
                       text: '  Enter your new password',
                       errors: "password must contains 8 characters",
                       controller: appCon.passwordController),
                   SizedBox(
                     height: Get.height * 0.04,
                   ),
                   InkWell(
                     onTap: () {
                       //TO:DO
                       // Get.to(OpenForgotMail());
                       if(appCon.forgotFormKey.currentState!.validate()) {
                         authCon.sendVerificationEmail(appCon.passwordController.text.trim(),appCon.emailController.text.trim(), context);
                       }
                     },
                     child: Container(
                         padding: EdgeInsets.only(
                             left: Get.width * 0.03, right: Get.width * 0.03),
                         alignment: Alignment.center,
                         height: Get.height * 0.08,
                         width: Get.width,
                         decoration: BoxDecoration(
                           color: Colors.white,
                           borderRadius: BorderRadius.circular(15),
                           // border: Border.all(width: 1,color: Colors.red),
                         ),
                         child: Text(
                           'Update',
                           style: TextStyle(
                               fontSize: Get.height * 0.023,
                               fontWeight: FontWeight.bold),
                         )),
                   ),
                   SizedBox(
                     height: Get.height * 0.04,
                   ),
                   Row(
                     mainAxisAlignment: MainAxisAlignment.center,
                     children: [
                       InkWell(
                         onTap: () {
                           // Navigator.push(context, MaterialPageRoute(builder: (context)=>const ForgetPasswordScreen()));
                           //Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>const LoginScreen()));
                         },
                         child: Text(
                           'Already have a account? ',
                           style: textStyleHeading3(width),
                         ),
                       ),
                       InkWell(
                         onTap: () {
                           // Navigator.push(context, MaterialPageRoute(builder: (context)=>const ForgetPasswordScreen()));
                           Get.back();
                           //Get.offAll(const LoginScreen());
                           //Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>const LoginScreen()));
                         },
                         child: Text(
                           'LOGIN',
                           style: textStyleHeading3(width)
                               .copyWith(
                               decoration:
                               TextDecoration.underline,
                               color: Colors.blue),
                         ),
                       ),
                     ],
                   ),
                   SizedBox(
                     height: Get.height * 0.04,
                   ),
                 ],
               ),
             ),
           ),
          )
        );
      });
    });
  }
}
