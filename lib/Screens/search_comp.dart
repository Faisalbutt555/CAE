import 'package:cae/Provider/AppConstants.dart';
import 'package:cae/Provider/auth_provider.dart';
import 'package:cae/Screens/competatiors_profiles.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
class SearchCompetition extends StatefulWidget {
  const SearchCompetition({Key? key}) : super(key: key);

  @override
  _SearchCompetitionState createState() => _SearchCompetitionState();
}

class _SearchCompetitionState extends State<SearchCompetition> {
  @override
  Widget build(BuildContext context) {
    return Consumer<AppConstants>(builder: (context,appPro,_){
      return Consumer<AuthProvider>(builder: (context,authPro,_){
        return SafeArea(child: Scaffold(
          body: SingleChildScrollView(
            child: Container(
                child: Column(
                  children: [
                    SizedBox(
                      height: Get.height*.03,
                    ),
                    Container(
                        padding: EdgeInsets.only(
                            left: Get.width * 0.03,
                            right: Get.width * 0.03),
                        // alignment: Alignment.center,
                        height: Get.height * 0.06,
                        width: Get.width,
                        decoration: BoxDecoration(
                          //color: Colors.red,
                          borderRadius: BorderRadius.circular(15),
                          // border: Border.all(width: 1,color: Colors.red),
                          // image: const DecorationImage(
                          //     fit: BoxFit.cover,
                          //     image: AssetImage(
                          //         'assets/images/textfield.png'))
                        ),
                        child: TextFormField(
                          obscureText: false,
                          enabled: true,
                          autofocus: true,
                          // controller:
                          // appProvider.confirmPasswordController,
                          cursorHeight: 30,
                          style: TextStyle(color: Colors.black),
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                                borderSide: BorderSide(
                                    color: Colors.black
                                )
                            ),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                                borderSide: BorderSide(
                                    color: Colors.black
                                )
                            ),
                            hintText: "search here",
                            // labelText: "",
                            contentPadding: EdgeInsets.only(left:20),
                            hintStyle: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w600),
                            suffixIcon: Icon(Icons.search,color: Colors.black,),
                            // prefixIcon: Image.asset(
                            //   'assets/images/lock.png',
                            //   color: Colors.white,
                            // ),
                          ),
                          onChanged: (val) {
                            setState(() {
                              appPro.setSearchText(val);
                            });
                          },
                        )),
                    Container(
                        width: Get.width,
                        height: Get.height*.5,
                        // color: Colors.black,
                        child:StreamBuilder<QuerySnapshot>(
                            stream: (appPro.name != "" && appPro.name != null)
                                ? FirebaseFirestore.instance
                                .collection('users')
                                .where("name", isEqualTo: appPro.name)
                                .snapshots()
                                : FirebaseFirestore.instance.collection("users").snapshots(),
                            builder: (context, snapshot) {
                              return (snapshot.connectionState == ConnectionState.waiting)?
                              Center(child: CircularProgressIndicator()):
                              ListView.builder(
                                itemCount: snapshot.data!.docs.length,
                                itemBuilder: (context, index) {
                                  DocumentSnapshot data = snapshot.data!.docs[index];
                                  return Card(
                                    child: GestureDetector(
                                      onTap: (){
                                        Get.to(CompetatorProfileScreen(
                                          name: data["name"],
                                          cName: data["zipcode"],
                                          profile: data["profile"],
                                        ));
                                      },
                                      child:Row(
                                        children: <Widget>[
                                          SizedBox(
                                            width: 25,
                                          ),
                                          Text(
                                            data['name'],
                                            style: TextStyle(
                                              fontWeight: FontWeight.w700,
                                              fontSize: 20,
                                            ),
                                          ),
                                        ],
                                      ),
                                    )
                                  );
                                },
                              );
                            }
                        )
                    )
                  ],
                )
            ),
          )
        ));
      });
    });
  }
}
