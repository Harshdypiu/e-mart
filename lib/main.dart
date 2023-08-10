// ignore_for_file: unused_import

import 'package:emart_app/consts/consts.dart';
import 'package:emart_app/views/splash_screen/category_screen/item_detail.dart';
// import 'package:emart_app/views/splash_screen/category_screen/item_detail.dart';
import 'package:emart_app/views/splash_screen/splash_screen.dart';
import 'package:emart_app/views/splash_screen/wishlist_screen.dart/wishlist_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
// import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'E-MART',
      debugShowCheckedModeBanner: false,
      
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.transparent,
        appBarTheme: const AppBarTheme(
          iconTheme: IconThemeData(
            color: darkFontGrey
          ),
          backgroundColor: Colors.transparent,
          
        ),
        fontFamily: regular
      ),
      home: const Splash_screen(),
    );
  }
}

