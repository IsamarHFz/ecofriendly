import 'cart_item.dart';

class Cart {
  static final Cart _instance = Cart._internal();
  factory Cart() => _instance;
  Cart._internal();

  final List<CartItem> _items = [];

  List<CartItem> get items => List.unmodifiable(_items);

  void addItem(CartItem item) {
    final index = _items.indexWhere(
      (i) => i.sweatshirt.id == item.sweatshirt.id,
    );
    if (index != -1) {
      _items[index].quantity += item.quantity;
    } else {
      _items.add(item);
    }
  }

  void clear() => _items.clear();

  double get totalPrice => _items.fold(
    0,
    (sum, item) => sum + item.sweatshirt.price * item.quantity,
  );
}
