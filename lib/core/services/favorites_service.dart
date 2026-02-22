import 'package:flutter/foundation.dart';
import 'package:hotel_app/features/home/models/hotel_model.dart';

/// Service for managing favorite/bookmarked hotels
class FavoritesService extends ChangeNotifier {
  static final FavoritesService _instance = FavoritesService._internal();
  factory FavoritesService() => _instance;
  FavoritesService._internal();

  final List<HotelModel> _favorites = [];

  List<HotelModel> get favorites => List.unmodifiable(_favorites);
  int get favoriteCount => _favorites.length;

  /// Check if a hotel is favorited
  bool isFavorite(String hotelId) {
    return _favorites.any((hotel) => hotel.id == hotelId);
  }

  /// Toggle favorite status
  void toggleFavorite(HotelModel hotel) {
    if (isFavorite(hotel.id)) {
      _favorites.removeWhere((h) => h.id == hotel.id);
    } else {
      _favorites.add(hotel);
    }
    notifyListeners();
  }

  /// Add to favorites
  void addFavorite(HotelModel hotel) {
    if (!isFavorite(hotel.id)) {
      _favorites.add(hotel);
      notifyListeners();
    }
  }

  /// Remove from favorites
  void removeFavorite(String hotelId) {
    _favorites.removeWhere((h) => h.id == hotelId);
    notifyListeners();
  }

  /// Clear all favorites
  void clearFavorites() {
    _favorites.clear();
    notifyListeners();
  }
}

