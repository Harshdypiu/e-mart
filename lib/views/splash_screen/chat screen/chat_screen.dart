// ignore_for_file: unused_import, prefer_const_constructors, unused_local_variable

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emart_app/consts/consts.dart';
import 'package:emart_app/controller/chat_controller.dart';
import 'package:emart_app/views/splash_screen/chat%20screen/component/sender_bubble.dart';
import 'package:get/get.dart';

import '../../../common_widget/loading_indicator.dart';
import '../../../services/firestore_services.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(ChatController());

    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        title: "${controller.friend_name}".text.color(darkFontGrey).semiBold.make(),
      ),
      body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Obx(
                () => controller.isloading.value
                    ? Center(
                        child: Loadingindicator(),
                      )
                    : Expanded(
                        child: StreamBuilder(
  stream: Firestoreservices.getchatmsg(controller.chatdocid.toString()),
  builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
    
    if (!snapshot.hasData) {
      return Center(
        child: Loadingindicator(),
      );
    } else if (snapshot.data!.docs.isEmpty) {
      return Center(
        child: "send a message".text.color(darkFontGrey).make(),
      );
    } else {
      return ListView(
        children: snapshot.data!.docs.map((data) {
          return Align(
            alignment: data['uid']==currentUser!.uid?Alignment.centerRight:Alignment.centerLeft,
            child: senderBubble(data),
          )
          ;
        }).toList(),
      );
    }
  },
),),
              ),
              10.heightBox,
              Row(
                children: [
                  Expanded(
                      child: TextFormField(
                    controller: controller.msgcontroller,
                    decoration: InputDecoration(
                      hintText: "type as message",
                      border: OutlineInputBorder(
                          borderSide: BorderSide(color: textfieldGrey)),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: textfieldGrey)),
                    ),
                  )),
                  IconButton(
                      onPressed: () {
                        controller.sendmessage(controller.msgcontroller.text);
                        controller.msgcontroller.clear();
                      },
                      icon: Icon(
                        Icons.send,
                        color: redColor,
                      ))
                ],
              )
                  .box
                  .height(80)
                  .padding(EdgeInsets.all(12))
                  .margin(EdgeInsets.only(bottom: 8.0))
                  .make()
            ],
          )),
    );
  }
}
