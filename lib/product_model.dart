class Product {
  final int id;
  final String title;
  final String thumbnail;
  final double price;
  final String brand;
  final List<String> images;
  final double rating;
  final String description;

  Product({
    required this.id,
    required this.title,
    required this.thumbnail,
    required this.price,
    required this.brand,
    required this.images,
    required this.rating,
    required this.description,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      title: json['title'],
      thumbnail: json['thumbnail'] ?? 'https://via.placeholder.com/150',
      price: json['price'].toDouble(),
      brand: json['brand'],
      images: List<String>.from(json['images']),
      rating: json['rating'].toDouble(),
      description: json['description'],
    );
  }
}
