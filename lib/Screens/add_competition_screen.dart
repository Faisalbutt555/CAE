import 'package:cae/Provider/AppConstants.dart';
import 'package:cae/Provider/auth_provider.dart';
import 'package:cae/StripePayment/payment.dart';
import 'package:cae/StripePayment/payment_screen.dart';
import 'package:cae/Widgets/text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:cae/Constants/Constants.dart';
import 'package:cae/Models/CompetationTypesModel.dart';
import 'package:cae/Widgets/CAEButton.dart';
import 'package:flutter/cupertino.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AddCompetitionScreen extends StatefulWidget {
  const AddCompetitionScreen({Key? key, this.type}) : super(key: key);
  final String? type;

  @override
  _AddCompetitionScreenState createState() => _AddCompetitionScreenState();
}

class _AddCompetitionScreenState extends State<AddCompetitionScreen> {
  void _showCategoryPicker(BuildContext ctx, double width, double height) {
    var appPro = Provider.of<AppConstants>(context, listen: false);
    showCupertinoModalPopup(
        context: ctx,
        barrierDismissible: false,
        semanticsDismissible: false,
        builder: (_) => CupertinoActionSheet(
              actions: [
                SizedBox(
                  width: width,
                  height: height,
                  child: CupertinoPicker(
                    backgroundColor: Colors.white,
                    itemExtent: 60,
                    scrollController:
                        FixedExtentScrollController(initialItem: 1),
                    children: appPro.categoryTypes
                        .map((e) => Center(child: Text('$e')))
                        .toList(),
                    onSelectedItemChanged: (value) {
                      appPro.compCategoryController.text =appPro.categoryTypes[int.parse(value.toString())];
                      print("--------------------------");
                      print(value.toString());
                      print("--------------------------");
                      appPro.fetchSubCategoryData(widget.type, value.toString());
                      // setState(() {
                      //   _selectedValue = value;
                      // });
                    },
                  ),
                ),
              ],
              cancelButton: Row(
                children: [
                  Expanded(
                    child: Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: CAEButton(
                          onPressed: () {
                            appPro.compCategoryController.clear();
                            appPro.compSubCategoryController.clear();
                            Navigator.pop(ctx);
                          },
                          backGroundColor: black,
                          height: height * 0.15,
                          textColor: 1,
                          width: width,
                          title: 'Cancle',
                        )),
                  ),
                  Expanded(
                    child: Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: CAEButton(
                          onPressed: () {
                            Navigator.pop(ctx);
                          },
                          backGroundColor: primaryColor,
                          height: height * 0.15,
                          textColor: 1,
                          width: width,
                          title: 'Ok',
                        )),
                  ),
                ],
              ),
            ));
  }


  void _showSubCategoryPicker(BuildContext ctx, double width, double height) {
    var appPro = Provider.of<AppConstants>(context, listen: false);
    showCupertinoModalPopup(
        context: ctx,
        barrierDismissible: true,
        semanticsDismissible: false,
        builder: (_) => CupertinoActionSheet(
          actions: [
            SizedBox(
              width: width,
              height: height,
              child: CupertinoPicker(
                backgroundColor: Colors.white,
                itemExtent: 60,
                scrollController:
                FixedExtentScrollController(initialItem: 1),
                children: appPro.subCategoryTypes
                    .map((e) => Center(child: Text('$e')))
                    .toList(),
                onSelectedItemChanged: (value) {
                  appPro.compSubCategoryController.text =appPro.subCategoryTypes[int.parse(value.toString())];
                  // setState(() {
                  //   _selectedValue = value;
                  // });
                },
              ),
            ),
          ],
          cancelButton: Row(
            children: [
              Expanded(
                child: Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: CAEButton(
                      onPressed: () {
                        appPro.compCategoryController.clear();
                        Navigator.pop(ctx);
                      },
                      backGroundColor: black,
                      height: height * 0.15,
                      textColor: 1,
                      width: width,
                      title: 'Cancle',
                    )),
              ),
              Expanded(
                child: Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: CAEButton(
                      onPressed: () {
                        Navigator.pop(ctx);
                      },
                      backGroundColor: primaryColor,
                      height: height * 0.15,
                      textColor: 1,
                      width: width,
                      title: 'Ok',
                    )),
              ),
            ],
          ),
        ));
  }

  List<CompetationTypeModel> dashBoardList = [];

  chkType(String? type) {
    var appPro = Provider.of<AppConstants>(context, listen: false);
    switch (type!.toLowerCase()) {
      case "sports":
        {
          appPro.fetchCategoryData("sports");
          break;
        }
      case "health":
        {
          appPro.fetchCategoryData("Health");
          break;
        }
      case "finance":
        {
          appPro.fetchCategoryData("finance");
          break;
        }
      case "education":
        {
          appPro.fetchCategoryData("education");
          break;
        }
    }
  }

  @override
  void initState() {
    chkType(widget.type);
    // CompetationTypeModel firstItem = CompetationTypeModel(
    //     index: 0,
    //     icon: FontAwesomeIcons.weightHanging,
    //     subtile: 'Cricket',
    //     title: '');
    // CompetationTypeModel secondItem = CompetationTypeModel(
    //     index: 1,
    //     icon: FontAwesomeIcons.university,
    //     subtile: 'Base Ball',
    //     title: '');
    // CompetationTypeModel thirdItem = CompetationTypeModel(
    //     index: 2, icon: Icons.school, subtile: 'Hockey', title: '');
    // CompetationTypeModel fourthItem = CompetationTypeModel(
    //     index: 3,
    //     icon: FontAwesomeIcons.certificate,
    //     subtile: 'Snooker',
    //     title: '');
    // CompetationTypeModel fifthItem = CompetationTypeModel(
    //     index: 4,
    //     icon: Icons.sports_baseball,
    //     subtile: 'Chess',
    //     title: 'Total');
    // dashBoardList.add(firstItem);
    // dashBoardList.add(secondItem);
    // dashBoardList.add(thirdItem);
    // dashBoardList.add(fourthItem);
    // dashBoardList.add(fifthItem);
    // setState(() {});
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AppConstants>(builder: (context, appCon, _) {
      return Consumer<AuthProvider>(builder: (context, authCon, _) {
        return Scaffold(
          body: Form(
            key: appCon.addCompFormKey,
            child: Container(
              padding: EdgeInsets.only(
                  left: Get.width * 0.05, right: Get.width * 0.05),
              height: Get.height,
              width: Get.width,
              decoration: const BoxDecoration(
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Get.back();
                          // Navigator.pop(context);
                        },
                        child: CircleAvatar(
                          radius: 20,
                          backgroundColor: Color(0xff707070),
                          child: Icon(Icons.arrow_back),
                        ),
                      ),
                      SizedBox(
                        width: Get.width * 0.17,
                      ),
                      Text(
                        'Create Competition',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: Get.height * 0.025,
                            fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                  SizedBox(
                    height: Get.height * 0.06,
                  ),
                  TextFormFieldCustom(
                    textInputType: TextInputType.emailAddress,
                    obscure: false,
                    enable: true,
                    image: Image.asset('assets/images/person.png'),
                    text: 'Competition Name',
                    errors: "Please enter competition name",
                    controller: appCon.compNameController,
                  ),
                  SizedBox(
                    height: Get.height * 0.013,
                  ),
                  TextFormFieldCustom(
                      controller: appCon.compTypeController,
                      textInputType: TextInputType.emailAddress,
                      obscure: false,
                      image: Image.asset('assets/images/person.png'),
                      text: appCon.competitionTypeName != null
                          ? appCon.competitionTypeName.toString()
                          : 'Competition Type',
                      //errors: "Please enter competition Type",
                      enable: false),
                  SizedBox(
                    height: Get.height * 0.013,
                  ),
                  TextFormFieldCustom(
                      textInputType: TextInputType.text,
                      obscure: false,
                      enable: false,
                      image: Image.asset('assets/images/category.png'),
                      text: 'Category',
                      errors: "Please enter category",
                      controller: appCon.compCategoryController,
                      fun: () =>
                          _showCategoryPicker(context, Get.width, Get.height * 0.4)),
                  SizedBox(
                    height: Get.height * 0.013,
                  ),
                  TextFormFieldCustom(
                    textInputType: TextInputType.emailAddress,
                    obscure: false,
                    enable: false,
                    image: Image.asset('assets/images/category.png'),
                    text: 'Sub Category',
                    errors: "Please enter sub category",
                    controller: appCon.compSubCategoryController,
                      fun: () =>
                          _showSubCategoryPicker(context, Get.width, Get.height * 0.4)
                  ),
                  SizedBox(
                    height: Get.height * 0.013,
                  ),
                  TextFormFieldCustom(
                    textInputType: TextInputType.emailAddress,
                    obscure: false,
                    enable: true,
                    image: Image.asset('assets/images/category.png'),
                    text: 'Measurement',
                    errors: "Please enter measurement",
                    controller: appCon.compMeasurementController,
                  ),
                  SizedBox(
                    height: Get.height * 0.013,
                  ),
                  TextFormFieldCustom(
                    textInputType: TextInputType.text,
                    obscure: false,
                    enable: true,
                    image: Image.asset('assets/images/person.png'),
                    text: 'Current Status',
                    errors: "enter you current status",
                    controller: appCon.compCurrentStatusController,
                  ),
                  SizedBox(
                    height: Get.height * 0.013,
                  ),
                  TextFormFieldCustom(
                    textInputType: TextInputType.text,
                    obscure: false,
                    enable: true,
                    image: Image.asset('assets/images/person.png'),
                    text: 'Your Goal',
                    errors: "Please enter your future goal",
                    controller: appCon.compGoalController,
                  ),
                  SizedBox(
                    height: Get.height * 0.013,
                  ),
                  TextFormFieldCustom(
                      textInputType: TextInputType.emailAddress,
                      obscure: false,
                      image: Image.asset('assets/images/date.png'),
                      text: appCon.compStartDate != null
                          ? appCon.compStartDate.toString().split(" ")[0]
                          : 'Start Date',
                      //errors: "Please enter start date",
                      enable: false,
                      fun: () async {
                        final DateTime? picked = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            initialDatePickerMode: DatePickerMode.day,
                            firstDate: DateTime(2015),
                            lastDate: DateTime(2101));
                        if (picked != null) {
                          print('picked $picked');
                          appCon.setStartDate(picked);
                        }
                      }),
                  SizedBox(
                    height: Get.height * 0.013,
                  ),
                  TextFormFieldCustom(
                      textInputType: TextInputType.emailAddress,
                      obscure: false,
                      image: Image.asset('assets/images/date.png'),
                      text: appCon.compEndDate != null
                          ? appCon.compEndDate.toString().split(" ")[0]
                          : 'End Date',
                      //errors: "Please enter end date",
                      enable: false,
                      fun: () async {
                        final DateTime? picked = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            initialDatePickerMode: DatePickerMode.day,
                            firstDate: DateTime(2015),
                            lastDate: DateTime(2101));
                        if (picked != null) {
                          print('picked $picked');
                          appCon.setEndDate(picked);
                        }
                      }),
                  SizedBox(
                    height: Get.height * 0.013,
                  ),
                  TextFormFieldCustom(
                      textInputType: TextInputType.number,
                      obscure: false,
                      enable: true,
                      image: Image.asset('assets/images/price.png'),
                      text: 'Price',
                      errors: "Please enter price",
                      controller: appCon.compPriceController),
                  SizedBox(
                    height: Get.height * 0.04,
                  ),
                  InkWell(
                    onTap: () {
                      if (appCon.addCompFormKey.currentState!.validate()) {
                        if (appCon.compStartDate == null ||
                            appCon.compEndDate == null) {
                          showErrorSnackBar(
                              "Start Date & End Date is Necessary");
                        } else {
                          // var authPro=Provider.of<AuthProvider>(context,listen: false);
                          authCon.getCardDetail();
                          Get.to(Payment(finalAmount: appCon.compPriceController.text.toString().trim()));
                        }
                      }
                    },
                    child: Container(
                        padding: EdgeInsets.only(
                            left: Get.width * 0.03, right: Get.width * 0.03),
                        alignment: Alignment.center,
                        height: Get.height * 0.08,
                        width: Get.width,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(15),
                          // border: Border.all(width: 1,color: Colors.red),
                        ),
                        child: Text(
                          'Pay Now',
                          style: TextStyle(
                              fontSize: Get.height * 0.023,
                              fontWeight: FontWeight.bold),
                        )),
                  ),
                  SizedBox(
                    height: Get.height * 0.05,
                  ),
                ],
              ),
            ),
          ),
        );
      });
    });
  }
}
