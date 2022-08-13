import 'package:flutter/material.dart';
import 'package:food_delivery_app/base/no_data_screen.dart';
import 'package:food_delivery_app/controllers/cart_controller.dart';
import 'package:food_delivery_app/controllers/popular_product_controller.dart';
import 'package:food_delivery_app/controllers/recommended_product_controller.dart';
import 'package:food_delivery_app/routes/routes_helper.dart';
import 'package:food_delivery_app/utils/app_constants.dart';
import 'package:food_delivery_app/utils/colors.dart';
import 'package:food_delivery_app/utils/dimensions.dart';
import 'package:food_delivery_app/widgets/big_text.dart';
import 'package:food_delivery_app/widgets/icon_with_container.dart';
import 'package:food_delivery_app/widgets/small_text.dart';
import 'package:get/get.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Stack(
          children: [
            //* Icons
            Positioned(
              top: 0,
              right: 0,
              left: 0,
              child: Container(
                margin: EdgeInsets.only(
                  left: Dimensions.size20,
                  right: Dimensions.size20,
                  top: Dimensions.size10,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () {},
                      child: IconWithContainer(
                        icon: Icons.arrow_back_ios_new_rounded,
                        backgroundColor: AppColors.mainColor,
                        iconColor: Colors.white,
                        bgSize: Dimensions.size40,
                        size: Dimensions.size25,
                      ),
                    ),
                    Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            Get.toNamed(RoutesHelper.getInitial());
                          },
                          child: IconWithContainer(
                            icon: Icons.home_outlined,
                            backgroundColor: AppColors.mainColor,
                            iconColor: Colors.white,
                            bgSize: Dimensions.size40,
                            size: Dimensions.size25,
                          ),
                        ),
                        SizedBox(
                          width: Dimensions.size30,
                        ),
                        IconWithContainer(
                          icon: Icons.shopping_cart_outlined,
                          backgroundColor: AppColors.mainColor,
                          iconColor: Colors.white,
                          bgSize: Dimensions.size40,
                          size: Dimensions.size20,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            //* Cart Food List
            GetBuilder<CartController>(builder: (cartController) {
              return cartController.cartList.isNotEmpty
                  ? Positioned(
                      top: Dimensions.size20 * 4,
                      left: Dimensions.size20,
                      right: Dimensions.size20,
                      bottom: 0,
                      child: SingleChildScrollView(
                        child: Container(
                          margin: EdgeInsets.only(bottom: Dimensions.size10),
                          child: MediaQuery.removePadding(
                            context: context,
                            removeTop: true,
                            child: ListView.builder(
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: cartController.cartList.length,
                              itemBuilder: (
                                context,
                                index,
                              ) {
                                return Row(
                                  children: [
                                    //*Image Container
                                    GestureDetector(
                                      onTap: () {
                                        var popularIndex =
                                            Get.find<PopularProductController>()
                                                .popularProductList
                                                .indexOf(cartController
                                                    .cartList[index].product!);
                                        if (popularIndex >= 0) {
                                          Get.toNamed(
                                              RoutesHelper.getPopularFood(
                                                  popularIndex, "cartscreen"));
                                        } else {
                                          var recommendedIndex = Get.find<
                                                  RecommendedProductController>()
                                              .recommendedProductList
                                              .indexOf(cartController
                                                  .cartList[index].product!);
                                          if (recommendedIndex < 0) {
                                            Get.snackbar(
                                              "History Product",
                                              "History product review is not available!",
                                              backgroundColor: Colors.red,
                                              colorText: Colors.white,
                                              duration:
                                                  const Duration(seconds: 1),
                                              animationDuration:
                                                  const Duration(seconds: 1),
                                            );
                                          } else {
                                            Get.toNamed(
                                                RoutesHelper.getRecommendedFood(
                                                    recommendedIndex,
                                                    "cartscreen"));
                                          }
                                        }
                                      },
                                      child: Container(
                                        margin: EdgeInsets.only(
                                            bottom: Dimensions.size15),
                                        height:
                                            Dimensions.popularImageContainer,
                                        width: Dimensions.popularImageContainer,
                                        decoration: BoxDecoration(
                                          color: AppColors.mainColor,
                                          borderRadius: BorderRadius.circular(
                                              Dimensions.size20),
                                          image: DecorationImage(
                                            // ignore: prefer_interpolation_to_compose_strings
                                            image: NetworkImage(
                                                AppConstant.BASE_APP_URL +
                                                    AppConstant.UPLOAD_URL +
                                                    cartController
                                                        .cartList[index].img!),
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                    ),

                                    //*Details Container
                                    Expanded(
                                      child: Container(
                                        padding:
                                            EdgeInsets.all(Dimensions.size10),
                                        margin: EdgeInsets.only(
                                            bottom: Dimensions.size10),
                                        height:
                                            Dimensions.popularDetailsContainer,
                                        // width: double.infinity,
                                        decoration: BoxDecoration(
                                          //color: Colors.white,
                                          borderRadius: BorderRadius.only(
                                            topRight: Radius.circular(
                                                Dimensions.size30),
                                            bottomRight: Radius.circular(
                                                Dimensions.size30),
                                          ),
                                        ),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            BigText(
                                                text: cartController
                                                    .cartList[index].name!),
                                            SizedBox(
                                              height: Dimensions.size05,
                                            ),
                                            const SmallText(
                                                text:
                                                    "With chinese characteristics"),
                                            SizedBox(
                                              height: Dimensions.size10,
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                BigText(
                                                  text:
                                                      "\$${cartController.cartList[index].price!}",
                                                  color: AppColors.mainColor,
                                                ),
                                                //* Add Remove Quantity Button

                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceAround,
                                                  children: [
                                                    GestureDetector(
                                                      onTap: () {
                                                        cartController.addItems(
                                                            cartController
                                                                .cartList[index]
                                                                .product!,
                                                            -1);
                                                      },
                                                      child: const Icon(
                                                        Icons.remove,
                                                        color: Color.fromARGB(
                                                            255, 197, 195, 195),
                                                      ),
                                                    ),
                                                    Container(
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                              //vertical: Dimensions.size05,
                                                              horizontal:
                                                                  Dimensions
                                                                      .size20),
                                                      decoration: BoxDecoration(
                                                        color: AppColors
                                                            .mainColor
                                                            .withOpacity(0.3),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(
                                                                    Dimensions
                                                                        .size10),
                                                      ),
                                                      child: BigText(
                                                          text: cartController
                                                              .cartList[index]
                                                              .quantity
                                                              .toString()
                                                          //popularProduct.inCartItems.toString()
                                                          ),
                                                    ),
                                                    GestureDetector(
                                                      onTap: () {
                                                        cartController.addItems(
                                                            cartController
                                                                .cartList[index]
                                                                .product!,
                                                            1);
                                                      },
                                                      child: const Icon(
                                                        Icons.add,
                                                        color: Color.fromARGB(
                                                            255, 197, 195, 195),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                );
                              },
                            ),
                          ),
                        ),
                      ),
                    )
                  : const NoDataScreen(text: "Your cart is empty!");
            }),
          ],
        ),
      ),
      //* Bottom Navigation
      bottomNavigationBar:
          GetBuilder<CartController>(builder: (cartController) {
        return SizedBox(
          height: Dimensions.mainCartContainer * 1.5,
          child: cartController.cartList.isEmpty
              ? Container()
              : Container(
                  height: Dimensions.mainCartContainer * 1.5,
                  decoration: BoxDecoration(color: Colors.white, boxShadow: [
                    BoxShadow(
                        offset: const Offset(0, -5),
                        color: AppColors.mainColor.withOpacity(0.5),
                        blurRadius: 30)
                  ]),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        margin: EdgeInsets.symmetric(
                            horizontal: Dimensions.size20,
                            vertical: Dimensions.size30),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const BigText(text: "Total"),
                            BigText(
                                text:
                                    "\$${cartController.totalAmount.toString()}"),
                          ],
                        ),
                      ),

                      //* Place Order Button Container
                      GestureDetector(
                        onTap: () {
                          // print("onTap");
                          cartController.addToCartHistory();
                        },
                        child: Container(
                          width: double.infinity,
                          margin: EdgeInsets.only(
                              right: Dimensions.size20,
                              left: Dimensions.size20,
                              bottom: Dimensions.size20),
                          padding: EdgeInsets.all(Dimensions.size20),
                          decoration: BoxDecoration(
                            color: AppColors.mainColor,
                            borderRadius:
                                BorderRadius.circular(Dimensions.size10),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: const [
                              BigText(
                                text: "Place Order",
                                color: Colors.white,
                              ),
                              Icon(
                                Icons.arrow_forward_ios,
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
      }),
    );
  }
}
