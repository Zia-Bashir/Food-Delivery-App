import 'package:food_delivery_app/screens/Cart/cart_screen.dart';
import 'package:food_delivery_app/screens/NavBar/bottom_navbar_screen.dart';
import 'package:food_delivery_app/screens/Popular/popular_food_screen.dart';
import 'package:food_delivery_app/screens/Recommended/recommended_food_screen.dart';
import 'package:food_delivery_app/screens/splash/splash_screen.dart';
import 'package:get/get.dart';

class RoutesHelper {
  static const String splashScreen = '/splash-screen';
  static const String initial = '/';
  static const String popularFood = '/popular-food';
  static const String recommendedFood = '/recommended-food';
  static const String cartScreen = '/cart-screen';

  //* GET Routes
  static String getSaplashScreen() => splashScreen;
  static String getInitial() => initial;
  static String getPopularFood(int pageId, String screen) =>
      '$popularFood?pageId=$pageId&screen=$screen';
  static String getRecommendedFood(int pageId, String screen) =>
      '$recommendedFood?pageId=$pageId&screen=$screen';
  static String getCartScreen() => cartScreen;

  //* Routes List

  static List<GetPage> routes = [
    GetPage(
      name: splashScreen,
      page: () => const SplashScreen(),
    ),
    GetPage(
      name: initial,
      page: () => const BottomNavBarScreen(),
    ),
    GetPage(
        name: popularFood,
        page: () {
          var pageId = Get.parameters['pageId'];
          var screen = Get.parameters["screen"];
          return PopularFoodScreen(
            pageId: int.parse(pageId!),
            screen: screen!,
          );
        },
        transition: Transition.fadeIn),
    GetPage(
        name: recommendedFood,
        page: () {
          var pageId = Get.parameters['pageId'];
          var screen = Get.parameters["screen"];
          return RecommendedFoodScreen(
            pageId: int.parse(pageId!),
            screen: screen!,
          );
        },
        transition: Transition.fadeIn),
    GetPage(
      name: cartScreen,
      page: () => const CartScreen(),
      transition: Transition.fadeIn,
    ),
  ];
}
