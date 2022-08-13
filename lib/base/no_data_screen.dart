import 'package:flutter/material.dart';
import 'package:food_delivery_app/utils/dimensions.dart';

class NoDataScreen extends StatelessWidget {
  const NoDataScreen(
      {Key? key,
      required this.text,
      this.imgPath = "assets/images/empty_cart.png"})
      : super(key: key);
  final String text;
  final String imgPath;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          imgPath,
          height: size.height * 0.22,
          width: size.width * 0.22,
        ),
        SizedBox(
          height: Dimensions.size10,
        ),
        Text(
          text,
          style: TextStyle(
              color: Theme.of(context).disabledColor,
              fontSize: Dimensions.fontSize12),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
