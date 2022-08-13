import 'package:flutter/material.dart';
import 'package:food_delivery_app/controllers/cart_controller.dart';
import 'package:food_delivery_app/controllers/popular_product_controller.dart';
import 'package:food_delivery_app/controllers/recommended_product_controller.dart';
import 'package:food_delivery_app/routes/routes_helper.dart';
import 'package:food_delivery_app/text_theme.dart';
import 'package:get/get.dart';
import 'package:food_delivery_app/helper/dependicies.dart' as dep;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dep.initState();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    //* Controller Initilization
    Get.find<CartController>().getCartData();
    Get.find<CartController>().addToCartHistory();
    /* We Initilize GetBuider of controller here because controller are deleted
    if we initilized it after GetMaterialApp.......We are now initialzing it
    in splash screen and it's after GetMaterialApp and that's why it's deleted 
    from memmory */

    return GetBuilder<PopularProductController>(builder: (_) {
      return GetBuilder<RecommendedProductController>(builder: (_) {
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Food Delivery App',
          theme: ThemeData(
              scaffoldBackgroundColor: Colors.white.withOpacity(0.98),
              textTheme: textTheme),
          // home: const SplashScreen(),
          initialRoute: RoutesHelper.getSaplashScreen(),
          getPages: RoutesHelper.routes,
        );
      });
    });
  }
}
