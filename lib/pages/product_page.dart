import 'package:flutter/material.dart';
import 'package:shopping_app/models/product.dart';
import 'package:shopping_app/managers/cart_wishlist_manager.dart';
import 'package:shopping_app/pages/cart_page.dart';

class ProductPage extends StatefulWidget {
  final Product product;
  const ProductPage({super.key, required this.product});

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  int _selectedImageIndex = 0;
  int _quantity = 1;
  late final PageController _pageController;
  final _manager = CartWishlistManager.instance;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _selectImage(int index) {
    setState(() => _selectedImageIndex = index);
    _pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  void _addToCart() {
    _manager.addToCart(widget.product, quantity: _quantity);
  }

  @override
  Widget build(BuildContext context) {
    final product = widget.product;
    final allImages = product.images.isNotEmpty
        ? product.images
        : [product.thumbnail];

    return Scaffold(
      appBar: AppBar(
        title: Text(
          product.title,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        actions: [
          ListenableBuilder(
            listenable: _manager,
            builder: (context, _) {
              final wishlisted = _manager.isWishlisted(product);
              return IconButton(
                icon: Icon(
                  wishlisted ? Icons.favorite : Icons.favorite_border,
                  color: wishlisted ? Colors.red : null,
                ),
                onPressed: () => _manager.toggleWishlist(product),
              );
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              children: [
                Container(
                  height: 300,
                  color: Colors.grey.shade100,
                  child: PageView.builder(
                    controller: _pageController,
                    itemCount: allImages.length,
                    onPageChanged: (i) =>
                        setState(() => _selectedImageIndex = i),
                    itemBuilder: (context, index) => Padding(
                      padding: const EdgeInsets.all(16),
                      child: Image.network(
                        allImages[index],
                        fit: BoxFit.contain,
                        errorBuilder: (context, error, stack) => const Icon(
                          Icons.image_not_supported,
                          size: 48,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                  ),
                ),
                if (allImages.length > 1)
                  SizedBox(
                    height: 72,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      padding: const EdgeInsets.all(8),
                      itemCount: allImages.length,
                      separatorBuilder: (_, _) => const SizedBox(width: 8),
                      itemBuilder: (context, index) {
                        final isSelected = index == _selectedImageIndex;
                        return GestureDetector(
                          onTap: () => _selectImage(index),
                          child: Container(
                            width: 56,
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: isSelected
                                    ? Colors.black
                                    : Colors.grey.shade300,
                                width: isSelected ? 2 : 1,
                              ),
                              borderRadius: BorderRadius.circular(8),
                              color: Colors.grey.shade100,
                            ),
                            padding: const EdgeInsets.all(4),
                            child: Image.network(
                              allImages[index],
                              fit: BoxFit.contain,
                              errorBuilder: (context, error, stack) =>
                                  const Icon(Icons.image, color: Colors.grey),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              product.title,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Row(
                            children: [
                              Icon(
                                Icons.star,
                                size: 16,
                                color: Colors.amber.shade600,
                              ),
                              const SizedBox(width: 2),
                              Text('${product.rating}'),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Text(
                        '₹${product.price.toStringAsFixed(2)}',
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 16),
                      const Text(
                        'Description',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        product.description,
                        style: TextStyle(
                          color: Colors.grey.shade700,
                          height: 1.5,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Row(
                        children: [
                          const Text(
                            'Quantity',
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                            ),
                          ),
                          const Spacer(),
                          IconButton(
                            icon: const Icon(Icons.remove),
                            onPressed: _quantity > 1
                                ? () => setState(() => _quantity--)
                                : null,
                          ),
                          Text(
                            '$_quantity',
                            style: const TextStyle(fontSize: 16),
                          ),
                          IconButton(
                            icon: const Icon(Icons.add),
                            onPressed: () => setState(() => _quantity++),
                          ),
                        ],
                      ),
                      const Divider(),
                      Row(
                        children: [
                          Icon(
                            Icons.local_shipping_outlined,
                            size: 16,
                            color: Colors.grey.shade600,
                          ),
                          const SizedBox(width: 6),
                          Text(
                            product.shippingInformation,
                            style: const TextStyle(fontSize: 14),
                          ),
                        ],
                      ),
                      const SizedBox(height: 6),
                      Row(
                        children: [
                          Icon(
                            Icons.verified_outlined,
                            size: 16,
                            color: Colors.grey.shade600,
                          ),
                          const SizedBox(width: 6),
                          Text(
                            product.warrantyInformation,
                            style: const TextStyle(fontSize: 14),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              left: 16,
              top: 8,
              right: 16,
              bottom: 24,
            ),
            child: Row(
              children: [
                Expanded(
                  child: ListenableBuilder(
                    listenable: _manager,
                    builder: (context, _) {
                      final inCart = _manager.isInCart(widget.product);
                      return OutlinedButton.icon(
                        onPressed: inCart
                            ? () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => const CartPage(),
                                ),
                              )
                            : _addToCart,
                        icon: Icon(
                          inCart
                              ? Icons.shopping_cart
                              : Icons.add_shopping_cart,
                        ),
                        label: Text(inCart ? 'Go to Cart' : 'Add to Cart'),
                      );
                    },
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: FilledButton(
                    onPressed: () {},
                    style: FilledButton.styleFrom(
                      backgroundColor: Colors.black,
                    ),
                    child: const Text('Buy Now'),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
