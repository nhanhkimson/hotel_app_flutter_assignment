import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:hotel_app/core/constants/app_constants.dart';

/// Service for managing app data
class DataService {
  static final DataService _instance = DataService._internal();
  factory DataService() => _instance;
  DataService._internal();

  List<Map<String, dynamic>>? _hotels;
  List<Map<String, dynamic>>? _rooms;
  List<Map<String, dynamic>>? _bookings;
  List<Map<String, dynamic>>? _notifications;
  Map<String, dynamic>? _currentLocation;
  bool _isLoaded = false;

  bool get isLoaded => _isLoaded;

  /// Load all data from separate JSON files (loaded in parallel for better performance)
  Future<void> loadData() async {
    if (_isLoaded) return;

    try {
      // Load all files in parallel for better performance
      final results = await Future.wait([
        rootBundle.loadString(AppConstants.hotelsDataPath),
        rootBundle.loadString(AppConstants.roomsDataPath),
        rootBundle.loadString(AppConstants.bookingsDataPath),
        rootBundle.loadString(AppConstants.notificationsDataPath),
        rootBundle.loadString(AppConstants.currentLocationDataPath),
      ]);

      // Parse hotels
      _hotels = (json.decode(results[0]) as List<dynamic>)
          .map((h) => h as Map<String, dynamic>)
          .toList();

      // Parse rooms
      _rooms = (json.decode(results[1]) as List<dynamic>)
          .map((r) => r as Map<String, dynamic>)
          .toList();

      // Parse bookings
      _bookings = (json.decode(results[2]) as List<dynamic>)
          .map((b) => b as Map<String, dynamic>)
          .toList();

      // Parse notifications
      _notifications = (json.decode(results[3]) as List<dynamic>)
          .map((n) => n as Map<String, dynamic>)
          .toList();

      // Parse current location
      _currentLocation = json.decode(results[4]) as Map<String, dynamic>;

      _isLoaded = true;
    } catch (e) {
      print('Error loading data: $e');
      _hotels = [];
      _rooms = [];
      _bookings = [];
      _notifications = [];
      _currentLocation = null;
      _isLoaded = false;
    }
  }

  /// Get all hotels
  List<Map<String, dynamic>> getHotels() {
    return _hotels ?? [];
  }

  /// Get rooms by hotel ID
  List<Map<String, dynamic>> getRooms({String? hotelId}) {
    final rooms = _rooms ?? [];
    if (hotelId != null && hotelId.isNotEmpty) {
      return rooms.where((r) => r['hotelId']?.toString() == hotelId).toList();
    }
    return rooms;
  }

  /// Get bookings
  List<Map<String, dynamic>> getBookings() {
    return _bookings ?? [];
  }

  /// Get hotel by ID
  Map<String, dynamic>? getHotelById(String id) {
    if (id.isEmpty) return null;
    final hotels = getHotels();
    try {
      return hotels.firstWhere((h) => h['id']?.toString() == id);
    } catch (e) {
      return null;
    }
  }

  /// Get current location
  Map<String, dynamic>? getCurrentLocation() {
    return _currentLocation;
  }

  /// Get all notifications
  List<Map<String, dynamic>> getNotifications() {
    return _notifications ?? [];
  }
}

