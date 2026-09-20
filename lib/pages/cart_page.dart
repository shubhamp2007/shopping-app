import 'package:flutter/material.dart';
import 'package:shopping_app/managers/cart_wishlist_manager.dart';
import 'package:shopping_app/widgets/cart_product_card.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    final manager = CartWishlistManager.instance;

    return Scaffold(
      appBar: AppBar(
        title: const Align(
          alignment: Alignment.center,
          child: Text('Cart', style: TextStyle(fontWeight: FontWeight.bold)),
        ),
      ),
      body: ListenableBuilder(
        listenable: manager,
        builder: (context, _) {
          final cartProducts = manager.cartItems;
          final total = manager.cartTotal;

          if (cartProducts.isEmpty) {
            return const Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.shopping_cart_outlined,
                    size: 64,
                    color: Colors.grey,
                  ),
                  SizedBox(height: 16),
                  Text(
                    'Your cart is empty',
                    style: TextStyle(fontSize: 18, color: Colors.grey),
                  ),
                  SizedBox(height: 4),
                  Text(
                    'Add items from the product page',
                    style: TextStyle(fontSize: 14, color: Colors.grey),
                  ),
                ],
              ),
            );
          }

          return Column(
            children: [
              Expanded(
                child: CustomScrollView(
                  slivers: [
                    SliverPadding(
                      padding: const EdgeInsets.all(16),
                      sliver: SliverList.separated(
                        itemCount: cartProducts.length,
                        itemBuilder: (context, index) {
                          return CartProductCard(product: cartProducts[index]);
                        },
                        separatorBuilder: (context, index) =>
                            const SizedBox(height: 16),
                      ),
                    ),
                    SliverToBoxAdapter(
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          children: [
                            const Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                'Order Summary',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            const SizedBox(height: 12),
                            Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(16),
                                child: Column(
                                  children: [
                                    _Row(
                                      label: 'Sub Total:',
                                      value: '₹${total.toStringAsFixed(2)}',
                                    ),
                                    const SizedBox(height: 8),
                                    _Row(label: 'Discount:', value: '₹00.00'),
                                    const SizedBox(height: 8),
                                    _Row(label: 'Tax:', value: '₹00.00'),
                                    const Divider(height: 24),
                                    _Row(
                                      label: 'Total',
                                      value: '₹${total.toStringAsFixed(2)}',
                                      bold: true,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              _CheckoutBar(total: total),
            ],
          );
        },
      ),
    );
  }
}

class _Row extends StatelessWidget {
  final String label;
  final String value;
  final bool bold;

  const _Row({required this.label, required this.value, this.bold = false});

  @override
  Widget build(BuildContext context) {
    final style = TextStyle(
      fontSize: bold ? 16 : 14,
      fontWeight: bold ? FontWeight.bold : FontWeight.normal,
      color: bold ? Colors.black : Colors.grey.shade600,
    );

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: style),
        Text(value, style: style.copyWith(color: Colors.black)),
      ],
    );
  }
}

class _CheckoutBar extends StatelessWidget {
  final double total;
  const _CheckoutBar({required this.total});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        decoration: BoxDecoration(color: Colors.white),
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Total Amount',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey.shade500,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  '₹${total.toStringAsFixed(0)}',
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(width: 16),
            Expanded(
              child: FilledButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.arrow_forward, size: 18),
                label: const Text(
                  'Proceed to Checkout',
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 15),
                ),
                iconAlignment: IconAlignment.end,
                style: FilledButton.styleFrom(
                  backgroundColor: Colors.black,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
