import 'package:flutter/material.dart';
import 'package:food_delivery_app/Utils/dimensions.dart';
import 'package:food_delivery_app/Utils/colors.dart';

class BigText extends StatelessWidget {
  const BigText(
      {Key? key,
      required this.text,
      this.color = AppColors.mainBlackColor,
      this.overflow = TextOverflow.ellipsis,
      this.size = 0})
      : super(key: key);

  final String text;
  final Color? color;
  final TextOverflow overflow;
  final double size;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: Theme.of(context).textTheme.headline6?.copyWith(
          color: color,
          fontSize: size == 0 ? Dimensions.fontSize20 : size,
          fontWeight: FontWeight.w500,
          overflow: TextOverflow.ellipsis),
    );
  }
}
