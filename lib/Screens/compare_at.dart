import 'package:cae/Constants/Constants.dart';
import 'package:cae/Constants/Styles.dart';
import 'package:cae/Provider/AppConstants.dart';
import 'package:cae/Provider/auth_provider.dart';
import 'package:cae/Screens/login_screen.dart';
import 'package:cae/Screens/own_and_other_competation.dart';
import 'package:cae/StripePayment/payment_screen.dart';
import 'package:cae/Screens/profile_screen.dart';
import 'package:cae/Screens/competatiors_profiles.dart';
import 'package:cae/Screens/search_comp.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hexagon/hexagon.dart';
import 'package:provider/provider.dart';

class CompateAt extends StatefulWidget {
  const CompateAt({Key? key}) : super(key: key);

  @override
  _CompateAtState createState() => _CompateAtState();
}

class _CompateAtState extends State<CompateAt> {
  final List<String> sliderImages = [
    imageBaseAddress + "slider1.png",
    imageBaseAddress + "slider2.png",
    imageBaseAddress + "slider1.png",
    imageBaseAddress + "slider2.png",
  ];

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Consumer<AppConstants>(builder: (context, appPro, _) {
      return Consumer<AuthProvider>(builder: (context, authPro, _) {
        return Scaffold(
          key: appPro.scaffoldKey1,
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
                child:            Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: height * 0.04,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconButton(
                            icon: Icon(
                              Icons.menu,
                              color: white,
                            ),
                            onPressed: () {
                              appPro.scaffoldKey1.currentState!.openDrawer();
                            },
                          ),
                          Text('Compete At Everything',
                              style:
                              textStyleHeading13Italic(width, whiteColor: 1)),
                          IconButton(
                            icon: Icon(
                              Icons.search,
                              color: white,
                            ),
                            onPressed: () {
                              Get.to(const SearchCompetition());
                            },
                          ),
                        ],
                      ),
                      CustomSizedBox(height: height),
                      Text('HOT Competitions',
                          style: textStyleHeading13Italic(width * 0.7,
                              whiteColor: 1)),
                      CustomSizedBox(height: height),
                      SizedBox(
                        height: height * 0.22,
                        width: width,
                        child: CarouselSlider(
                          options: CarouselOptions(
                            autoPlay: true,
                            enlargeCenterPage: true,
                            autoPlayAnimationDuration:
                            const Duration(milliseconds: 300),
                          ),
                          items: sliderImages
                              .map((item) => Stack(
                            children: [
                              Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 4.0, vertical: 4.0),
                                  child: Image.asset(
                                    item,
                                    fit: BoxFit.cover,
                                    width: width,
                                    height: height * 0.25,
                                  )),
                              Positioned(
                                  bottom: 20,
                                  left: 20,
                                  right: 5,
                                  child: Column(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Early Stage of Football Industry',
                                        style: textStyleHeading2(
                                            width * 0.7,
                                            whiteColor: 1),
                                      ),
                                      Text(
                                        'June, 29',
                                        style: textStyleHeading2(
                                            width * 0.6,
                                            whiteColor: 1),
                                      ),
                                    ],
                                  ))
                            ],
                          ))
                              .toList(),
                        ),
                      ),
                      CustomSizedBox(height: height),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Current Competitors',
                              style: textStyleHeading13Italic(width * 0.7,
                                  whiteColor: 1)),
                          // Text('See All',
                          //     style: textStyleHeading1(width * 0.7, whiteColor: 4))
                        ],
                      ),
                      SizedBox(
                        height: height * 0.2,
                        child: StreamBuilder(
                            stream: FirebaseFirestore.instance
                                .collection("users")
                                .snapshots(),
                            builder:
                                (BuildContext context, AsyncSnapshot snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return Center(child: CircularProgressIndicator());
                              } else if (snapshot.connectionState ==
                                  ConnectionState.active ||
                                  snapshot.connectionState ==
                                      ConnectionState.done) {
                                if (snapshot.hasError) {
                                  return const Text('Error');
                                }
                              } else if (!snapshot.hasData) {
                                return Center(
                                  child: Text("No Data Found"),
                                );
                              }
                              var list = snapshot.data;
                              return snapshot.data.docs.length>=1?ListView.builder(
                                itemCount: snapshot.data.docs.length,
                                shrinkWrap: true,
                                scrollDirection: Axis.horizontal,
                                physics: const BouncingScrollPhysics(),
                                itemBuilder: (BuildContext context, int index) {
                                  return InkWell(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  CompetatorProfileScreen(
                                                    name: snapshot
                                                        .data.docs[index]["name"],
                                                    cName: snapshot.data
                                                        .docs[index]["zipcode"],
                                                    profile: snapshot.data
                                                        .docs[index]["profile"],
                                                  )));
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Stack(
                                        children: [
                                          Padding(
                                            padding: EdgeInsets.only(
                                                top: height * 0.05),
                                            child: Container(
                                              height: height * 0.17,
                                              width: width * 0.26,
                                              decoration: BoxDecoration(
                                                  color: primaryColor,
                                                  borderRadius:
                                                  BorderRadius.circular(20)),
                                            ),
                                          ),
                                          Positioned(
                                            top: 0,
                                            left: 2,
                                            right: 2,
                                            child: Column(
                                              children: [
                                                HexagonWidget.flat(
                                                  width: width * 0.25,
                                                  color: competeAtBackGroundColor
                                                      .withOpacity(0.4),
                                                  padding: 4.0,
                                                  cornerRadius: 10,
                                                  child: snapshot.data.docs[index]
                                                  ["profile"] !=
                                                      null
                                                      ? Image.network(snapshot
                                                      .data
                                                      .docs[index]["profile"])
                                                      : Image.asset(
                                                    imageBaseAddress +
                                                        '1.png',
                                                    fit: BoxFit.cover,
                                                    width: width,
                                                    height: height * 0.08,
                                                  ),
                                                ),
                                                CustomSizedBox(height: height),
                                                Text(
                                                    '${snapshot.data.docs[index]["name"]}',
                                                    style: textStyleHeading2(
                                                        width * 0.62,
                                                        whiteColor: 1)),
                                                Text(
                                                    '${snapshot.data.docs[index]["zipcode"]}',
                                                    style: textStyleHeading2(
                                                        width * 0.55,
                                                        whiteColor: 1))
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              ):Center(child:Text('Empty Competitors',style: TextStyle(color: Colors.white),));
                            }),
                      ),
                      // CustomSizedBox(height: height),
                      Text('Competitions',
                          style: textStyleHeading13Italic(width * 0.7,
                              whiteColor: 1)),
                      Container(
                          height: Get.height*.3,
                          // color: Colors.blue,
                          child: StreamBuilder(
                            stream: FirebaseFirestore.instance
                                .collection("competition")
                                .snapshots(),
                            builder:
                                (BuildContext context, AsyncSnapshot snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return Center(child: CircularProgressIndicator());
                              } else if (snapshot.connectionState ==
                                  ConnectionState.active ||
                                  snapshot.connectionState ==
                                      ConnectionState.done) {
                                if (snapshot.hasError) {
                                  return const Center(child:Text('Error',style: TextStyle(color: Colors.white),));
                                }
                              } else if (!snapshot.hasData) {
                                return const Center(child:Text('Empty Competition',style: TextStyle(color: Colors.white),));
                              }
                              return snapshot.data.docs.length>=1?ListView.builder(
                                itemCount: snapshot.data.docs.length,
                                shrinkWrap: true,
                                itemBuilder: (BuildContext context, int index) {
                                  return Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: InkWell(
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                const OwnAndOtherCompetations()));
                                      },
                                      child: Container(
                                        decoration: BoxDecoration(
                                            color: primaryColor,
                                            borderRadius:
                                            BorderRadius.circular(20)),
                                        width: width,
                                        child: Column(
                                          children: [
                                            Container(
                                              color: competeAtBackGreenColor,
                                              child: Padding(
                                                padding:
                                                const EdgeInsets.all(2.0),
                                                child: Text(
                                                  'Premier League',
                                                  style: textStyleHeading2(
                                                      width * 0.5,
                                                      whiteColor: 1),
                                                ),
                                              ),
                                            ),
                                            Row(
                                              children: [
                                                Expanded(
                                                  // flex: 3,
                                                    child: Column(
                                                      crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                      mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                      children: [
                                                        Image.asset(imageBaseAddress +
                                                            'firstmatch1.png'),
                                                        Text(
                                                          'Arsenal',
                                                          style: textStyleHeading2(
                                                              width * 0.7,
                                                              whiteColor: 1),
                                                        )
                                                      ],
                                                    )),
                                                Column(
                                                  children: [
                                                    Text(
                                                      'Premier League',
                                                      style: textStyleHeading2(
                                                          width * 0.5,
                                                          whiteColor: 1),
                                                    ),
                                                    Text(
                                                      '${snapshot.data.docs[index]["currentStatus"]} - ${snapshot.data.docs[index]["goal"]}',
                                                      style: textStyleHeading1(
                                                          width,
                                                          whiteColor: 1),
                                                    ),
                                                    Text(
                                                      DateTime.fromMicrosecondsSinceEpoch(
                                                          snapshot
                                                              .data
                                                              .docs[index]
                                                          ["sDate"]
                                                              .microsecondsSinceEpoch)
                                                          .toLocal()
                                                          .toString()
                                                          .split(" ")[0],
                                                      style: textStyleHeading2(
                                                          width * 0.5,
                                                          whiteColor: 1),
                                                    ),
                                                  ],
                                                ),
                                                // Expanded(child: Image.asset(imageBaseAddress+'firstmatch1.png')),
                                                Expanded(
                                                  // flex: 3,
                                                    child: Column(
                                                      crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                      mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                      children: [
                                                        Image.asset(imageBaseAddress +
                                                            'firstmatch2.png'),
                                                        Text(
                                                          'Manchester Utd',
                                                          style: textStyleHeading2(
                                                              width * 0.7,
                                                              whiteColor: 1),
                                                        )
                                                      ],
                                                    )),
                                              ],
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.symmetric(
                                                  horizontal: 14.0),
                                              child: Divider(
                                                color: white,
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  bottom: 8.0),
                                              child: Text('Details',
                                                  style: textStyleHeading2(
                                                      width * 0.75,
                                                      whiteColor: 1)),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ):Center(child:Text('Empty Competition',style: TextStyle(color: Colors.white),));
                            },
                          )),
                    ],
                  ),
                ),
            ),
          ),
        );
      });
    });
  }
}

class CustomSizedBox extends StatelessWidget {
  const CustomSizedBox({
    Key? key,
    required this.height,
  }) : super(key: key);

  final double height;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height * 0.01,
    );
  }
}

