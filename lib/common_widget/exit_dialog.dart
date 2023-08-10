// ignore_for_file: unused_import, non_constant_identifier_names, prefer_const_constructors

import 'package:emart_app/common_widget/our_button.dart';
import 'package:emart_app/consts/consts.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

Widget Exitdialog(context){
  return Dialog(
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        "confirm".text.fontFamily(bold).color(darkFontGrey).size(18).make(),
        Divider(),
        "are you sure want to exit".text.color(darkFontGrey).size(16).make(),
        10.heightBox,
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ourButton(
              title: "yes",
              color: redColor,
              textcolor: whiteColor,
              onPress: (){
                SystemNavigator.pop();
              }
            ),
             ourButton(
              title: "no",
              color: redColor,
              textcolor: whiteColor,
              onPress: (){
                Navigator.pop(context);
              }
            )
          ],
        )
      ],
    ).box.rounded.padding( const EdgeInsets.all(12)).color(lightGrey).make(),
  );
}