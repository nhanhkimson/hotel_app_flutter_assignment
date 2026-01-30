
class Hotel {
  final String id;
  final String name;
  final String location;
  final String price;
  final double rating;
  final String imageUrl;
  final String description;

  Hotel({
    required this.id,
    required this.name,
    required this.location,
    required this.price,
    required this.rating,
    required this.imageUrl,
    required this.description,
  });

  // Convert from JSON
  factory Hotel.fromJson(Map<String, dynamic> json) {
    return Hotel(
      id: json['id'],
      name: json['name'],
      location: json['location'],
      price: json['price'],
      rating: json['rating'].toDouble(),
      imageUrl: json['imageUrl'],
      description: json['description'],
    );
  }

  // Convert to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'location': location,
      'price': price,
      'rating': rating,
      'imageUrl': imageUrl,
      'description': description,
    };
  }
}