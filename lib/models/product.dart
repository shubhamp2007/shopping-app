class Product {
  final int id;
  final String title;
  final String description;
  final String category;
  final double price;
  final double discountPercentage;
  final double rating;
  final String brand;
  final String warrantyInformation;
  final String shippingInformation;
  final String availabilityStatus;
  final List<String> images;
  final String thumbnail;

  Product({
    required this.id,
    required this.title,
    required this.description,
    required this.category,
    required this.price,
    required this.discountPercentage,
    required this.rating,
    required this.brand,
    required this.warrantyInformation,
    required this.shippingInformation,
    required this.availabilityStatus,
    required this.images,
    required this.thumbnail,
  });
}
