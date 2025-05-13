import 'package:ecofriendly/screens/base_screen.dart';
import 'package:ecofriendly/screens/ticket_screen.dart';
import 'package:flutter/material.dart';
import 'package:ecofriendly/theme/app_theme.dart';

class ProductDetailScreen extends StatelessWidget {
  final String title;
  final String imagePath;
  final String tallas;
  final String precio;

  const ProductDetailScreen({
    super.key,
    required this.title,
    required this.imagePath,
    required this.tallas,
    required this.precio,
  });

  @override
  Widget build(BuildContext context) {
    return BaseScreen(
      selectedIndex: 0,
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

            // Galería de 3 imágenes centradas
            SizedBox(
              height: 80,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  _buildImagePreview('assets/images/sudaderaArbol.jpeg'),
                  _buildImagePreview('assets/images/sudaderaTronco.jpeg'),
                  _buildImagePreview('assets/images/sudaderaTortuga.jpeg'),
                ],
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
                              Navigator.pop(context); // Cerrar alerta
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder:
                                      (context) => const TicketDigital(
                                        nombreCliente: 'Yaneth',
                                        gradoyGrupo: '6ºA',
                                        numeroTelefono: '1234567890',
                                        items: [
                                          {
                                            'nombre': 'Producto ejemplo',
                                            'precio': 350.00,
                                            'total': 350.00,
                                          },
                                        ],
                                        subtotal: 350.00,
                                        total: 350.00,
                                        totalPagado: 350.00,
                                        metodoPago:
                                            '', // Método de pago eliminado
                                        fecha:
                                            '2025-05-13', // Agrega una fecha válida
                                      ),
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
      padding: const EdgeInsets.symmetric(
        horizontal: 8.0,
      ), // Espacio entre imágenes
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Image.asset(
          path,
          width: 80,
          height: 80,
          fit: BoxFit.cover, // Ajuste de las imágenes
        ),
      ),
    );
  }
}
