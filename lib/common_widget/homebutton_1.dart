import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class CustomButton extends StatelessWidget {
  final dynamic icon;
  final double height;
  final double width;
  final dynamic title;
  final void Function()? onPressed;

  const CustomButton({
    required this.icon,
    required this.height,
    required this.width,
    required this.title,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return VxBox(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            size: 26.0,
          ),
          5.widthBox,
          title is String
              ? title.toString().text
                  .fontFamily('semibold')
                  .color(Colors.grey[700]!)
                  .make()
              : title,
        ],
      ),
    )
        .width(width)
        .height(height)
        .rounded
        .white
        .make()
        .onTap(onPressed);
  }
}
