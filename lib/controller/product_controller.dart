// ignore_for_file: non_constant_identifier_names, unused_import

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emart_app/consts/consts.dart';
import 'package:emart_app/models/category_model.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class ProductController extends GetxController {
  var subcat = [];
  var quantity = 0.obs;
  var colorIndex = 0.obs;
  var totalprice = 0.obs;
  var isfav=false.obs;

  Getsubcategories(title) async {
    subcat.clear();
    var data = await rootBundle.loadString("lib/services/category_model.json");
    var decoded = categoryModelFromJson(data);
    var s =
        decoded.categories.where((element) => element.name == title).toList();

    for (var e in s[0].subcategories) {
      subcat.add(e);
    }
  }

  ChangecolorIndex(index) {
    colorIndex.value = index;
  }

  increasequantity(totalquantity) {
    if (totalquantity > quantity.value) {
      quantity.value++;
    }
  }

  decreasequantity() {
    if (quantity.value > 0) {
      quantity.value--;
    }
  }

  calculateTotalPrice(price) {
    totalprice.value = price * quantity.value;
  }

  addTocart({title, img, sellername, color, qty, tprice, context,vendor_id}) async {
    await firestore.collection(cartCollection).doc().set({
      'title': title,
      'image': img,
      'sellername': sellername,
      'color': color,
      'quantity': qty,
      'total price': tprice,
      'added by': currentUser!.uid,
      'vendor_id':vendor_id
    }).catchError((error) {
      VxToast.show(context, msg: error.toString());
    });
  }

  resetValue() {
    totalprice.value = 0;
    quantity.value = 0;
    colorIndex.value = 0;
  }

// get cart value

  addtowishlist(docid,context) async {
    await firestore.collection(productCollection).doc(docid).set({
      'p_wishlist': FieldValue.arrayUnion([currentUser!.uid])
    }, SetOptions(merge: true));
    isfav(true);
    VxToast.show(context, msg: "added to wishlist");
  }

  removetowishlist(docid,context) async {
    await firestore.collection(productCollection).doc(docid).set({
      'p_wishlist': FieldValue.arrayRemove([currentUser!.uid])
    }, SetOptions(merge: true));
    isfav(false);
     VxToast.show(context, msg: "removed from  wishlist");
  }

  CheckSIsFav(data) async{
    if (data['p_wishlist'].contains(currentUser!.uid)){
      isfav(true);
    }else{
      isfav(false);
    }
  }
}
