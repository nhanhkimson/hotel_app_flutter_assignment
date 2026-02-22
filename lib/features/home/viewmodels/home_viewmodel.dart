import 'package:hotel_app/core/base/base_viewmodel.dart';
import 'package:hotel_app/core/services/data_service.dart';
import 'package:hotel_app/core/services/notification_service.dart';
import 'package:hotel_app/features/home/models/hotel_model.dart';

/// ViewModel for Home Screen
class HomeViewModel extends BaseViewModel {
  final DataService _dataService = DataService();
  final NotificationService _notificationService = NotificationService();

  List<HotelModel> _hotels = [];
  Map<String, dynamic>? _currentLocation;

  List<HotelModel> get hotels => _hotels;
  Map<String, dynamic>? get currentLocation => _currentLocation;
  int get unreadNotificationCount => _notificationService.unreadCount;

  @override
  void init() {
    super.init();
    loadData();
    _initializeNotifications();
    _notificationService.addListener(_onNotificationServiceChanged);
  }

  /// Initialize notifications asynchronously
  Future<void> _initializeNotifications() async {
    await _notificationService.initialize();
    notifyListeners();
  }

  @override
  void dispose() {
    _notificationService.removeListener(_onNotificationServiceChanged);
    super.dispose();
  }

  void _onNotificationServiceChanged() {
    notifyListeners();
  }

  /// Load hotels and location data
  Future<void> loadData() async {
    await executeWithLoading(() async {
      final hotelsData = _dataService.getHotels();
      _hotels = hotelsData.map((h) => HotelModel.fromJson(h)).toList();
      _currentLocation = _dataService.getCurrentLocation();
      notifyListeners();
    });
  }

  /// Get formatted location string
  String getFormattedLocation() {
    if (_currentLocation == null) {
      return 'Phnom Penh, Cambodia';
    }
    final city = _currentLocation!['city'] ?? 'Phnom Penh';
    final country = _currentLocation!['country'] ?? 'Cambodia';
    return '$city, $country';
  }
}

