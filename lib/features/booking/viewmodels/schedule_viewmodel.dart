import 'package:hotel_app/core/base/base_viewmodel.dart';
import 'package:hotel_app/core/services/cart_service.dart';
import 'package:hotel_app/core/services/data_service.dart';
import 'package:hotel_app/features/booking/models/booking_model.dart';

/// ViewModel for Schedule Screen
class ScheduleViewModel extends BaseViewModel {
  final DataService _dataService = DataService();
  final CartService _cartService = CartService();
  final Map<String, dynamic>? selectedRoom;

  final List<BookingModel> _bookings = [];
  DateTime _selectedDate = DateTime(2026, 1, 25);

  List<BookingModel> get bookings => _bookings;
  DateTime get selectedDate => _selectedDate;

  ScheduleViewModel({this.selectedRoom});

  @override
  void init() {
    super.init();
    loadBookings();
  }

  /// Load bookings
  Future<void> loadBookings() async {
    await executeWithLoading(() async {
      if (selectedRoom != null) {
        _bookings.add(BookingModel.fromJson(selectedRoom!));
      }
      final dataBookings = _dataService.getBookings();
      if (_bookings.isEmpty && dataBookings.isNotEmpty) {
        _bookings.addAll(
          dataBookings.map((b) => BookingModel.fromJson(b)).toList(),
        );
      }
      notifyListeners();
    });
  }

  /// Select a date
  void selectDate(DateTime date) {
    _selectedDate = date;
    notifyListeners();
  }

  /// Check if a date has a booking
  bool hasBookingOnDate(int day) {
    return _bookings.any((booking) {
      try {
        final bookingDay = int.tryParse(booking.date.split(' ')[0]);
        return bookingDay == day;
      } catch (e) {
        return false;
      }
    });
  }

  /// Add bookings to cart
  void addToCart() {
    for (var booking in _bookings) {
      _cartService.addToCart(booking.toJson());
    }
  }

  /// Get booking count
  int get bookingCount => _bookings.length;
}

