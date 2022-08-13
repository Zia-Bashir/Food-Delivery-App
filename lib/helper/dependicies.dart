import 'package:food_delivery_app/controllers/cart_controller.dart';
import 'package:food_delivery_app/controllers/popular_product_controller.dart';
import 'package:food_delivery_app/controllers/recommended_product_controller.dart';
import 'package:food_delivery_app/data/API/apiclient.dart';
import 'package:food_delivery_app/data/Repo/cart_repo.dart';
import 'package:food_delivery_app/data/Repo/popular_product_repo.dart';
import 'package:food_delivery_app/data/Repo/recommended_product_repo.dart';
import 'package:food_delivery_app/utils/app_constants.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

@override
Future<void> initState() async {
  //? Shared Preference for Local Storage
  final SharedPreferences sharedPreferences =
      await SharedPreferences.getInstance();
  Get.lazyPut(() => sharedPreferences);

  //* API Clients
  Get.lazyPut(() => ApiClient(appBaseUrl: AppConstant.BASE_APP_URL));

  //* Repositories
  Get.lazyPut(() => PopularProductRepo(apiClient: Get.find()));
  Get.lazyPut(() => RecommendedProductRepo(apiClient: Get.find()));
  //? Use data of cart to Store in local Storage
  Get.lazyPut(() => CartRepo(sharedPreferences: Get.find()));

  //* Controllers
  Get.lazyPut(() => PopularProductController(popularProductRepo: Get.find()));
  Get.lazyPut(
      () => RecommendedProductController(recommendedProductRepo: Get.find()));
  //Get.lazyPut(() => CartController(cartRepo: Get.find()));
  Get.put(CartController(cartRepo: Get.find()));
}
