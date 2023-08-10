// ignore_for_file: unused_local_variable

import 'package:emart_app/common_widget/custom_textfield.dart';
import 'package:emart_app/common_widget/our_button.dart';
import 'package:emart_app/consts/consts.dart';
import 'package:emart_app/controller/cart_controller.dart';
import 'package:emart_app/views/splash_screen/cart_screen/payment_method.dart';
import 'package:get/get.dart';

class Shipping_detail extends StatelessWidget {
  const Shipping_detail({super.key});

  @override
  Widget build(BuildContext context) {
    var controller =Get.find<cartcontroller>();
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        title: "shipping_detail".text.semiBold.color(darkFontGrey).make(),
      ),
      bottomNavigationBar: ourButton(
        color: redColor,
        textcolor: whiteColor,
        title: "Continue",
        onPress: (){
          if (controller.addresscontroller.text.length>10) {
             Get.to(()=>PaymentMethods());
          }else{
            VxToast.show(context, msg: "please fill the form");
          }
         
        }
      ),
      body: Padding(
        padding:EdgeInsets.all(12),
        child: Column(
          children: [
            customTextField(isPass: false,hint: "City",tittle: "City",controller: controller.citycontroller),
            customTextField(isPass: false,hint: "State",tittle: "State",controller: controller.statecontroller),
            customTextField(isPass: false,hint: "Phone",tittle: "Phone",controller: controller.phonecontroller),
            customTextField(isPass: false,hint: "Postal Code",tittle: "Postal Code",controller: controller.postalcodecontroller),
            customTextField(isPass: false,hint: "Address",tittle: "Address",controller: controller.addresscontroller)
          ],
        ),
      ),
    );
  }
}