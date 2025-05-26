import 'package:ecofriendly/screens/menu_screen.dart';
import 'package:ecofriendly/screens/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:ecofriendly/screens/cart_screen.dart';
import 'package:ecofriendly/screens/contact_screen.dart';
import 'package:ecofriendly/screens/home_screen.dart';
import 'package:ecofriendly/theme/app_theme.dart';

class BaseScreen extends StatefulWidget {
  final Widget body;
  final int selectedIndex;
  final String title;

  const BaseScreen({
    super.key,
    required this.body,
    this.selectedIndex = 0,
    this.title = '',
  });

  @override
  State<BaseScreen> createState() => BaseScreenState();
}

class BaseScreenState extends State<BaseScreen> {
  void openScreen(BuildContext context, int index) {
    if (index == widget.selectedIndex) return;

    late Widget screen;
    switch (index) {
      case 0:
        screen = const MenuScreen();
        break;
      case 1:
        screen = CartScreen();
        break;
      case 2:
        screen = const ProfileScreen();
        break;
    }

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder:
            (context) => BaseScreen(
              body: screen,
              selectedIndex: index,
              title: widget.title,
            ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: AppTheme.foundColor,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          title: Text(widget.title),
          backgroundColor: Colors.transparent,
          elevation: 0,
          iconTheme: const IconThemeData(color: Colors.black),
        ),
        drawer: Drawer(
          child: ListView(
            children: <Widget>[
              const DrawerHeader(
                decoration: BoxDecoration(color: AppTheme.buttonColor),
                child: Text(
                  '',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              ListTile(
                leading: const Icon(Icons.contact_mail),
                title: const Text('Contáctanos'),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ContactScreen(),
                    ),
                  );
                },
              ),
              ListTile(
                leading: const Icon(Icons.person_2),
                title: const Text('Perfil'),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ProfileScreen(),
                    ),
                  );
                },
              ),
              ListTile(
                leading: const Icon(Icons.exit_to_app),
                title: const Text('Cerrar sesión'),
                onTap: () {
                  Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (context) => const HomeScreen()),
                    (route) => false,
                  );
                },
              ),
            ],
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.only(top: 12.0),
          child: widget.body,
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: widget.selectedIndex,
          onTap: (index) => openScreen(context, index),
          backgroundColor: Colors.white,
          selectedItemColor: Colors.green,
          unselectedItemColor: Colors.grey,
          selectedLabelStyle: const TextStyle(
            color: Color.fromARGB(255, 18, 88, 20),
            fontWeight: FontWeight.bold,
          ),
          unselectedLabelStyle: const TextStyle(color: Colors.grey),
          showUnselectedLabels: true,
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Inicio'),
            BottomNavigationBarItem(
              icon: Icon(Icons.shopping_cart),
              label: 'Carrito',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person_2),
              label: 'Perfil',
            ),
          ],
        ),
      ),
    );
  }
}
