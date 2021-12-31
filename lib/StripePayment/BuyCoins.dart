// import 'package:cae/StripePayment/payment.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart' hide Trans;
// import 'package:provider/provider.dart';
//
// class BuyCoins extends StatefulWidget {
//   @override
//   _BuyCoinsState createState() => _BuyCoinsState();
// }
//
// class _BuyCoinsState extends State<BuyCoins> {
//   @override
//   // List<BuyCoin> data = getCoinData();
//
// // add you merchantId as per apple developer account      androidPayMode: 'test',     ),  );}
//
//   // final userData = Get.find<UserDataController>().userModel.value;
//
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Container(
//               width:MediaQuery.of(context).size.width*.8,
//               height:MediaQuery.of(context).size.height*.07,
//               child: MaterialButton(
//                 onPressed: ()=>Get.to(()=>Payment(finalAmount: 200)),//double.parse(userModal.orderModal.data!.totalPrice!)
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(30),
//                 ),
//                 color: Colors.red,
//                 child: Text(
//                   'MAKE PAYMENT',
//                   style: TextStyle(
//                     color: Colors.white,
//                     fontSize: 18,
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
//
// startPayment(String? price,String? coins) async {
//   print(price.toString());
//   print(coins.toString());
//   print("-------------");
//   double amount = double.parse(price!) * 100;
//   print(amount.toString());
//   String finalAmount = amount.toString();
//   int coin = double.parse(coins!).toInt();
//   print(finalAmount.toString());
//   print(coin.toString());
//
//   Get.to(() => Payment(
//         finalAmount: finalAmount,
//       ));
//   // Get.to(() => MakePayment());
// }
//
