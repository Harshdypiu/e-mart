// ignore_for_file: unused_import

import 'package:emart_app/consts/consts.dart';

Widget OrderStatus({icon,color,title,showdone}){
  return ListTile(
    leading: Icon(
      icon,
      color: color,

    ).box.border(color: color).roundedSM.padding(EdgeInsets.all(4)).make(),
    trailing:  SizedBox(
      height:100 ,
      width: 120,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            "$title".text.make(),
            showdone?  Icon(Icons.done,
            color: redColor,):Container()
          ],
        ),
    ),
    
  );
}