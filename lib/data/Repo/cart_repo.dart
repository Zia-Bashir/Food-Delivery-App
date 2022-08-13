import 'dart:convert';

import 'package:food_delivery_app/models/cart_model.dart';
import 'package:food_delivery_app/utils/app_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CartRepo {
  final SharedPreferences sharedPreferences;
  CartRepo({required this.sharedPreferences});

  //* Global Cart Variable
  List<String> cart = []; //? Storing data in String List from addToCartList
  List<String> cartHistory = []; //? Storing Cart History

  //= These Functions are for saving and fetching cart data from STorage

  void addToCartList(List<CartModel> cartList) {
    //* Convert Obj to String Because SharedPreference only accept String
    //? This was the Old way
    // cartList.forEach((element) {
    //   return cart.add(jsonEncode(element));
    // });
    // sharedPreferences.remove(AppConstant.CART_LIST);
    // sharedPreferences.remove(AppConstant.CART_LIST_HISTORY);

    cart = [];
    var time = DateTime.now().toString();
    for (var element in cartList) {
      element.time = time;
      cart.add(jsonEncode(element));
    }
    sharedPreferences.setStringList(AppConstant.CART_LIST, cart);
    // print(sharedPreferences.getStringList(AppConstant.CART));
    getListFromCart();
  }

  List<CartModel> getListFromCart() {
    List<String> carts = [];
    if (sharedPreferences.containsKey(AppConstant.CART_LIST)) {
      carts = sharedPreferences.getStringList(AppConstant.CART_LIST)!;
      // print(carts.toString());
    }
    //* Local Variable
    //? Get data Back from Storage in form of OBJ.
    List<CartModel> cartList = [];
    for (var element in carts) {
      cartList.add(CartModel.fromJson(jsonDecode(element)));
    }
    return cartList;
  }

  //= These Functions are for saving and fetching cart data History from STorage

  void addToCartHistoryList() {
    if (sharedPreferences.containsKey(AppConstant.CART_LIST_HISTORY)) {
      cartHistory =
          sharedPreferences.getStringList(AppConstant.CART_LIST_HISTORY)!;
    }
    for (var i = 0; i < cart.length; i++) {
      print("History List${cart[i]}");
      cartHistory.add(cart[i]);
    }
    remove();
    sharedPreferences.setStringList(AppConstant.CART_LIST_HISTORY, cartHistory);
    print("The length of history list is ${getCartHistoryList().length}");
  }

  List<CartModel> getCartHistoryList() {
    if (sharedPreferences.containsKey(AppConstant.CART_LIST_HISTORY)) {
      cartHistory = [];
      cartHistory =
          sharedPreferences.getStringList(AppConstant.CART_LIST_HISTORY)!;
    }
    List<CartModel> cartListHistory = [];
    for (var element in cartHistory) {
      cartListHistory.add(CartModel.fromJson(jsonDecode(element)));
    }
    return cartListHistory;
  }

  //* Remove List from Storage
  void remove() {
    cart = [];
    sharedPreferences.remove(AppConstant.CART_LIST);
  }
}
