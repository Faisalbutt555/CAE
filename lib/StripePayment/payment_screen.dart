// import 'package:cae/Constants/Constants.dart';
// import 'package:cae/Constants/Styles.dart';
// import 'package:cae/Provider/AppConstants.dart';
// import 'package:cae/Provider/auth_provider.dart';
// import 'package:cae/Screens/compare_at.dart';
// import 'package:cae/StripePayment/BuyCoins.dart';
// import 'package:cae/StripePayment/payment.dart';
// import 'package:cae/Widgets/CAECircularButton.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:provider/provider.dart';
//
// class PaymentScreen extends StatefulWidget {
//   const PaymentScreen({Key? key}) : super(key: key);
//
//   @override
//   _PaymentScreenState createState() => _PaymentScreenState();
// }
//
// class _PaymentScreenState extends State<PaymentScreen> {
//   bool? shippingIsSelected = true;
//   bool? paymentIsSelected = true;
//   @override
//   Widget build(BuildContext context) {
//     var width = MediaQuery.of(context).size.width;
//     var height = MediaQuery.of(context).size.height;
//     return Consumer<AppConstants>(builder: (context,appPro,_){
//       return Consumer<AuthProvider>(builder: (context,authPro,_){
//         return Scaffold(
//           body: Container(
//             color: black,
//             width: width,
//             height: height,
//             child: Column(
//               children: [
//                 CustomSizedBox(height: height),
//                 Container(
//                   decoration: BoxDecoration(
//                       color: payScreenUperColor,
//                       borderRadius: BorderRadius.only(
//                           bottomLeft: Radius.circular(width * 0.1),
//                           bottomRight: Radius.circular(width * 0.1))),
//                   child: Padding(
//                     padding: EdgeInsets.all(width * 0.1),
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         // IconButton(
//                         //   icon:
//                         InkWell(
//                             onTap: () {
//                               Navigator.pop(context);
//                             },
//                             child: Icon(
//                               Icons.arrow_back_ios,
//                               color: white,
//                             )),
//                         // onPressed: (){}),
//                         Text(
//                           'Summary',
//                           style: textStyleHeading1(width, whiteColor: 1),
//                         ),
//                         SizedBox(
//                           width: width * 0.003,
//                         )
//                       ],
//                     ),
//                   ),
//                 ),
//                 CustomSizedBox(height: height),
//                 Expanded(
//                   child: Padding(
//                     padding: const EdgeInsets.all(8.0),
//                     child: SingleChildScrollView(
//                       physics: const BouncingScrollPhysics(),
//                       child: Column(
//                         children: [
//                           // Container(
//                           //   decoration: BoxDecoration(
//                           //       color: payScreenUperColor,
//                           //       borderRadius: BorderRadius.circular(width * 0.1)),
//                           //   child: Padding(
//                           //     padding: EdgeInsets.symmetric(horizontal: width*0.08, vertical: 10),
//                           //     child: Row(
//                           //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           //       children: [
//                           //         Column(
//                           //           mainAxisAlignment: MainAxisAlignment.center,
//                           //           crossAxisAlignment: CrossAxisAlignment.start,
//                           //           children: [
//                           //             Text(
//                           //               'Shipping Address',
//                           //               style: textStyleHeading1(width * 0.77,
//                           //                   whiteColor: 1),
//                           //             ),
//                           //             CustomSizedBox(height: height * 0.8),
//                           //             Text(
//                           //               'Jose Ortiz',
//                           //               style: textStyleHeading2(width * 0.8,
//                           //                   whiteColor: 1),
//                           //             ),
//                           //             CustomSizedBox(height: height * 0.8),
//                           //             Text(
//                           //               'BIll Me Later',
//                           //               style: textStyleHeading2(width * 0.8,
//                           //                   whiteColor: 1),
//                           //             ),
//                           //             CustomSizedBox(height: height * 0.8),
//                           //             Text(
//                           //               'Add ACH Option',
//                           //               style: textStyleHeading2(width * 0.8,
//                           //                   whiteColor: 1),
//                           //             ),
//                           //             TextButton(
//                           //               child: Text(
//                           //                 'Change',
//                           //                 style: textStyleHeading2(width * 0.8,
//                           //                     whiteColor: 5),
//                           //               ),
//                           //               onPressed: () {},
//                           //             )
//                           //           ],
//                           //         ),
//                           //         Theme(
//                           //           data: ThemeData(
//                           //               unselectedWidgetColor: white,
//                           //             ),
//                           //           child: Checkbox(
//                           //             checkColor: Colors.white,
//                           //             activeColor: primaryColor,
//                           //             // fillColor: MaterialStateProperty.resolveWith(Colors.w),
//                           //             value: shippingIsSelected,
//                           //             shape: const CircleBorder(),
//                           //             onChanged: (bool? value) {
//                           //               setState(() {
//                           //                 shippingIsSelected = value!;
//                           //               });
//                           //             },
//                           //           ),
//                           //         )
//                           //       ],
//                           //     ),
//                           //   ),
//                           // ),
//                           CustomSizedBox(height: height),
//                           Container(
//                             decoration: BoxDecoration(
//                                 color: payScreenUperColor,
//                                 borderRadius: BorderRadius.circular(width * 0.1)),
//                             child: Padding(
//                               padding: EdgeInsets.symmetric(
//                                   horizontal: width * 0.08, vertical: 10),
//                               child:creditCardModelObj.cardNumber!=null? Row(
//                                 children: [
//                                   Expanded(
//                                     flex: 8,
//                                     child: Column(
//                                       crossAxisAlignment: CrossAxisAlignment.start,
//                                       children: [
//                                         Text(
//                                           'Payment',
//                                           style: textStyleHeading1(width * 0.77,
//                                               whiteColor: 1),
//                                         ),
//                                         CustomSizedBox(height: height),
//                                         ListTile(
//                                           leading: Image.asset(
//                                               imageBaseAddress + 'master_card.png'),
//                                           title: Text(
//                                             'Master Card',
//                                             style: textStyleHeading2(width * 0.7,
//                                                 whiteColor: 1),
//                                           ),
//                                           subtitle: Text(
//                                             '****  ****  ****  4543',
//                                             style: textStyleHeading2(width * 0.7,
//                                                 whiteColor: 1),
//                                           ),
//                                         ),
//                                         TextButton(
//                                           child: Text(
//                                             'Change',
//                                             style: textStyleHeading2(width * 0.8,
//                                                 whiteColor: 5),
//                                           ),
//                                           onPressed: () {},
//                                         )
//                                       ],
//                                     ),
//                                   ),
//                                   Expanded(
//                                     flex: 2,
//                                     child: Theme(
//                                       data: ThemeData(
//                                         unselectedWidgetColor: white,
//                                       ),
//                                       child: Checkbox(
//                                         checkColor: Colors.white,
//                                         activeColor: primaryColor,
//                                         // fillColor: MaterialStateProperty.resolveWith(Colors.w),
//                                         value: paymentIsSelected,
//                                         shape: const CircleBorder(),
//                                         onChanged: (bool? value) {
//                                           setState(() {
//                                             paymentIsSelected = value!;
//                                           });
//                                           // authPro.getCardDetail();
//                                         },
//                                       ),
//                                     ),
//                                   )
//                                 ],
//                               ):SizedBox(
//                                 child: Center(child: Text("+ ADD Card",style: TextStyle(fontSize: 22,color: Colors.white),),),
//                               )
//                             ),
//                           )
//                         ],
//                       ),
//                     ),
//                   ),
//                 ),
//                 Container(
//                   color: payScreenUperColor,
//                   child: Padding(
//                     padding: EdgeInsets.all(width * 0.05),
//                     child: Row(
//                       children: [
//                         Expanded(
//                           child: Padding(
//                             padding: const EdgeInsets.only(right: 4.0),
//                             child: CAECircularButton(
//                                 width: width,
//                                 textColor: 1,
//                                 title: 'Back',
//                                 backGroundColor: transparentColor,
//                                 onPressed: () {
//                                   Get.back();
//                                 }),
//                           ),
//                         ),
//                         Expanded(
//                           child: CAECircularButton(
//                               width: width,
//                               textColor: 1,
//                               title: 'Pay',
//                               backGroundColor: primaryColor,
//                               onPressed: () {
//                                 Get.to(Payment(finalAmount: ));
//                               }),
//                         ),
//                       ],
//                     ),
//                   ),
//                 )
//               ],
//             ),
//           ),
//         );
//       });
//     });
//   }
// }
