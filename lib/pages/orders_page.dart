import 'package:flutter/material.dart';
import 'package:shopping_app/models/my_products.dart';
import 'package:shopping_app/models/product.dart';

class OrdersPage extends StatelessWidget {
  const OrdersPage({super.key});

  @override
  Widget build(BuildContext context) {
    final products = MyProducts.allProducts.take(3).toList();

    return Scaffold(
      appBar: AppBar(
        title: Text('My Orders', style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
      ),
      body: DefaultTabController(
        length: 3,
        child: Column(
          children: [
            TabBar(
              tabs: [
                Tab(text: 'Ongoing'),
                Tab(text: 'Completed'),
                Tab(text: 'Cancelled'),
              ],
              labelColor: Colors.black,
              unselectedLabelColor: Colors.grey.shade800,
              indicatorColor: Colors.black,
              labelStyle: const TextStyle(fontWeight: FontWeight.bold),
              unselectedLabelStyle: const TextStyle(
                fontWeight: FontWeight.w600,
              ),
              padding: EdgeInsets.symmetric(horizontal: 16),
            ),
            Expanded(
              child: TabBarView(
                children: [
                  _OrderListView(products: products, status: 'Ongoing'),
                  _OrderListView(products: products, status: 'Completed'),
                  _OrderListView(products: products, status: 'Cancelled'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _OrderListView extends StatelessWidget {
  final List<Product> products;
  final String status;

  const _OrderListView({required this.products, required this.status});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverList.builder(
          itemCount: products.length,
          itemBuilder: (context, index) {
            return _OrderItem(product: products[index], status: status);
          },
        ),
      ],
    );
  }
}

class _OrderItem extends StatelessWidget {
  final Product product;
  final String status;

  const _OrderItem({required this.product, required this.status});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.grey.shade100,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          children: [
            Container(
              width: 90,
              height: 90,
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: BorderRadius.circular(12),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.network(product.thumbnail, fit: BoxFit.cover),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    product.title,
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '₹${product.price}',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {},
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 18,
                            vertical: 8,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.grey.shade900,
                            borderRadius: BorderRadius.circular(32),
                          ),
                          child: Text(
                            status == 'Completed'
                                ? 'Reorder'
                                : status == 'Cancelled'
                                ? 'Order Again'
                                : 'Track Order',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
