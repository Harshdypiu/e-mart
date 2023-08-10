// ignore_for_file: prefer_const_constructors, unused_local_variable, unused_import

import 'package:emart_app/common_widget/applogo_widget.dart';
import 'package:emart_app/common_widget/bg_widget.dart';
import 'package:emart_app/common_widget/custom_textfield.dart';
import 'package:emart_app/common_widget/our_button.dart';
import 'package:emart_app/consts/consts.dart';
import 'package:emart_app/consts/list.dart';
import 'package:emart_app/controller/authcontroller.dart';
import 'package:emart_app/views/splash_screen/auth_screen/sign_up.dart';
import 'package:emart_app/views/splash_screen/home_screen/home.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(AuthController());
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
              Obx(()=> Column(
                  children: [
                    customTextField(
                        hint: emailhint,
                        tittle: email,
                        isPass: false,
                        controller: controller.emailcontroller),
                    customTextField(
                        hint: passwordhint,
                        tittle: password,
                        isPass: true,
                        controller: controller.passwordcontroller),
                    Align(
                        alignment: Alignment.centerRight,
                        child: TextButton(
                            onPressed: () {}, child: forgetpassword.text.make())),
                    5.heightBox,
                    controller.isloading.value?CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation(redColor),
                    ) : ourButton(
                        color: redColor,
                        title: login,
                        textcolor: whiteColor,
                        onPress: ()  async{
                          controller.isloading(true);

                         await controller
                              .loginmethod(context: context)
                              .then((value) {
                            if (value != null) {
                              VxToast.show(context, msg: loggedin);
                              Get.offAll(() => const Home());
                              
                            }else{
                              controller.isloading(false);
                            }
                          });
                          // Get.to(()=>Home());
                        }).box.width(context.screenWidth - 50).make(),
                    5.heightBox,
                    createnewaccount.text.color(fontGrey).make(),
                    5.heightBox,
                    ourButton(
                            textcolor: redColor,
                            onPress: () {
                              Get.to(() => SignupScreen());
                            },
                            title: singup,
                            color: lightgolden)
                        .box
                        .width(context.screenWidth - 50)
                        .make(),
                    10.heightBox,
                    logininwith.text.color(fontGrey).make(),
                    5.heightBox,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(
                        3,
                        (index) => Padding(
                          padding: EdgeInsets.all(8.0),
                          child: CircleAvatar(
                            radius: 25,
                            backgroundColor: lightGrey,
                            child: Image.asset(
                              socialiconList[index],
                              width: 30,
                            ),
                          ),
                        ),
                      ),
                    )
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
