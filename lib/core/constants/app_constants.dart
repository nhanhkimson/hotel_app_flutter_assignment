/// Application-wide constants
class AppConstants {
  // App Info
  static const String appName = 'StayHub';
  static const String appVersion = '1.0.0';

  // Assets
  static const String appLogoPath = 'assets/static/App/logo.png';

  // API/Data - JSON file paths
  static const String hotelsDataPath = 'assets/data/hotels.json';
  static const String roomsDataPath = 'assets/data/rooms.json';
  static const String bookingsDataPath = 'assets/data/bookings.json';
  static const String notificationsDataPath = 'assets/data/notifications.json';
  static const String currentLocationDataPath = 'assets/data/current_location.json';

  // Navigation
  static const int homeTabIndex = 0;
  static const int cartTabIndex = 1;
  static const int favoritesTabIndex = 2;
  static const int profileTabIndex = 3;

  // Delays
  static const Duration splashDelay = Duration(seconds: 2);
  static const Duration snackbarDuration = Duration(seconds: 2);

  // Defaults
  static const int defaultGuests = 2;
  static const int defaultRating = 0;
}

/// App Routes
class AppRoutes {
  static const String splash = '/';
  static const String signIn = '/sign-in';
  static const String register = '/register';
  static const String forgotPassword = '/forgot-password';
  static const String verifyCode = '/verify-code';
  static const String newPassword = '/new-password';
  static const String home = '/home';
  static const String hotelDetail = '/hotel-detail';
  static const String selectRoom = '/select-room';
  static const String schedule = '/schedule';
  static const String bookingSuccess = '/booking-success';
  static const String cart = '/cart';
  static const String orders = '/orders';
  static const String profile = '/profile';
  static const String search = '/search';
}

