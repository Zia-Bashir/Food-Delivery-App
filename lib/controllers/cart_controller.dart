import 'package:flutter/material.dart';
import 'package:food_delivery_app/data/Repo/cart_repo.dart';
import 'package:food_delivery_app/models/cart_model.dart';
import 'package:food_delivery_app/models/product_model.dart';
import 'package:food_delivery_app/utils/colors.dart';
import 'package:get/get.dart';

class CartController extends GetxController {
  final CartRepo cartRepo;

  CartController({required this.cartRepo});

  Map<int, CartModel> _items = {};
  Map<int, CartModel> get items => _items;

  //* Only for Storage and for SharedPreference
  List<CartModel> storageItems = [];

  void addItems(ProductModel product, int quantity) {
    var totalQuantity = 0;
    if (_items.containsKey(product.id)) {
      _items.update(product.id!, (value) {
        totalQuantity = value.quantity! + quantity;
        return CartModel(
          id: value.id,
          name: value.name,
          price: value.price,
          img: value.img,
          quantity: value.quantity! + quantity,
          isExist: true,
          time: DateTime.now().toString(),
          product: product,
        );
      });
      if (totalQuantity <= 0) {
        _items.remove(product.id);
      }
    } else {
      if (quantity > 0) {
        _items.putIfAbsent(product.id!, () {
          return CartModel(
            id: product.id,
            name: product.name,
            price: product.price,
            img: product.img,
            quantity: quantity,
            isExist: true,
            time: DateTime.now().toString(),
            product: product,
          );
        });
      } else {
        Get.snackbar(
          "Zero Item",
          "Your Item must be greater then 0!",
          backgroundColor: AppColors.mainColor,
          colorText: Colors.white,
        );
      }
    }
    cartRepo.addToCartList(cartList);
    update();
  }

  bool isExistProduct(ProductModel product) {
    if (_items.containsKey(product.id)) {
      return true;
    } else {
      return false;
    }
  }

  int getQuantity(ProductModel product) {
    var quantity = 0;
    if (_items.containsKey(product.id)) {
      _items.forEach((key, value) {
        if (key == product.id) {
          quantity = value.quantity!;
        }
      });
    }
    return quantity;
  }

  int get totalItems {
    var totalQuantity = 0;
    _items.forEach((key, value) {
      totalQuantity += value.quantity!;
    });
    return totalQuantity;
  }

  List<CartModel> get cartList {
    return _items.entries.map((e) {
      return e.value;
    }).toList();
  }

  int get totalAmount {
    var total = 0;
    _items.forEach((key, value) {
      //! Error Throw Here because on Reorder we get Null Quantity of product
      //total += value.quantity! * value.price!;
    });
    return total;
  }

  //= These both getCartData & setCartData are for fecthing Data from Storage....

  List<CartModel> getCartData() {
    setCartData = cartRepo.getListFromCart();
    print("Length is ${storageItems.length.toString()}");
    return storageItems;
  }

  set setCartData(List<CartModel> items) {
    //*First put in Storage
    storageItems = items;

    //* Then update
    for (int i = 0; i < storageItems.length; i++) {
      _items.putIfAbsent(storageItems[i].product!.id!, () => storageItems[i]);
    }
  }

  //= These functions are for fetching Cart History from Storage....

  void addToCartHistory() {
    cartRepo.addToCartHistoryList();
    clear();
  }

  //* To Clear Map after CheckOut
  void clear() {
    _items = {};
    update();
  }

  List<CartModel> getCartHistoryList() {
    return cartRepo.getCartHistoryList();
  }

  //= These Function are using in Order again [Get Items from Cart History to Cart]

  set setOrderAgainItems(Map<int, CartModel> orderAgainItems) {
    _items = {};
    _items = orderAgainItems;
  }

  void addOrderAgainItemsToCart() {
    cartRepo.addToCartList(cartList);
    update();
  }
}
