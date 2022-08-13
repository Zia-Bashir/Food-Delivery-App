import 'package:flutter/material.dart';
import 'package:food_delivery_app/Utils/dimensions.dart';
import 'package:food_delivery_app/widgets/big_text.dart';
import 'package:food_delivery_app/widgets/small_text.dart';

class RecommendedText extends StatelessWidget {
  const RecommendedText({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
          top: Dimensions.size30,
          left: Dimensions.size20,
          right: Dimensions.size20,
          bottom: Dimensions.size30),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          const BigText(
            text: "Recommended",
          ),
          SizedBox(
            width: Dimensions.size05,
          ),
          Container(
            padding: EdgeInsets.only(bottom: Dimensions.dotTextSize03),
            child: const BigText(
              text: ".",
              color: Colors.black26,
            ),
          ),
          SizedBox(
            width: Dimensions.size10,
          ),
          Container(
            padding: EdgeInsets.only(bottom: Dimensions.dotTextSize03),
            child: const SmallText(text: "Food Pairing"),
          ),
        ],
      ),
    );
  }
}
