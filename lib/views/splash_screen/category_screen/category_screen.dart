import 'package:emart_app/common_widget/bg_widget.dart';
import 'package:emart_app/consts/consts.dart';
import 'package:emart_app/consts/list.dart';
import 'package:emart_app/controller/product_controller.dart';
import 'package:emart_app/views/splash_screen/category_screen/category_detail.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Category_screen extends StatelessWidget {
  const Category_screen({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(ProductController());



    return bgWidget(
        child: Scaffold(
      appBar: AppBar(
        title: categories.text.fontFamily(bold).white.make(),
      ),
      body: Container(
        padding: EdgeInsets.all(12),
        child: GridView.builder(
          shrinkWrap: true,
          itemCount: 9,
            gridDelegate:
                SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3,mainAxisExtent: 200,crossAxisSpacing: 8,mainAxisSpacing: 8),
            itemBuilder: (context, index) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.asset(categoryimage[index],width: 200,height: 120,fit: BoxFit.cover,),
                  10.heightBox,
                  categorytext[index].text.color(darkFontGrey).align(TextAlign.center).make()
                  
                ],
              ).box.clip(Clip.antiAlias).outerShadowSm.white.make().onTap(() {
                controller.Getsubcategories(categorytext[index]);


                Get.to(()=>CategoryDetails(title: categorytext[index]));
              });
            }),
      ),
    ));
  }
}
