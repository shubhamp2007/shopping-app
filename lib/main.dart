import 'package:flutter/material.dart';
import 'package:shopping_app/managers/cart_wishlist_manager.dart';
import 'package:shopping_app/pages/cart_page.dart';
import 'package:shopping_app/pages/wishlist_page.dart';
import 'package:shopping_app/pages/home_page.dart';

void main() {
  runApp(const Main());
}

class Main extends StatefulWidget {
  const Main({super.key});

  @override
  State<Main> createState() => _MainState();
}

class _MainState extends State<Main> {
  int _selectedIndex = 0;
  void _navigateBottomBar(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  final List _pages = [HomePage(), WishlistPage(), CartPage()];

  @override
  Widget build(BuildContext context) {
    final manager = CartWishlistManager.instance;

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Bytekart",
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.grey,
          brightness: Brightness.light,
        ),
        useMaterial3: true,
      ),
      home: Scaffold(
        body: _pages[_selectedIndex],
        bottomNavigationBar: ListenableBuilder(
          listenable: manager,
          builder: (context, _) {
            return NavigationBar(
              selectedIndex: _selectedIndex,
              onDestinationSelected: _navigateBottomBar,
              destinations: [
                const NavigationDestination(
                  icon: Icon(Icons.home),
                  label: 'Home',
                ),
                NavigationDestination(
                  icon: Badge(
                    isLabelVisible: manager.wishlistCount > 0,
                    label: Text('${manager.wishlistCount}'),
                    child: const Icon(Icons.favorite_rounded),
                  ),
                  label: 'Wishlist',
                ),
                NavigationDestination(
                  icon: Badge(
                    isLabelVisible: manager.cartCount > 0,
                    label: Text('${manager.cartCount}'),
                    child: const Icon(Icons.shopping_cart),
                  ),
                  label: 'Cart',
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
