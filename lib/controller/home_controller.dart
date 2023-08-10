import 'package:emart_app/consts/consts.dart';
import 'package:get/get.dart';

import '../consts/firebase_const.dart';

class HomeController extends GetxController{
  @override
  void onInit() {
    // TODO: implement onInit
    getUserName();
    super.onInit();
  }
  
  
  var currentnavindex=0.obs;

  var username='';
  var searchcontroller=TextEditingController();

  getUserName() async{
    var n = await firestore.collection(userCollection).where('id', isEqualTo: currentUser!.uid).get().then((value) {
      if(value.docs.isNotEmpty){
        return value.docs.single['name'];
      }
    });
    username = n;
   

  }
}