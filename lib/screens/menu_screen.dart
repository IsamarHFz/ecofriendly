import 'package:ecofriendly/screens/base_screen.dart';
import 'package:ecofriendly/screens/product_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:ecofriendly/theme/app_theme.dart';

class MenuScreen extends StatelessWidget {
  const MenuScreen({super.key});

  final List<Map<String, dynamic>> products = const [
    {
      'images': [
        'assets/images/sudaderaArbol.jpeg',
        'assets/images/sudaderaA.jpg',
        'assets/images/manga.jpg',
        'assets/images/sudaderaF2.jpg',
      ],
      'title': 'Sudadera Árbol',
      'tallas': ['M', 'L'],
      'precio': '350',
    },
    {
      'images': [
        'assets/images/sudaderaTronco.jpeg',
        'assets/images/sudaderaT2.jpg',
        'assets/images/manga.jpg',
        'assets/images/sudaderaF2.jpg',
      ],
      'title': 'Sudadera Tronco',
      'tallas': ['M', 'L'],
      'precio': '350',
    },
    {
      'images': [
        'assets/images/sudaderaTortuga.jpeg',
        'assets/images/sudaderaT.jpg',
        'assets/images/manga.jpg',
        'assets/images/sudaderaF2.jpg',
      ],
      'title': 'Sudadera Tortuga',
      'tallas': ['M', 'L'],
      'precio': '350',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return BaseScreen(
      selectedIndex: 0,
      title: 'Menú',
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const Text(
              'Seleccionar contenedor',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: AppTheme.textColor,
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: GridView.builder(
                itemCount: products.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  childAspectRatio: 0.85,
                ),
                itemBuilder: (context, index) {
                  final product = products[index];
                  final images = List<String>.from(product['images'] as List);
                  final tallas = List<String>.from(product['tallas'] as List);

                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder:
                              (_) => ProductDetailScreen(
                                title: product['title'],
                                imagePath: images[0],
                                images: images,
                                tallas: tallas,
                                precio: product['precio'],
                              ),
                        ),
                      );
                    },
                    child: imageContainer(images[0], product['title']),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget imageContainer(String imagePath, String label) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
      elevation: 10,
      color: AppTheme.iconColor,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20.0),
                child: Image.asset(
                  imagePath,
                  fit: BoxFit.cover,
                  width: double.infinity,
                ),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              label,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: AppTheme.textColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
