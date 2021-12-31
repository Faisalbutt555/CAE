import 'package:flutter/material.dart';
import 'package:get/get.dart';
class TextFormFieldCustom extends StatelessWidget {
   TextFormFieldCustom({Key? key,this.onTap,this.iconData,this.textInputType,this.obscure,this.text,this.controller,this.enable,this.errors,this.fun,this.image}) : super(key: key);
  Image? image;
  String? text;
   bool? enable = true;
   bool? obscure = false;
   IconData? iconData;
   Function()? fun;
   Function()? onTap;
  var controller;
  TextInputType? textInputType;
  String? errors;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: fun,
        child: Container(
            padding: EdgeInsets.only(
                left: Get.width * 0.03, right: Get.width * 0.03),
            alignment: Alignment.center,
            height: Get.height * 0.08,
            width: Get.width,
            decoration: BoxDecoration(
              //color: Colors.red,
                borderRadius: BorderRadius.circular(15),
                // border: Border.all(width: 1,color: Colors.red),
                image: const DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage('assets/images/textfield.png'))),
            child: TextFormField(
              obscureText: obscure!,
              enabled: enable,
              validator: (value) {
                if (value!.isEmpty || value == "") {
                  return errors;
                } else
                  return null;
              },
              controller: controller,
              cursorHeight: 25,
              style: TextStyle(color: Colors.white),
              keyboardType: textInputType,
              decoration: InputDecoration(
                suffixIcon: GestureDetector(onTap: onTap,
                child: Icon(iconData,color: Colors.white),),
                  border: InputBorder.none,
                  hintText: text,
                  hintStyle: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.w600),
                  prefixIcon: image),
            )));
  }
}
