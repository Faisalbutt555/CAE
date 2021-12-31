import 'package:cae/Constants/Constants.dart';
import 'package:cae/Constants/Styles.dart';
import 'package:cae/Provider/AppConstants.dart';
import 'package:cae/Provider/auth_provider.dart';
import 'package:cae/Screens/AddCompetation.dart';
import 'package:cae/Screens/login_screen.dart';
import 'package:cae/Screens/add_competition_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class SelectCompetitionType extends StatelessWidget {
  const SelectCompetitionType({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthProvider>(builder: (context, auth, _) {
      return Consumer<AppConstants>(builder: (context, app, _) {
        return Scaffold(
          key: app.scaffoldKey3,
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
            height: Get.height,
            width: Get.width,
            decoration: BoxDecoration(
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
                Padding(
                  padding: EdgeInsets.only(
                      left: Get.width * 0.05, right: Get.width * 0.05),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // CircleAvatar(
                      //   radius: 20,
                      //   backgroundColor: Color(0xff707070),
                      //   child: Icon(Icons.arrow_back),
                      // ),
                      InkWell(
                          onTap: () {
                            app.scaffoldKey3.currentState!.openDrawer();
                          },
                          child: Icon(
                            Icons.menu,
                            color: white,
                          )),
                      // GestureDetector(
                      //   onTap: (){
                      //     print("ddd");
                      //   },
                      //   child:CircleAvatar(
                      //     radius: 20,
                      //     backgroundColor: Color(0xff707070),
                      //     child: Image.asset('assets/images/heart.png',),
                      //   )
                      // )
                    ],
                  ),
                ),
                Container(
                  alignment: Alignment.center,
                  height: Get.height * 0.44,
                  width: Get.width,
                  decoration: BoxDecoration(
                      //color: Colors.red,

                      image: DecorationImage(
                          fit: BoxFit.cover,
                          image: AssetImage('assets/images/sport.png'))),
                  child: Padding(
                    padding: EdgeInsets.only(bottom: Get.height * 0.03),
                    child: Container(
                        child: Image.asset('assets/images/sports.png')),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                      left: Get.width * 0.05, right: Get.width * 0.05),
                  child: Text(
                    'SPORTS',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: Get.height * 0.03,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(
                  height: Get.height * 0.02,
                ),
                Padding(
                  padding: EdgeInsets.only(
                      left: Get.width * 0.05, right: Get.width * 0.05),
                  child: Text(
                    'The Siamese fighting fish, commonly known as the betta, is a freshwater fish native to Southeast Asia, namely Cambodia, Laos, Myanmar, Malaysia, Indonesia, Thailand, and Vietnam. ',
                    style: TextStyle(
                        color: Colors.grey,
                        fontSize: Get.height * 0.017,
                        height: Get.height * 0.002),
                  ),
                ),
                SizedBox(
                  height: Get.height * 0.02,
                ),
                Padding(
                  padding: EdgeInsets.only(
                      left: Get.width * 0.05, right: Get.width * 0.05),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Column(
                          children: [
                            GestureDetector(
                              onTap: () {
                                app.compSelect(0);
                                app.updatedCompetitionTypeName("Sports");
                                app.compSubCategoryController.clear();
                                app.compCategoryController.clear();
// app
//     .updatedSelectedIndexCompetationType(e.index);
//  if (e.index==0) {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const AddCompetitionScreen(
                                              type: "sports",
                                            )));
                              },
                              child: Container(
                                alignment: Alignment.topRight,
                                width: Get.width,
                                height: Get.height * 0.25,
                                decoration: BoxDecoration(
                                    //color: Colors.red,
                                    borderRadius: BorderRadius.circular(15),
                                    border: Border.all(
                                        color: app.isCompSelected == 0
                                            ? Colors.white
                                            : Colors.black),
                                    image: const DecorationImage(
                                        fit: BoxFit.cover,
                                        image: AssetImage(
                                            'assets/images/container.png'))),
                                child: Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Spacer(),
                                      GestureDetector(
                                        onTap: () {
                                          print("dfdf");
                                          app.setFav(!app.isFavourite1, "1");
                                        },
                                        child: CircleAvatar(
                                          radius: 15,
                                          backgroundColor: Color(0xff707070),
                                          child: Image.asset(
                                            'assets/images/heart.png',
                                            color: app.isFavourite1
                                                ? Colors.red
                                                : Colors.white,
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                app.compSelect(1);
                                app.updatedCompetitionTypeName(
                                    "Health & Fitness");
                                app.compSubCategoryController.clear();
                                app.compCategoryController.clear();
                                // app
                                //     .updatedSelectedIndexCompetationType(e.index);
                                //  if (e.index==0) {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const AddCompetitionScreen(
                                              type: "Health",
                                            )));
                              },
                              child: Container(
                                alignment: Alignment.topRight,
                                height: Get.height * 0.25,
                                decoration: BoxDecoration(
                                    //color: Colors.red,
                                    borderRadius: BorderRadius.circular(15),
                                    border: Border.all(
                                        color: app.isCompSelected == 1
                                            ? Colors.white
                                            : Colors.black),
                                    image: const DecorationImage(
                                        fit: BoxFit.cover,
                                        image: AssetImage(
                                            'assets/images/health.png'))),
                                child: Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Spacer(),
                                      GestureDetector(
                                        onTap: () {
                                          print("dfdf");
                                          app.setFav(!app.isFavourite2, "2");
                                        },
                                        child: CircleAvatar(
                                          radius: 15,
                                          backgroundColor: Color(0xff707070),
                                          child: Image.asset(
                                            'assets/images/heart.png',
                                            color: app.isFavourite2
                                                ? Colors.red
                                                : Colors.white,
                                          ),
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
                      SizedBox(
                        width: Get.width * 0.04,
                      ),
                      Expanded(
                        child: Column(
                          children: [
                            SizedBox(
                              height: Get.height * 0.1,
                            ),
                            GestureDetector(
                              onTap: () {
                                app.compSelect(2);
                                app.updatedCompetitionTypeName("Education");
                                app.compSubCategoryController.clear();
                                app.compCategoryController.clear();
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const AddCompetitionScreen(
                                              type: "education",
                                            )));
                              },
                              child: Container(
                                alignment: Alignment.topRight,
                                height: Get.height * 0.25,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                    border: Border.all(
                                        color: app.isCompSelected == 2
                                            ? Colors.white
                                            : Colors.black),
                                    image: const DecorationImage(
                                        fit: BoxFit.cover,
                                        image: AssetImage(
                                            'assets/images/education.png'))),
                                child: Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Spacer(),
                                      GestureDetector(
                                        onTap: () {
                                          print("dfdf");
                                          app.setFav(!app.isFavourite3, "3");
                                        },
                                        child: CircleAvatar(
                                          radius: 15,
                                          backgroundColor: Color(0xff707070),
                                          child: Image.asset(
                                            'assets/images/heart.png',
                                            color: app.isFavourite3
                                                ? Colors.red
                                                : Colors.white,
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                app.compSelect(3);
                                app.updatedCompetitionTypeName("Finance");
                                app.compSubCategoryController.clear();
                                app.compCategoryController.clear();
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const AddCompetitionScreen(
                                              type: "finance",
                                            )));
                              },
                              child: Container(
                                alignment: Alignment.topRight,
                                height: Get.height * 0.25,
                                decoration: BoxDecoration(
                                    //color: Colors.red,
                                    //color: Colors.blue,
                                    borderRadius: BorderRadius.circular(15),
                                    border: Border.all(
                                        color: app.isCompSelected == 3
                                            ? Colors.white
                                            : Colors.black),
                                    image: const DecorationImage(
                                        fit: BoxFit.cover,
                                        image: AssetImage(
                                            'assets/images/finance.png'))),
                                child: Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      const Spacer(),
                                      GestureDetector(
                                        onTap: () {
                                          print("dfdf");
                                          app.setFav(!app.isFavourite4, "4");
                                        },
                                        child: CircleAvatar(
                                          radius: 15,
                                          backgroundColor: Color(0xff707070),
                                          child: Image.asset(
                                            'assets/images/heart.png',
                                            color: app.isFavourite4
                                                ? Colors.red
                                                : Colors.white,
                                          ),
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
                    ],
                  ),
                )
              ],
            ),
          ),
        );
      });
    });
  }
}
