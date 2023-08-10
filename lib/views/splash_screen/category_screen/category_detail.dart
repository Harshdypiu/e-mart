import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emart_app/common_widget/bg_widget.dart';
import 'package:emart_app/common_widget/loading_indicator.dart';
import 'package:emart_app/controller/product_controller.dart';
import 'package:emart_app/services/firestore_services.dart';
import 'package:emart_app/views/splash_screen/category_screen/item_detail.dart';
import 'package:flutter/material.dart';
import 'package:emart_app/consts/consts.dart';
import 'package:get/get.dart';
// ignore: unnecessary_import
import 'package:velocity_x/velocity_x.dart';

class CategoryDetails extends StatelessWidget {
  final String? title;
  const CategoryDetails({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<ProductController>();

    return bgWidget(
        child: Scaffold(
            appBar: AppBar(
              title: title!.text.fontFamily(bold).make(),
            ),
            body: StreamBuilder(
                stream: Firestoreservices.getProducts(title),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (!snapshot.hasData) {
                    return Center(
                      child: Loadingindicator(),
                    );
                  } else if (snapshot.data!.docs.isEmpty) {
                    return Center(
                      child: "no product found".text.make(),
                    );
                  } else {
                    var data = snapshot.data!.docs;

                    return Container(
                      padding: EdgeInsets.all(12),
                      child: Column(
                        children: [
                          SingleChildScrollView(
                            physics: const BouncingScrollPhysics(),
                            scrollDirection: Axis.horizontal,
                            child: Row(
                                children: List.generate(
                              controller.subcat.length,
                              (index) => "${controller.subcat[index]}"
                                  .text
                                  .size(12)
                                  .fontFamily(bold)
                                  .makeCentered()
                                  .box
                                  .white
                                  .size(120, 60)
                                  .rounded
                                  .margin(EdgeInsets.symmetric(horizontal: 4))
                                  .make(),
                            )),
                          ),
                          20.heightBox,
                          Expanded(
                              child: GridView.builder(
                                  physics: BouncingScrollPhysics(),
                                  shrinkWrap: true,
                                  itemCount: data.length,
                                  gridDelegate:
                                      SliverGridDelegateWithFixedCrossAxisCount(
                                          crossAxisCount: 2,
                                          crossAxisSpacing: 8,
                                          mainAxisExtent: 280,
                                          mainAxisSpacing: 8),
                                  itemBuilder: (context, index) {
                                    return Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Image.network(
                                          data[index]['p_imgs'][0],
                                          height: 200,
                                          width: 200,
                                          fit: BoxFit.cover,
                                        ),
                                        const Spacer(),
                                        "${data[index]['p_name']}"
                                            .text
                                            .fontFamily(bold)
                                            .color(darkFontGrey)
                                            .make(),
                                        10.heightBox,
                                        "${data[index]['p_price']}"
                                            .numCurrency
                                            .text
                                            .fontFamily(bold)
                                            .color(redColor)
                                            .make()
                                      ],
                                    )
                                        .box
                                        .white
                                        .rounded
                                        .outerShadowSm
                                        .margin(
                                            EdgeInsets.symmetric(horizontal: 4))
                                        .padding(EdgeInsets.all(12))
                                        .make()
                                        .onTap(() {
                                          controller.CheckSIsFav(data[index]);
                                      Get.to(() => ItemDetails(
                                            title: "${data[index]['p_name']}",
                                            data: data[index],
                                          ));
                                    });
                                  }))
                        ],
                      ),
                    );
                  }
                })));
  }
}
