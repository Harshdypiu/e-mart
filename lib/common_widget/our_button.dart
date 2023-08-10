import 'package:emart_app/consts/consts.dart';

Widget ourButton({onPress, color, textcolor,String?title}){
  
  return ElevatedButton(onPressed: onPress,
  style: ElevatedButton.styleFrom(
    primary: color,
    padding: const EdgeInsets.all(12)
  ),
   child: title?.text.color(textcolor).fontFamily(bold).make());
}