import 'package:flutter/material.dart';
import 'package:food_delivery_app/controllers/cart_controller.dart';
import 'package:food_delivery_app/controllers/popular_product_controller.dart';
import 'package:food_delivery_app/routes/routes_helper.dart';
import 'package:food_delivery_app/screens/Popular/components/star_and_icons.dart';
import 'package:food_delivery_app/utils/app_constants.dart';
import 'package:food_delivery_app/utils/colors.dart';
import 'package:food_delivery_app/utils/dimensions.dart';
import 'package:food_delivery_app/widgets/big_text.dart';
import 'package:food_delivery_app/widgets/extendable_text.dart';
import 'package:food_delivery_app/widgets/icon_with_container.dart';
import 'package:get/get.dart';

// ignore: must_be_immutable
class PopularFoodScreen extends StatelessWidget {
  final int pageId;
  final String screen;
  const PopularFoodScreen({
    Key? key,
    required this.pageId,
    required this.screen,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var product =
        Get.find<PopularProductController>().popularProductList[pageId];
    Get.find<PopularProductController>()
        .inItProduct(product, Get.find<CartController>());
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
                        // controller.totalItems >= 1?
                        Get.toNamed(RoutesHelper.getCartScreen());
                        // : Get.snackbar(
                        //     "Cart Empty",
                        //     "Your cart is empty!",
                        //     icon: Image.asset(
                        //       "assets/images/empty-cart.png",
                        //       height: 30,
                        //     ),
                        //     backgroundColor: AppColors.mainColor,
                        //     colorText: Colors.white,
                        //   );
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

          //Food Info and Detail
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              padding: EdgeInsets.only(
                  top: Dimensions.size30,
                  left: Dimensions.size20,
                  right: Dimensions.size20,
                  bottom: Dimensions.foodDetailsPaddingContainer),
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
                  //?food info text
                  BigText(text: product.name!),

                  const StarsAndIcon(),
                  //Extendable Text Widget
                  SizedBox(
                    height: Dimensions.size20,
                  ),
                  const BigText(text: "Intoduction"),
                  SizedBox(
                    height: Dimensions.size10,
                  ),
                  ExtendableText(
                    text: product.description!,
                  )
                ],
              ),
            ),
          ),
          //Cart Container
          //TODO  We should add here bottom navigation
          Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: GetBuilder<PopularProductController>(
                  builder: (popularProduct) {
                return Container(
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
                      // Add Sub Container
                      Container(
                        width: Dimensions.addSubContainer,
                        margin: EdgeInsets.only(left: Dimensions.size20),
                        padding: EdgeInsets.all(Dimensions.size20),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius:
                              BorderRadius.circular(Dimensions.size20),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            GestureDetector(
                              onTap: () {
                                popularProduct.setQuantity(false);
                              },
                              child: const Icon(
                                Icons.remove,
                                color: Color.fromARGB(255, 197, 195, 195),
                              ),
                            ),
                            BigText(
                                text: popularProduct.inCartItems.toString()),
                            GestureDetector(
                              onTap: () {
                                popularProduct.setQuantity(true);
                              },
                              child: const Icon(
                                Icons.add,
                                color: Color.fromARGB(255, 197, 195, 195),
                              ),
                            ),
                          ],
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          popularProduct.addItems(product);
                          Get.snackbar("Item Added",
                              "Your items are added successfully in the cart!",
                              backgroundColor: AppColors.mainColor,
                              colorText: Colors.white,
                              duration: const Duration(seconds: 1),
                              animationDuration: const Duration(seconds: 1));
                        },
                        child: Container(
                          width: Dimensions.addToCartContainer,
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
                                text: "\$${product.price!.toString()}",
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
                );
              })),
        ],
      ),
    );
  }
}
