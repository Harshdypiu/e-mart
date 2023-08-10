import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emart_app/consts/consts.dart';

import '../../../common_widget/loading_indicator.dart';
import '../../../services/firestore_services.dart';

class Wishlist_screen extends StatelessWidget {
  const Wishlist_screen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        title: "My Wishlist".text.semiBold.color(darkFontGrey).make(),
        backgroundColor: whiteColor,
      ),
      body: StreamBuilder(
        stream: Firestoreservices.getwishlist(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: Loadingindicator(),
            );
          } else if (snapshot.data!.docs.isEmpty) {
            return Center(
              child: "no wishlist yet".text.make(),
            );
          } else {
            var data = snapshot.data!.docs;
            return ListView.builder(
              itemCount: data.length,
              itemBuilder: (BuildContext context, index) {
                return ListTile(
                  leading: Image.network(
                    "${data[index]['p_imgs'][0]}",
                    width: 80,
                    height: 80,
                    fit: BoxFit.cover,
                  ),
                  title: "${data[index]['p_name']}"
                      .text
                      .size(16)
                      .fontFamily(semibold)
                      .make(),
                  subtitle: "${data[index]['p_price']}"
                      .text
                      .color(redColor)
                      .semiBold
                      .make(),
                  trailing: Icon(
                    Icons.favorite,
                    color: redColor,
                  ).onTap(() async {
                    await firestore.collection(productCollection).doc(data[index].id).set({'p_wishlist':FieldValue.arrayRemove([currentUser!.uid])},SetOptions(merge: true));
                    // Handle favorite icon tap event.
                  }),
                );
              },
            );
          }
        },
      ),
    );
  }
}
