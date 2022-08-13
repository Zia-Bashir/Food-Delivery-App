import 'package:get/get.dart';

class Dimensions {
  static double screenHeight = Get.context!.height;
  static double screenWidth = Get.context!.width;

  //! Height == 781       Width==392.7

  //Page View Builder
  static double pageViewSizeBox = screenHeight / 2.44;
  static double pageViewContainer = screenHeight / 3.55;
  static double pageTextViewContainer = screenHeight / 6;

  //*Screen Height

  static double size05 = screenHeight / 156.2;
  static double size10 = screenHeight / 78.1;
  static double size15 = screenHeight / 52.06;
  static double size20 = screenHeight / 39.05;
  static double size25 = screenHeight / 31.24;
  static double size30 = screenHeight / 26.03;
  static double size40 = screenHeight / 19.53;
  static double size50 = screenHeight / 15.62;

  //?Extra Sizes

  //* Header Icon Container
  static double iconContainerSize30 = screenHeight / 19.53;

  //* For Small Font
  static double fontSize12 = screenHeight / 65.08;
  static double fontSize20 = screenHeight / 39.05;

  //* For Dots Indicator
  static double dotSize09 = screenHeight / 86.78;
  static double dotSize18 = screenHeight / 43.39;

  //* Dot Polpular Text
  static double dotTextSize03 = screenHeight / 260.33;

  //* Popular Container
  static double popularImageContainer = screenHeight / 6.51;
  static double popularDetailsContainer = screenHeight / 7.81;

  //* Recommended Food Container
  static double recommendedFoodImageContainer = screenHeight / 2.60;
  static double recommendedIconSpace = screenHeight / 13.02;

  //* Food Details and Info Container
  static double foodDetailsContainer = screenHeight / 1.56;
  static double foodDetailsPaddingContainer = screenHeight / 6.07;

  //* Cart Container
  static double mainCartContainer = screenHeight / 6.07;
  static double addSubContainer = screenHeight / 6.51;
  static double addToCartContainer = screenHeight / 3.91;

  //* Splash Image
  static double splashImg = screenHeight / 3.12;
}
