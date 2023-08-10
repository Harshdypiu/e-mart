import 'package:emart_app/consts/consts.dart';

Widget customTextField({String? tittle, String? hint,controller,isPass}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      tittle!.text.color(redColor).fontFamily(semibold).size(16).make(),
      5.heightBox,
      TextFormField(
        obscureText: isPass,
        controller: controller,
        
        decoration:  InputDecoration(
          hintStyle:TextStyle(
            fontFamily: semibold,
            color: textfieldGrey,
          ),
          
          hintText: hint,
          isDense: true,
          fillColor: lightGrey,
          filled: true,
          border: InputBorder.none,
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: redColor
            )
          )
        ),
      ),
      5.heightBox
      
    ],
  );
}