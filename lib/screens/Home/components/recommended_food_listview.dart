import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:food_delivery_app/controllers/recommended_product_controller.dart';
import 'package:food_delivery_app/routes/routes_helper.dart';
import 'package:food_delivery_app/utils/app_constants.dart';
import 'package:food_delivery_app/utils/colors.dart';
import 'package:food_delivery_app/utils/dimensions.dart';
import 'package:food_delivery_app/widgets/big_text.dart';
import 'package:food_delivery_app/widgets/icon_with_text.dart';
import 'package:food_delivery_app/widgets/small_text.dart';
import 'package:get/get.dart';

class RecommendedFoodListView extends StatelessWidget {
  const RecommendedFoodListView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //Mian Container
    return GetBuilder<RecommendedProductController>(
        builder: (recommendedProduct) {
      return recommendedProduct.isLoaded
          ? ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: recommendedProduct.recommendedProductList.length,
              itemBuilder: (
                context,
                index,
              ) {
                return GestureDetector(
                  onTap: () {
                    Get.toNamed(RoutesHelper.getRecommendedFood(index, "home"));
                  },
                  child: Row(
                    children: [
                      //Image Container
                      Container(
                        margin: EdgeInsets.only(bottom: Dimensions.size15),
                        height: Dimensions.popularImageContainer,
                        width: Dimensions.popularImageContainer,
                        decoration: BoxDecoration(
                          color: AppColors.mainColor,
                          borderRadius:
                              BorderRadius.circular(Dimensions.size20),
                          image: DecorationImage(
                            // ignore: prefer_interpolation_to_compose_strings
                            image: NetworkImage(AppConstant.BASE_APP_URL +
                                "/uploads/" +
                                recommendedProduct
                                    .recommendedProductList[index].img!),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),

                      //Details Container
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.all(Dimensions.size10),
                          margin: EdgeInsets.only(bottom: Dimensions.size10),
                          height: Dimensions.popularDetailsContainer,
                          // width: double.infinity,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                              topRight: Radius.circular(Dimensions.size30),
                              bottomRight: Radius.circular(Dimensions.size30),
                            ),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              BigText(
                                  text: recommendedProduct
                                      .recommendedProductList[index].name!),
                              SizedBox(
                                height: Dimensions.size05,
                              ),
                              const SmallText(
                                  text: "With chinese characteristics"),
                              SizedBox(
                                height: Dimensions.size10,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
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
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            )
          : Container(
              margin: EdgeInsets.symmetric(vertical: Dimensions.size50),
              child: SpinKitFadingCircle(
                itemBuilder: (BuildContext context, int index) {
                  return const DecoratedBox(
                    decoration: BoxDecoration(color: AppColors.mainColor),
                  );
                },
              ),
            );
    });
  }
}
