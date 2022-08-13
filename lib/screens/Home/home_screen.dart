import 'package:flutter/material.dart';
import 'package:food_delivery_app/screens/Home/components/foodpage_itembuilder.dart';
import 'package:food_delivery_app/screens/Home/components/home_header.dart';
import 'package:food_delivery_app/screens/Home/components/recommended_food_listview.dart';
import 'package:food_delivery_app/screens/Home/components/recommended_text.dart';
import 'package:food_delivery_app/utils/dimensions.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            //HomePage Header
            const HomeHeader(),
            //Page Item Builder
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const FoodPageItemBuilder(),
                    //Popular Foods Text
                    const RecommendedText(),
                    //Popular Food ListView
                    Container(
                        margin: EdgeInsets.only(
                          top: Dimensions.size20,
                          left: Dimensions.size20,
                          right: Dimensions.size20,
                        ),
                        child: const RecommendedFoodListView()),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
