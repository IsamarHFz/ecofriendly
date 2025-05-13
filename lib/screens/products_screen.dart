import 'package:flutter/material.dart';

class ProductsScreen extends StatefulWidget {
  const ProductsScreen({super.key});

  @override
  _ProductsScreenState createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        const SizedBox(height: 10),
        imageCard(),
        Center(
          child: ElevatedButton(
            onPressed: () {
              _showAddSudaderaDialog(context);
            },
            style: ElevatedButton.styleFrom(
              foregroundColor: Colors.white,
              backgroundColor: Colors.blue,
              padding: const EdgeInsets.symmetric(
                vertical: 15.0,
                horizontal: 30.0,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25.0),
              ),
              elevation: 5,
              shadowColor: Colors.blueGrey.shade600,
            ),
            child: const Text('Agregar sudadera'),
          ),
        ),
        const SizedBox(height: 30),
      ],
    );
  }

  Widget imageCard() {
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
            children: [
              TableRow(
                children: [
                  _buildProductTile(
                    'assets/images/sudaderaTortuga.jpeg',
                    'Sudadera',
                    'M',
                    1,
                  ),
                  _buildProductTile(
                    'assets/images/sudaderaTronco.jpeg',
                    'Sudadera',
                    'L',
                    2,
                  ),
                ],
              ),
              TableRow(
                children: [
                  _buildProductTile(
                    'assets/images/sudaderaArbol.jpeg',
                    'Sudadera',
                    'XL',
                    3,
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildProductTile(String img, String title, String talla, int id) {
    return GestureDetector(
      onTap: () {
        _showConfirmationDialog(context, img, title, talla, id);
      },
      child: imageContainer(img, title, talla),
    );
  }

  Widget imageContainer(String imagePath, String title1, String talla) {
    return SizedBox(
      width: 150,
      height: 200,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        elevation: 10,
        color: Colors.lightBlue[50],
        child: Container(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(20.0),
                child: Image.asset(
                  imagePath,
                  width: 120,
                  height: 120,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(height: 8),
              Text(title1, style: const TextStyle(fontWeight: FontWeight.bold)),
              Text("Talla $talla"),
            ],
          ),
        ),
      ),
    );
  }

  void _showConfirmationDialog(
    BuildContext context,
    String imagePath,
    String title1,
    String talla,
    int id,
  ) {
    showDialog(
      context: context,
      builder:
          (_) => AlertDialog(
            backgroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            title: const Text(
              'Confirmación',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            content: const Text(
              '¿Deseas agregar esta sudadera a tu colección?',
              style: TextStyle(fontSize: 18),
            ),
            actions: [
              TextButton(
                style: TextButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.blue,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('Cancelar'),
              ),
              TextButton(
                style: TextButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.blue,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onPressed: () {
                  // Guardar o navegar
                  Navigator.of(context).pop();
                },
                child: const Text('Agregar'),
              ),
            ],
          ),
    );
  }

  void _showAddSudaderaDialog(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    String? _title1;
    String? _talla;

    showDialog(
      context: context,
      builder:
          (_) => AlertDialog(
            backgroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            title: const Text(
              'Agregar sudadera',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
            ),
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
                    onSaved: (value) => _title1 = value,
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
                style: TextButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.blue,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('Cancelar'),
              ),
              TextButton(
                style: TextButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.blue,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    // Aquí podrías guardar en una lista
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
