import 'package:flutter/material.dart';
import 'package:food_delivery_app/controllers/cart_controller.dart';
import 'package:food_delivery_app/controllers/popular_product_controller.dart';
import 'package:food_delivery_app/controllers/recommended_product_controller.dart';
import 'package:food_delivery_app/routes/routes_helper.dart';
import 'package:food_delivery_app/utils/app_constants.dart';
import 'package:food_delivery_app/utils/colors.dart';
import 'package:food_delivery_app/utils/dimensions.dart';
import 'package:food_delivery_app/widgets/big_text.dart';
import 'package:food_delivery_app/widgets/extendable_text.dart';
import 'package:food_delivery_app/widgets/icon_with_container.dart';
import 'package:get/get.dart';

class RecommendedFoodScreen extends StatelessWidget {
  const RecommendedFoodScreen(
      {Key? key, required this.pageId, required this.screen})
      : super(key: key);
  final int pageId;
  final String screen;

  @override
  Widget build(BuildContext context) {
    var product =
        Get.find<RecommendedProductController>().recommendedProductList[pageId];
    Get.find<PopularProductController>()
        .inItProduct(product, Get.find<CartController>());
    //print("image is " + product.img);
    return Scaffold(
      body: Stack(
        children: [
          //Image Container
          Container(
            height: Dimensions.recommendedFoodImageContainer,
            decoration: BoxDecoration(
              color: AppColors.iconColor2,
              image: DecorationImage(
                image: NetworkImage(AppConstant.BASE_APP_URL +
                    AppConstant.UPLOAD_URL +
                    product.img!),
                fit: BoxFit.cover,
              ),
            ),
            child: Padding(
              padding: EdgeInsets.only(
                  top: Dimensions.recommendedIconSpace,
                  left: Dimensions.size20,
                  right: Dimensions.size20),

              //Icons Row
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      if (screen == "cartscreen") {
                        Get.toNamed(RoutesHelper.getCartScreen());
                      } else {
                        Get.toNamed(RoutesHelper.getInitial());
                      }
                    },
                    child: const IconWithContainer(
                        icon: Icons.arrow_back_ios_new_rounded),
                  ),
                  GetBuilder<PopularProductController>(builder: (controller) {
                    return GestureDetector(
                      onTap: () {
                        Get.toNamed(RoutesHelper.getCartScreen());
                      },
                      child: Stack(
                        children: [
                          const IconWithContainer(
                              icon: Icons.shopping_cart_outlined),
                          controller.totalItems >= 1
                              ? Positioned(
                                  top: 0,
                                  right: 0,
                                  child: Container(
                                    //height: Dimensions.size10,
                                    padding: const EdgeInsets.all(3),
                                    decoration: const BoxDecoration(
                                        color: AppColors.mainColor,
                                        shape: BoxShape.circle),
                                    child: Center(
                                      child: BigText(
                                        text: controller.totalItems.toString(),
                                        size: Dimensions.size10,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                )
                              : Container(),
                        ],
                      ),
                    );
                  })
                ],
              ),
            ),
          ),

          //Food Detail
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              padding: EdgeInsets.only(
                  top: Dimensions.size30,
                  left: Dimensions.size20,
                  right: Dimensions.size20,
                  bottom: (Dimensions.foodDetailsPaddingContainer * 2) -
                      Dimensions.size30),
              height: Dimensions.foodDetailsContainer,
              width: double.maxFinite,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(Dimensions.size30),
                  topLeft: Radius.circular(Dimensions.size30),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //food info text
                  Center(child: BigText(text: product.name!)),
                  //Extendable Text Widget
                  SizedBox(
                    height: Dimensions.size20,
                  ),
                  ExtendableText(
                    text: product.description!,
                  ),
                ],
              ),
            ),
          ),

          //Add Remove Container

          GetBuilder<PopularProductController>(builder: (controller) {
            return Positioned(
              left: 0,
              right: 0,
              bottom: Dimensions.mainCartContainer,
              child: Container(
                //color: Colors.grey,
                padding: EdgeInsets.symmetric(
                    horizontal: Dimensions.size50, vertical: Dimensions.size20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () {
                        controller.setQuantity(false);
                      },
                      child: IconWithContainer(
                        icon: Icons.remove,
                        size: Dimensions.size30,
                        bgSize: Dimensions.size50,
                        iconColor: Colors.white,
                        backgroundColor: AppColors.mainColor,
                      ),
                    ),
                    Row(
                      children: [
                        BigText(
                          text: "\$${product.price.toString()}",
                          size: Dimensions.size30,
                        ),
                        SizedBox(
                          width: Dimensions.size15,
                        ),
                        BigText(
                          text: "X",
                          size: Dimensions.size30,
                        ),
                        SizedBox(
                          width: Dimensions.size05,
                        ),
                        BigText(
                          text: controller.inCartItems.toString(),
                          size: Dimensions.size30,
                        ),
                      ],
                    ),
                    GestureDetector(
                      onTap: () {
                        controller.setQuantity(true);
                      },
                      child: IconWithContainer(
                        icon: Icons.add,
                        size: Dimensions.size30,
                        bgSize: Dimensions.size50,
                        iconColor: Colors.white,
                        backgroundColor: AppColors.mainColor,
                      ),
                    ),
                  ],
                ),
              ),
            );
          }),

          //*Add to Cart Container
          GetBuilder<PopularProductController>(builder: (controller) {
            return Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                height: Dimensions.mainCartContainer,
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 236, 236, 236),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(Dimensions.size30),
                    topRight: Radius.circular(Dimensions.size30),
                  ),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Favourite Icon Container
                    Container(
                      margin: EdgeInsets.only(left: Dimensions.size20),
                      padding: EdgeInsets.all(Dimensions.size20),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(Dimensions.size20),
                      ),
                      child: Icon(Icons.favorite,
                          color: AppColors.mainColor, size: Dimensions.size30),
                    ),

                    // Add to Cart Container
                    GestureDetector(
                      onTap: () {
                        controller.addItems(product);
                        Get.snackbar(
                          "Item Added",
                          "Your items are added successfully in the cart!",
                          backgroundColor: AppColors.mainColor,
                          colorText: Colors.white,
                          duration: const Duration(seconds: 1),
                          animationDuration: const Duration(seconds: 1),
                        );
                      },
                      child: Container(
                        width: 260,
                        margin: EdgeInsets.only(right: Dimensions.size20),
                        padding: EdgeInsets.all(Dimensions.size20),
                        decoration: BoxDecoration(
                          color: AppColors.mainColor,
                          borderRadius:
                              BorderRadius.circular(Dimensions.size20),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            BigText(
                              text: "\$${product.price.toString()}",
                              color: Colors.white,
                            ),
                            const BigText(
                              text: "|",
                              color: Colors.white,
                            ),
                            const BigText(
                              text: "Add to cart",
                              color: Colors.white,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          })
        ],
      ),
    );
  }
}
