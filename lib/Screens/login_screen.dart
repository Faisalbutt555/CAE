import 'package:cae/Constants/Constants.dart';
import 'package:cae/Constants/Styles.dart';
import 'package:cae/Provider/AppConstants.dart';
import 'package:cae/Provider/auth_provider.dart';
import 'package:cae/Screens/HomeScreen.dart';
import 'package:cae/Screens/forgot_password_screen.dart';
import 'package:cae/Screens/registration_screen.dart';
import 'package:cae/Widgets/CAEButton.dart';
import 'package:cae/Widgets/text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  // late AuthProvider _authProvider;

  @override
  void initState() {
    super.initState();
    // _authProvider = Provider.of<AuthProvider>(context);
  }

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
                          padding: EdgeInsets.all(8.0),
                          child: Form(
                            key: appProvider.loginFormKey,
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
                                const SizedBox(
                                  height: 10,
                                ),
                                TextFormFieldCustom(
                                    textInputType: TextInputType.emailAddress,
                                    obscure: false,
                                    enable: true,
                                    image: Image.asset(
                                        'assets/images/category.png'),
                                    text: '  Enter your email or username',
                                    errors:
                                        "Please enter a valid mail or username",
                                    controller: appProvider.emailController),

                                /////////////////
                                SizedBox(
                                  height: height * 0.015,
                                ),

                                TextFormFieldCustom(
                                    onTap: () {
                                      setState(() {
                                        appProvider.setLoginEye();
                                      });
                                    },
                                    iconData: appProvider.loginEye
                                        ? Icons.visibility
                                        : Icons.visibility_off,
                                    textInputType: TextInputType.text,
                                    obscure:
                                        appProvider.loginEye ? false : true,
                                    enable: true,
                                    image: Image.asset(
                                      'assets/images/lock.png',
                                      color: Colors.white,
                                    ),
                                    text: '  Enter your password',
                                    errors:
                                        "Password contains minimum 8 characters",
                                    controller: appProvider.passwordController),

                                SizedBox(
                                  height: height * 0.02,
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: CAEButton(
                                    onPressed: () async {
                                      if (appProvider.loginFormKey.currentState!
                                          .validate()) {
                                        var res = await auth.login(
                                          context,
                                          appProvider.emailController.text
                                              .trim()
                                              .toString(),
                                          appProvider.passwordController.text
                                              .trim()
                                              .toString(),
                                        );
                                        if (res == false) {
                                          
                                        }
                                        print('responce: $res');
                                        setState(() {
                                          auth.stopLoading();
                                          print(auth.loading);
                                        });
                                      }
                                      // Navigator.push(context, MaterialPageRoute(builder: (context)=>const CompareAt()));
                                      // Navigator.push(
                                      //     context,
                                      //     MaterialPageRoute(
                                      //         builder: (context) =>
                                      //             const HomeScreen()));
                                    },
                                    backGroundColor: primaryColor,
                                    height: height * 0.068,
                                    textColor: 1,
                                    width: width,
                                    title: 'Login',
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: CAEButton(
                                    onPressed: () {
                                      auth.setFieldClear(context);
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  const RegistrationScreen()));
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
                                InkWell(
                                  onTap: () {
                                    auth.setFieldClear(context);
                                    // appProvider.passwordController.clear();
                                    // Navigator.push(context, MaterialPageRoute(builder: (context)=>const ForgetPasswordScreen()));
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const ForgotPassword()));
                                  },
                                  child: Text(
                                    'Forgot your password? Click Here',
                                    style: textStyleHeading3(width),
                                  ),
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
