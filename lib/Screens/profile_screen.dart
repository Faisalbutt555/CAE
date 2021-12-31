import 'package:cae/Constants/Constants.dart';
import 'package:cae/Constants/Styles.dart';
import 'package:cae/Provider/AppConstants.dart';
import 'package:cae/Provider/auth_provider.dart';
import 'package:cae/Screens/compare_at.dart';
import 'package:cae/Screens/login_screen.dart';
import 'package:cae/Screens/search_comp.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hexagon/hexagon.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  var ret;
  totalComp() async {
    ret = await FirebaseFirestore.instance.collection('competition').get();
    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    totalComp();
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;

    return Consumer<AuthProvider>(builder: (context, auth, _) {
      return Consumer<AppConstants>(builder: (context, app, _) {
        return Scaffold(
            key: app.scaffoldKey4,
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
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    // mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: height * 0.04,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          InkWell(
                              onTap: () {
                                app.scaffoldKey4.currentState!.openDrawer();
                              },
                              child: Icon(
                                Icons.menu,
                                color: white,
                              )),
                          Text(
                            'Profile',
                            style:
                                textStyleHeading1(width * 0.8, whiteColor: 1),
                          ),
                          GestureDetector(
                            onTap: () {
                              Get.to(const SearchCompetition());
                            },
                            child: Icon(
                              Icons.search,
                              color: white,
                            ),
                          )
                        ],
                      ),
                      CustomSizedBox(height: height),
                      Container(
                        decoration:
                            BoxDecoration(color: white.withOpacity(0.15)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            GestureDetector(
                              onTap: () => auth.openBottomSheet(context),
                              child: HexagonWidget.flat(
                                width: width * 0.35,
                                color:
                                    competeAtBackGroundColor.withOpacity(0.2),
                                padding: 4.0,
                                cornerRadius: 10,
                                child: auth.downloadedLink != null
                                    ? Image.network(auth.downloadedLink!)
                                    : userModelObj.profile != null
                                        ? Image.network(userModelObj.profile!)
                                        : Image.asset(
                                            imageBaseAddress + 'splash1.png',
                                            fit: BoxFit.cover,
                                            width: width,
                                            // height: height * 0.08,
                                          ),
                              ),
                            ),
                            Expanded(
                              child: Center(
                                  child: GestureDetector(
                                onTap: () => auth.editProfileBS(context),
                                child: Column(
                                  // mainAxisAlignment: MainAxisAlignment.center,
                                  // crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      "${userModelObj != null ? userModelObj.name : "Set Name"}",
                                      style: textStyleHeading1(width,
                                          whiteColor: 1),
                                    ),
                                    Text(
                                      "${userModelObj != null ? userModelObj.zipCode : "Set zip code"}",
                                      style: textStyleHeading2(width * 0.75,
                                          whiteColor: 4),
                                    ),
                                  ],
                                ),
                              )),
                            ),
                          ],
                        ),
                      ),
                      CustomSizedBox(height: height + height),
                      Text('STATISTIC',
                          style: textStyleHeading13Italic(width * 0.7,
                              whiteColor: 1)),
                      Container(
                        decoration:
                            BoxDecoration(color: white.withOpacity(0.15)),
                        child: Padding(
                          padding: EdgeInsets.all(width * 0.02),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              StatisticPercentage(
                                  title: 'Win Rate',
                                  percentage: 0.75,
                                  radius: width * 0.2,
                                  percentageTitle: '70.0%',
                                  widthLine: 9.0,
                                  width: width,
                                  height: height),
                              StatisticPercentage(
                                  title: 'Played Games',
                                  percentage: 0.79,
                                  radius: width * 0.28,
                                  percentageTitle: '79.0%',
                                  widthLine: 16.0,
                                  width: width,
                                  height: height),
                              StatisticPercentage(
                                  title: 'Draw',
                                  percentage: 0.62,
                                  radius: width * 0.2,
                                  percentageTitle: '62.0%',
                                  widthLine: 9.0,
                                  width: width,
                                  height: height)
                            ],
                          ),
                        ),
                      ),
                      CustomSizedBox(height: height),
                      Container(
                        decoration:
                            BoxDecoration(color: white.withOpacity(0.15)),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                'Number of Competitons',
                                style: textStyleHeading2(width * 0.55,
                                    whiteColor: 1),
                              ),
                              SizedBox(
                                height: height * 0.08,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(right: 8.0),
                                child: Text(
                                  ret != null
                                      ? ret.docs.length.toString()
                                      : "0",
                                  style:
                                      textStyleHeading1(width, whiteColor: 4),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      CustomSizedBox(height: height + height + height),
                      Text('MORE INFO',
                          style: textStyleHeading13Italic(width * 0.7,
                              whiteColor: 1)),
                      CustomSizedBox(height: height + height),
                      Text(
                        'João Félix Sequeira  born 10 November 1999) is a Portuguese professional footballer who plays for Spanish club Atlético Madrid and the Portugal national team as a striker. He can also play as a winger or an attacking midfielder.\nFélix initially trained at Porto\'s youth ranks before moving to rivals Benfica in 2015. He began playing for the club\'s reserve side a year later and was promoted to the first-team in 2018, making his professional debut at 18 years old. He then starred as a goalscorer and helped Benfica win the league title in his first and only season, being awarded a',
                        style: textStyleHeading2(width, whiteColor: 1),
                      )
                    ],
                  ),
                ),
              ),
            ));
      });
    });
  }
}

class StatisticPercentage extends StatelessWidget {
  const StatisticPercentage(
      {Key? key,
      required this.width,
      required this.height,
      required this.radius,
      this.title,
      required this.percentage,
      this.percentageTitle,
      required this.widthLine})
      : super(key: key);

  final double width;
  final double height;
  final String? title;
  final double radius;
  final double percentage;
  final String? percentageTitle;
  final double widthLine;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          '$title',
          style: textStyleHeading2(width * 0.55, whiteColor: 1),
        ),
        CustomSizedBox(height: height),
        CircularPercentIndicator(
            radius: radius,
            lineWidth: widthLine,
            animation: true,
            animationDuration: 1000,
            addAutomaticKeepAlive: true,
            percent: percentage,
            progressColor: primaryColor,
            circularStrokeCap: CircularStrokeCap.round,
            center: FittedBox(
              child: Text("$percentageTitle",
                  style: textStyleHeading1(width * 0.58, whiteColor: 1)),
            ))
      ],
    );
  }
}
