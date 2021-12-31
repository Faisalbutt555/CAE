import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AppConstants extends ChangeNotifier {
  final GlobalKey<ScaffoldState> scaffoldKey1 = GlobalKey<ScaffoldState>();
  final GlobalKey<ScaffoldState> scaffoldKey2 = GlobalKey<ScaffoldState>();
  final GlobalKey<ScaffoldState> scaffoldKey3 = GlobalKey<ScaffoldState>();
  final GlobalKey<ScaffoldState> scaffoldKey4 = GlobalKey<ScaffoldState>();

  final GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();
  final GlobalKey<FormState> regisFormKey = GlobalKey<FormState>();
  final GlobalKey<FormState> forgotFormKey = GlobalKey<FormState>();
  final GlobalKey<FormState> addCompFormKey = GlobalKey<FormState>();
  // controllers
  final  emailController = TextEditingController();
  final  passwordController = TextEditingController();
  final  confirmPasswordController = TextEditingController();
  final  nameController = TextEditingController();
  final  userNameController = TextEditingController();
  final  zipCodeController = TextEditingController();
  final  phoneController = TextEditingController();

  // add comptitation
  // var addCompFormKey=GlobalKey<FormState>();
  var compNameController = TextEditingController();
  var compTypeController = TextEditingController();
  var compCategoryController = TextEditingController();
  var compSubCategoryController = TextEditingController();
  var compMeasurementController = TextEditingController();
  var compGoalController = TextEditingController();
  var compCurrentStatusController = TextEditingController();
  var compStartDateController = TextEditingController();
  var compEndDateController = TextEditingController();
  var compPriceController = TextEditingController();

  String name = "";
  setSearchText(String text){
    name=text;
    notifyListeners();
  }
  var loginEye=false;
  var reg1Eye=false;
  var reg2Eye=false;
  var forgotEye=false;

  setLoginEye(){
    loginEye=!loginEye;
   
  }
  setReg1Eye(){
    reg1Eye=!reg1Eye;
   
  }
  setReg2Eye(){
    reg2Eye=!reg2Eye;
    

  }setForgotEye(){
    forgotEye=forgotEye;
   

  }
  bool isSignIn = true;
  bool isFavourite1=false;
  bool isFavourite2=false;
  bool isFavourite3=false;
  bool isFavourite4=false;
  setFav(bool val,String index){
     switch(index){
       case "1":{
         isFavourite1=val;
         break;
       }
       case "2":{
         isFavourite2=val;
         break;
       }
       case "3":{
         isFavourite3=val;
         break;
       }
       case "4":{
         isFavourite4=val;
         break;
       }
     }
     notifyListeners();
  }

  int isCompSelected = 0;

  compSelect(int val) {
    isCompSelected = val;
    notifyListeners();
  }

  int selectedIndexDashBoard = 0;
  int selectedIndexOrder = 1;
  int? selectCompetitionTypeIndex = 1;
  String? competitionTypeName = 'Type Of Competition';

  DateTime? compStartDate;
  DateTime? compEndDate;

  setStartDate(DateTime? date) {
    compStartDate = date;
    notifyListeners();
  }

  setEndDate(DateTime? date) {
    compEndDate = date;
    notifyListeners();
  }

  updatedSelectedIndexOrder(int index) {
    selectedIndexOrder = index;
   
  }

  updatedCompetitionTypeName(String? name) {
    competitionTypeName = name;
    notifyListeners();
  }

  updatedSelectedIndexDashBoard(int index) {
    selectedIndexDashBoard = index;
    notifyListeners();
  }

  updatedSelectedIndexCompetationType(int? index) {
    selectCompetitionTypeIndex = index;
    
  }

  updatedIsSignIn(bool signin) {
    isSignIn = signin;
    notifyListeners();
  }

  List<dynamic> categoryTypes=[];
  List<dynamic> subCategoryTypes=[];
  fetchCategoryData(String type){
    categoryTypes.clear();
    FirebaseFirestore.instance.collection("categories").doc(type).get().then((value){
      categoryTypes=value.data()!["category"];
      // print(value.data());
      print(categoryTypes);
      // fetchSubCategoryData(type,categoryTypes[0]);
    });
    notifyListeners();
  }

  fetchSubCategoryData(String? type,String? subType){
    subCategoryTypes.clear();
    FirebaseFirestore.instance.collection("categories").doc(type).get().then((value){
      subCategoryTypes=value.data()![categoryTypes[int.parse(subType!)]];
      print(subCategoryTypes);
    });
    notifyListeners();
  }
  


}

showErrorSnackBar(String message) {
  Get.snackbar("Error", message,
      colorText: Colors.white, backgroundColor: Colors.black);
}

showSuccessSnackBar(String message) {
  Get.snackbar("Done", message,
      colorText: Colors.white, backgroundColor: Colors.black);
}
