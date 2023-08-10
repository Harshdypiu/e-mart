// ignore_for_file: unused_local_variable

import 'package:emart_app/common_widget/loading_indicator.dart';
import 'package:emart_app/consts/consts.dart';
import 'package:emart_app/consts/list.dart';
import 'package:emart_app/controller/cart_controller.dart';
import 'package:emart_app/views/splash_screen/home_screen/home.dart';
import 'package:get/get.dart';

import '../../../common_widget/our_button.dart';

class PaymentMethods extends StatelessWidget {
  const PaymentMethods({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<cartcontroller>();
    return Obx(
      () => Scaffold(
        backgroundColor: whiteColor,
        appBar: AppBar(
          backgroundColor: whiteColor,
          title:
              "Choose Payment methods".text.semiBold.color(darkFontGrey).make(),
        ),
        bottomNavigationBar: controller.placingorders.value
            ? Center(
                child: Loadingindicator(),
              )
            : ourButton(
                color: redColor,
                textcolor: whiteColor,
                title: "Place Orders",
                onPress: () async {
                  await controller.placemyorder(
                      orderPaymentMethod:
                          paymentnames[controller.paymentindex.value],
                      totalamount: controller.totalP.value);
                  await controller.clearcart();
                  VxToast.show(context, msg: "order placed successfully");
                  Get.offAll(const Home());
                }),
        body: Padding(
          padding: EdgeInsets.all(12),
          child: Obx(
            () => Column(
              children: List.generate(paymentimgs.length, (index) {
                return GestureDetector(
                  onTap: () {
                    controller.changepaymentindex(index);
                  },
                  child: Container(
                    clipBehavior: Clip.antiAlias,
                    decoration: BoxDecoration(
                        border: Border.all(
                            style: BorderStyle.solid,
                            color: controller.paymentindex.value == index
                                ? redColor
                                : Colors.transparent,
                            width: 4),
                        borderRadius: BorderRadius.circular(12)),
                    margin: const EdgeInsets.only(bottom: 8),
                    child: Stack(
                      alignment: Alignment.topRight,
                      children: [
                        Image.asset(
                          paymentimgs[index],
                          width: double.infinity,
                          height: 120,
                          fit: BoxFit.cover,
                          colorBlendMode: controller.paymentindex.value == index
                              ? BlendMode.darken
                              : BlendMode.color,
                          color: controller.paymentindex.value == index
                              ? Colors.black.withOpacity(0.4)
                              : Colors.transparent,
                        ),
                        controller.paymentindex.value == index
                            ? Transform.scale(
                                scale: 1.3,
                                child: Checkbox(
                                    activeColor: Colors.green,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(50)),
                                    value: true,
                                    onChanged: (value) {}),
                              )
                            : Container(),
                        Positioned(
                            bottom: 0,
                            right: 0,
                            child: paymentnames[index]
                                .text
                                .semiBold
                                .color(whiteColor)
                                .make())
                      ],
                    ),
                  ),
                );
              }),
            ),
          ),
        ),
      ),
    );
  }
}
