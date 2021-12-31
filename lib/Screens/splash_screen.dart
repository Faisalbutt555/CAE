import 'package:cae/Constants/Constants.dart';
import 'package:cae/Provider/auth_provider.dart';
import 'package:cae/Screens/HomeScreen.dart';
import 'package:cae/Screens/intro_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'login_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({ Key? key }) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
      @override
  void initState() {
    super.initState();
    goToNextScreen(context);
  }
   void goToNextScreen(BuildContext context) async{

     var user = await _auth.currentUser;
    Future.delayed(const Duration(seconds: 3), () {
     user==null?Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>const IntroScreen())):
     Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>const HomeScreen()));
    });
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    var authPro=Provider.of<AuthProvider>(context,listen: false);
    _auth.currentUser!=null?authPro.getData(_auth.currentUser!.uid):false;
    return Scaffold(
      body: Container(
        width: width,
        height: height,
        color: black,
        child: Column(
          children: [
            Expanded(
              flex: 2,
              child: Image.asset(
                    imageBaseAddress + 'splash1.png',
                    height: height * 0.1,
                    width: width,
                  ),
            ),
            Expanded(
              flex: 3,
              child: Image.asset(
                    imageBaseAddress + 'splash2.png',
                    fit: BoxFit.cover,
                  ),
            ),
            Row(
              children: [
                Expanded(
                  child: Image.asset(
                        imageBaseAddress + 'splash3.png',
                        fit: BoxFit.cover,
                        // height: height * 0.1,
                        // width: width,
                      ),
                ),
                Expanded(
                  child: Image.asset(
                    imageBaseAddress + 'splash4.png',
                    fit: BoxFit.cover,
                    // height: height * 0.1,
                    // width: width,
                  ),
                ),
              ],
            ),
            Expanded(
              flex: 2,
              child: Image.asset(
                    imageBaseAddress + 'splash5.png',
                    fit: BoxFit.cover,
                    // height: height * 0.1,
                    // width: width,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}