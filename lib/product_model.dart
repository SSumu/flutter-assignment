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
      id: json['id'] ?? 0,
      title: json['title'] ?? 'No title',
      thumbnail: json['thumbnail'] ?? 'https://via.placeholder.com/150',
      price: (json['price'] ?? 0).toDouble(),
      brand: json['brand'] ?? 'Unknown',
      images: (json['images'] != null)
          ? List<String>.from(json['images'])
          : ['https://via.placeholder.com/150'],
      rating: (json['rating'] ?? 0).toDouble(),
      description: json['description'] ?? 'No description availabel',
    );
  }
}
