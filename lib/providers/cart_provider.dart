import 'package:flutter/material.dart';

class CartProvider with ChangeNotifier {
  List<Map<String, dynamic>> _cartItems = [];

  List<Map<String, dynamic>> get cartItems => _cartItems;

  void addToCart(Map<String, dynamic> item) {
    _cartItems.add(item);
    notifyListeners(); // Updates UI
  }
  double totalPrice() {
  double total = 0.0;
  for (var item in _cartItems) {
    total += double.parse(item['price']) * item['quantity'];
  }
  return total;
}

  void removeFromCart(int index) {
    _cartItems.removeAt(index);
    notifyListeners();
  }

  void clearCart() {
    _cartItems.clear();
    notifyListeners();
  }
}
