import 'package:emart_app/consts/consts.dart';


Widget Homebutton({width,height,icon,String ?title,onpress}) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          icon,
          width: 26,
        ),
        5.heightBox,
        title!.text.fontFamily(semibold).color(darkFontGrey).make()
      ],
    ).box.rounded.size(width, height).white.make();
}
