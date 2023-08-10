// ignore_for_file: unused_import, unnecessary_import

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emart_app/consts/colors.dart';
import 'package:emart_app/consts/consts.dart';
import 'package:emart_app/views/splash_screen/order_screen/component/order status.dart';
import 'package:emart_app/views/splash_screen/order_screen/component/order_place_detail.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart' as intl;

class Order_Details extends StatelessWidget {
  final dynamic data;
  const Order_Details({Key? key, this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: whiteColor,
        appBar: AppBar(
          backgroundColor: whiteColor,
          title: "Order Detail".text.semiBold.color(Vx.black).make(),
        ),
        body: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            children: [
              OrderStatus(
                  icon: Icons.done,
                  color: Colors.green,
                  title: "Placed",
                  showdone: data['order placed']),
              OrderStatus(
                  icon: Icons.thumb_up_sharp,
                  color: Colors.blue,
                  title: "Confirmed",
                  showdone: data['order confirmed']),
              OrderStatus(
                  icon: Icons.car_crash,
                  color: Colors.yellow,
                  title: "On Delivery",
                  showdone: data['order on  delivery']),
              OrderStatus(
                  icon: Icons.done_all_rounded,
                  color: Colors.purple,
                  title: "Delivered",
                  showdone: data['order delivered']),
              Divider(),
              10.heightBox,
              Column(
                children: [
                  Orderplacedetail(
                      data: data,
                      title1: "Order Code",
                      title2: "Shipping Method",
                      d1: data['order code'],
                      d2: data['shipping method']),
                  Orderplacedetail(
                      data: data,
                      title1: "Order date",
                      title2: "Payment Method",
                      d1: intl.DateFormat()
                          .add_yMEd()
                          .format((data['order date'].toDate())),
                      d2: data['payment method']),
                  Orderplacedetail(
                    data: data,
                    title1: "Payment Status",
                    title2: "Deleivery status",
                    d1: "Unpaid",
                    d2: "Order confirmed",
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            "Shipping Detail".text.semiBold.make(),
                            "${data['order_by_name']}".text.make(),
                            "${data['order_by_email']}".text.make(),
                            "${data['order_by_phone']}".text.make(),
                            "${data['order_by_address']}".text.make(),
                            "${data['order_by_city']}".text.make(),
                            "${data['order_by_state']}".text.make(),
                            "${data['order_by_postalcode']}".text.make(),
                          ],
                        ),
                      ),
                      SizedBox(
                        width: 130,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            "total amount".text.fontFamily(semibold).make(),
                            "${data['total amount']}"
                                .numCurrency
                                .text
                                .color(redColor)
                                .make()
                          ],
                        ),
                      )
                    ],
                  ),
                ],
              ).box.outerShadowMd.white.make(),
              Divider(),
              10.heightBox,
              "Order Products".text.size(16).color(darkFontGrey).makeCentered(),
              10.heightBox,
              ListView(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                children: List.generate(data['orders'].length, (index){
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children:[ Orderplacedetail(
                    data: data,
                    title1: data['orders'][index]['title'],
                    title2: data['orders'][index]['tprice'],
                    d1: "${data['orders'][index]['qty']} x ",
                    d2: "refundable"),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Container(
                        width: 30,
                        height: 10,
                        color: Color(data['orders'][index]['color']),
                      ),
                    ),
                    const Divider()
                  ]
                  
                );
              }).toList(),
              ).box.outerShadowMd.white.margin(EdgeInsets.only(bottom: 4.0)).make(),
              10.heightBox,

              
        
            ],
          ),
        ));
  }
}
