// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emart_app/consts/consts.dart';
import 'package:emart_app/views/splash_screen/order_screen/order_detail.dart';
import 'package:get/get.dart';

import '../../../common_widget/loading_indicator.dart';
import '../../../services/firestore_services.dart';

class Orderscreen extends StatelessWidget {
  const Orderscreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      backgroundColor: whiteColor,
      appBar:AppBar(
        title: "My Orders".text.semiBold.color(darkFontGrey).make(),
        backgroundColor: whiteColor,

      ),
      body: StreamBuilder(
        stream: Firestoreservices.getallorders(),
        builder: (BuildContext context, AsyncSnapshot <QuerySnapshot> snapshot) {
             if(!snapshot.hasData){
            return Center(
              child: Loadingindicator(),
            );
             }else if(snapshot.data!.docs.isEmpty){
               return Center(
              child: "no order yet".text.make(),
            );

             }else{
              var data = snapshot.data!.docs;

              return ListView.builder(
                itemCount: data.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: "${index+1}".text.color(darkFontGrey).xl3.make(),
                    title: data[index]['order code'].toString().text.color(redColor).make(),
                    subtitle:data[index]['total amount'].toString().numCurrency.text.bold.make() ,
                    trailing: IconButton(onPressed: (){
                      Get.to(()=>Order_Details(data: data[index],));
                    }, icon: Icon(Icons.arrow_forward_ios_rounded,color: redColor,)),

                  );
                  
                },);
             }

        } )
    );
  }
}