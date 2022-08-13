import 'package:flutter/material.dart';
import 'package:food_delivery_app/Utils/dimensions.dart';
import 'package:food_delivery_app/widgets/small_text.dart';

class IconWithText extends StatelessWidget {
  const IconWithText(
      {Key? key, required this.icon, required this.text, required this.color})
      : super(key: key);
  final IconData icon;
  final String text;
  final Color color;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          icon,
          color: color,
          size: Dimensions.size25,
        ),
        SizedBox(
          width: Dimensions.size05,
        ),
        SmallText(text: text)
      ],
    );
  }
}
