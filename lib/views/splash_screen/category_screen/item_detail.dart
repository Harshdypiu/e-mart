// ignore_for_file: prefer_const_constructors

import 'package:emart_app/views/splash_screen/chat%20screen/chat_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:emart_app/common_widget/our_button.dart';
import 'package:emart_app/consts/consts.dart';
import 'package:emart_app/consts/list.dart';
import 'package:emart_app/controller/product_controller.dart';

class ItemDetails extends StatelessWidget {
  final String? title;
  final dynamic data;

  const ItemDetails({Key? key, required this.title, required this.data})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<ProductController>();

    return WillPopScope(
      onWillPop: () async {
        controller.resetValue();
        return false;
      },
      child: Scaffold(
        backgroundColor: whiteColor,
        appBar: AppBar(
          leading: IconButton(onPressed: (){
            controller.resetValue();
            Get.back();
          }, icon: Icon(Icons.arrow_back)),
          backgroundColor: lightGrey,
          title: title!.text.color(darkFontGrey).make(),
          actions: [
            IconButton(onPressed: () {}, icon: Icon(Icons.share)),
            Obx(()=>
               IconButton(onPressed: () {
                if(controller.isfav.value){
                  controller.removetowishlist(data.id,context);
                  controller.isfav(false);
                }else{
                  controller.addtowishlist(data.id,context);
                  controller.isfav(true);
                  
            
                }
              }, icon: Icon(Icons.favorite_outlined,color: controller.isfav.value?redColor:darkFontGrey,)),
            ),
          ],
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Container(
                padding: EdgeInsets.all(8),
                child: SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      VxSwiper.builder(
                        height: 350,
                        autoPlay: true,
                        aspectRatio: 16 / 9,
                        viewportFraction: 1.0,
                        itemCount: data['p_imgs'].length,
                        itemBuilder: (context, index) {
                          return Image.network(
                            data["p_imgs"][index],
                            width: double.infinity,
                            fit: BoxFit.cover,
                          );
                        },
                      ),
                      10.heightBox,
                      title!.text
                          .fontFamily(bold)
                          .color(darkFontGrey)
                          .size(16)
                          .make(),
                      10.heightBox,
                      VxRating(
                        isSelectable: false,
                        value: double.parse(data['p_rating']),
                        onRatingUpdate: (value) {},
                        normalColor: textfieldGrey,
                        selectionColor: golden,
                        maxRating: 5,
                        size: 25,
                        count: 5,
                      ),
                      10.heightBox,
                      "${data['p_price']}"
                          .numCurrency
                          .text
                          .size(18)
                          .color(redColor)
                          .align(TextAlign.start)
                          .make(),
                      10.heightBox,
                      Row(
                        children: [
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                "Seller".text.white.semiBold.make(),
                                5.heightBox,
                                "${data['p_seller']}"
                                    .text
                                    .semiBold
                                    .color(darkFontGrey)
                                    .make(),
                              ],
                            ),
                          ),
                          const CircleAvatar(
                            backgroundColor: whiteColor,
                            child: Icon(Icons.message),
                          ).onTap(() {Get.to(()=>ChatScreen(),
                          arguments: [data['p_seller'],data['vendor_id']]);}),
                        ],
                      )
                          .box
                          .height(60)
                          .margin(const EdgeInsets.symmetric(horizontal: 16))
                          .color(textfieldGrey)
                          .make(),
                      20.heightBox,
                      Obx(() => Column(
                            children: [
                              Row(
                                children: [
                                  SizedBox(
                                    width: 100,
                                    child: "Color "
                                        .text
                                        .semiBold
                                        .color(textfieldGrey)
                                        .make(),
                                  ),
                                  Row(
                                    children: List.generate(
                                      data['p_colors'].length,
                                      (index) => Stack(
                                        alignment: Alignment.center,
                                        children: [
                                          VxBox()
                                              .size(40, 40)
                                              .roundedFull
                                              .color(Color(data['p_colors'][index]))
                                              .margin(
                                                  const EdgeInsets.symmetric(horizontal: 6))
                                              .make().onTap(() {
                                            controller.ChangecolorIndex(index);
                                          }),
                                          Visibility(
                                            visible: index == controller.colorIndex.value,
                                            child: Icon(Icons.done, color: whiteColor),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      Obx(
                        () => Row(
                          children: [
                            SizedBox(
                              width: 100,
                              child: "Quantity"
                                  .text
                                  .semiBold
                                  .color(textfieldGrey)
                                  .make(),
                            ),
                            Row(
                              children: [
                                IconButton(
                                    onPressed: () {
                                      controller.decreasequantity();
                                      controller.calculateTotalPrice(int.parse(data['p_price']));
                                    }, icon: Icon(Icons.remove)),
                                controller.quantity.value.text.size(16).make(),
                                IconButton(
                                    onPressed: () {
                                      controller.increasequantity(int.parse(data['p_quantity']));
                                      controller.calculateTotalPrice(int.parse(data['p_price']));
                                    }, icon: Icon(Icons.add)),
                                10.widthBox,
                                "${data['p_quantity']}"
                                    .text
                                    .color(textfieldGrey)
                                    .make()
                              ],
                            ),
                          ],
                        ),
                      ),
                      Row(
                        children: [
                          SizedBox(
                            width: 100,
                            child: "Total ".text.color(textfieldGrey).make(),
                          ),
                          controller.totalprice.value.numCurrency
                              .text
                              .color(redColor)
                              .fontFamily(bold)
                              .size(16)
                              .make(),
                        ],
                      ).box.white.shadowSm.make(),
                      10.heightBox,
                      "description"
                          .text
                          .color(darkFontGrey)
                          .fontFamily(semibold)
                          .make(),
                      5.heightBox,
                      "${data['p_description']}".text.color(textfieldGrey).make(),
                      ListView(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        children: List.generate(
                            5,
                            (index) => ListTile(
                                  title: "${itemdetaillist[index]}".text.make(),
                                  trailing: const Icon(Icons.arrow_forward),
                                )),
                      ),
                      20.heightBox,
                      product_you_may_like.text
                          .fontFamily(bold)
                          .color(darkFontGrey)
                          .size(16)
                          .make(),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: List.generate(
                              6,
                              (index) => Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Image.asset(
                                        imgP1,
                                        width: 150,
                                        fit: BoxFit.cover,
                                      ),
                                      10.heightBox,
                                      "Laptop 4gb ram/512GB SSD"
                                          .text
                                          .fontFamily(semibold)
                                          .color(darkFontGrey)
                                          .make(),
                                      10.heightBox,
                                      "\$600"
                                          .text
                                          .size(16)
                                          .color(redColor)
                                          .fontFamily(bold)
                                          .make()
                                    ],
                                  )
                                      .box
                                      .white
                                      .roundedSM
                                      .padding(EdgeInsets.all(8))
                                      .margin(EdgeInsets.symmetric(horizontal: 4))
                                      .make()),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
            10.heightBox,
            SizedBox(
              height: 60,
              width: double.infinity,
              child: ourButton(
                title: "add to cart",
                onPress: () {
                 if (controller.quantity.value>0) {
                   controller.addTocart(
                    color: data['p_colors'][controller.colorIndex.value],
                    context: context,
                    img: data['p_imgs'][0],
                    qty: controller.quantity.value,
                    sellername: data['p_seller'],
                    tprice: controller.totalprice.value,
                    title: data['p_name'],
                    vendor_id: data['vendor_id']
    
    
                  );VxToast.show(context, msg: "added to cart");
                   
                 }else{
                  VxToast.show(context, msg: "please add minimum quantity");
                 }
                },
                textcolor: whiteColor,
                color: redColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
