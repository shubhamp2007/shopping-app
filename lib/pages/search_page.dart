import 'package:flutter/material.dart';
import 'package:shopping_app/models/my_products.dart';
import 'package:shopping_app/models/product.dart';
import 'package:shopping_app/widgets/product_card.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  String _query = '';

  List<Product> get _results => MyProducts.allProducts.where((p) {
    final q = _query.toLowerCase();
    return p.title.toLowerCase().contains(q) ||
        p.brand.toLowerCase().contains(q) ||
        p.category.toLowerCase().contains(q);
  }).toList();

  @override
  Widget build(BuildContext context) {
    final results = _query.isEmpty ? [] : _results;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: TextField(
          autofocus: true,
          decoration: const InputDecoration(
            hintText: 'Search products, brands…',
            border: InputBorder.none,
          ),
          onChanged: (v) => setState(() => _query = v),
        ),
      ),
      body: _query.isEmpty
          ? const Center(
              child: Text(
                'Start typing to search',
                style: TextStyle(fontSize: 18),
              ),
            )
          : results.isEmpty
          ? const Center(
              child: Text('No results found', style: TextStyle(fontSize: 18)),
            )
          : CustomScrollView(
              slivers: [
                SliverPadding(
                  padding: const EdgeInsets.all(12),
                  sliver: SliverGrid(
                    delegate: SliverChildBuilderDelegate(
                      (context, i) => ProductCard(product: results[i]),
                      childCount: results.length,
                    ),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 12,
                          mainAxisSpacing: 12,
                          childAspectRatio: 0.78,
                        ),
                  ),
                ),
              ],
            ),
    );
  }
}
