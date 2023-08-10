import 'package:emart_app/consts/consts.dart';

Widget Detail_button({String ?count,width,String ?title}){
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      count!.text.color(darkFontGrey).fontFamily(bold).size(16).make(),
      5.heightBox,
      title!.text.color(darkFontGrey).make()
    ],
  ).box.white.rounded.height(80).width(width).padding(const EdgeInsets.all(4)).make();
}