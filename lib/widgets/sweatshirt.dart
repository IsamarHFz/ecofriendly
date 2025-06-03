import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/sweatshirt.dart';
import '../providers/cart_provider.dart';

class SweatshirtCard extends StatelessWidget {
  final Sweatshirt sweatshirt;

  SweatshirtCard({required this.sweatshirt});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          Image.network(sweatshirt.imageUrl ?? ''),
          Text(sweatshirt.name),
          Text('\$${sweatshirt.price}'),
          ElevatedButton(
            onPressed: () {
              Provider.of<CartProvider>(
                context,
                listen: false,
              ).addToCart(sweatshirt);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('${sweatshirt.name} agregada al carrito'),
                ),
              );
            },
            child: Text('Agregar al carrito'),
          ),
        ],
      ),
    );
  }
}
