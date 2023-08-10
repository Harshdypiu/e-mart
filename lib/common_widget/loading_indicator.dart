import 'package:emart_app/consts/consts.dart';

Widget Loadingindicator(){
  return const CircularProgressIndicator(
    valueColor: AlwaysStoppedAnimation(redColor),
  );
}