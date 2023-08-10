// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart'; // Import the material library

import 'package:emart_app/consts/consts.dart';
import 'package:get/get.dart';

Widget Orderplacedetail({data,title1,title2,d1,d2}) {
  return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                "$title1".text.make(),
                "$d1".text.color(redColor).fontFamily(semibold).make()
              ],
            ).paddingSymmetric(horizontal: 16,vertical: 8),
            SizedBox(
              width: 130,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  "$title2".text.make(),
                "$d2".text.make()
                ],
              ).paddingSymmetric(horizontal: 16,vertical: 8),
            ),
            

          ],
         );
}
