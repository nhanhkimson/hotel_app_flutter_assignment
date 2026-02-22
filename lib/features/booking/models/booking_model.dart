/// Booking model
class BookingModel {
  final String id;
  final String hotelName;
  final String location;
  final String date;
  final String price;
  final String imageUrl;

  BookingModel({
    required this.id,
    required this.hotelName,
    required this.location,
    required this.date,
    required this.price,
    required this.imageUrl,
  });

  factory BookingModel.fromJson(Map<String, dynamic> json) {
    return BookingModel(
      id: json['id']?.toString() ?? '',
      hotelName: json['hotelName']?.toString() ?? json['name']?.toString() ?? '',
      location: json['location']?.toString() ?? '',
      date: json['date']?.toString() ?? '',
      price: json['price']?.toString() ?? '0',
      imageUrl: json['imageUrl']?.toString() ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': hotelName,
      'hotelName': hotelName,
      'location': location,
      'date': date,
      'price': price,
      'imageUrl': imageUrl,
    };
  }
}

