import 'package:flutter/material.dart';
import 'package:food_delivery_app/Utils/dimensions.dart';

class IconWithContainer extends StatelessWidget {
  const IconWithContainer({
    Key? key,
    required this.icon,
    this.iconColor = Colors.black,
    this.backgroundColor = Colors.white54,
    this.size = 0,
    this.bgSize = 0,
  }) : super(key: key);

  final IconData icon;
  final Color iconColor;
  final Color backgroundColor;
  final double size;
  final double bgSize;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: bgSize == 0 ? Dimensions.size30 : bgSize,
      width: bgSize == 0 ? Dimensions.size30 : bgSize,
      decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(Dimensions.size30)),
      child: Icon(
        icon,
        size: size == 0 ? Dimensions.size20 : size,
        color: iconColor,
      ),
    );
  }
}
