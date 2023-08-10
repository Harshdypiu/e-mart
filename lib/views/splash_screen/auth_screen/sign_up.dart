// ignore_for_file: unused_import, unnecessary_import, prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:emart_app/consts/consts.dart';
import 'package:emart_app/controller/authcontroller.dart';
import 'package:emart_app/views/splash_screen/home_screen/home.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../common_widget/applogo_widget.dart';
import '../../../common_widget/bg_widget.dart';
import '../../../common_widget/custom_textfield.dart';
import '../../../common_widget/our_button.dart';
import '../../../consts/colors.dart';
import '../../../consts/list.dart';
import '../../../consts/strings.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  bool? isCheck = false;
  var controller = Get.put(AuthController());

  var namecontroller = TextEditingController();
  var emailcontroller = TextEditingController();
  var passwordcontroller = TextEditingController();
  var retypepasswordcontroller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return bgWidget(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Center(
          child: Column(
            children: [
              (context.screenHeight * 0.1).heightBox,
              applogoWidget(),
              10.heightBox,
              "Log in to $appname".text.fontFamily(bold).white.size(18).make(),
              15.heightBox,
              Obx(()=>
                 Column(
                  children: [
                    customTextField(
                        hint: namehint, tittle: name, controller: namecontroller,isPass: false),
                    customTextField(
                        hint: emailhint,
                        tittle: email,
                        controller: emailcontroller,
                        isPass: false),
                    customTextField(
                        hint: passwordhint,
                        tittle: password,
                        controller: passwordcontroller,
                        isPass: true),
                    customTextField(
                        hint: passwordhint,
                        tittle: retypepassword,
                        controller: retypepasswordcontroller,
                        isPass: true),
                    Row(
                      children: [
                        Checkbox(
                          value: isCheck,
                          onChanged: (newvalue) {
                            setState(() {
                              isCheck = newvalue;
                            });
                          },
                          checkColor: whiteColor,
                          activeColor: redColor,
                        ),
                        5.heightBox,
                        Expanded(
                          child: RichText(
                              text: const TextSpan(children: [
                            TextSpan(
                              text: "I agree to the",
                              style: TextStyle(
                                fontFamily: regular,
                                color: fontGrey,
                              ),
                            ),
                            TextSpan(
                              text: termandcondition,
                              style: TextStyle(
                                fontFamily: regular,
                                color: redColor,
                              ),
                            ),
                            TextSpan(
                              text: "&",
                              style: TextStyle(
                                fontFamily: regular,
                                color: redColor,
                              ),
                            ),
                            TextSpan(
                              text: privacypolicy,
                              style: TextStyle(
                                fontFamily: regular,
                                color: redColor,
                              ),
                            )
                          ])),
                        )
                      ],
                    ),
                    controller.isloading.value? CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation(redColor),
                    ): ourButton(
                            textcolor: whiteColor,
                            onPress: () async{
                              if(isCheck!=false){
                                try {
                                  controller.isloading(true);
              
                                  await controller.signupmethod(
                                    context: context,
                                    email: emailcontroller.text,
                                    password: passwordcontroller.text
                                  ).then((value) {
                                    return controller.storeUserData(
                                      email: emailcontroller.text,
                                      password: passwordcontroller.text,
                                      name: namecontroller.text,
                                    );
                                  }).then((value) {
                                    VxToast.show(context, msg: loggedin);
                                    Get.offAll(() => const Home());
                                  });
                                  
                                } catch (e) {
                                  auth.signOut();
                                  VxToast.show(context, msg: e.toString());
                                  controller.isloading(false);
              
                                  
                                }
                              }
                            },
                            title: singup,
                            color: isCheck == true ? redColor : lightGrey)
                        .box
                        .width(context.screenWidth - 50)
                        .make(),
                    10.heightBox,
                    RichText(
                        text: TextSpan(children: [
                      TextSpan(
                          text: alreadyhaveaccount,
                          style: TextStyle(
                            fontFamily: bold,
                            color: fontGrey,
                          )),
                      TextSpan(
                          text: login,
                          style: TextStyle(fontFamily: bold, color: redColor))
                    ])).onTap(() {
                      Get.back();
                    }),
                    5.heightBox,
                  ],
                )
                    .box
                    .white
                    .rounded
                    .padding(EdgeInsets.all(16))
                    .width(context.screenWidth - 70)
                    .shadow
                    .make(),
              )
            ],
          ),
        ),
      ),
    );
  }
}
