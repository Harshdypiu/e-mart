// ignore_for_file: unused_local_variable

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emart_app/consts/consts.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class AuthController extends GetxController{
  var emailcontroller=TextEditingController();
  var passwordcontroller=TextEditingController();

  var isloading=false.obs;


  // login method
  Future<UserCredential?> loginmethod({context}) async{
    UserCredential? userCredential;
    try {
      userCredential= await auth.signInWithEmailAndPassword(email: emailcontroller.text , password: passwordcontroller.text);
      
    } on FirebaseAuthException catch (e) {
      VxToast.show(context, msg: e.toString());
      
    }
    return userCredential;
  }

// signup method
 Future<UserCredential?> signupmethod({email,password,context}) async{
    UserCredential? userCredential;
    try {
      userCredential= await auth.createUserWithEmailAndPassword(email: email , password: password);
      
    } on FirebaseAuthException catch (e) {
      VxToast.show(context, msg: e.toString());
      
    }
    return userCredential;
  }

  storeUserData({email,password,name}) async {
    DocumentReference store =  firestore.collection(userCollection).doc(currentUser!.uid);
    store.set({'email':email,'password':password,'name':name,'imageurl':'','id':currentUser!.uid,'cart_count':'00','order_count':'00','wishlist_count':'00'});

  }

  // signout method
  signout({context})async{
    try {
      await auth.signOut();
    } catch (e) {
      VxToast.show(context, msg: e.toString());
      
    }
  }


}