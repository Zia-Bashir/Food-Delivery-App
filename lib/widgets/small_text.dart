import 'package:flutter/material.dart';
import 'package:food_delivery_app/Utils/dimensions.dart';
import 'package:food_delivery_app/Utils/colors.dart';

class SmallText extends StatelessWidget {
  const SmallText(
      {Key? key,
      required this.text,
      this.color = AppColors.textColor,
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
      textAlign: TextAlign.justify,
      text,
      style: Theme.of(context).textTheme.caption?.copyWith(
          color: color, fontSize: size == 0 ? Dimensions.fontSize12 : size),
    );
  }
}
