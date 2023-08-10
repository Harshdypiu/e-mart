// ignore_for_file: unused_import, equal_keys_in_map

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emart_app/consts/consts.dart';
import 'package:emart_app/controller/home_controller.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class cartcontroller extends GetxController {
  var totalP = 0.obs;
  var addresscontroller = TextEditingController();
  var citycontroller = TextEditingController();
  var phonecontroller = TextEditingController();
  var postalcodecontroller = TextEditingController();
  var statecontroller = TextEditingController();

  var paymentindex = 0.obs;

  var placingorders=false.obs;

  late dynamic productsnapshot;
  var data = [];

  calculate(data) {
    totalP.value = 0;
    for (var i = 0; i < data.length; i++) {
      totalP.value =
          totalP.value + int.parse(data[i]['total price'].toString());
    }
  }

  changepaymentindex(index) {
    paymentindex.value = index;
  }

  placemyorder({required orderPaymentMethod,required totalamount}) async {
    placingorders(true);
    await getproductdetails();
    await firestore.collection(ordercollection).doc().set({
      'order date':FieldValue.serverTimestamp(),
      'order code':'202265879',
      'order_by': currentUser!.uid,
      'order_by_name': Get.find<HomeController>().username,
      'order_by_email': currentUser!.email,
      'order_by_address': addresscontroller.text,
      'order_by_state': statecontroller.text,
      'order_by_city': citycontroller.text,
      'order_by_phone': phonecontroller.text,
      'order_by_postalcode': postalcodecontroller.text,
      'shipping method': 'home delivery',
      'payment method': orderPaymentMethod,
      'order placed': true,
      'order confirmed':false,
      'order placed':false,
      'order on  delivery':false,
      'total amount': totalamount,
      'orders':FieldValue.arrayUnion(data)
    });
    placingorders(false);
  }

  getproductdetails() async {
    // data.clear();
    for (var i = 0; i < productsnapshot.length; i++) {
      data.add({
        'color': productsnapshot[i]['color'],
        'img': productsnapshot[i]['image'],
        'qty': productsnapshot[i]['quantity'],
        'tprice':productsnapshot[i]['total price'],
        'title': productsnapshot[i]['title'],
        'vendor_id':productsnapshot[i]['vendor_id']
      });
    }
    print(data);
  }

  clearcart() {
    for (var i = 0; i < productsnapshot.length; i++) {
      firestore.collection(cartCollection).doc(productsnapshot[i].id).delete();
      
    }

  }
}
