// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emart_app/common_widget/loading_indicator.dart';
import 'package:emart_app/common_widget/our_button.dart';
import 'package:emart_app/controller/cart_controller.dart';
import 'package:emart_app/services/firestore_services.dart';
import 'package:emart_app/views/splash_screen/cart_screen/shipping_screen.dart';
import 'package:flutter/material.dart';
import 'package:emart_app/consts/consts.dart';
import 'package:get/get.dart';

class Cart_screen extends StatelessWidget {
  const Cart_screen({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(cartcontroller());
    return Scaffold(
        backgroundColor: whiteColor,
        bottomNavigationBar: ourButton(
            title: "Place order",
            onPress: () {
              Get.to(() => Shipping_detail());
            },
            color: redColor,
            textcolor: whiteColor),
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: "Shopping Cart"
              .text
              .color(darkFontGrey)
              .fontFamily(semibold)
              .make(),
        ),
        body: StreamBuilder(
            stream: Firestoreservices.getcart(currentUser!.uid),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (!snapshot.hasData) {
                return Center(
                  child: Loadingindicator(),
                );
              } else if (snapshot.data!.docs.isEmpty) {
                return Center(
                  child: "cart is empty".text.make(),
                );
              } else {
                var data = snapshot.data!.docs;
                controller.calculate(data);
                controller.productsnapshot = data;
                return Padding(
                  padding: EdgeInsets.all(8),
                  child: Column(
                    children: [
                      Expanded(
                          child: Container(
                        child: ListView.builder(
                            itemCount: data.length,
                            itemBuilder: ((context, index) {
                              return ListTile(
                                leading:
                                    Image.network("${data[index]['image']}",
                                    width: 80,
                                    fit: BoxFit.cover,),
                                title:
                                    "${data[index]['title']} (x ${data[index]['quantity']})"
                                        .text
                                        .size(16)
                                        .fontFamily(semibold)
                                        .make(),
                                subtitle: "${data[index]['total price']}"
                                    .text
                                    .color(redColor)
                                    .semiBold
                                    .make(),
                                trailing: Icon(
                                  Icons.delete,
                                  color: redColor,
                                ).onTap(() {
                                  Firestoreservices.deletedocument(
                                      data[index].id);
                                }),
                              );
                            })),
                      )),
                      Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                            "Total Price ".text.color(darkFontGrey).make(),
                            Obx(() => "${controller.totalP.value} "
                                .numCurrency
                                .text
                                .color(redColor)
                                .make())
                          ])
                          .box
                          .roundedSM
                          .padding(EdgeInsets.all(12))
                          .color(lightgolden)
                          .make(),
                      10.heightBox,
                    ],
                  ),
                );
              }
            }));
  }
}
