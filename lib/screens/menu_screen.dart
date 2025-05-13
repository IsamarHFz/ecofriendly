import 'package:ecofriendly/screens/base_screen.dart';
import 'package:ecofriendly/screens/products_screen.dart';
import 'package:ecofriendly/screens/select_product.dart';
import 'package:ecofriendly/theme/app_theme.dart';
import 'package:flutter/material.dart';

class MenuPrincipal extends StatefulWidget {
  const MenuPrincipal({super.key});

  @override
  State<MenuPrincipal> createState() => _MenuPrincipalState();
}

class _MenuPrincipalState extends State<MenuPrincipal> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return BaseScreen(
      body: Scaffold(
        backgroundColor: Colors.transparent,
        body: ListView(children: [imageCard()]),
      ),
      selectedIndex:
          selectedIndex, // Establecer el índice seleccionado para el BottomNavigationBar
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
              'Ecofriendly',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24.0),
            ),
          ),
          const Center(
            child: Text(
              'Bienvenid@',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24.0),
            ),
          ),
          const SizedBox(height: 20.0),
          Table(
            children: [
              TableRow(
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const SelectContainer(),
                        ),
                      );
                    },
                    child: imageContainer(
                      'assets/images/sudaderaTortuga.png',
                      'Sudadera',
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const ProductsScreen(),
                        ),
                      );
                    },
                    child: imageContainer(
                      'assets/images/sudaderaTronco.jpeg',
                      'Sudadera',
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const ProductsScreen(),
                        ),
                      );
                    },
                    child: imageContainer(
                      'assets/images/sudaderaArbol.jpegg',
                      'Sudadera',
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const ProductsScreen(),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget imageContainer(String imagePath, String title1) {
    return SizedBox(
      width: 150,
      height: 200,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        elevation: 10,
        color: AppTheme.iconColor,
        child: Container(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(20.0),
                child: Image(
                  width: 120,
                  height: 120,
                  image: AssetImage(imagePath),
                ),
              ),
              const SizedBox(height: 8),
              Text(title1, style: const TextStyle(fontWeight: FontWeight.bold)),
            ],
          ),
        ),
      ),
    );
  }
}
