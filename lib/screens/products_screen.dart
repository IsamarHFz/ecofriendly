import 'package:flutter/material.dart';

class ProductsScreen extends StatefulWidget {
  const ProductsScreen({super.key});

  @override
  _ProductsScreenState createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  final List<Map<String, String>> _products = [
    {
      'img': 'imagenes/sudadera1.png',
      'title': 'Sudadera Clásica',
      'talla': 'M',
    },
    {
      'img': 'imagenes/sudadera2.png',
      'title': 'Sudadera con Capucha',
      'talla': 'L',
    },
    {
      'img': 'imagenes/sudadera1.png',
      'title': 'Sudadera Oversize',
      'talla': 'XL',
    },
    {
      'img': 'imagenes/sudadera1.png',
      'title': 'Sudadera Deportiva',
      'talla': 'S',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Productos')),
      body: ListView(
        children: [
          const SizedBox(height: 10),
          _imageCard(),
          Center(
            child: ElevatedButton(
              onPressed: () => _showAddSudaderaDialog(context),
              child: const Text('Agregar sudadera'),
            ),
          ),
          const SizedBox(height: 30),
        ],
      ),
    );
  }

  Widget _imageCard() {
    return Container(
      margin: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Center(
            child: Text(
              'Selecciona tu producto',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24.0),
            ),
          ),
          const SizedBox(height: 20.0),
          Table(
            children: List.generate(2, (i) {
              return TableRow(
                children: List.generate(2, (j) {
                  int index = i * 2 + j;
                  if (index >= _products.length) return const SizedBox();
                  final product = _products[index];
                  return GestureDetector(
                    onTap:
                        () => _showConfirmationDialog(
                          context,
                          product['img']!,
                          product['title']!,
                          product['talla']!,
                        ),
                    child: _imageContainer(
                      product['img']!,
                      product['title']!,
                      product['talla']!,
                    ),
                  );
                }),
              );
            }),
          ),
        ],
      ),
    );
  }

  Widget _imageContainer(String img, String title, String talla) {
    return SizedBox(
      width: 150,
      height: 200,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        elevation: 10,
        color: Colors.lightBlue[50],
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(20.0),
                child: Image.asset(
                  img,
                  width: 100,
                  height: 100,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(height: 8),
              Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
              Text("Talla $talla"),
            ],
          ),
        ),
      ),
    );
  }

  void _showConfirmationDialog(
    BuildContext context,
    String img,
    String title,
    String talla,
  ) {
    showDialog(
      context: context,
      builder:
          (_) => AlertDialog(
            title: const Text('Confirmación'),
            content: const Text(
              '¿Deseas agregar esta sudadera a tu colección?',
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('Cancelar'),
              ),
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('Agregar'),
              ),
            ],
          ),
    );
  }

  void _showAddSudaderaDialog(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    String? _title;
    String? _talla;

    showDialog(
      context: context,
      builder:
          (_) => AlertDialog(
            title: const Text('Agregar sudadera'),
            content: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'Nombre'),
                    validator:
                        (value) =>
                            value == null || value.isEmpty
                                ? 'Por favor ingresa un nombre'
                                : null,
                    onSaved: (value) => _title = value,
                  ),
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'Talla'),
                    validator:
                        (value) =>
                            value == null || value.isEmpty
                                ? 'Por favor ingresa la talla'
                                : null,
                    onSaved: (value) => _talla = value,
                  ),
                ],
              ),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('Cancelar'),
              ),
              TextButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    setState(() {
                      _products.add({
                        'img': 'imagenes/sudadera1.png',
                        'title': _title!,
                        'talla': _talla!,
                      });
                    });
                    Navigator.of(context).pop();
                  }
                },
                child: const Text('Agregar'),
              ),
            ],
          ),
    );
  }
}
