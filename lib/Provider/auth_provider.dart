// ignore_for_file: unused_local_variable

import 'dart:async';
import 'dart:io';

import 'package:cae/Constants/Constants.dart';
import 'package:cae/Constants/Styles.dart';
import 'package:cae/Models/credit_card_model.dart';
import 'package:cae/Models/user_model.dart';
import 'package:cae/Provider/AppConstants.dart';
import 'package:cae/Screens/HomeScreen.dart';
import 'package:cae/Screens/login_screen.dart';
import 'package:cae/Screens/congrats_screen.dart';
import 'package:cae/Screens/openforgotmail.dart';
import 'package:cae/StripePayment/payment.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_credit_card/credit_card_model.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';
import 'package:firebase_core/firebase_core.dart' as firebase_core;
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class AuthProvider extends ChangeNotifier {
  var loading = false;
  startLoading() {
    loading = true;
    notifyListeners();
  }

  stopLoading() {
    loading = false;
    notifyListeners();
  }

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final firebaseFirestore = FirebaseFirestore.instance;
  void register(BuildContext context, String name, String userName,
      String email, String zipCode, String phoneNum, String password) async {
    startLoading();
    firebaseFirestore
        .collection("user")
        .where("mail", isEqualTo: email)
        .get()
        .then((value) async {
      if (value.docs.length == 0) {
        try {
          final user = (await _auth
                  .createUserWithEmailAndPassword(
                    email: email,
                    password: password,
                  )
                  .timeout(const Duration(seconds: 30)))
              .user;
          if (user != null) {
            //enter mail verification
            await saveData(context, user.uid, name, userName, email, zipCode,
                    phoneNum, password)
                .then((value) {
              _auth.currentUser!.sendEmailVerification().then((value) {
                stopLoading();
                _auth.signOut();
                Get.offAll(const OpenForgotMail());
                showSuccessSnackBar("Registration done successfully.");
              });
            });
          } else {
            stopLoading();
            Get.snackbar("Error", "Registration not done");
          }
        } on TimeoutException catch (_) {
          stopLoading();
          showErrorSnackBar("Internet connection is not constant.");
        } on FormatException catch (error) {
          stopLoading();
          showErrorSnackBar("Bad response format from server");
          return null;
        } catch (v) {
          stopLoading();
          print(v.toString());
          showErrorSnackBar(v.toString());
          return null;
        }
      } else {
        //stopLoading();
        showErrorSnackBar(
            "This mail is already exist use another one and try again");
      }
    });
  }

  void sendVerificationMail() async {}
  login(BuildContext context, String email, String password) async {
    var appPro = Provider.of<AppConstants>(context, listen: false);
    startLoading();

    if (email.contains("@")) {
      try {
        await _auth
            .signInWithEmailAndPassword(
              email: email,
              password: password,
            )
            .timeout(const Duration(seconds: 30))
            .then((value) {
          if (value != null && value.user!.emailVerified) {
            appPro.emailController.clear();
            appPro.passwordController.clear();
            getData(_auth.currentUser!.uid).then((value) {
              stopLoading();
              Get.offAll(const HomeScreen());
            });
          } else {
            stopLoading();
            showErrorSnackBar(
                "Your mail is not verified. Check your email and click on link to verify yourself.");
          }
          return true;
        });
      } on FirebaseAuthException catch (e) {
        print('e firebase: $e');
        if (e.code == 'user-not-found') {
          stopLoading();
          showErrorSnackBar("No user found for that email..");
        } else if (e.code == 'wrong-password') {
          stopLoading();
          showErrorSnackBar("Wrong password provided for that user.");
        }
      } on TimeoutException catch (_) {
        stopLoading();
        showErrorSnackBar("Internet connection is not constant.");
        return false;
      } on FormatException catch (error) {
        stopLoading();
        showErrorSnackBar("Bad response format from server");
        return false;
      } catch (v) {
        stopLoading();
        showErrorSnackBar("${v.toString()}");
        return false;
      }
    } else {
      print("Where get $email");
      try {
        FirebaseFirestore.instance.collection("user").get().then((value) {
          value.docs.forEach((result) {
            // print("Where");
            // print(result.data());
            // print("Db user ${result.data()['userName']}");
            // print("user Enter $email");
            if (result.data()['userName'] == email) {
              var userEmail = result.data()['mail'];
              print('userEmail: $userEmail');
              try {
                _auth
                    .signInWithEmailAndPassword(
                      email: userEmail,
                      password: password,
                    )
                    .timeout(const Duration(seconds: 30))
                    .then((value) {
                  if (value != null && value.user!.emailVerified) {
                    appPro.emailController.clear();
                    appPro.passwordController.clear();
                    getData(_auth.currentUser!.uid).then((value) {
                      stopLoading();
                      Get.offAll(const HomeScreen());
                    });
                  } else {
                    print("Get Not vrify Data");
                    stopLoading();
                    showErrorSnackBar(
                        "Your mail is not verified. Check your email and click on link to verify yourself.");
                  }
                });
              } catch (e) {
                print('e: $e');

                print("catech is wrong");
                stopLoading();
                showErrorSnackBar("Your username and password is wrong");
              }
            } else {
              print("User name fail");
              // stopLoading();
              // showErrorSnackBar("Your username and password is wrong");
              //  return false;
            }
          });
        });
      } catch (e) {
        print("asdfdaaaaaaaaaaaaaaaaaaaaaaaaaaaaa");
      }

      // print("USer name validate");
      // await FirebaseFirestore.instance
      //     .collection("user")
      //     .get()
      //     .then((querySnapshot) {
      //   print('querySnapshot: $querySnapshot');
      //   for (var result in querySnapshot.docs) {
      //     var uName = result.data()["userName"].toString();
      //     print('result.data(): ${result.data()}');
      //     print('email: $email');
      //     print('yourName: $uName');
      //     if (uName == email.toString()) {
      //       var userEmail = result.data()['mail'];
      //       print('userEmail: $userEmail');

      //       try {
      //         _auth
      //             .signInWithEmailAndPassword(
      //               email: userEmail,
      //               password: password,
      //             )
      //             .timeout(const Duration(seconds: 30))
      //             .then((value) {
      //           if (value != null && value.user!.emailVerified) {
      //             appPro.emailController.clear();
      //             appPro.passwordController.clear();
      //             getData(_auth.currentUser!.uid).then((value) {
      //               stopLoading();
      //               Get.offAll(const HomeScreen());
      //             });
      //           } else {
      //             print("Get Not vrify Data");
      //             stopLoading();
      //             showErrorSnackBar(
      //                 "Your mail is not verified. Check your email and click on link to verify yourself.");
      //           }
      //           return true;
      //         });
      //       } catch (e) {
      //         print('e: $e');

      //         print("catech is wrong");
      //         stopLoading();
      //         showErrorSnackBar("Your username and password is wrong");
      //         return false;
      //       }
      //     } else {
      //       // print("eslse case");
      //       // stopLoading();
      //       print("username is wrong");

      //       showErrorSnackBar("Your username and password is wrong");
      //       return false;
      //     }
      //   }
      // });
    }

    //}
    // else{
    //   stopLoading();
    //   firebaseFirestore.collection("user").where("userName",isEqualTo: email).get().then((value){
    //     print(value.docs.length);
    //     if(value.docs.length==0){
    //       showErrorSnackBar("not exist.");
    //     }
    //     else{
    //       firebaseFirestore.collection("user").where("userName",isEqualTo: email).where("pass",isEqualTo:password).get().then((value){
    //         if(value.docs.length!=0){
    //           // print(value.docs[1]["name"]);
    //           showSuccessSnackBar("exist");
    //         }
    //         else{
    //           showErrorSnackBar("This user name is'nt exist.");
    //         }
    //       });
    //     }
    //   });
    // }
  }

  setFieldClear(BuildContext context) {
    var appPro = Provider.of<AppConstants>(context, listen: false);
    appPro.nameController.clear();
    appPro.emailController.clear();
    appPro.zipCodeController.clear();
    appPro.phoneController.clear();
    appPro.passwordController.clear();
    appPro.confirmPasswordController.clear();
  }

  Future<bool> saveData(
      BuildContext context,
      String doc,
      String name,
      String userName,
      String mail,
      String zipCode,
      String phone,
      String pass) async {
    var appPro = Provider.of<AppConstants>(context, listen: false);
    await firebaseFirestore.collection("user").doc(doc).set({
      "id": doc,
      "name": name,
      "userName": userName,
      "mail": mail,
      "zipcode": zipCode,
      "phone": phone,
      "pass": pass,
      "profile": ""
    }).then((value) {
      appPro.nameController.clear();
      appPro.emailController.clear();
      appPro.zipCodeController.clear();
      appPro.phoneController.clear();
      appPro.passwordController.clear();
      appPro.confirmPasswordController.clear();
      return Future.value(true);
    });
    return Future.value(false);
  }

  ///////////////////////// image //////////////////////
  File? profilePic;
  String? downloadedLink;
  Future pickImage(ImageSource source, BuildContext context) async {
    // final progress=ProgressHUD.of(context);
    final ImagePicker picker = ImagePicker();
    final pickedFile = await picker.getImage(source: source);
    profilePic = File(pickedFile!.path);
    // progress.show();
    uploadImageToFirebase(context, profilePic!).then((value) {
      if (value) {
        //Get.snackbar("Done", "Image Uploaded Successfully");
      } else {
        //Get.snackbar("Error", "Image not Uploaded");
      }
    });
    // AuthUtils().user.updatePhotoURL(imageFile);
    notifyListeners();
  }

  Future<bool> uploadImageToFirebase(
      BuildContext context, File imageUrl) async {
    var uuid = Uuid();
    firebase_storage.Reference firebaseStorageRef = firebase_storage
        .FirebaseStorage.instance
        .ref()
        .child('candidate_pic/${_auth.currentUser!.uid}+${uuid.v4()}');
    firebase_storage.UploadTask uploadTask =
        firebaseStorageRef.putFile(imageUrl);
    firebase_storage.TaskSnapshot taskSnapshot =
        await uploadTask.whenComplete(() async {
      String img = await uploadTask.snapshot.ref.getDownloadURL();
      notifyListeners();
    });
    taskSnapshot.ref.getDownloadURL().then(
      (value) {
        downloadedLink = value;
        firebaseFirestore
            .collection("users")
            .doc(_auth.currentUser!.uid)
            .update({"profile": downloadedLink});
        _auth.currentUser!.updatePhotoURL(downloadedLink);
        notifyListeners();
        return true;
      },
    );
    return false;
  }

  openBottomSheet(context) {
    showModalBottomSheet(
        isDismissible: false,
        context: context,
        builder: (BuildContext bc) {
          return Container(
            child: Wrap(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Icon(
                      Icons.arrow_drop_down_sharp,
                      color: Colors.grey,
                      size: 80,
                    )
                  ],
                ),
                ListTile(
                    leading: const Icon(Icons.camera),
                    title: const Text('From CAMERA'),
                    onTap: () async {
                      pickImage(ImageSource.camera, context);
                      Navigator.of(context).pop();
                      // if(permissionStatus==_permissionStatus){
                      //   imgFrom(ImageSource.gallery, context);
                      //   Navigator.of(context).pop();
                      // }
                      // else {
                      //   if (await requestPermission() == _permissionStatus.isGranted) {
                      //     imgFrom(ImageSource.camera, context);
                      //     Navigator.of(context).pop();
                      //   }
                      // }
                    }),
                ListTile(
                  leading: const Icon(Icons.image_outlined),
                  title: const Text('From INTERNAL STORAGE'),
                  onTap: () async {
                    pickImage(ImageSource.gallery, context);
                    Navigator.of(context).pop();
                    // if(permissionStatus==_permissionStatus){
                    //   imgFrom(ImageSource.gallery, context);
                    //   Navigator.of(context).pop();
                    // }
                    // else {
                    //   if (await requestPermission() == _permissionStatus.isGranted) {
                    //     imgFrom(ImageSource.gallery, context);
                    //     Navigator.of(context).pop();
                    //   }
                    // }
                  },
                ),
              ],
            ),
          );
        });
  }

  editProfileBS(context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    var appProvider = Provider.of<AppConstants>(context, listen: false);
    showModalBottomSheet(
        isDismissible: false,
        context: context,
        builder: (BuildContext bc) {
          return SingleChildScrollView(
              child: Wrap(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.all(16),
                child: Container(
                    decoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Padding(
                        padding: EdgeInsets.only(left: 15, right: 15, top: 5),
                        child: TextFormField(
                            controller: appProvider.nameController,
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                              labelText: 'Your username',
                            )))),
              ),
              SizedBox(
                height: height * 0.015,
              ),
              Padding(
                padding: EdgeInsets.all(16),
                child: Container(
                    decoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Padding(
                        padding: EdgeInsets.only(left: 15, right: 15, top: 5),
                        child: TextFormField(
                            controller: appProvider.zipCodeController,
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                              labelText: 'Your zip code',
                            )))),
              ),
              GestureDetector(
                  onTap: () {
                    if (appProvider.nameController.text == "" &&
                        appProvider.zipCodeController.text == "") {
                      showErrorSnackBar(
                          "At least one field is required for update profile");
                    } else {
                      updateProfileData(context);
                    }
                  },
                  child: Center(
                    child: Container(
                      alignment: Alignment.center,
                      width: Get.width * .7,
                      height: Get.height * .08,
                      decoration: BoxDecoration(
                          color: Colors.grey,
                          borderRadius: BorderRadius.circular(20)),
                      child: const Text(
                        "Update",
                        style: TextStyle(color: Colors.black, fontSize: 20),
                      ),
                    ),
                  ))
            ],
          ));
        });
  }

  updateCompetitionData(BuildContext context, String goal, String doc) {
    var appProvider = Provider.of<AppConstants>(context, listen: false);
    startLoading();
    firebaseFirestore.collection("competition").doc(doc).update({
      // "currentStatus":cStatus,
      "newGoal": goal,
    }).then((value) {
      stopLoading();
      appProvider.compCurrentStatusController.clear();
      appProvider.compGoalController.clear();
    });
  }

  updateProfileData(BuildContext context) {
    var appProvider = Provider.of<AppConstants>(context, listen: false);
    firebaseFirestore.collection("users").doc(_auth.currentUser!.uid).update({
      "name": appProvider.nameController.text == ""
          ? userModelObj.name
          : appProvider.nameController.text.trim(),
      "zipcode": appProvider.zipCodeController.text == ""
          ? userModelObj.zipCode
          : appProvider.zipCodeController.text.trim(),
    }).then((value) {
      appProvider.nameController.clear();
      appProvider.zipCodeController.clear();
      getData(_auth.currentUser!.uid);
      // Get.offAll(HomeScreen());
    });
  }

  Future<bool> getData(String doc) async {
    firebaseFirestore.collection("users").doc(doc).get().then((value) {
      if (value.data()!.length > 0) {
        userModelObj = UserModel(
          profile: value.data()!["profile"],
          name: value.data()!["name"],
          zipCode: value.data()!["zipcode"],
        );
        notifyListeners();
      }
      return Future.value(true);
    });
    return Future.value(false);
  }

  getCardDetail() {
    firebaseFirestore
        .collection("credit_cards")
        .where("user_id", isEqualTo: _auth.currentUser!.uid)
        .get()
        .then((value) {
      if (value.docs.isNotEmpty) {
        creditCardModelObj = GetCreditCardDetailModel(
            cardNumber: value.docs[0]["cardNumber"],
            cardName: value.docs[0]["cardName"],
            cardCvc: value.docs[0]["cardCvc"],
            cardExp: value.docs[0]["cardExp"]);
        print(creditCardModelObj.cardNumber);
      }
    });
  }

  saveCardDetail({
    BuildContext? context,
    String? cardCVC,
    String? cardExpiry,
    String? cardName,
    String? cardNumber,
  }) {
    startLoading();
    firebaseFirestore.collection("credit_cards").doc().set({
      "cardNumber": cardNumber,
      "cardName": cardName,
      "cardExp": cardExpiry,
      "cardCvc": cardCVC,
      "user_id": _auth.currentUser!.uid
    }).then((value) {
      stopLoading();
      // Get.to(Payment(finalAmount: 2000));
      Get.back();
      showSuccessSnackBar("Card Added Successfully");
    });
  }

  saveCompetitionData(
      BuildContext context,
      String? compName,
      String? compType,
      String? compCategory,
      String? compSubCategory,
      String? compMeasurement,
      String? compGoal,
      String? compCurrentStatus,
      DateTime? compSDate,
      DateTime? compEDate,
      String? compPrice) {
    var appPro = Provider.of<AppConstants>(context, listen: false);
    firebaseFirestore.collection("competition").doc().set({
      "name": compName,
      "type": compType,
      "category": compCategory,
      "subCategory": compSubCategory,
      "measurement": compMeasurement,
      "newGoal": compGoal,
      "goal": compGoal,
      "currentStatus": compCurrentStatus,
      "sDate": compSDate,
      "eDate": compEDate,
      "amount": compPrice,
      "user_id": _auth.currentUser!.uid
    }).then((value) {
      appPro.compNameController.clear();
      appPro.compTypeController.clear();
      appPro.compCategoryController.clear();
      appPro.compSubCategoryController.clear();
      appPro.compMeasurementController.clear();
      appPro.compGoalController.clear();
      appPro.compCurrentStatusController.clear();
      appPro.compPriceController.clear();
      appPro.compStartDate = null;
      appPro.compEndDate = null;
      Get.offAll(CongratsScreen());
    });
  }

  sendVerificationEmail(String password, String email, BuildContext context) {
    var appPro = Provider.of<AppConstants>(context, listen: false);
    var authPro = Provider.of<AuthProvider>(context, listen: false);
    startLoading();
    try {
      firebaseFirestore
          .collection("users")
          .where("mail", isEqualTo: email)
          .get()
          .then((user) async {
        if (user.docs.isNotEmpty) {
          print(user.docs[0]["name"]);
          await _auth
              .signInWithEmailAndPassword(
                email: email,
                password: user.docs[0]["pass"],
              )
              .timeout(const Duration(seconds: 30))
              .then((value) {
            print(_auth.currentUser!.uid);
            firebaseFirestore
                .collection("users")
                .doc(user.docs[0]["id"])
                .update({"pass": password}).then((value) {
              // _auth.currentUser!.updatePassword(password).then((value) {
              _auth.sendPasswordResetEmail(email: email).then((value) {
                _auth.signOut();
                stopLoading();
                appPro.emailController.clear();
                appPro.passwordController.clear();
                Get.offAll(const OpenForgotMail());
                showSuccessSnackBar("Successfully update password");
              });
              // });
            });
          });
        } else {
          stopLoading();
          showErrorSnackBar("Could not find account on that mail.");
        }
      });
    } on TimeoutException catch (_) {
      stopLoading();
      showErrorSnackBar("Internet connection is not constant.");
    } on FormatException catch (error) {
      stopLoading();
      showErrorSnackBar("Bad response format from server");
      return null;
    } catch (v) {
      stopLoading();
      showErrorSnackBar(v.toString());
      return null;
    }
  }

  // searchData(String name)async{
  //   List<DocumentSnapshot> documentList;
  //   documentList=await firebaseFirestore
  //       .collection("users")
  //       .where("name", isEqualTo: name)
  //       .get().then((value){
  //   });
  // if(documentList!=null){
  //   List<String> caseSearchList =[];
  //   String temp = "";
  //   for (int i = 0; i < documentList.length; i++) {
  //     // temp = temp + documentList[i];
  //     caseSearchList.add(documentList[i]);
  //   }
  //   return caseSearchList;
  // }
  // }
}
// var appPro = Provider.of<AppConstants>(context, listen: false);
// var authPro = Provider.of<AuthProvider>(context, listen: false);
// startLoading();
// firebaseFirestore
//     .collection("users")
// .where("mail", isEqualTo: email)
// .get()
//     .then((value) async {
// if (value.docs.length>0) {
// _auth.sendPasswordResetEmail(email: email).then((value){
// stopLoading();
// // appPro.emailController.clear();
// Get.offAll(OpenForgotMail());
// showSuccessSnackBar("successfully done");
// });
// Future.delayed(Duration(seconds: 30),(){
// authPro.stopLoading();
// showErrorSnackBar("Internet Problem. Slow Internet Connection");
// });
// // try{
// //
// // }
// // catch(e){
// //   stopLoading();
// //   showErrorSnackBar(e.toString());
// // }
// }
// else{
// stopLoading();
// showErrorSnackBar("Could not find account on that mail.");
// }
// });
