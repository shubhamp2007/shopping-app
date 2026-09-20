import 'package:flutter/material.dart';
import 'package:shopping_app/managers/cart_wishlist_manager.dart';
import 'package:shopping_app/widgets/product_card.dart';

class WishlistPage extends StatelessWidget {
  const WishlistPage({super.key});

  @override
  Widget build(BuildContext context) {
    final manager = CartWishlistManager.instance;

    return Scaffold(
      appBar: AppBar(
        title: const Align(
          alignment: Alignment.center,
          child: Text(
            'Wishlist',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
      ),
      body: ListenableBuilder(
        listenable: manager,
        builder: (context, _) {
          final wishlistProducts = manager.wishlistItems;

          if (wishlistProducts.isEmpty) {
            return const Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.favorite_border, size: 64, color: Colors.grey),
                  SizedBox(height: 16),
                  Text(
                    'Your wishlist is empty',
                    style: TextStyle(fontSize: 18, color: Colors.grey),
                  ),
                  SizedBox(height: 4),
                  Text(
                    'Add anything you love',
                    style: TextStyle(fontSize: 14, color: Colors.grey),
                  ),
                ],
              ),
            );
          }

          return CustomScrollView(
            slivers: [
              SliverPadding(
                padding: const EdgeInsets.all(12),
                sliver: SliverGrid(
                  delegate: SliverChildBuilderDelegate((context, index) {
                    return ProductCard(product: wishlistProducts[index]);
                  }, childCount: wishlistProducts.length),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12,
                    childAspectRatio: 0.78,
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
