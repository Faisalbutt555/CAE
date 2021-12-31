import 'package:cae/Provider/AppConstants.dart';
import 'package:cae/Screens/HomeScreen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
class CongratsScreen extends StatefulWidget {
  const CongratsScreen({Key? key}) : super(key: key);

  @override
  _CongratsScreenState createState() => _CongratsScreenState();
}

class _CongratsScreenState extends State<CongratsScreen> {
  @override
  void initState() {
    // TODO: implement initState

    Future.delayed(Duration(seconds: 2),(){
      Get.offAll(HomeScreen());
      showSuccessSnackBar("Payment done successfully");
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.only(left: Get.width*0.05,right: Get.width*0.05),
        height: Get.height,
        width: Get.width,
        decoration: BoxDecoration(
            image: DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage('assets/images/background.png')
            )
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: Get.height*0.25,
                width: Get.height*0.25,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                        fit: BoxFit.cover,
                        image: AssetImage('assets/images/congrats.png')
                    )
                ),
              ),
              SizedBox(height: Get.height*0.05,),
              Text('Congrats !',style: TextStyle(
                  color: Colors.white,
                  fontSize: Get.height*0.03,
                  fontWeight: FontWeight.bold
              ),),
              SizedBox(height: Get.height*0.025,),

              Text('Congrats on creating a competition',style: TextStyle(
                color: Colors.white60,
                fontSize: Get.height*0.018,
              ),),
              SizedBox(height: Get.height*0.005,),

              Text('Duis autr irure dolor reprehenderit in',style: TextStyle(
                color: Colors.white60,
                fontSize: Get.height*0.018,
              ),),
              SizedBox(height: Get.height*0.005,),

              Text('valuepatate velit esse cillium',style: TextStyle(
                color: Colors.white60,
                fontSize: Get.height*0.018,
              ),)

            ],
          ),
        ),
      ),
    );
  }
}
