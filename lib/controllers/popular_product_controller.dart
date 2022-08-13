import 'package:flutter/material.dart';
import 'package:food_delivery_app/controllers/cart_controller.dart';
import 'package:food_delivery_app/data/Repo/popular_product_repo.dart';
import 'package:food_delivery_app/models/cart_model.dart';
import 'package:food_delivery_app/models/product_model.dart';
import 'package:food_delivery_app/utils/colors.dart';
import 'package:get/get.dart';

class PopularProductController extends GetxController {
  final PopularProductRepo popularProductRepo;
  List<dynamic> _popularProductList = [];
  List<dynamic> get popularProductList => _popularProductList;
  bool _isLoaded = false;
  bool get isLoaded => _isLoaded;

  int _quantity = 0;
  //int get quantity => _quantity;
  int get quantity => checkQuantity(_quantity);

  int _inCartItems = 0;
  //int get inCartItems => _inCartItems;
  int get inCartItems => _inCartItems + _quantity;

  late CartController _cart;
  CartController get cart => _cart;

  PopularProductController({required this.popularProductRepo});

  Future<void> getPopularProductList() async {
    Response response = await popularProductRepo.getPopularProductList();
    if (response.statusCode == 200) {
      _popularProductList = [];
      //Map rawData = jsonDecode(response.body); if we got error in response body
      popularProductList.addAll(Product.fromJson(response.body).products);
      _isLoaded = true;
      update();
    } else {}
  }

  void setQuantity(bool isIncrement) {
    if (isIncrement) {
      _quantity = checkQuantity(_quantity + 1);
    } else {
      _quantity = checkQuantity(_quantity - 1);
      // print("Qauntity is $_quantity");
    }

    update();
  }

  int checkQuantity(int quantity) {
    if ((_inCartItems + quantity) < 0) {
      Get.snackbar(
        "Count Error",
        "You can't remove more!",
        backgroundColor: AppColors.mainColor,
        colorText: Colors.white,
        snackStyle: SnackStyle.FLOATING,
      );
      if (_inCartItems > 0) {
        _quantity = -_inCartItems;
        return _quantity;
      }
      return 0;
    } else if ((_inCartItems + quantity) > 20) {
      Get.snackbar(
        "Count Error",
        "You can't add more!",
        backgroundColor: AppColors.mainColor,
        colorText: Colors.white,
      );
      return 20;
    } else {
      return quantity;
    }
  }

  void inItProduct(ProductModel product, CartController cart) {
    _quantity = 0;
    _inCartItems = 0;
    _cart = cart;
    var exist = false;
    exist = cart.isExistProduct(product);
    if (exist = true) {
      _inCartItems = cart.getQuantity(product);
    }
    // print("in Cart Items $_inCartItems");
    //print("Item Availabe $exist");
  }

  void addItems(ProductModel product) {
    _cart.addItems(product, _quantity);
    _quantity = 0;
    _inCartItems = _cart.getQuantity(product);
    // print("2nd INCART ITEMS $_inCartItems");
    _cart.items.forEach((key, value) {
      //print("The id is ${value.id} the Quantity is ${value.quantity}");
    });
    update();
  }

  int get totalItems {
    return _cart.totalItems;
  }

  List<CartModel> get cartList {
    return _cart.cartList;
  }
}
