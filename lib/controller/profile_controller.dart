// ignore_for_file: unnecessary_null_comparison, unused_import, unused_local_variable, unused_label

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emart_app/consts/consts.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';

class Profliecontroller extends GetxController {
  var profileImgpath=''.obs;
  var profileimglink='';
  var isloading = false.obs;

  var namecontroller=TextEditingController();
  var newpasswordcontroller=TextEditingController();
  var oldpasswordcontroller=TextEditingController();



  Changeimage({context}) async{
    try {
      final img= await ImagePicker().pickImage(source: ImageSource.gallery,imageQuality: 70);
      if(img==null) return ;
      profileImgpath.value=img.path;
    } on PlatformException catch (e) {
      VxToast.show(context, msg: e.toString());
      
    }
    
  }
  uploadProfileImage() async{
    var filename=basename(profileImgpath.value);
    var destination = 'images/${currentUser!.uid}/$filename';
    Reference ref= FirebaseStorage.instance.ref().child(destination);
    await ref.putFile(File(profileImgpath.value));
    profileimglink= await ref.getDownloadURL();
  }

  updataProfile({name,password,imgUrl}) async {
    var store=firestore.collection(userCollection).doc(currentUser!.uid);
    await store.set({
      'name' : name,
      'password': password,
      'imageurl':imgUrl
    },SetOptions(merge: true));
    isloading(false);

  }

  ChangeAuthPassword({email,password,newpassword}) async {

    final cred= EmailAuthProvider.credential(email: email, password: password);

    await currentUser!.reauthenticateWithCredential(cred).then((value) {
      currentUser!.updatePassword(newpassword);
    }).catchError((error){
      print(error.toString());
    });



  }





  
}