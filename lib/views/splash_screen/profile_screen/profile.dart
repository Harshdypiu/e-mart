// ignore_for_file: unused_import, unused_local_variable, prefer_const_constructors


import 'package:collection/collection.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emart_app/common_widget/bg_widget.dart';
import 'package:emart_app/common_widget/loading_indicator.dart';
import 'package:emart_app/consts/consts.dart';
import 'package:emart_app/consts/list.dart';
import 'package:emart_app/controller/authcontroller.dart';
import 'package:emart_app/controller/profile_controller.dart';
import 'package:emart_app/services/firestore_services.dart';
import 'package:emart_app/views/splash_screen/auth_screen/login_screen.dart';
import 'package:emart_app/views/splash_screen/chat%20screen/messaging_screen.dart';
import 'package:emart_app/views/splash_screen/order_screen/order_screen.dart';
import 'package:emart_app/views/splash_screen/profile_screen/component/detailbutton.dart';
import 'package:emart_app/views/splash_screen/profile_screen/profile_screen_edit.dart';
import 'package:emart_app/views/splash_screen/wishlist_screen.dart/wishlist_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfileSection extends StatelessWidget {
  const ProfileSection({Key? key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(Profliecontroller());
    Firestoreservices.getcounts();
    return bgWidget(
      child: Scaffold(
        body: StreamBuilder(
          stream: Firestoreservices.getUser(currentUser!.uid),
          builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) {
              return const Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation(redColor),
                ),
              );
            } 

            
            else {
              // var data = snapshot.data!.docs[0];
              // var data_1=data.data();
              var data = snapshot.data!.docs[0];


              return SafeArea(
                child: Container(
                  padding: const EdgeInsets.all(8),
                  child: Column(
                    children: [
                      Align(
                        alignment: Alignment.topRight,
                        child: Icon(Icons.edit, color: whiteColor),
                      ).onTap(() {
                        controller.namecontroller.text=data['name'];
                       ;




                        Get.to(() => Editprofilescreen(data:data,));
                      }),
                      Row(
                        children: [

                          data['imageurl']==''?




                          Image.asset(
                            imgProfile,
                            width: 100,
                            fit: BoxFit.cover,
                          )
                              .box
                              .roundedFull
                              .clip(Clip.antiAlias)
                              .make():Image.network(data['imageurl'],width: 100,fit:BoxFit.cover).box
                              .roundedFull
                              .clip(Clip.antiAlias)
                              .make(),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  data['name'] ?? 'N/A',
                                  // 'name',
                                  style: TextStyle(fontFamily: semibold, color: whiteColor),
                                ),
                                const SizedBox(height: 5),
                                Text(
                                  data['email'],
                                  style: TextStyle(color: whiteColor),
                                ),
                              ],
                            ),
                          ),
                          OutlinedButton(
                            style: OutlinedButton.styleFrom(
                              side: BorderSide(color: whiteColor),
                            ),
                            onPressed: () async {
                              await Get.put(AuthController()).signout(context: context);
                              Get.offAll(() => const LoginScreen());
                            },
                            child: Text(
                              'log out',
                              style: TextStyle(fontFamily: semibold, color: whiteColor),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      FutureBuilder(
                        future: Firestoreservices.getcounts(),builder:(context,AsyncSnapshot snapshot) {
                          if (!snapshot.hasData) {
                            return Loadingindicator();
                            
                          } else {
                            var countdata=snapshot.data;
                            
                          
                          return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Detail_button(
                            width: context.screenWidth / 3.4,
                            count: countdata[0].toString(),
                            title: 'in your cart',
                          ),
                          Detail_button(
                            width: context.screenWidth / 3.4,
                            count: countdata[1].toString(),
                            title: 'wishlist',
                          ),
                          Detail_button(
                            width: context.screenWidth / 3.4,
                            count: countdata[2].toString(),
                            title: 'order',
                          ),
                        ],
                      );}
                          
                        },),
                      
                      const SizedBox(height: 40),
                      ListView.separated(
                        itemCount: profilebutton.length,
                        shrinkWrap: true,
                        itemBuilder: (BuildContext context, int index) {
                          return ListTile(
                            onTap: (){
                              switch (index) {
                                case 0:
                                Get.to(()=>Orderscreen()); 
                                  break;
                                  case 1:
                                  Get.to(()=>Message_screen()); 
                                  break;
                                  case 2:
                                  Get.to(()=>Wishlist_screen()); 
                                  break;

                                default:
                              }
                            },
                            leading: Image.asset(profilebuttonimage[index], width: 22),
                            title: Text(profilebutton[index]),
                          );
                        },
                        separatorBuilder: (context, index) {
                          return const Divider(
                            color: lightGrey,
                          );
                        },
                      )
                          .box
                          .rounded
                          .white
                          .padding(const EdgeInsets.symmetric(horizontal: 16))
                          .margin(EdgeInsets.all(12))
                          .shadowSm
                          .make(),
                    ],
                  ),
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
