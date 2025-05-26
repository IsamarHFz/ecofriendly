import 'package:flutter/material.dart';
import '../models/sweatshirt.dart';
import '../models/cart_item.dart';

class CartProvider with ChangeNotifier {
  final List<CartItem> _items = [];

  List<CartItem> get items => _items;

  void addToCart(Sweatshirt sweatshirt) {
    final index = _items.indexWhere(
      (item) => item.sweatshirt.id == sweatshirt.id,
    );
    if (index >= 0) {
      _items[index].quantity += 1;
    } else {
      _items.add(CartItem(sweatshirt: sweatshirt));
    }
    notifyListeners(); // avisa que hay cambios
  }

  void removeFromCart(String id) {
    _items.removeWhere((item) => item.sweatshirt.id == id);
    notifyListeners();
  }

  void clearCart() {
    _items.clear();
    notifyListeners();
  }

  double get totalPrice {
    return _items.fold(
      0,
      (sum, item) => sum + item.sweatshirt.price * item.quantity,
    );
  }
}
