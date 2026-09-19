import 'package:flutter/material.dart';
import 'package:shopping_app/models/my_products.dart';
import 'package:shopping_app/models/product.dart';
import 'package:shopping_app/widgets/cart_product_card.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  late final List<Product> _cartProducts;

  @override
  void initState() {
    super.initState();
    _cartProducts = MyProducts.allProducts.take(4).toList();
  }

  double get _total => _cartProducts.fold(0, (sum, p) => sum + p.price);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Align(
          alignment: Alignment.center,
          child: Text('Cart', style: TextStyle(fontWeight: FontWeight.bold)),
        ),
      ),
      bottomNavigationBar: _CheckoutBar(total: _total),
      body: CustomScrollView(
        slivers: [
          SliverPadding(
            padding: const EdgeInsets.all(16),
            sliver: SliverList.separated(
              itemCount: _cartProducts.length,
              itemBuilder: (context, index) {
                return CartProductCard(product: _cartProducts[index]);
              },
              separatorBuilder: (context, index) => const SizedBox(height: 16),
            ),
          ),
        ],
      ),
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
