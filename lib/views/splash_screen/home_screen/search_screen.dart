// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emart_app/common_widget/loading_indicator.dart';
import 'package:emart_app/consts/consts.dart';
import 'package:emart_app/services/firestore_services.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart'; // Make sure to import the 'material.dart' package

import '../category_screen/item_detail.dart';

class Searchscreen extends StatelessWidget {
  final String? title;
  const Searchscreen({Key? key, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        title: title!.text.color(darkFontGrey).make(),
        backgroundColor: whiteColor,
      ),
      body: FutureBuilder(
        future: Firestoreservices.searchproducts(title),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: Loadingindicator(),
            );
          } else if (snapshot.data!.docs.isEmpty) {
            return "no product found".text.make();
          } else {
            var data = snapshot.data!.docs;
            var filtered = data
                .where(
                  (element) => element['p_name']
                      .toString()
                      .toLowerCase()
                      .contains(title!.toLowerCase()),
                )
                .toList();
            print(data[0]['p_name']);

            return GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 8,
                mainAxisExtent: 300,
                crossAxisSpacing: 8,
              ),
              itemCount: filtered.length, // Specify the number of items in the grid
              itemBuilder: (context, index) {
                var documentData = filtered[index].data() as Map<String, dynamic>;

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Image.network(
                      documentData['p_imgs'][0], // Access image URL correctly
                      width: 200,
                      height: 200,
                      fit: BoxFit.fill,
                    ),
                    const Spacer(),
                    10.heightBox,
                    "${documentData['p_name']}"
                        .text
                        .fontFamily(semibold)
                        .color(darkFontGrey)
                        .make(),
                    10.heightBox,
                    "${documentData['p_price']}"
                        .numCurrency
                        .text
                        .size(16)
                        .color(redColor)
                        .fontFamily(bold)
                        .make(),
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
                      title: "${filtered[index]['p_name']}", data: filtered[index]));
                });
              },
            );
          }
        },
      ),
    );
  }
}
