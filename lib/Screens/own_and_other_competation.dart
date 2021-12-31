import 'package:cae/Constants/Constants.dart';
import 'package:cae/Constants/Styles.dart';
import 'package:cae/Provider/AppConstants.dart';
import 'package:cae/Provider/auth_provider.dart';
import 'package:cae/Widgets/text_form_field.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:contained_tab_bar_view/contained_tab_bar_view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:provider/provider.dart';

class OwnAndOtherCompetations extends StatefulWidget {
  const OwnAndOtherCompetations({Key? key}) : super(key: key);

  @override
  _OwnAndOtherCompetationsState createState() =>
      _OwnAndOtherCompetationsState();
}

class _OwnAndOtherCompetationsState extends State<OwnAndOtherCompetations> {
  @override
  Widget build(BuildContext context) {
    // var appConstants = Provider.of<AppConstants>(context, listen: true);
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Consumer<AppConstants>(builder: (context, appPro, _) {
      return Consumer<AuthProvider>(builder: (context, authPro, _) {
        return SafeArea(
            child: Scaffold(
                body: ModalProgressHUD(
          dismissible: false,
          inAsyncCall: authPro.loading,
          progressIndicator: loader(),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 500),
            // padding: const EdgeInsets.all(8.0),
            // color: Colors.blue,
            width: width,
            height: height,
            child: ContainedTabBarView(
              tabs: const [
                Text('My Competition'),
                Text(
                  'Competitions',
                ),
              ],
              tabBarProperties: TabBarProperties(
                  background: Container(
                    color: Colors.black,
                  ),
                  indicatorColor: primaryColor,
                  unselectedLabelColor: Colors.white,
                  labelColor: primaryColor,
                  labelStyle: textStyleHeading2(width, whiteColor: 0)),
              views: [
                Container(
                    color: Color(0xff243448),
                    child: StreamBuilder(
                      stream: FirebaseFirestore.instance
                          .collection("competition")
                          .where("user_id",
                              isEqualTo: FirebaseAuth.instance.currentUser!.uid)
                          .snapshots(),
                      builder: (BuildContext context, AsyncSnapshot snapshot) {
                        if (snapshot.hasError) {
                          return Center(
                              child: const Text('Something went wrong'));
                        }
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Center(
                              child: const CircularProgressIndicator());
                        }
                        return snapshot.data.docs.length >= 1
                            ? ListView.builder(
                                itemCount: snapshot.data.docs.length,
                                shrinkWrap: true,
                                itemBuilder: (BuildContext context, int index) {
                                  return Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: InkWell(
                                      onTap: () {
                                        showEditCompetition(
                                            snapshot.data.docs[index].id);
                                        // Navigator.push(
                                        //     context,
                                        //     MaterialPageRoute(
                                        //         builder: (context) =>
                                        //             const OwnAndOtherCompetations()));
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
                                                  '${snapshot.data.docs[index]["name"]} - ${snapshot.data.docs[index]["goal"]}',
                                                  style: textStyleHeading2(
                                                          width * 0.5,
                                                          whiteColor: 1)
                                                      .copyWith(
                                                          color: Colors.black),
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
                                                    Image.asset(
                                                        imageBaseAddress +
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
                                                      '${snapshot.data.docs[index]["currentStatus"]} - ${snapshot.data.docs[index]["newGoal"]}',
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
                                                    Image.asset(
                                                        imageBaseAddress +
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
                                              padding:
                                                  const EdgeInsets.symmetric(
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
                              )
                            : Center(
                                child: Text(
                                'Empty Competition',
                                style: TextStyle(color: Colors.white),
                              ));
                      },
                    )),
                Container(
                    color: Color(0xff243448),
                    child: StreamBuilder(
                      stream: FirebaseFirestore.instance
                          .collection("competition")
                          .snapshots(),
                      builder: (BuildContext context, AsyncSnapshot snapshot) {
                        if (snapshot.hasError) {
                          return Center(
                              child: const Text('Something went wrong'));
                        }
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Center(
                              child: const CircularProgressIndicator());
                        }
                        return snapshot.data.docs.length >= 1
                            ? ListView.builder(
                                itemCount: snapshot.data.docs.length,
                                shrinkWrap: true,
                                itemBuilder: (BuildContext context, int index) {
                                  return Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: InkWell(
                                      onTap: () {
                                        // Navigator.push(
                                        //     context,
                                        //     MaterialPageRoute(
                                        //         builder: (context) =>
                                        //             const OwnAndOtherCompetations()));
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
                                                    Image.asset(
                                                        imageBaseAddress +
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
                                                    Image.asset(
                                                        imageBaseAddress +
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
                                              padding:
                                                  const EdgeInsets.symmetric(
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
                              )
                            : Center(
                                child: Text(
                                'Empty Competition',
                                style: TextStyle(color: Colors.white),
                              ));
                      },
                    ))
              ],
              onChange: (index) {
                // ignore: avoid_print
                print(index);
              },
            ),
          ),
        )));
      });
    });
  }

  showEditCompetition(String doc) {
    var appCon = Provider.of<AppConstants>(context, listen: false);
    var authCon = Provider.of<AuthProvider>(context, listen: false);
    showModalBottomSheet(
        backgroundColor: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(Get.height * 0.06),
        ),
        context: context,
        builder: (context) {
          return Container(
            height: Get.height * 0.45,
            width: Get.width,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30)),
                color: Colors.black),
            child: Padding(
              padding: EdgeInsets.only(
                  left: Get.width * 0.05,
                  right: Get.width * 0.05,
                  top: Get.height * 0.01),
              child: Column(
                children: [
                  // TextFormFieldCustom(
                  //     controller: appCon.compCurrentStatusController,
                  //     textInputType: TextInputType.number,
                  //     obscure: false,
                  //     image: Image.asset('assets/images/person.png'),
                  //     text: 'Current Status',
                  //     errors: "Please enter Current Status",
                  //     enable: true),
                  SizedBox(
                    height: Get.height * 0.013,
                  ),
                  TextFormFieldCustom(
                    textInputType: TextInputType.text,
                    obscure: false,
                    enable: true,
                    image: Image.asset('assets/images/category.png'),
                    text: 'Next Goal',
                    errors: "Please enter your goal",
                    controller: appCon.compGoalController,
                  ),
                  SizedBox(
                    height: Get.height * 0.013,
                  ),
                  GestureDetector(
                    onTap: () {
                      authCon.updateCompetitionData(
                          context,
                          appCon.compGoalController.text.trim().toString(),
                          doc);
                      Navigator.pop(context);
                    },
                    child: Container(
                      height: Get.height * 0.06,
                      width: Get.width * .7,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25),
                          color: Colors.deepOrangeAccent[100]),
                      child: Center(
                        child: Text(
                          "Start",
                          style: TextStyle(
                              color: Colors.white, fontSize: Get.height * 0.02),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          );
        });
  }
}
