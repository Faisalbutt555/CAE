import 'package:cae/Constants/Constants.dart';
import 'package:cae/Constants/Styles.dart';
import 'package:cae/Provider/AppConstants.dart';
import 'package:cae/Provider/auth_provider.dart';
import 'package:cae/Screens/login_screen.dart';
import 'package:cae/Widgets/CAEButton.dart';
import 'package:cae/Widgets/text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:provider/provider.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({Key? key}) : super(key: key);

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Consumer<AuthProvider>(builder: (context, auth, _) {
      return Consumer<AppConstants>(builder: (context, appProvider, _) {
        return Scaffold(
            body: ModalProgressHUD(
          dismissible: false,
          inAsyncCall: auth.loading,
          progressIndicator: loader(),
          child: Stack(
            children: [
              Container(
                height: height,
                width: width,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage(
                          imageBaseAddress + 'login_background.png',
                        ),
                        fit: BoxFit.cover)),
              ),
              Container(
                height: height,
                width: width,
                decoration: BoxDecoration(
                    gradient: LinearGradient(colors: [
                  white.withOpacity(0.5),
                  backgroundColor.withOpacity(0.6)
                ], begin: Alignment.topCenter, end: Alignment.bottomCenter)
                    // image: DecorationImage(
                    //   image: AssetImage(imageBaseAddress+'login_background.png',),
                    //   fit: BoxFit.cover
                    //   )
                    ),
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                        children: AnimationConfiguration.toStaggeredList(
                      duration: const Duration(milliseconds: 375),
                      childAnimationBuilder: (widget) => SlideAnimation(
                        horizontalOffset: 50.0,
                        child: FadeInAnimation(
                          child: widget,
                        ),
                      ),
                      children: [
                        SizedBox(
                          height: height * 0.12,
                        ),
                        // Image.asset(imageBaseAddress+'Splash_image.png',height: height*0.1,),
                        // SizedBox(
                        //   height: height * 0.015,
                        // ),
                        Image.asset(
                          imageBaseAddress + 'splash1.png',
                          height: height * 0.1,
                          width: width,
                        ),

                        SizedBox(
                          height: height * 0.019,
                        ),
                        //   Text('EMBRACE', style:textStyleHeading1(width, whiteColor: 1)),
                        // SizedBox(
                        //     height: height * 0.019,
                        //   ),

                        SizedBox(
                          height: height * 0.025,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Form(
                            key: appProvider.regisFormKey,
                            child: Column(
                                children:
                                    AnimationConfiguration.toStaggeredList(
                              duration: const Duration(milliseconds: 600),
                              childAnimationBuilder: (widget) => SlideAnimation(
                                horizontalOffset: 50.0,
                                child: FadeInAnimation(
                                  child: widget,
                                ),
                              ),
                              children: [
                                // const SizedBox(
                                //   height: 10,
                                // ),
                                TextFormFieldCustom(
                                    textInputType: TextInputType.text,
                                    obscure: false,
                                    image:
                                        Image.asset('assets/images/person.png'),
                                    text: ' full name',
                                    errors: "Please enter your name",
                                    controller: appProvider.nameController),
                                SizedBox(
                                  height: height * 0.015,
                                ),
                                TextFormFieldCustom(
                                    textInputType: TextInputType.text,
                                    obscure: false,
                                    image:
                                        Image.asset('assets/images/person.png'),
                                    text: ' username',
                                    errors: "Please enter your username",
                                    controller: appProvider.userNameController),
                                SizedBox(
                                  height: height * 0.015,
                                ),
                                TextFormFieldCustom(
                                    textInputType: TextInputType.emailAddress,
                                    obscure: false,
                                    image: Image.asset(
                                        'assets/images/category.png'),
                                    text: '  abc@gmail.com',
                                    errors: "Please enter valid mail",
                                    controller: appProvider.emailController),
                                SizedBox(
                                  height: height * 0.015,
                                ),
                                TextFormFieldCustom(
                                    textInputType: TextInputType.text,
                                    obscure: false,
                                    image: Image.asset(
                                      'assets/images/flag.png',
                                      scale: 9,
                                    ),
                                    text: '  zip code (optional)',
                                    // errors: "Please enter your zip code",
                                    controller: appProvider.zipCodeController),
                                SizedBox(
                                  height: height * 0.015,
                                ),
                                TextFormFieldCustom(
                                    textInputType: TextInputType.phone,
                                    obscure: false,
                                    image: Image.asset(
                                      'assets/images/flag.png',
                                      scale: 9,
                                    ),
                                    text: '  phone number(optional)',
                                    // errors: "Please enter your phone number",
                                    controller: appProvider.phoneController),
                                SizedBox(
                                  height: height * 0.015,
                                ),
                                TextFormFieldCustom(
                                    onTap: () {
                                      setState(() {
                                        appProvider.setReg1Eye();
                                      });
                                    },
                                    iconData: appProvider.reg1Eye
                                        ? Icons.visibility
                                        : Icons.visibility_off,
                                    textInputType: TextInputType.text,
                                    obscure: appProvider.reg1Eye ? false : true,
                                    image: Image.asset(
                                      'assets/images/lock.png',
                                      color: Colors.white,
                                    ),
                                    text: '  password',
                                    errors:
                                        "Password contains minimum 8 characters",
                                    controller: appProvider.passwordController),
                                SizedBox(
                                  height: height * 0.015,
                                ),
                                Container(
                                    padding: EdgeInsets.only(
                                        left: Get.width * 0.03,
                                        right: Get.width * 0.03),
                                    alignment: Alignment.center,
                                    height: Get.height * 0.08,
                                    width: Get.width,
                                    decoration: BoxDecoration(
                                        //color: Colors.red,
                                        borderRadius: BorderRadius.circular(15),
                                        // border: Border.all(width: 1,color: Colors.red),
                                        image: const DecorationImage(
                                            fit: BoxFit.cover,
                                            image: AssetImage(
                                                'assets/images/textfield.png'))),
                                    child: TextFormField(
                                      obscureText:
                                          appProvider.reg2Eye ? false : true,
                                      enabled: true,
                                      validator: (value) {
                                        if (value!.isEmpty ||
                                            value == "" ||
                                            value.length < 8) {
                                          return "Password contains minimum 8 characters";
                                        }
                                        if (value !=
                                            appProvider.passwordController.text
                                                .trim()) {
                                          return "password does not match";
                                        } else
                                          return null;
                                      },
                                      controller:
                                          appProvider.confirmPasswordController,
                                      cursorHeight: 25,
                                      style: TextStyle(color: Colors.white),
                                      keyboardType: TextInputType.text,
                                      decoration: InputDecoration(
                                        suffixIcon: GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              appProvider.setReg2Eye();
                                            });
                                          },
                                          child: Icon(
                                              appProvider.reg2Eye
                                                  ? Icons.visibility
                                                  : Icons.visibility_off,
                                              color: Colors.white),
                                        ),
                                        border: InputBorder.none,
                                        hintText: "confirm you password",
                                        hintStyle: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w600),
                                        prefixIcon: Image.asset(
                                          'assets/images/lock.png',
                                          color: Colors.white,
                                        ),
                                      ),
                                    )),
                                // TextFormFieldCustom(
                                //     image: Image.asset(
                                //         'assets/images/lock.png',color: Colors.white,),
                                //     text: '  confirm your password',
                                //     errors:
                                //         "Password contains minimum 8 characters",
                                //     controller:
                                //         appProvider.confirmPasswordController),
                                SizedBox(
                                  height: height * 0.02,
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: CAEButton(
                                    onPressed: () {
                                      if (appProvider.regisFormKey.currentState!
                                          .validate()) {
                                        print("ok");
                                        auth.register(
                                          context,
                                          appProvider.nameController.text
                                              .trim()
                                              .toString(),
                                          appProvider.userNameController.text
                                              .trim()
                                              .toString(),
                                          appProvider.emailController.text
                                              .trim()
                                              .toString(),
                                          appProvider.zipCodeController.text
                                                      .trim()
                                                      .isEmpty ||
                                                  appProvider.zipCodeController
                                                          .text
                                                          .trim()
                                                          .toString() ==
                                                      ""
                                              ? "Set ZipCode"
                                              : appProvider
                                                  .zipCodeController.text
                                                  .trim()
                                                  .toString(),
                                          appProvider.phoneController.text
                                                      .trim()
                                                      .isEmpty ||
                                                  appProvider
                                                          .phoneController.text
                                                          .trim()
                                                          .toString() ==
                                                      ""
                                              ? "Set phone number"
                                              : appProvider.phoneController.text
                                                  .trim()
                                                  .toString(),
                                          appProvider.passwordController.text
                                              .trim()
                                              .toString(),
                                        );
                                      }
                                      // Future.delayed(Duration(seconds: 10),(){
                                      //   auth.stopLoading();
                                      //   showErrorSnackBar("Internet problem. Check you internet and try again");
                                      // });
                                      // Navigator.push(context, MaterialPageRoute(builder: (context)=>const HomeScreen()));
                                    },
                                    backGroundColor: transparentColor,
                                    // height: height * 0.068,
                                    textColor: 1,
                                    width: width,
                                    title: 'Register',
                                  ),
                                ),
                                SizedBox(
                                  height: height * 0.015,
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
                                  height: height * 0.015,
                                ),
                              ],
                            )),
                          ),
                        )
                      ],
                    )),
                  ),
                ),
              ),
            ],
          ),
        ));
      });
    });
  }
}
