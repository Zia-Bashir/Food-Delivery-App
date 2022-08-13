import 'package:flutter/material.dart';
import 'package:food_delivery_app/Utils/colors.dart';
import 'package:food_delivery_app/Utils/dimensions.dart';
import 'package:food_delivery_app/widgets/big_text.dart';
import 'package:food_delivery_app/widgets/small_text.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 20, bottom: 10),
      margin: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            // crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const BigText(
                text: "Pakistan",
                color: AppColors.mainColor,
              ),
              Row(
                children: [
                  const SmallText(
                    text: "Okara",
                    color: Colors.black54,
                  ),
                  SizedBox(
                    width: Dimensions.size05,
                  ),
                  const Icon(Icons.arrow_drop_down_rounded),
                ],
              ),
            ],
          ),
          Container(
            height: Dimensions.iconContainerSize30,
            width: Dimensions.iconContainerSize30,
            decoration: const BoxDecoration(
              color: AppColors.mainColor,
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.search,
              color: Colors.white,
              size: Dimensions.size25,
            ),
          ),
        ],
      ),
    );
  }
}
