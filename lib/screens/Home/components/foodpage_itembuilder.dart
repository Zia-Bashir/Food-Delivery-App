import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:food_delivery_app/controllers/popular_product_controller.dart';
import 'package:food_delivery_app/models/product_model.dart';
import 'package:food_delivery_app/routes/routes_helper.dart';
import 'package:food_delivery_app/utils/app_constants.dart';
import 'package:food_delivery_app/utils/colors.dart';
import 'package:food_delivery_app/utils/dimensions.dart';
import 'package:food_delivery_app/widgets/big_text.dart';
import 'package:food_delivery_app/widgets/icon_with_text.dart';
import 'package:food_delivery_app/widgets/small_text.dart';
import 'package:get/get.dart';

class FoodPageItemBuilder extends StatefulWidget {
  const FoodPageItemBuilder({Key? key}) : super(key: key);

  @override
  State<FoodPageItemBuilder> createState() => _FoodPageItemBuilderState();
}

class _FoodPageItemBuilderState extends State<FoodPageItemBuilder> {
  final PageController _pageController = PageController(viewportFraction: 0.85);
  var _curentPageValue = 0.0;
  final _scaleFactor = 0.8;
  final _height = 220;

  @override
  void initState() {
    // ignore: todo
    // TODO: implement initState
    super.initState();
    _pageController.addListener((() {
      setState(() {
        _curentPageValue = _pageController.page!;
//print(_curentPageValue.toString());
      });
    }));
  }

  @override
  void dispose() {
    // ignore: todo
    super.dispose();
    _pageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //final Size size = MediaQuery.of(context).size;

    return Column(
      children: [
        GetBuilder<PopularProductController>(builder: (popularProducts) {
          return popularProducts.isLoaded
              ? SizedBox(
                  height: Dimensions.pageViewSizeBox,
                  //color: AppColors.mainColor,
                  child: PageView.builder(
                      controller: _pageController,
                      itemCount: popularProducts.popularProductList.length,
                      itemBuilder: (context, position) {
                        return _buildPageItem(position,
                            popularProducts.popularProductList[position]);
                      }),
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
        }),
        GetBuilder<PopularProductController>(builder: (popularProduct) {
          return DotsIndicator(
            dotsCount: popularProduct.popularProductList.isEmpty
                ? 1
                : popularProduct.popularProductList.length,
            position: _curentPageValue,
            decorator: DotsDecorator(
              activeColor: AppColors.mainColor,
              size: Size.square(Dimensions.dotSize09),
              activeSize: Size(Dimensions.dotSize18, Dimensions.dotSize09),
              activeShape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(Dimensions.size05),
              ),
            ),
          );
        })
      ],
    );
  }

  Widget _buildPageItem(int index, ProductModel popularProduct) {
    Matrix4 matrix = Matrix4.identity();
    if (index == _curentPageValue.floor()) {
      var currentScale = 1 - (_curentPageValue - index) * (1 - _scaleFactor);
      var currrentTrans = _height * (1 - currentScale) / 2;
      matrix = Matrix4.diagonal3Values(1, currentScale, 1)
        ..setTranslationRaw(0, currrentTrans, 0);
    } else if (index == _curentPageValue.floor() + 1) {
      var currentScale =
          _scaleFactor + (_curentPageValue - index + 1) * (1 - _scaleFactor);
      var currrentTrans = _height * (1 - currentScale) / 2;
      matrix = Matrix4.diagonal3Values(1, currentScale, 1)
        ..setTranslationRaw(0, currrentTrans, 0);
    } else if (index == _curentPageValue.floor() - 1) {
      var currentScale = 1 - (_curentPageValue - index) * (1 - _scaleFactor);
      var currrentTrans = _height * (1 - currentScale) / 2;
      matrix = Matrix4.diagonal3Values(1, currentScale, 1)
        ..setTranslationRaw(0, currrentTrans, 0);
    } else {
      var currentScal = 0.8;
      matrix = Matrix4.diagonal3Values(1, currentScal, 1)
        ..setTranslationRaw(0, _height * (1 - currentScal), 0);
    }

    return Transform(
      transform: matrix,
      child: Stack(
        children: [
          GestureDetector(
            onTap: () {
              Get.toNamed(RoutesHelper.getPopularFood(index, "home"));
            },
            child: Container(
              height: Dimensions.pageViewContainer,
              margin: EdgeInsets.only(
                  left: Dimensions.size05, right: Dimensions.size05),
              decoration: BoxDecoration(
                color:
                    index.isEven ? AppColors.pageColor1 : AppColors.pageColor2,
                borderRadius: BorderRadius.circular(30),
                image: DecorationImage(
                    image: NetworkImage(
                        "${AppConstant.BASE_APP_URL}/uploads/${popularProduct.img!}"),
                    fit: BoxFit.cover),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: Dimensions.pageTextViewContainer,
              width: double.infinity,
              margin: EdgeInsets.only(
                  left: Dimensions.size30,
                  right: Dimensions.size30,
                  bottom: Dimensions.size20),
              padding: EdgeInsets.only(
                  top: Dimensions.size20,
                  bottom: Dimensions.size10,
                  left: Dimensions.size20,
                  right: Dimensions.size15),
              // padding: const EdgeInsets.only(bottom: 10),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(Dimensions.size30),
                  boxShadow: [
                    BoxShadow(
                        offset: const Offset(0, 5),
                        color: Colors.black.withOpacity(0.2),
                        blurRadius: Dimensions.size10),
                    const BoxShadow(
                      offset: Offset(5, 0),
                      color: Colors.white,
                    ),
                    const BoxShadow(
                      offset: Offset(-5, 0),
                      color: Colors.white,
                    ),
                  ]),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  BigText(text: popularProduct.name!),
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
              ),
            ),
          ),
        ],
      ),
    );
  }
}
