import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emart_app/consts/consts.dart';
import 'package:emart_app/views/splash_screen/chat%20screen/chat_screen.dart';
import 'package:get/get.dart';

import '../../../common_widget/loading_indicator.dart';
import '../../../services/firestore_services.dart';

class Message_screen extends StatelessWidget {
  const Message_screen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: whiteColor,
        appBar: AppBar(
          title: "Messages".text.semiBold.color(darkFontGrey).make(),
          backgroundColor: whiteColor,
        ),
        body: StreamBuilder(
            stream: Firestoreservices.getallmessages(),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (!snapshot.hasData) {
                return Center(
                  child: Loadingindicator(),
                );
              } else if (snapshot.data!.docs.isEmpty) {
                return Center(
                  child: "No Message yet".text.make(),
                );
              } else {
                var data = snapshot.data!.docs;
                return Column(
                  children: [
                    Expanded(
                      child: ListView.builder(
                          itemCount: data.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Card(
                              child: ListTile(
                                onTap: (){
                                  Get.to(()=>ChatScreen(),
                                  arguments: [
                                    data[index]['friend_name'],
                                    data[index]['to_id']
                                  ]);
                                },
                                leading: CircleAvatar(
                                  backgroundColor: redColor,
                                  child: Icon(
                                    Icons.person,
                                    color: whiteColor,
                                  ),
                                ),
                                title: "${data[index]['friend_name']}"
                                    .text
                                    .fontFamily(semibold)
                                    .color(darkFontGrey)
                                    .make(),
                                subtitle: "${data[index]['last_msg']}"
                                    .text
                                    .fontFamily(semibold)
                                    .color(darkFontGrey)
                                    .make(),
                              ),
                            );
                          }),
                    )
                  ],
                );
              }
            }));
  }
}
