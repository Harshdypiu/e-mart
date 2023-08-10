import 'package:emart_app/common_widget/applogo_widget.dart';
import 'package:emart_app/consts/colors.dart';
import 'package:emart_app/consts/consts.dart';
import 'package:emart_app/views/splash_screen/auth_screen/login_screen.dart';
import 'package:emart_app/views/splash_screen/home_screen/home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Splash_screen extends StatefulWidget {

  const Splash_screen({super.key});

  @override
  State<Splash_screen> createState() => _Splash_screenState();
}

class _Splash_screenState extends State<Splash_screen> {
  changeScreen(){
  Future.delayed(const Duration(seconds: 3),() {
    // Get.to(() => const LoginScreen());
    auth.authStateChanges().listen((User? user ) {
      if (user==null && mounted ) {
        Get.to(()=> const LoginScreen());
        
      }else{
        Get.to(()=> const Home());
      }
     });









  });
  
  }
  @override
  void initState() {
    changeScreen();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: redColor,
      body: Center(
        child:Column(
          children: [
            Align(
              alignment: Alignment.topLeft,
              child: Image.asset(icSplashBg ,
              width: 300)),
              20.heightBox,
              applogoWidget(),
              10.heightBox,
              appname.text.fontFamily(bold).size(22).white.make(),
              5.heightBox,
              appversion.text.white.make(),
              const Spacer(),
              credits.text.white.size(18).fontFamily(semibold).make(),
              30.heightBox

          ],
       
        ),

        ),
    );
  }
}