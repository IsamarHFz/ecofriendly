import 'package:ecofriendly/models/cart.dart';
import 'package:ecofriendly/models/cart_item.dart';
import 'package:ecofriendly/models/sweatshirt.dart';
import 'package:ecofriendly/screens/base_screen.dart';
import 'package:ecofriendly/screens/order_form_dialog.dart';
import 'package:ecofriendly/screens/ticket_screen.dart';
import 'package:flutter/material.dart';
import 'package:ecofriendly/theme/app_theme.dart';

class ProductDetailScreen extends StatelessWidget {
  final String title;
  final String imagePath;
  final List<String> images;
  final String tallas;
  final String precio;

  const ProductDetailScreen({
    super.key,
    required this.title,
    required this.imagePath,
    required this.images,
    required this.tallas,
    required this.precio,
  });

  @override
  Widget build(BuildContext context) {
    return BaseScreen(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Imagen principal
            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.asset(
                imagePath,
                width: double.infinity,
                height: 250,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 12),

            // Galería de imágenes dinámicas
            SizedBox(
              height: 80,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: images.length,
                itemBuilder:
                    (context, index) => _buildImagePreview(images[index]),
              ),
            ),

            const SizedBox(height: 25),

            // Título y descripción
            Text(
              title,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: AppTheme.iconColor,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 10),
            Text(
              'Tallas disponibles: $tallas\nPrecio: \$${precio}',
              style: const TextStyle(fontSize: 16, color: AppTheme.iconColor),
              textAlign: TextAlign.center,
            ),
            const Spacer(),

            // Botón de agregar al carrito
            ElevatedButton.icon(
              onPressed: () {
                showDialog(
                  context: context,
                  builder:
                      (context) => AlertDialog(
                        title: const Text("Agregar al carrito"),
                        content: const Text(
                          "¿Deseas agregar este producto al carrito y solicitar tu ticket?",
                        ),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.pop(context),
                            child: const Text("Cancelar"),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context); // Cierra el diálogo
                              showDialog(
                                context: context,
                                builder:
                                    (context) => OrderFormDialog(
                                      onSubmit: (nombre, grado, telefono) {
                                        // Crear objeto temporal del producto
                                        final sweatshirt = Sweatshirt(
                                          id: title,
                                          name: title,
                                          price: double.parse(precio),
                                          image: imagePath,
                                        );

                                        // Agregar al carrito
                                        final cartItem = CartItem(
                                          sweatshirt: sweatshirt,
                                        );
                                        Cart().addItem(cartItem);

                                        // Navegar al ticket
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder:
                                                (context) => TicketDigital(
                                                  nombreCliente: nombre,
                                                  gradoyGrupo: grado,
                                                  numeroTelefono: telefono,
                                                  items: [
                                                    {
                                                      'nombre': sweatshirt.name,
                                                      'precio':
                                                          sweatshirt.price,
                                                      'total': sweatshirt.price,
                                                    },
                                                  ],
                                                  subtotal: sweatshirt.price,
                                                  total: sweatshirt.price,
                                                  totalPagado: sweatshirt.price,
                                                  metodoPago: '',
                                                  fecha: DateTime.now()
                                                      .toString()
                                                      .substring(0, 10),
                                                ),
                                          ),
                                        );
                                      },
                                    ),
                              );
                            },
                            child: const Text("Sí"),
                          ),
                        ],
                      ),
                );
              },
              icon: const Icon(Icons.add_shopping_cart),
              label: const Text('Agregar al carrito'),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppTheme.buttonColor,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 12,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildImagePreview(String path) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Image.asset(path, width: 80, height: 80, fit: BoxFit.cover),
      ),
    );
  }
}
