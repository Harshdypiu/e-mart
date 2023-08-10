// ignore_for_file: prefer_const_constructors, unused_import, unnecessary_import, unused_local_variable

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emart_app/common_widget/homebutton.dart';
import 'package:emart_app/consts/consts.dart';
import 'package:emart_app/consts/list.dart';
import 'package:emart_app/controller/home_controller.dart';
import 'package:emart_app/controller/product_controller.dart';
import 'package:emart_app/services/firestore_services.dart';
import 'package:emart_app/views/splash_screen/category_screen/item_detail.dart';
import 'package:emart_app/views/splash_screen/home_screen/component/featuredbutton.dart';
import 'package:emart_app/views/splash_screen/home_screen/search_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../../common_widget/loading_indicator.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key});

  @override
  Widget build(BuildContext context) {
    var controller=Get.put(ProductController());
    var controller1=Get.put(HomeController());
    return Container(
      color: lightGrey,
      width: context.screenWidth,
      height: context.screenHeight,
      padding: EdgeInsets.all(12),
      child: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                alignment: Alignment.center,
                height: 60,
                color: lightGrey,
                child: TextFormField(
                   controller: controller1.searchcontroller,
                  decoration: InputDecoration(
                    filled: true,
                    border: InputBorder.none,
                    fillColor: whiteColor,
                    hintText: searchanything,
                    suffixIcon: Icon(Icons.search).onTap(() {
                      if (controller1.searchcontroller.text.isNotEmptyAndNotNull) {
                         Get.to(()=>Searchscreen(title: controller1.searchcontroller.text,));
                      }
                     

                     }),
                    hintStyle: TextStyle(color: textfieldGrey),
                    
                  ),
                ),
              ),
              10.heightBox,
              VxSwiper.builder(
                aspectRatio: 16 / 9,
                autoPlay: true,
                height: 200,
                enlargeCenterPage: true,
                itemCount: sliderlist2.length,
                itemBuilder: (BuildContext context, index) {
                  return Image.asset(sliderlist[index], fit: BoxFit.fill)
                      .box
                      .rounded
                      .clip(Clip.antiAlias)
                      .margin(const EdgeInsets.symmetric(horizontal: 8))
                      .make();
                },
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: List.generate(
                  2,
                  (index) => Homebutton(
                    width: context.screenWidth / 2.5,
                    height: context.screenHeight * 0.15,
                    icon: index == 0 ? icTodaysDeal : icFlashDeal,
                    title: index == 0 ? today_deal : flash_sale,
                  ),
                ),
              ),
              VxSwiper.builder(
                aspectRatio: 16 / 9,
                autoPlay: true,
                height: 150,
                enlargeCenterPage: true,
                itemCount: sliderlist2.length,
                itemBuilder: (context, index) {
                  return Image.asset(sliderlist2[index], fit: BoxFit.fill)
                      .box
                      .rounded
                      .clip(Clip.antiAlias)
                      .margin(const EdgeInsets.symmetric(horizontal: 8))
                      .make();
                },
              ),
              10.heightBox,
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: List.generate(
                      3,
                      (index) => Homebutton(
                        width: context.screenWidth / 4,
                        height: context.screenHeight * 0.15,
                        icon: index == 0
                            ? icTodaysDeal
                            : index == 1
                                ? icTopSeller
                                : icBrands,
                        title: index == 0
                            ? today_deal
                            : index == 1
                                ? top_seller
                                : braand,
                      ),
                    ),
                  ),
                  20.heightBox,
                  Align(
                    alignment: Alignment.centerLeft,
                    child: feature_categories.text
                        .size(18)
                        .fontFamily(semibold)
                        .color(darkFontGrey)
                        .make(),
                  ),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: List.generate(
                          3,
                          (index) => Column(
                                children: [
                                  Featuredbutton(
                                      icon: featureimage1[index],
                                      title: featuretitle1[index]),
                                  10.heightBox,
                                  Featuredbutton(
                                      icon: featureimage2[index],
                                      title: featuretitle2[index])
                                ],
                              )).toList(),
                    ),
                  ),
                  20.heightBox,
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: redColor,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        feature_product.text
                            .size(18)
                            .white
                            .fontFamily(bold)
                            .make(),
                        10.heightBox,
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: FutureBuilder(
                              future: Firestoreservices.getfeaturedproduct(),
                              builder: (context,
                                  AsyncSnapshot<QuerySnapshot> snapshot) {
                                if (!snapshot.hasData) {
                                  return Center(
                                    child: Loadingindicator(),
                                  );
                                } else if (snapshot.data!.docs.isEmpty) {
                                  return "no featured product"
                                      .text
                                      .makeCentered();
                                } else {
                                  var data = snapshot.data!.docs;
                                  return Row(
                                    children: List.generate(
                                        data.length,
                                        (index) => Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Image.network(
                                                  data[index]['p_imgs'][0],
                                                  width: 130,
                                                  height: 130,
                                                  fit: BoxFit.cover,
                                                ),
                                                10.heightBox,
                                                "${data[index]['p_name']}"
                                                    .text
                                                    .fontFamily(semibold)
                                                    .color(darkFontGrey)
                                                    .make(),
                                                10.heightBox,
                                                "${data[index]['p_price']}"
                                                    .numCurrency
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
                                                .margin(EdgeInsets.symmetric(
                                                    horizontal: 4))
                                                .make()
                                                .onTap(() {
                                              Get.to(() => ItemDetails(
                                                  title:
                                                      "${data[index]['p_name']}",
                                                  data: data[index]));
                                            })),
                                  );
                                }
                              }),
                        )
                      ],
                    ),
                  ),
                  20.heightBox,
                  VxSwiper.builder(
                    aspectRatio: 16 / 9,
                    autoPlay: true,
                    height: 150,
                    enlargeCenterPage: true,
                    itemCount: sliderlist2.length,
                    itemBuilder: (context, index) {
                      return Image.asset(sliderlist2[index], fit: BoxFit.fill)
                          .box
                          .rounded
                          .clip(Clip.antiAlias)
                          .margin(const EdgeInsets.symmetric(horizontal: 8))
                          .make();
                    },
                  ),
                  20.heightBox,
                  "all Products".text.size(18).align(TextAlign.start).make(),
                  StreamBuilder(
                      stream: Firestoreservices.getallproducts(),
                      builder: (BuildContext context,
                          AsyncSnapshot<QuerySnapshot> snapshot) {
                        if (!snapshot.hasData) {
                          return Center(
                            child: Loadingindicator(),
                          );
                        } else {
                          var data = snapshot.data!.docs;

                          return GridView.builder(
                            physics: NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: data.length,
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    mainAxisSpacing: 8,
                                    mainAxisExtent: 300,
                                    crossAxisSpacing: 8),
                            itemBuilder: (context, index) {
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Image.network(
                                    data[index]['p_imgs'][0],
                                    width: 200,
                                    height: 200,
                                    fit: BoxFit.fill,
                                  ),
                                  const Spacer(),
                                  10.heightBox,
                                  "${data[index]['p_name']}"
                                      .text
                                      .fontFamily(semibold)
                                      .color(darkFontGrey)
                                      .make(),
                                  10.heightBox,
                                  "${data[index]['p_price']}"
                                      .numCurrency
                                      .text
                                      .size(16)
                                      .color(redColor)
                                      .fontFamily(bold)
                                      .make()
                                ],
                              )
                                  .box
                                  .white
                                  .padding(EdgeInsets.all(8))
                                  .margin(EdgeInsets.symmetric(horizontal: 4))
                                  .roundedSM
                                  .make()
                                  .onTap(() {
                                Get.to(() => ItemDetails(
                                    title: "${data[index]['p_name']}",
                                    data: data[index]));
                              });
                            },
                          );
                        }
                      })
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
