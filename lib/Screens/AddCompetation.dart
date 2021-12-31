// import 'package:cae/Constants/Constants.dart';
// import 'package:cae/Constants/Styles.dart';
// import 'package:cae/Models/CompetationTypesModel.dart';
// import 'package:cae/Provider/AppConstants.dart';
// import 'package:cae/Provider/auth_provider.dart';
// import 'package:cae/Screens/payment_screen.dart';
// import 'package:cae/Widgets/CAEButton.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'package:get/get.dart';
// import 'package:provider/provider.dart';
//
// class AddCompetator extends StatefulWidget {
//   const AddCompetator({Key? key}) : super(key: key);
//
//   @override
//   _AddCompetatorState createState() => _AddCompetatorState();
// }
//
// class _AddCompetatorState extends State<AddCompetator> {
//   void _showPicker(BuildContext ctx, double width, double height) {
//     var appPro = Provider.of<AppConstants>(context, listen: false);
//     showCupertinoModalPopup(
//         context: ctx,
//         barrierDismissible: true,
//         semanticsDismissible: false,
//         builder: (_) => CupertinoActionSheet(
//               actions: [
//                 SizedBox(
//                   width: width,
//                   height: height,
//                   child: CupertinoPicker(
//                     backgroundColor: Colors.white,
//                     itemExtent: 60,
//                     scrollController:
//                         FixedExtentScrollController(initialItem: 1),
//                     children: dashBoardList
//                         .map((e) => Center(child: Text('${e.subtile}')))
//                         .toList(),
//                     onSelectedItemChanged: (value) {
//                       appPro.compCategory.text = dashBoardList[value].subtile!;
//                       // setState(() {
//                       //   _selectedValue = value;
//                       // });
//                     },
//                   ),
//                 ),
//               ],
//               cancelButton: Row(
//                 children: [
//                   Expanded(
//                     child: Padding(
//                         padding: const EdgeInsets.all(4.0),
//                         child: CAEButton(
//                           onPressed: () {
//                             appPro.compCategory.clear();
//                             Navigator.pop(ctx);
//                           },
//                           backGroundColor: black,
//                           height: height * 0.15,
//                           textColor: 1,
//                           width: width,
//                           title: 'Cancle',
//                         )),
//                   ),
//                   Expanded(
//                     child: Padding(
//                         padding: const EdgeInsets.all(4.0),
//                         child: CAEButton(
//                           onPressed: () {
//                             Navigator.pop(ctx);
//                           },
//                           backGroundColor: primaryColor,
//                           height: height * 0.15,
//                           textColor: 1,
//                           width: width,
//                           title: 'Ok',
//                         )),
//                   ),
//                 ],
//               ),
//             ));
//   }
//   List<CompetationTypeModel> dashBoardList = [];
//   @override
//   void initState() {
//     CompetationTypeModel firstItem = CompetationTypeModel(
//         index: 0,
//         icon: FontAwesomeIcons.weightHanging,
//         subtile: 'Cricket',
//         title: '');
//     CompetationTypeModel secondItem = CompetationTypeModel(
//         index: 1,
//         icon: FontAwesomeIcons.university,
//         subtile: 'Base Ball',
//         title: '');
//     CompetationTypeModel thirdItem = CompetationTypeModel(
//         index: 2, icon: Icons.school, subtile: 'Hockey', title: '');
//     CompetationTypeModel fourthItem = CompetationTypeModel(
//         index: 3,
//         icon: FontAwesomeIcons.certificate,
//         subtile: 'Snooker',
//         title: '');
//     CompetationTypeModel fifthItem = CompetationTypeModel(
//         index: 4,
//         icon: Icons.sports_baseball,
//         subtile: 'Chess',
//         title: 'Total');
//     dashBoardList.add(firstItem);
//     dashBoardList.add(secondItem);
//     dashBoardList.add(thirdItem);
//     dashBoardList.add(fourthItem);
//     dashBoardList.add(fifthItem);
//     setState(() {});
//     super.initState();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     // var appConstants = Provider.of<AppConstants>(context, listen: true);
//     var width = MediaQuery.of(context).size.width;
//     var height = MediaQuery.of(context).size.height;
//     return Consumer<AuthProvider>(builder: (context, auth, _) {
//       return Consumer<AppConstants>(builder: (context, app, _) {
//         return Scaffold(
//           body: SafeArea(
//             child: Center(
//               child: AnimatedContainer(
//                 duration: const Duration(milliseconds: 700),
//                 color: white,
//                 child: SingleChildScrollView(
//                   child: Padding(
//                       padding: const EdgeInsets.symmetric(
//                           horizontal: 12.0, vertical: 8),
//                       child: Form(
//                         key: app.addCompFormKey,
//                         child: Column(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children: [
//                             TextFormField(
//                               validator: (String? value) {
//                                 if (value!.isEmpty || value == "") {
//                                   return "Field is necessary";
//                                 } else {
//                                   return null;
//                                 }
//                               },
//                               style: textStyleHeading2(width * 0.97,
//                                   whiteColor: 0),
//                               controller: app.compName,
//                               obscureText: false,
//                               keyboardType: TextInputType.text,
//                               // readOnly: true,
//                               enabled: true,
//                               onTap: () {
//                                 // _showPicker(context, width, height*0.4);
//                               },
//                               maxLines: 1,
//                               decoration: InputDecoration(
//                                 filled: false,
//                                 fillColor: black.withOpacity(0.1),
//                                 // contentPadding: const EdgeInsets.all(4),
//                                 prefixIcon: Icon(
//                                   Icons.person_outline_outlined,
//                                   color: black,
//                                 ),
//                                 //isDense: true,
//                                 labelStyle: textStyleHeading2(width * 0.97,
//                                     whiteColor: 0),
//                                 enabledBorder: UnderlineInputBorder(
//                                   borderSide: BorderSide(color: black),
//                                 ),
//                                 focusedBorder: UnderlineInputBorder(
//                                   borderSide: BorderSide(color: black),
//                                 ),
//                                 hintText: "Name Of Competition",
//                                 hintTextDirection: TextDirection.ltr,
//                                 hintStyle: textStyleHeading2(width * 0.97,
//                                     whiteColor: 0),
//                                 // errorText: snapshot.error,
//                               ),
//                             ),
//                             ListTile(
//                               onTap: () {},
//                               leading: Icon(
//                                 FontAwesomeIcons.trophy,
//                                 color: black,
//                               ),
//                               title: Text('${app.competitionTypeName}'),
//                             ),
//                             Container(
//                               color: black,
//                               width: width,
//                               height: 1,
//                             ),
//                             // Divider(
//                             //   color: black,
//                             //   thickness: 0.93,
//                             //   ),
//                             TextFormField(
//                               validator: (String? value) {
//                                 if (value!.isEmpty || value == "") {
//                                   return "Field is necessary";
//                                 } else {
//                                   return null;
//                                 }
//                               },
//                               style: textStyleHeading2(width * 0.97,
//                                   whiteColor: 0),
//                               controller: app.compCategory,
//                               obscureText: false,
//                               keyboardType: TextInputType.text,
//                               readOnly: true,
//                               enabled: true,
//                               onTap: () {
//                                 _showPicker(context, width, height * 0.4);
//                               },
//                               maxLines: 1,
//                               decoration: InputDecoration(
//                                 filled: false,
//                                 fillColor: black.withOpacity(0.1),
//                                 // contentPadding: const EdgeInsets.all(4),
//                                 prefixIcon: Icon(
//                                   Icons.category_outlined,
//                                   color: black,
//                                 ),
//                                 //isDense: true,
//                                 labelStyle: textStyleHeading2(width * 0.97,
//                                     whiteColor: 0),
//                                 enabledBorder: UnderlineInputBorder(
//                                   borderSide: BorderSide(color: black),
//                                 ),
//                                 focusedBorder: UnderlineInputBorder(
//                                   borderSide: BorderSide(color: black),
//                                 ),
//                                 hintText: "Competition Category",
//                                 hintTextDirection: TextDirection.ltr,
//                                 hintStyle: textStyleHeading2(width * 0.97,
//                                     whiteColor: 0),
//                                 // errorText: snapshot.error,
//                               ),
//                             ),
//                             Padding(
//                               padding: EdgeInsets.all(height * 0.02),
//                               child: Row(
//                                 children: [
//                                   Expanded(
//                                     child: CAEButton(
//                                       onPressed: () async {
//                                         final DateTime? picked =
//                                             await showDatePicker(
//                                                 context: context,
//                                                 initialDate: DateTime.now(),
//                                                 initialDatePickerMode:
//                                                     DatePickerMode.day,
//                                                 firstDate: DateTime(2015),
//                                                 lastDate: DateTime(2101));
//                                         if (picked != null) {
//                                           print('picked $picked');
//                                           app.setStartDate(picked);
//                                         }
//                                         // setState(() {
//                                         //   selectedDate = picked;
//                                         //   _dateController.text = DateFormat.yMd().format(selectedDate);
//                                         // });
//                                       },
//                                       backGroundColor: black,
//                                       height: height * 0.068,
//                                       textColor: 1,
//                                       width: width,
//                                       title: 'Start Date',
//                                     ),
//                                   ),
//                                   SizedBox(width: width * 0.05),
//                                   Expanded(
//                                     child: CAEButton(
//                                       onPressed: () async {
//                                         final DateTime? picked =
//                                             await showDatePicker(
//                                                 context: context,
//                                                 initialDate: DateTime.now(),
//                                                 initialDatePickerMode:
//                                                     DatePickerMode.day,
//                                                 firstDate: DateTime(2015),
//                                                 lastDate: DateTime(2101));
//                                         if (picked != null) {
//                                           print('picked $picked');
//                                           app.setEndDate(picked);
//                                         }
//                                       },
//                                       backGroundColor: primaryColor,
//                                       height: height * 0.068,
//                                       textColor: 1,
//                                       width: width,
//                                       title: 'End Date',
//                                     ),
//                                   )
//                                 ],
//                               ),
//                             ),
//                             TextFormField(
//                               validator: (String? value) {
//                                 if (value!.isEmpty || value == "") {
//                                   return "Field is necessary";
//                                 } else {
//                                   return null;
//                                 }
//                               },
//                               style: textStyleHeading2(width * 0.97,
//                                   whiteColor: 0),
//                               controller: app.compStatus,
//                               obscureText: false,
//                               keyboardType: TextInputType.text,
//                               enabled: true,
//                               onTap: () {},
//                               maxLines: 1,
//                               decoration: InputDecoration(
//                                 filled: false,
//                                 fillColor: black.withOpacity(0.1),
//                                 contentPadding: const EdgeInsets.all(4),
//                                 labelText: "Current Status",
//                                 prefixIcon: Icon(
//                                   Icons.transfer_within_a_station_rounded,
//                                   color: black,
//                                 ),
//                                 //isDense: true,
//                                 labelStyle: textStyleHeading2(width * 0.97,
//                                     whiteColor: 0),
//                                 enabledBorder: UnderlineInputBorder(
//                                   borderSide: BorderSide(color: black),
//                                 ),
//                                 focusedBorder: UnderlineInputBorder(
//                                   borderSide: BorderSide(color: black),
//                                 ),
//                                 hintText: "DONE",
//                                 hintStyle: textStyleHeading2(width * 0.97,
//                                     whiteColor: 1),
//                                 // errorText: snapshot.error,
//                               ),
//                             ),
//                             TextFormField(
//                               validator: (String? value) {
//                                 if (value!.isEmpty || value == "") {
//                                   return "Field is necessary";
//                                 } else {
//                                   return null;
//                                 }
//                               },
//                               style: textStyleHeading2(width * 0.97,
//                                   whiteColor: 0),
//                               controller: app.compGoal,
//                               obscureText: false,
//                               keyboardType: TextInputType.text,
//                               enabled: true,
//                               onTap: () {},
//                               maxLines: 1,
//                               decoration: InputDecoration(
//                                 filled: false,
//                                 fillColor: black.withOpacity(0.1),
//                                 contentPadding: const EdgeInsets.all(4),
//                                 labelText: "Goal",
//                                 prefixIcon: Icon(
//                                   Icons.g_mobiledata_sharp,
//                                   color: black,
//                                 ),
//                                 //isDense: true,
//                                 labelStyle: textStyleHeading2(width * 0.97,
//                                     whiteColor: 0),
//                                 enabledBorder: UnderlineInputBorder(
//                                   borderSide: BorderSide(color: black),
//                                 ),
//                                 focusedBorder: UnderlineInputBorder(
//                                   borderSide: BorderSide(color: black),
//                                 ),
//                                 hintText: "My gole is",
//                                 hintStyle: textStyleHeading2(width * 0.97,
//                                     whiteColor: 1),
//                                 // errorText: snapshot.error,
//                               ),
//                             ),
//                             TextFormField(
//                               validator: (String? value) {
//                                 if (value!.isEmpty || value == "") {
//                                   return "Field is necessary";
//                                 } else {
//                                   return null;
//                                 }
//                               },
//                               style: textStyleHeading2(width * 0.97,
//                                   whiteColor: 0),
//                               controller: app.compAmount,
//                               obscureText: false,
//                               keyboardType: TextInputType.text,
//                               enabled: true,
//                               onTap: () {},
//                               maxLines: 1,
//                               decoration: InputDecoration(
//                                 filled: false,
//                                 fillColor: black.withOpacity(0.1),
//                                 contentPadding: const EdgeInsets.all(4),
//                                 labelText: "Amount On Line",
//                                 prefixIcon: Icon(
//                                   Icons.local_atm_outlined,
//                                   color: black,
//                                 ),
//                                 //isDense: true,
//                                 labelStyle: textStyleHeading2(width * 0.97,
//                                     whiteColor: 0),
//                                 enabledBorder: UnderlineInputBorder(
//                                   borderSide: BorderSide(color: black),
//                                 ),
//                                 focusedBorder: UnderlineInputBorder(
//                                   borderSide: BorderSide(color: black),
//                                 ),
//                                 hintText: "My gole is",
//                                 hintStyle: textStyleHeading2(width * 0.97,
//                                     whiteColor: 1),
//                                 // errorText: snapshot.error,
//                               ),
//                             ),
//                             SizedBox(
//                               height: height * 0.02,
//                             ),
//                             CAEButton(
//                               onPressed: () {
//                                 if (app.addCompFormKey.currentState!
//                                     .validate()) {
//                                   if (app.compStartDate == null ||
//                                       app.compEndDate == null) {
//                                     showErrorSnackBar(
//                                         "Start Date & End Date is Necessary");
//                                   } else {
//                                     Get.to(PaymentScreen());
//                                   }
//                                 }
//                                 // Navigator.push(context, MaterialPageRoute(builder: (context)=>const HomeScreen()));
//                               },
//                               backGroundColor: primaryColor,
//                               height: height * 0.068,
//                               textColor: 1,
//                               width: width,
//                               title: 'Pay',
//                             ),
//                           ],
//                         ),
//                       )),
//                 ),
//               ),
//             ),
//           ),
//         );
//       });
//     });
//   }
// }
