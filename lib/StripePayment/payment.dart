import 'package:cae/Provider/AppConstants.dart';
import 'package:cae/Provider/auth_provider.dart';
import 'package:cae/Screens/HomeScreen.dart';
import 'package:cae/Screens/congrats_screen.dart';
import 'package:cae/StripePayment/Payment_service.dart';
import 'package:cae/StripePayment/enter_credit_card_details.dart';
import 'package:cae/StripePayment/existing_card_page.dart';
import 'package:flutter/material.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class Payment extends StatefulWidget {
  final String? finalAmount;
  const Payment({Key? key,this.finalAmount}) : super(key: key);

  @override
  PaymentState createState() => PaymentState();
}

class PaymentState extends State<Payment> {
  onItemPress(BuildContext context, int index) async {
    switch (index) {
      case 0:
        payViaNewCard(context);
        break;
      case 1:
        Get.to(ExistingCardsPage());
        break;
      case 2:
        Get.to(EnterCreditCradScreen());
        break;
    }
  }

  payViaNewCard(BuildContext context) async {
    var app = Provider.of<AppConstants>(context, listen: false);
    var auth = Provider.of<AuthProvider>(context, listen: false);
    // print(widget.finalAmount);
    final ProgressDialog dialog = ProgressDialog(context);
    dialog.style(message: 'Please wait...');
    await dialog.show();
    var response = await StripeService.payWithNewCard(
            amount: widget.finalAmount!, currency: 'USD');
    await dialog.hide();
    Scaffold.of(context).showSnackBar(SnackBar(
      content: Text(response.message),
      duration: new Duration(seconds: 3),
    ));
    print(response.message);
    print(response.success);
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

  @override
  void initState() {
    super.initState();
    StripeService.init();
  }

  Icon? icon;
  Text? text;
  @override
  Widget build(BuildContext context) {
    print(widget.finalAmount);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        title: Text(
          'Payment',
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        child: ListView.separated(
            itemBuilder: (context, index) {
              // Icon? icon;
              // Text? text;
              switch (index) {
                case 0:
                  icon = Icon(Icons.add_circle, color: Colors.black);
                  text = Text(
                    'Direct Pay with new card',
                    style: TextStyle(color: Colors.black),
                  );
                  break;
                case 1:
                  icon = Icon(Icons.credit_card, color: Colors.black);
                  text = Text(
                    'Pay via existing card',
                    style: TextStyle(color: Colors.black),
                  );
                  break;
                case 2:
                  icon = Icon(Icons.credit_card, color: Colors.black);
                  text = Text(
                    'Add New Card',
                    style: TextStyle(color: Colors.black),
                  );
                  break;
              }
              return InkWell(
                onTap: () {
                  onItemPress(context, index);
                },
                child: ListTile(
                  title: text,
                  leading: icon,
                ),
              );
            },
            separatorBuilder: (context, index) => Divider(
                  color: Colors.grey,
                ),
            itemCount: 3),
      ),
    );
  }
}
