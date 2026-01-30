class Booking {
  final String id;
  final String hotelName;
  final String location;
  final String dates;
  final String details;
  final String price;
  final BookingStatus status;

  Booking({
    required this.id,
    required this.hotelName,
    required this.location,
    required this.dates,
    required this.details,
    required this.price,
    required this.status,
  });

  // Convert from JSON
  factory Booking.fromJson(Map<String, dynamic> json) {
    return Booking(
      id: json['id'],
      hotelName: json['hotelName'],
      location: json['location'],
      dates: json['dates'],
      details: json['details'],
      price: json['price'],
      status: BookingStatus.values.firstWhere(
        (e) => e.toString() == 'BookingStatus.${json['status']}',
      ),
    );
  }

  // Convert to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'hotelName': hotelName,
      'location': location,
      'dates': dates,
      'details': details,
      'price': price,
      'status': status.toString().split('.').last,
    };
  }
}

enum BookingStatus {
  confirmed,
  pending,
  cancelled,
}