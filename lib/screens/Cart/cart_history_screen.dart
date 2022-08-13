import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:food_delivery_app/base/no_data_screen.dart';
import 'package:food_delivery_app/controllers/cart_controller.dart';
import 'package:food_delivery_app/models/cart_model.dart';
import 'package:food_delivery_app/routes/routes_helper.dart';
import 'package:food_delivery_app/utils/app_constants.dart';
import 'package:food_delivery_app/utils/colors.dart';
import 'package:food_delivery_app/utils/dimensions.dart';
import 'package:food_delivery_app/widgets/big_text.dart';
import 'package:food_delivery_app/widgets/icon_with_container.dart';
import 'package:food_delivery_app/widgets/small_text.dart';
import 'package:get/get.dart';
// ignore: depend_on_referenced_packages
import 'package:intl/intl.dart';

class CartHistoryScreen extends StatelessWidget {
  const CartHistoryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var getCartHistoryList =
        Get.find<CartController>().getCartHistoryList().reversed.toList();
    Map<String, int> cartItemPerOrder = {};

    for (int i = 0; i < getCartHistoryList.length; i++) {
      if (cartItemPerOrder.containsKey(getCartHistoryList[i].time)) {
        cartItemPerOrder.update(
            getCartHistoryList[i].time!, (value) => ++value);
      } else {
        cartItemPerOrder.putIfAbsent(getCartHistoryList[i].time!, () => 1);
      }
    }
    List<String> cartOrderTimeToList() => //* Returning Map keys into List
        cartItemPerOrder.entries.map((e) => e.key).toList();
    List<int> cartItemPerOrderToList() => //* Returning Map Values into List
        cartItemPerOrder.entries.map((e) => e.value).toList();
    List<int> itemsPerOrder = cartItemPerOrderToList();

    var listCounter = 0;

    return Scaffold(
        appBar: AppBar(
            elevation: 1,
            backgroundColor: AppColors.mainColor,
            //leading: const BigText(text: "Cart History"),
            title: const BigText(
              text: "Cart History",
              color: Colors.white,
            ),
            actions: [
              Container(
                margin: EdgeInsets.symmetric(horizontal: Dimensions.size10),
                child: const Center(
                  child: IconWithContainer(
                    icon: Icons.shopping_basket_sharp,
                    iconColor: AppColors.mainColor,
                    backgroundColor: Colors.white,
                    //bgSize: Dimensions.size30,
                  ),
                ),
              ),
            ]),
        body: GetBuilder<CartController>(builder: (cartController) {
          return cartController.getCartHistoryList().isEmpty
              ? const NoDataScreen(
                  text: "Your history is empty!",
                  //imgPath: "assets/images/empty_box.png",
                )
              : Column(
                  children: [
                    Expanded(
                      child: SizedBox(
                        child: ListView(children: [
                          SizedBox(
                            height: Dimensions.size20,
                          ),
                          for (int i = 0; i < itemsPerOrder.length; i++)
                            Container(
                              margin: EdgeInsets.only(top: Dimensions.size10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    margin: EdgeInsets.only(
                                        left: Dimensions.size20,
                                        right: Dimensions.size20),

                                    //= IMF......... Immediate Involving Function
                                    //* Coverting Date Format
                                    child: (() {
                                      DateTime parseDate = DateFormat(
                                              'yyyy-MM-dd hh:mm:ss')
                                          .parse(getCartHistoryList[listCounter]
                                              .time!);
                                      var inputDate =
                                          DateTime.parse(parseDate.toString());
                                      var outputDateFormat =
                                          DateFormat('MM-dd-yyyy   hh:mm a');
                                      var outputDate =
                                          outputDateFormat.format(inputDate);

                                      return BigText(text: outputDate);
                                    }()),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(
                                        top: Dimensions.size10,
                                        left: Dimensions.size20,
                                        right: Dimensions.size20),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        //* Wrap List of Order Items
                                        Wrap(
                                          direction: Axis.horizontal,
                                          children: List.generate(
                                              itemsPerOrder[i], (index) {
                                            if (listCounter <
                                                getCartHistoryList.length) {
                                              listCounter++;
                                            }
                                            return index < 2
                                                ? Container(
                                                    height:
                                                        Dimensions.size40 * 2,
                                                    width:
                                                        Dimensions.size40 * 2,
                                                    margin: EdgeInsets.only(
                                                        right:
                                                            Dimensions.size10),
                                                    decoration: BoxDecoration(
                                                      color:
                                                          AppColors.iconColor1,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              Dimensions
                                                                      .size15 /
                                                                  2),
                                                      image: DecorationImage(
                                                        image: NetworkImage(
                                                          AppConstant
                                                                  .BASE_APP_URL +
                                                              AppConstant
                                                                  .UPLOAD_URL +
                                                              getCartHistoryList[
                                                                      listCounter -
                                                                          1]
                                                                  .img!,
                                                        ),
                                                        fit: BoxFit.cover,
                                                      ),
                                                    ),
                                                  )
                                                : Container();
                                          }),
                                        ),

                                        //* Total Items with ORDER AGAIN Button
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            BigText(
                                              text:
                                                  "\$${getCartHistoryList[i].price.toString()}",
                                              color: AppColors.mainColor,
                                              size: Dimensions.size25,
                                            ),
                                            SmallText(
                                                text:
                                                    "Total Items: ${itemsPerOrder[i]}"),
                                            SizedBox(
                                              height: Dimensions.size10,
                                            ),
                                            GestureDetector(
                                              onTap: () {
                                                var orderTime =
                                                    cartOrderTimeToList();
                                                Map<int, CartModel> orderAgin =
                                                    {};
                                                for (var j = 0;
                                                    j <
                                                        getCartHistoryList
                                                            .length;
                                                    j++) {
                                                  if (getCartHistoryList[j]
                                                          .time ==
                                                      orderTime[i]) {
                                                    orderAgin.putIfAbsent(
                                                        getCartHistoryList[j]
                                                            .id!,
                                                        () => CartModel.fromJson(
                                                            jsonDecode(jsonEncode(
                                                                getCartHistoryList[
                                                                    j]))));
                                                    Get.find<CartController>()
                                                            .setOrderAgainItems =
                                                        orderAgin;
                                                    Get.find<CartController>()
                                                        .addOrderAgainItemsToCart();
                                                    Get.toNamed(RoutesHelper
                                                        .getCartScreen());
                                                  }
                                                }
                                              },
                                              child: Container(
                                                padding: EdgeInsets.symmetric(
                                                    vertical: Dimensions.size05,
                                                    horizontal:
                                                        Dimensions.size05),
                                                decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  border: Border.all(
                                                      width: 1,
                                                      color:
                                                          AppColors.mainColor),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          Dimensions.size05),
                                                ),
                                                child: BigText(
                                                  text: "Order Again",
                                                  size: Dimensions.size15,
                                                  color: AppColors.mainColor,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  // SizedBox(
                                  //   height: Dimensions.size10,
                                  // ),
                                ],
                              ),
                            ),
                        ]),
                      ),
                    ),
                  ],
                );
        }));
  }
}
