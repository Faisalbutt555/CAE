import 'package:cae/Constants/Constants.dart';
import 'package:cae/Provider/AppConstants.dart';
import 'package:cae/Provider/auth_provider.dart';
import 'package:cae/StripePayment/Payment_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_credit_card/credit_card_widget.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:stripe_payment/stripe_payment.dart';
import 'package:progress_dialog/progress_dialog.dart';

class ExistingCardsPage extends StatefulWidget {
  ExistingCardsPage({Key? key}) : super(key: key);

  @override
  ExistingCardsPageState createState() => ExistingCardsPageState();
}

class ExistingCardsPageState extends State<ExistingCardsPage> {
  // List cards = [
  //   {
  //     'cardNumber': creditCardModelObj.cardNumber,
  //     'expiryDate': creditCardModelObj.cardExp,
  //     'cardHolderName': creditCardModelObj.cardName,
  //     'cvvCode': creditCardModelObj.cardCvc,
  //     'showBackView': false,
  //   }
  // ];

  payViaExistingCard(
      BuildContext context,
      String? price,
      String? cardNumber,
      String? expiryDate,
      String? cardHolderName,
      String? cvvCode,
      bool showBackView) async {
    var app = Provider.of<AppConstants>(context, listen: false);
    var auth = Provider.of<AuthProvider>(context, listen: false);
    ProgressDialog dialog = new ProgressDialog(context);
    dialog.style(message: 'Please wait...');
    await dialog.show();
    var expiryArr = expiryDate!.split('/');
    CreditCard stripeCard = CreditCard(
      number: cardNumber,
      expMonth: int.parse(expiryArr[0]),
      expYear: int.parse(expiryArr[1]),
    );
    var response = await StripeService.payViaExistingCard(
        amount: price, currency: 'USD', card: stripeCard);
    await dialog.hide();
    print(response.message);
    Scaffold.of(context).showSnackBar(SnackBar(
      content: Text(response.message),
      duration: new Duration(seconds: 2),
    ));
    if (response.success) {
      auth.saveCompetitionData(
          context,
          app.compNameController.text.toString(),
          //app.compTypeController.toString(),
          app.competitionTypeName,
          app.compCategoryController.text.toString(),
          app.compSubCategoryController.text.toString(),
          app.compMeasurementController.text.toString(),
          app.compGoalController.text.toString(),
          app.compCurrentStatusController.text.toString(),
          app.compStartDate,
          app.compEndDate,
          app.compPriceController.text.toString());

// userModal.getOrder(userModal.orderModal.data!.id);
      // CoinsDeduction().addCoins(widget.coins);
      // Future.delayed(Duration(seconds: 2),(){
      //   Get.back();
      // });
    }
  }

  delete() {}
  @override
  Widget build(BuildContext context) {
    return Consumer<AppConstants>(builder: (context, appCon, _) {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: Text('Choose existing card'),
        ),
        body: Container(
            padding: EdgeInsets.all(20),
            child: FutureBuilder<QuerySnapshot>(
              future: FirebaseFirestore.instance
                  .collection("credit_cards")
                  .where("user_id",
                      isEqualTo: FirebaseAuth.instance.currentUser!.uid)
                  .get(),
              builder: (context, snapshot) {
                // final List<DocumentSnapshot> documents = snapshot.data!.docs;
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (!snapshot.hasData) {
                  return Center(
                    child: Text(
                      "No Card Found",
                      style: TextStyle(color: Colors.black, fontSize: 22),
                    ),
                  );
                }
                return ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (BuildContext context, int index) {
                    // var card = cards[index];
                    return InkWell(
                        onTap: () {
                          payViaExistingCard(
                            context,
                            appCon.compPriceController.text.toString().trim(),
                            snapshot.data!.docs[index]["cardNumber"],
                            snapshot.data!.docs[index]["cardExp"],
                            snapshot.data!.docs[index]["cardName"],
                            snapshot.data!.docs[index]["cardCvc"],
                            false,
                          );
                        },
                        child: Slidable(
                          key: ValueKey(0),
                          dragStartBehavior: DragStartBehavior.down,
                          endActionPane: ActionPane(
                            motion: ScrollMotion(),
                            // dismissible: DismissiblePane(onDismissed:),
                            children: [
                              SlidableAction(
                                backgroundColor: Colors.black,
                                foregroundColor: Colors.white,
                                icon: Icons.save,
                                label: 'DELETE',
                                onPressed: (BuildContext context) {
                                  FirebaseFirestore.instance
                                      .collection("credit_cards")
                                      .doc(snapshot.data!.docs[index].id)
                                      .delete().then((value) {
                                        Get.back();
                                  });
                                },
                              ),
                            ],
                          ),
                          child: CreditCardWidget(
                            cardNumber: snapshot.data!.docs[index]
                                ["cardNumber"],
                            expiryDate: snapshot.data!.docs[index]["cardExp"],
                            cardHolderName: snapshot.data!.docs[index]
                                ["cardName"],
                            cvvCode: snapshot.data!.docs[index]["cardCvc"],
                            showBackView: false,
                            onCreditCardWidgetChange: (CreditCardBrand) {},
                          ),
                        ));
                  },
                );
              },
            )),
      );
    });
  }
}
