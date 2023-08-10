import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emart_app/consts/consts.dart';
import 'package:emart_app/controller/home_controller.dart';
import 'package:get/get.dart';

class ChatController extends GetxController {
  @override
  void onInit() {
    // TODO: implement onInit
    getchatid();
    super.onInit();
  }
  var chats = firestore.collection(chatcollection);
  var friend_name = Get.arguments[0];
  var friend_id = Get.arguments[1];
  var sender_name = Get.find<HomeController>().username;
  var currentId = currentUser!.uid;
  var msgcontroller = TextEditingController();
  dynamic chatdocid;
  var isloading = false.obs;
  getchatid() async{
    isloading(true);
    await chats.where('users',isEqualTo: {
      friend_id:null,
      currentId:null

    }).limit(1).get().then((QuerySnapshot snapshot) {
      if(snapshot.docs.isNotEmpty){
        chatdocid=snapshot.docs.single.id;
      }else{
        chats.add({
          'created_on':null,
          'last_msg':'',
          'users':{friend_id:null,currentId:null},
          'to_id':'',
          'from_id':'',
          'friend_name':friend_name,
          'sender_name':sender_name
        }).then((value) {
          {
            chatdocid=value.id;
          }
        });
      }
    });
    isloading(false);

  

  }

  sendmessage(String msg ) async {
    if (msg.trim().isNotEmpty) {
      chats.doc(chatdocid).update({
        'created_on':FieldValue.serverTimestamp(),
        'last_msg':msg,
        'to_id':friend_id,
        'from_id':currentId,
      });

    chats.doc(chatdocid).collection(messagecollection).doc().set({
      'created_on':FieldValue.serverTimestamp(),
      'msg':msg,
      'uid':currentId


    });
      
    }

  }



  
}