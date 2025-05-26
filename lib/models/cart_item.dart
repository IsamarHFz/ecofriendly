import 'sweatshirt.dart';

class CartItem {
  final Sweatshirt sweatshirt;
  int quantity;

  CartItem({required this.sweatshirt, this.quantity = 1});
}
