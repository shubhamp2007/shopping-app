import 'package:flutter/foundation.dart';
import 'package:shopping_app/models/product.dart';

class CartWishlistManager extends ChangeNotifier {
  CartWishlistManager._();
  static final instance = CartWishlistManager._();

  final Map<int, Product> _wishlist = {};
  List<Product> get wishlistItems => _wishlist.values.toList();
  int get wishlistCount => _wishlist.length;

  bool isWishlisted(Product product) => _wishlist.containsKey(product.id);

  void toggleWishlist(Product product) {
    isWishlisted(product)
        ? _wishlist.remove(product.id)
        : _wishlist[product.id] = product;
    notifyListeners();
  }

  final Map<int, Product> _cartProducts = {};
  final Map<int, int> _cartQuantities = {};

  List<Product> get cartItems => _cartProducts.values.toList();
  int get cartCount => _cartProducts.length;

  bool isInCart(Product product) => _cartProducts.containsKey(product.id);

  int cartQuantity(Product product) => _cartQuantities[product.id] ?? 0;

  double get cartTotal => _cartProducts.values.fold(
    0,
    (sum, p) => sum + p.price * _cartQuantities[p.id]!,
  );

  void addToCart(Product product, {int quantity = 1}) {
    _cartProducts[product.id] = product;
    _cartQuantities[product.id] = cartQuantity(product) + quantity;
    notifyListeners();
  }

  void removeFromCart(Product product) {
    _cartProducts.remove(product.id);
    _cartQuantities.remove(product.id);
    notifyListeners();
  }

  void increaseQuantity(Product product) {
    if (!isInCart(product)) return;
    _cartQuantities[product.id] = cartQuantity(product) + 1;
    notifyListeners();
  }

  void decreaseQuantity(Product product) {
    if (!isInCart(product)) return;
    if (cartQuantity(product) > 1) {
      _cartQuantities[product.id] = cartQuantity(product) - 1;
    } else {
      removeFromCart(product);
    }
    notifyListeners();
  }
}
