/// Room model
class RoomModel {
  final String id;
  final String hotelId;
  final String name;
  final String location;
  final String date;
  final String price;
  final List<String> features;
  final String imageUrl;

  RoomModel({
    required this.id,
    required this.hotelId,
    required this.name,
    required this.location,
    required this.date,
    required this.price,
    required this.features,
    required this.imageUrl,
  });

  factory RoomModel.fromJson(Map<String, dynamic> json) {
    return RoomModel(
      id: json['id']?.toString() ?? '',
      hotelId: json['hotelId']?.toString() ?? '',
      name: json['name']?.toString() ?? '',
      location: json['location']?.toString() ?? '',
      date: json['date']?.toString() ?? '',
      price: json['price']?.toString() ?? '0',
      features: (json['features'] as List<dynamic>?)
              ?.map((e) => e.toString())
              .toList() ??
          [],
      imageUrl: json['imageUrl']?.toString() ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'hotelId': hotelId,
      'name': name,
      'location': location,
      'date': date,
      'price': price,
      'features': features,
      'imageUrl': imageUrl,
    };
  }
}

