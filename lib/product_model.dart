class Product {
  final int id;
  final String title;
  final String thumbnail;
  final double price;
  final String brand;

  Product({
    required this.id,
    required this.title,
    required this.thumbnail,
    required this.price,
    required this.brand,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      title: json['title'],
      thumbnail: json['thumbnail'] ?? 'https://via.placeholder.com/150',
      price: json['price'].toDouble(),
      brand: json['brand'],
    );
  }
}
