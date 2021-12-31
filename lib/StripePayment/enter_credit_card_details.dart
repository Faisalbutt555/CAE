import 'package:cae/Constants/Constants.dart';
import 'package:cae/Provider/AppConstants.dart';
import 'package:cae/Provider/auth_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_credit_card/credit_card_form.dart';
import 'package:flutter_credit_card/credit_card_model.dart';
import 'package:flutter_credit_card/flutter_credit_card.dart';
import 'package:get/get.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:provider/provider.dart';

class EnterCreditCradScreen extends StatefulWidget {
  static String id = 'driver_new_card';
  @override
  _EnterCreditCradScreenState createState() => _EnterCreditCradScreenState();
}

class _EnterCreditCradScreenState extends State<EnterCreditCradScreen> {
  String cardNumber = '';
  String expiryDate = '';
  String cardHolderName = '';
  String cvvCode = '';
  bool isCvvFocused = false;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Consumer<AppConstants>(builder: (context, appPro, _) {
      return Consumer<AuthProvider>(builder: (context, authPro, _) {
        return ModalProgressHUD(
          progressIndicator: loader(),
          dismissible: false,
          inAsyncCall: authPro.loading,
          child: Scaffold(
            appBar: AppBar(
              title: Text("Driver Card"),
              centerTitle: true,
              backgroundColor: Colors.black,
            ),
            resizeToAvoidBottomInset: true,
            body: SafeArea(
              child: Column(
                children: <Widget>[
                  CreditCardWidget(
                    cardNumber: cardNumber,
                    expiryDate: expiryDate,
                    cardHolderName: cardHolderName,
                    cvvCode: cvvCode,
                    showBackView: isCvvFocused,
                    obscureCardNumber: true,
                    obscureCardCvv: true,
                    onCreditCardWidgetChange: (CreditCardBrand) {},
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        children: <Widget>[
                          CreditCardForm(
                            formKey: formKey,
                            obscureCvv: true,
                            obscureNumber: false,
                            cardNumber: cardNumber,
                            cvvCode: cvvCode,
                            cardHolderName: cardHolderName,
                            expiryDate: expiryDate,
                            themeColor: Colors.blue,
                            cardNumberDecoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Credit Card Number',
                              hintText: 'XXXX XXXX XXXX XXXX',
                            ),
                            expiryDateDecoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Expired Date',
                              hintText: 'XX/XX',
                            ),
                            cvvCodeDecoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'CVV',
                              hintText: 'XXX',
                            ),
                            cardHolderDecoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Card Holder',
                            ),
                            onCreditCardModelChange: onCreditCardModelChange,
                          ),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                              primary: const Color(0xff32CD32),
                            ),
                            child: Container(
                              margin: const EdgeInsets.all(8),
                              child: const Text(
                                '+ ADD',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: 'halter',
                                  fontSize: 14,
                                  package: 'flutter_credit_card',
                                ),
                              ),
                            ),
                            onPressed: () {
                              if (formKey.currentState!.validate()) {
                                authPro.saveCardDetail(
                                  context: context,
                                  cardCVC: cvvCode,
                                  cardExpiry: expiryDate,
                                  cardName: cardHolderName,
                                  cardNumber: cardNumber,
                                );

                                // FirebaseFirestore.instance
                                //     .collection("credit_cards")
                                //     .where("user_id",
                                //         isEqualTo: FirebaseAuth
                                //             .instance.currentUser!.uid)
                                //     .get()
                                //     .then((value) {
                                //   if (value.docs.length == 0) {
                                //     authPro.saveCardDetail(
                                //       context: context,
                                //       cardCVC: cvvCode,
                                //       cardExpiry: expiryDate,
                                //       cardName: cardHolderName,
                                //       cardNumber: cardNumber,
                                //     );
                                //   } else {
                                //     showErrorSnackBar(
                                //         "You Already added a card delete it to add new one");
                                //   }
                                // });
                                //enter backend
                              }
                            },
                          ),
                          // ElevatedButton(
                          //   style: ElevatedButton.styleFrom(
                          //     shape: RoundedRectangleBorder(
                          //       borderRadius: BorderRadius.circular(8.0),
                          //     ),
                          //     primary: const Color(0xffFF0000),
                          //   ),
                          //   child: Container(
                          //     margin: const EdgeInsets.all(8),
                          //     child: const Text(
                          //       '- DELETE',
                          //       style: TextStyle(
                          //         color: Colors.white,
                          //         fontFamily: 'halter',
                          //         fontSize: 14,
                          //       ),
                          //     ),
                          //   ),
                          //   onPressed: () {
                          //     Get.defaultDialog(
                          //       buttonColor: Colors.white,
                          //       content: const Text("Are you sure?"),
                          //       barrierDismissible: false,
                          //       backgroundColor: Colors.white,
                          //       title: "DELETE CARD",
                          //       confirmTextColor: Colors.green,
                          //       textConfirm: "YES",
                          //       onConfirm: () {
                          //         authPro.startLoading();
                          //         //delete card
                          //         FirebaseFirestore.instance
                          //             .collection("credit_cards")
                          //             .where("user_id",
                          //                 isEqualTo: FirebaseAuth
                          //                     .instance.currentUser!.uid)
                          //             .get()
                          //             .then((value) {
                          //           if (value.docs.length == 0) {
                          //             authPro.stopLoading();
                          //             showErrorSnackBar("You don't have any card add it first");
                          //           }
                          //           else{
                          //             FirebaseFirestore.instance.collection("credit_cards").doc(value.docs[0].id).delete().then((value){
                          //               authPro.stopLoading();
                          //               Navigator.pop(context);
                          //             });
                          //           }
                          //         });
                          //       },
                          //       cancelTextColor: Colors.red,
                          //       textCancel: "NO",
                          //       onCancel: () {
                          //         Navigator.pop(context);
                          //       },
                          //     );
                          //   },
                          // )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      });
    });
  }

  void onCreditCardModelChange(CreditCardModel? creditCardModel) {
    setState(() {
      cardNumber = creditCardModel!.cardNumber;
      expiryDate = creditCardModel.expiryDate;
      cardHolderName = creditCardModel.cardHolderName;
      cvvCode = creditCardModel.cvvCode;
      isCvvFocused = creditCardModel.isCvvFocused;
    });
  }
}
