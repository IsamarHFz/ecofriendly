import 'package:ecofriendly/models/cart_item.dart';
import 'package:ecofriendly/models/sweatshirt.dart';
import 'package:ecofriendly/screens/base_screen.dart';
import 'package:ecofriendly/screens/order_form_dialog.dart';
import 'package:ecofriendly/screens/ticket_screen.dart';
import 'package:flutter/material.dart';
import 'package:ecofriendly/theme/app_theme.dart';
import 'package:provider/provider.dart';
import '../providers/cart_provider.dart';

class ProductDetailScreen extends StatefulWidget {
  final String title;
  final String imagePath;
  final String precio;
  final List<String> images;
  final List<String> tallas;

  const ProductDetailScreen({
    super.key,
    required this.title,
    required this.imagePath,
    required this.precio,
    required this.images,
    required this.tallas,
  });

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  String? tallaSeleccionada;
  final List<String> _imagenes = [];
  late final List<String> _tallasDisponibles;

  @override
  void initState() {
    super.initState();
    _imagenes.addAll(widget.images);
    _tallasDisponibles = widget.tallas;
  }

  @override
  Widget build(BuildContext context) {
    try {
      final parsedPrice = double.tryParse(widget.precio);
      if (parsedPrice == null) {
        return Scaffold(
          body: Center(child: Text('Error: precio inválido: ${widget.precio}')),
        );
      }

      return BaseScreen(
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.asset(
                  widget.imagePath,
                  width: double.infinity,
                  height: 250,
                  fit: BoxFit.cover,
                  errorBuilder:
                      (context, error, stackTrace) =>
                          const Icon(Icons.broken_image, size: 100),
                ),
              ),
              const SizedBox(height: 12),
              SizedBox(
                height: 80,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: _imagenes.length,
                  itemBuilder:
                      (context, index) => _buildImagePreview(_imagenes[index]),
                ),
              ),
              const SizedBox(height: 25),
              Text(
                widget.title,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: AppTheme.iconColor,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 10),
              DropdownButtonFormField<String>(
                value: tallaSeleccionada,
                decoration: const InputDecoration(
                  labelText: 'Selecciona tu talla',
                  border: OutlineInputBorder(),
                ),
                items:
                    _tallasDisponibles
                        .map(
                          (talla) => DropdownMenuItem<String>(
                            value: talla,
                            child: Text(talla),
                          ),
                        )
                        .toList(),
                onChanged: (value) {
                  setState(() {
                    tallaSeleccionada = value;
                  });
                },
              ),
              const SizedBox(height: 10),
              Text(
                'Precio: \$${widget.precio}',
                style: const TextStyle(fontSize: 16, color: AppTheme.iconColor),
                textAlign: TextAlign.center,
              ),
              const Spacer(),
              ElevatedButton.icon(
                onPressed: () {
                  if (tallaSeleccionada == null) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Por favor selecciona una talla.'),
                      ),
                    );
                    return;
                  }

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
                                Navigator.pop(context);
                                showDialog(
                                  context: context,
                                  builder:
                                      (context) => OrderFormDialog(
                                        onSubmit: (nombre, grado, telefono) {
                                          final sweatshirt = Sweatshirt(
                                            id: widget.title,
                                            name: widget.title,
                                            price: parsedPrice,
                                            image: widget.imagePath,
                                          );

                                          final cartProvider =
                                              Provider.of<CartProvider>(
                                                context,
                                                listen: false,
                                              );
                                          cartProvider.addToCart(sweatshirt);

                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder:
                                                  (context) => TicketDigital(
                                                    nombreCliente: nombre,
                                                    emailCliente: '',
                                                    gradoyGrupo: grado,
                                                    numeroTelefono: telefono,
                                                    talla: tallaSeleccionada!,
                                                    items: [
                                                      {
                                                        'nombre':
                                                            sweatshirt.name,
                                                        'precio':
                                                            sweatshirt.price,
                                                        'total':
                                                            sweatshirt.price,
                                                      },
                                                    ],
                                                    subtotal: sweatshirt.price,
                                                    total: sweatshirt.price,
                                                    totalPagado:
                                                        sweatshirt.price,
                                                    metodoPago: '',
                                                    fecha: DateTime.now()
                                                        .toIso8601String()
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
    } catch (e, stackTrace) {
      debugPrint('Error en ProductDetailScreen: $e\n$stackTrace');
      return Scaffold(
        body: Center(
          child: Text('Ha ocurrido un error al cargar el producto.\n$e'),
        ),
      );
    }
  }

  Widget _buildImagePreview(String path) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Image.asset(
          path,
          width: 80,
          height: 80,
          fit: BoxFit.cover,
          errorBuilder:
              (context, error, stackTrace) =>
                  const Icon(Icons.broken_image, size: 50),
        ),
      ),
    );
  }
}
