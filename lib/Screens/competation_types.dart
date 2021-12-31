import 'package:cae/Constants/Constants.dart';
import 'package:cae/Constants/Styles.dart';
import 'package:cae/Provider/AppConstants.dart';
import 'package:cae/Screens/AddCompetation.dart';
import 'package:cae/Screens/compare_at.dart';
import 'package:cae/Screens/login_screen.dart';
import 'package:cae/Screens/select_sompetation_type.dart';
import 'package:cae/Screens/select_competation_type.dart';
import 'package:cae/Widgets/CAECircularButton.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class CompetitionTypes extends StatefulWidget {
  const CompetitionTypes({Key? key}) : super(key: key);

  @override
  _CompetitionTypesState createState() => _CompetitionTypesState();
}

class _CompetitionTypesState extends State<CompetitionTypes> {
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;

    return Consumer<AppConstants>(builder: (context, app, _) {
      return Scaffold(
          key: app.scaffoldKey2,
          drawer: Drawer(
            child: Column(
              children: [
                Spacer(),
                GestureDetector(
                    onTap: () {
                      final FirebaseAuth _auth = FirebaseAuth.instance;
                      _auth.signOut();
                      Get.offAll(LoginScreen());
                    },
                    child: ListTile(
                      leading: Icon(Icons.logout),
                      title: Text("Logout"),
                    ))
              ],
            ),
          ),
          body: Container(
            height: height,
            width: width,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(
                      imageBaseAddress + 'compare_background.png',
                    ),
                    fit: BoxFit.cover)),
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    SizedBox(
                      height: height * 0.04,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        InkWell(
                            onTap: () {
                              app.scaffoldKey2.currentState!.openDrawer();
                            },
                            child: Padding(
                              padding: EdgeInsets.only(right:Get.width*.0),
                              child: Icon(
                                Icons.menu,
                                color: white,
                              ),
                            )),
                      ],
                    ),
                    Text(
                      'Workout',
                      style: textStyleHeading1(width * 0.8, whiteColor: 1),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(14.0),
                      child: Container(
                        decoration: BoxDecoration(
                            color: payScreenUperColor,
                            borderRadius: BorderRadius.circular(width * 0.015)),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 15.0, vertical: 14),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // SizedBox(width: width,),
                              Padding(
                                padding: const EdgeInsets.only(left: 8.0),
                                child: Text(
                                  'Workot',
                                  style: textStyleHeading2(width * 0.75,
                                      whiteColor: 4),
                                ),
                              ),
                              SizedBox(
                                width: width,
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  'Me Vs Me',
                                  style: textStyleHeading1(width * 0.8,
                                      whiteColor: 1),
                                ),
                              ),
                              SizedBox(
                                width: width,
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  'Put your money where your heart \nis and Challenge yourself to complete a goal',
                                  style: textStyleHeading2(width * 0.85,
                                      whiteColor: 1),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 8.0),
                                child: Row(
                                  children: [
                                    Expanded(
                                        flex: 7,
                                        child: SizedBox(
                                          width: width * 0.01,
                                        )),
                                    Expanded(
                                      flex: 3,
                                      child: CAECircularButton(
                                          width: width,
                                          backGroundColor: primaryColor,
                                          height: height,
                                          textColor: 1,
                                          title: 'See more',
                                          onPressed: () {
                                            Get.to(SelectCompetitionType());
                                          }),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    /////////////////////////
                    Padding(
                      padding: const EdgeInsets.all(14.0),
                      child: Container(
                        decoration: BoxDecoration(
                            color: payScreenUperColor,
                            borderRadius: BorderRadius.circular(width * 0.015)),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 15.0, vertical: 14),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // SizedBox(width: width,),

                              SizedBox(
                                width: width,
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  'You Vs Me',
                                  style: textStyleHeading1(width * 0.8,
                                      whiteColor: 1),
                                ),
                              ),
                              SizedBox(
                                width: width,
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  'Lorem Ipsum\n\n',
                                  style: textStyleHeading2(width * 0.85,
                                      whiteColor: 1),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 8.0),
                                child: Row(
                                  children: [
                                    Expanded(
                                        flex: 7,
                                        child: SizedBox(
                                          width: width * 0.01,
                                        )),
                                    Expanded(
                                      flex: 3,
                                      child: CAECircularButton(
                                          width: width,
                                          backGroundColor: primaryColor,
                                          height: height,
                                          textColor: 1,
                                          title: 'See more',
                                          onPressed: () {
                                            Get.to(SelectCompetitionType());
                                          }),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.all(14.0),
                      child: Container(
                        decoration: BoxDecoration(
                            color: payScreenUperColor,
                            borderRadius: BorderRadius.circular(width * 0.015)),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 15.0, vertical: 14),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // SizedBox(width: width,),
                              Padding(
                                padding: const EdgeInsets.only(left: 8.0),
                                child: Text(
                                  'Workot',
                                  style: textStyleHeading2(width * 0.75,
                                      whiteColor: 4),
                                ),
                              ),
                              SizedBox(
                                width: width,
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  'Us Vs Them',
                                  style: textStyleHeading1(width * 0.8,
                                      whiteColor: 1),
                                ),
                              ),
                              SizedBox(
                                width: width,
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  'Lorem Ipsum\n\n',
                                  style: textStyleHeading2(width * 0.85,
                                      whiteColor: 1),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 8.0),
                                child: Row(
                                  children: [
                                    Expanded(
                                        flex: 7,
                                        child: SizedBox(
                                          width: width * 0.01,
                                        )),
                                    Expanded(
                                      flex: 3,
                                      child: CAECircularButton(
                                          width: width,
                                          backGroundColor: primaryColor,
                                          height: height,
                                          textColor: 1,
                                          title: 'See more',
                                          onPressed: () {
                                            Get.to(SelectCompetitionType());
                                          }),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ));
    });
  }
}
