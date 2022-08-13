import 'package:flutter/material.dart';
import 'package:food_delivery_app/Utils/colors.dart';
import 'package:food_delivery_app/Utils/dimensions.dart';
import 'package:food_delivery_app/widgets/icon_with_text.dart';
import 'package:food_delivery_app/widgets/small_text.dart';

class StarsAndIcon extends StatelessWidget {
  const StarsAndIcon({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: Dimensions.size10,
        ),
        Row(
          children: [
            Wrap(
              spacing: 0.01,
              children: [
                Icon(
                  Icons.star,
                  color: AppColors.mainColor,
                  size: Dimensions.size20,
                ),
                Icon(
                  Icons.star,
                  color: AppColors.mainColor,
                  size: Dimensions.size20,
                ),
                Icon(
                  Icons.star,
                  color: AppColors.mainColor,
                  size: Dimensions.size20,
                ),
                Icon(
                  Icons.star,
                  color: AppColors.mainColor,
                  size: Dimensions.size20,
                ),
                Icon(
                  Icons.star,
                  color: AppColors.mainColor,
                  size: Dimensions.size20,
                ),
              ],
            ),
            SizedBox(
              width: Dimensions.size05,
            ),
            const SmallText(text: "4.5"),
            SizedBox(
              width: Dimensions.size10,
            ),
            const SmallText(text: "1287 comments"),
          ],
        ),
        SizedBox(
          height: Dimensions.size20,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: const [
            IconWithText(
              icon: Icons.circle,
              text: "Normal",
              color: AppColors.iconColor1,
            ),
            IconWithText(
              icon: Icons.location_pin,
              text: "1.7KM",
              color: AppColors.mainColor,
            ),
            IconWithText(
              icon: Icons.timelapse,
              text: "32min",
              color: AppColors.iconColor2,
            )
          ],
        ),
      ],
    );
  }
}
