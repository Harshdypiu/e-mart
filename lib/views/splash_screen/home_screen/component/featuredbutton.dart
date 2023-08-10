// ignore_for_file: prefer_const_constructors

import 'package:emart_app/consts/consts.dart';
import 'package:emart_app/views/splash_screen/category_screen/category_detail.dart';
import 'package:get/get.dart';
Widget Featuredbutton({icon,String?title}){
  return Row(
    children: [
      Image.asset(icon,width:60 ,fit: BoxFit.fill,),
      10.heightBox,
      title!.text.fontFamily(semibold).color(darkFontGrey).make()
    ],
  ).box.white.rounded.width(200).margin(EdgeInsets.symmetric(horizontal: 4)).make().onTap(() {
    Get.to(()=>CategoryDetails(title: title));
  });
}