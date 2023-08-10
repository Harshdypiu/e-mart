// ignore_for_file: prefer_const_constructors, unused_local_variable, unused_import

import 'package:emart_app/common_widget/exit_dialog.dart';
import 'package:emart_app/consts/consts.dart';
import 'package:emart_app/controller/home_controller.dart';
import 'package:emart_app/views/splash_screen/cart_screen/cart.dart';
import 'package:emart_app/views/splash_screen/category_screen/category_screen.dart';
import 'package:emart_app/views/splash_screen/home_screen/home_screen.dart';
import 'package:emart_app/views/splash_screen/profile_screen/profile.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  

  @override
  Widget build(BuildContext context) {
    var homeController=Get.put(HomeController());
    var navbaritems=[
      BottomNavigationBarItem(icon: Image.asset(icHome, width: 26,),label:home ),
      BottomNavigationBarItem(icon: Image.asset(icCategories,width: 26,),label:categories),
      BottomNavigationBarItem(icon: Image.asset(icCart,width: 26,),label: cart),
      BottomNavigationBarItem(icon: Image.asset(icProfile,width: 26,),label: account)
    ];
    var navbody=[
      HomeScreen(),
      Category_screen(),
      Cart_screen(),
      ProfileSection(),

    ]
    ;




    return WillPopScope(
      onWillPop: () async{
        showDialog(barrierDismissible: false,context: context, builder: (context)=>Exitdialog(context));
        return false;
      },
      child: Scaffold(
        body: Column(
          children: [Obx(()=>
             Expanded(child: navbody.elementAt(homeController.currentnavindex.value),
              
            ),
          ),]
        ),
        bottomNavigationBar:Obx(()=>
           BottomNavigationBar(
            currentIndex: homeController.currentnavindex.value,
            items: navbaritems,
            selectedItemColor: redColor,
            selectedLabelStyle: TextStyle(
              fontFamily: semibold,
            ),
            backgroundColor: whiteColor,
            type: BottomNavigationBarType.fixed,
            onTap: (value){
              homeController.currentnavindex.value=value;
            },
            ),
        ) ,
      ),
    );
  }
}