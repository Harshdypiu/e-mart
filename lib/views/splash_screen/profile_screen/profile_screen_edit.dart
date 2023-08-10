import 'dart:io';

import 'package:emart_app/common_widget/bg_widget.dart';
import 'package:emart_app/common_widget/custom_textfield.dart';
import 'package:emart_app/common_widget/our_button.dart';
import 'package:emart_app/consts/consts.dart';
import 'package:emart_app/controller/profile_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Editprofilescreen extends StatelessWidget {
  
  final dynamic data;

  const Editprofilescreen({Key? key,this.data}):super(key:key);

  @override
  Widget build(BuildContext context) {
    
    var controller = Get.find<Profliecontroller>();
    

    return bgWidget(
        child: Scaffold(
          resizeToAvoidBottomInset: false,
      appBar: AppBar(),
      body: Obx(()=>
         Column(mainAxisSize: MainAxisSize.min, children: [
          data['imageurl']=='' && controller.profileImgpath.isEmpty
              ? Image.asset(
                  imgProfile,
                  width: 100,
                  fit: BoxFit.cover,
                ).box.roundedFull.clip(Clip.antiAlias).make()
              : data['imageurl']!='' && controller.profileImgpath.isEmpty?
              Image.network(data['imageurl'],width: 100,fit: BoxFit.cover,).box.roundedFull.clip(Clip.antiAlias).make():
               Image.file(
                  File(controller.profileImgpath.value),
                  width: 100,
                  fit: BoxFit.cover,
                ).box.roundedFull.clip(Clip.antiAlias).make(),
          10.heightBox,
          ourButton(
              color: redColor,
              textcolor: whiteColor,
              title: 'change',
              onPress: () {
                controller.Changeimage(context: context);
              }),
          Divider(),
          20.heightBox,
          customTextField(tittle: name, hint: namehint, isPass: false,controller: controller.namecontroller),
          10.heightBox,

          customTextField(tittle: oldpass, hint: passwordhint, isPass: true,controller: controller.oldpasswordcontroller),
          10.heightBox,
          customTextField(tittle: password, hint: passwordhint, isPass: true,controller: controller.newpasswordcontroller),

          20.heightBox,
          controller.isloading.value ? CircularProgressIndicator(valueColor: AlwaysStoppedAnimation(redColor),):  SizedBox(
            width: context.screenWidth - 60,
            child: ourButton(
                title: "save",
                color: redColor,
                textcolor: whiteColor,
                onPress: () async{
                  controller.isloading(true);


                  if(controller.profileImgpath.value.isNotEmpty){
                    await controller.uploadProfileImage();

                  }
                  else{
                    controller.profileimglink = data['imageurl'];

                  }
                  if(data['password']==controller.oldpasswordcontroller.text){
                    await controller.ChangeAuthPassword(
                      email: data['email'],
                      password: controller.oldpasswordcontroller.text,
                      newpassword: controller.newpasswordcontroller.text

                    );



                      await controller.updataProfile(
                    name: controller.namecontroller.text,
                    password: controller.newpasswordcontroller.text,
                    imgUrl: controller.profileimglink);

                    VxToast.show(context, msg: "updated");

                  }else{
                    VxToast.show(context, msg: "wrong password");
                    controller.isloading(false);
                  }

                  
                



                
                  




                }),
          )
        ])
            .box
            .white
            .roundedSM
            .padding(const EdgeInsets.all(16))
            .margin(const EdgeInsets.only(top: 50, left: 25, right: 25))
            .shadowSm
            .make(),
      ),
    ));
  }
}
