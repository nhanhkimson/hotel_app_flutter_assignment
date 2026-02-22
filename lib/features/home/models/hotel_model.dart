/// Hotel model
class HotelModel {
  final String id;
  final String name;
  final String location;
  final String price;
  final double rating;
  final String imageUrl;
  final String description;
  final List<String> amenities;

  HotelModel({
    required this.id,
    required this.name,
    required this.location,
    required this.price,
    required this.rating,
    required this.imageUrl,
    required this.description,
    required this.amenities,
  });

  factory HotelModel.fromJson(Map<String, dynamic> json) {
    return HotelModel(
      id: json['id']?.toString() ?? '',
      name: json['name']?.toString() ?? '',
      location: json['location']?.toString() ?? '',
      price: json['price']?.toString() ?? '0',
      rating: (json['rating'] as num?)?.toDouble() ?? 0.0,
      imageUrl: json['imageUrl']?.toString() ?? '',
      description: json['description']?.toString() ?? '',
      amenities: (json['amenities'] as List<dynamic>?)
              ?.map((e) => e.toString())
              .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'location': location,
      'price': price,
      'rating': rating,
      'imageUrl': imageUrl,
      'description': description,
      'amenities': amenities,
    };
  }
}

