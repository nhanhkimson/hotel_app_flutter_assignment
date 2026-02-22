import 'package:flutter/material.dart';
import 'package:hotel_app/core/services/language_service.dart';

/// App Localizations
class AppLocalizations {
  final LanguageService _languageService = LanguageService();

  String get currentLanguage => _languageService.currentLanguage;
  bool get isEnglish => _languageService.isEnglish;

  // Common
  String get appName => _getText('StayHub', 'ស្តេយហ៊ូប');
  String get welcome => _getText('Welcome', 'សូមស្វាគមន៍');
  String get save => _getText('Save', 'រក្សាទុក');
  String get cancel => _getText('Cancel', 'បោះបង់');
  String get next => _getText('Next', 'បន្ទាប់');
  String get back => _getText('Back', 'ត្រលប់');
  String get continue_ => _getText('Continue', 'បន្ត');
  String get ok => _getText('OK', 'យល់ព្រម');
  String get loading => _getText('Loading...', 'កំពុងផ្ទុក...');
  String get error => _getText('Error', 'កំហុស');
  String get success => _getText('Success', 'ជោគជ័យ');
  String get done => _getText('Done', 'រួចរាល់');

  // Navigation
  String get home => _getText('Home', 'ទំព័រដើម');
  String get cart => _getText('Cart', 'រទេះ');
  String get favorites => _getText('Favorites', 'ចូលចិត្ត');
  String get profile => _getText('Profile', 'ប្រូហ្វាល');
  String get schedule => _getText('Schedule', 'កាលវិភាគ');
  String get orders => _getText('Orders', 'ការកម្មង់');
  String get notifications => _getText('Notifications', 'ការជូនដំណឹង');

  // Auth
  String get signIn => _getText('Sign In', 'ចូល');
  String get signUp => _getText('Sign Up', 'ចុះឈ្មោះ');
  String get register => _getText('Register', 'ចុះឈ្មោះ');
  String get login => _getText('Login', 'ចូល');
  String get logout => _getText('Logout', 'ចេញ');
  String get welcomeBack => _getText('Welcome Back', 'សូមស្វាគមន៍មកវិញ');
  String get signInToContinue => _getText('Sign in to continue', 'ចូលដើម្បីបន្ត');
  String get emailOrPhone => _getText('Email/phone number', 'អ៊ីមែល/លេខទូរស័ព្ទ');
  String get password => _getText('Password', 'ពាក្យសម្ងាត់');
  String get forgotPassword => _getText('Forgot Password?', 'ភ្លេចពាក្យសម្ងាត់?');
  String get dontHaveAccount => _getText("Don't have an account? ", 'មិនមានគណនីទេ? ');
  String get alreadyHaveAccount => _getText("Already have an account? ", 'មានគណនីរួចហើយ? ');
  String get confirmPassword => _getText('Confirm Password', 'បញ្ជាក់ពាក្យសម្ងាត់');
  String get forgotPasswordTitle => _getText('Forgot Password', 'ភ្លេចពាក្យសម្ងាត់');
  String get send => _getText('Send', 'ផ្ញើ');
  String get verifyCode => _getText('Verify Code', 'ផ្ទៀងផ្ទាត់លេខកូដ');
  String get pleaseEnterCode => _getText('Please enter your code sent to', 'សូមបញ្ចូលលេខកូដដែលបានផ្ញើទៅ');
  String get sendCodeAgain => _getText('Send code again', 'ផ្ញើលេខកូដម្តងទៀត');

  // Profile
  String get myProfile => _getText('My Profile', 'ប្រូហ្វាលរបស់ខ្ញុំ');
  String get passwordAndSecurity =>
      _getText('Password and Security', 'ពាក្យសម្ងាត់ និងសុវត្ថិភាព');
  String get transactionHistory =>
      _getText('Transaction History', 'ប្រវត្តិប្រតិបត្តិការ');
  String get fqa => _getText('FQA', 'សំណួរចម្លើយ');
  String get aboutApp => _getText('About App', 'អំពីកម្មវិធី');
  String get language => _getText('Language', 'ភាសា');

  // My Profile
  String get basicDetail => _getText('Basic Detail', 'ព័ត៌មានមូលដ្ឋាន');
  String get fullName => _getText('Full name', 'ឈ្មោះពេញ');
  String get dateOfBirth => _getText('Date of birth', 'ថ្ងៃខែឆ្នាំកំណើត');
  String get gender => _getText('Gender', 'ភេទ');
  String get male => _getText('Male', 'ប្រុស');
  String get female => _getText('Female', 'ស្រី');
  String get email => _getText('Email', 'អ៊ីមែល');

  // Password
  String get changeYourPassword =>
      _getText('Change your password', 'ផ្លាស់ប្តូរពាក្យសម្ងាត់');
  String get oldPassword => _getText('Old Password', 'ពាក្យសម្ងាត់ចាស់');
  String get newPassword => _getText('New Password', 'ពាក្យសម្ងាត់ថ្មី');
  String get showPassword => _getText('Show password', 'បង្ហាញពាក្យសម្ងាត់');
  String get forgotYourPassword =>
      _getText('Forgot your password!!!', 'ភ្លេចពាក្យសម្ងាត់!!!');
  String get passwordChangedSuccessfully =>
      _getText('Password changed successfully!', 'បានផ្លាស់ប្តូរពាក្យសម្ងាត់ដោយជោគជ័យ!');
  String get passwordChangedMessage => _getText(
      'Your password has been changed successfully we will let you know if there are more problems with your account',
      'ពាក្យសម្ងាត់របស់អ្នកត្រូវបានផ្លាស់ប្តូរដោយជោគជ័យ យើងនឹងជូនដំណឹងដល់អ្នកប្រសិនបើមានបញ្ហាបន្ថែមទៀតជាមួយគណនីរបស់អ្នក');

  // Transaction
  String get today => _getText('Today', 'ថ្ងៃនេះ');

  // Home
  String get nearLocation => _getText('Near Location', 'កន្លែងក្បែរ');
  String get currentLocation => _getText('Current Location', 'ទីតាំងបច្ចុប្បន្ន');
  String get search => _getText('Search', 'ស្វែងរក');
  String get viewAll => _getText('View All', 'មើលទាំងអស់');
  String get seeAll => _getText('See All', 'មើលទាំងអស់');
  String get perNight => _getText('/night', '/យប់');
  String get amenities => _getText('Amenities', 'ផលិតផល');
  String get gallery => _getText('Gallery', 'វិចិត្រសាល');
  String get bookingNow => _getText('Booking Now', 'កក់ឥឡូវ');
  String get selectRoomToBook => _getText('Select Room To Book', 'ជ្រើសរើសបន្ទប់ដើម្បីកក់');
  String get noRoomsAvailable => _getText('No rooms available', 'គ្មានបន្ទប់ទេ');

  // Booking
  String get addToCart => _getText('Add To Cart', 'បន្ថែមទៅរទេះ');
  String get checkout => _getText('Checkout', 'ទូទាត់');
  String get paymentSuccessful => _getText('Payment Successful!', 'បង់ប្រាក់ជោគជ័យ!');
  String get paymentSuccessMessage =>
      _getText('Your payment has been processed successfully', 'ការទូទាត់របស់អ្នកត្រូវបានដំណើរការដោយជោគជ័យ');
  String get bookingConfirmed => _getText('Your booking has been confirmed', 'ការកក់របស់អ្នកត្រូវបានបញ្ជាក់');
  String get backToSchedule => _getText('Back to Schedule', 'ត្រលប់ទៅកាលវិភាគ');
  String get itemsAddedToCart => _getText('item(s) added to cart', 'បានបន្ថែមទៅរទេះ');
  String get mySchedule => _getText('My Schedule', 'កាលវិភាគរបស់ខ្ញុំ');
  String get noBookingsYet => _getText('No bookings yet', 'គ្មានការកក់នៅឡើយ');

  // Cart
  String get cartEmpty => _getText('Your cart is empty', 'រទេះរបស់អ្នកទទេ');
  String get total => _getText('Total', 'សរុប');
  String get remove => _getText('Remove', 'ដកចេញ');
  String get noItemsInCart => _getText('No items in cart', 'គ្មានធាតុក្នុងរទេះ');

  // Favorites
  String get noFavoritesYet => _getText('No favorites yet', 'មិនទាន់មានចូលចិត្តទេ');
  String get tapHeartToAdd => _getText(
      'Tap the heart icon on hotels to add them to favorites',
      'ចុចលើរូបសញ្ញាបេះដូងនៅលើសណ្ឋាគារដើម្បីបន្ថែមទៅចូលចិត្ត');
  String get removedFromFavorites =>
      _getText('Removed from favorites', 'បានដកចេញពីចូលចិត្ត');

  // Notifications
  String get markAllRead => _getText('Mark all read', 'សម្គាល់អានទាំងអស់');
  String get clearAll => _getText('Clear all', 'លុបទាំងអស់');
  String get notificationDeleted =>
      _getText('Notification deleted', 'បានលុបការជូនដំណឹង');
  String get noNotifications => _getText('No notifications', 'គ្មានការជូនដំណឹង');

  // Common actions
  String get viewDetails => _getText('View Details', 'មើលព័ត៌មានលម្អិត');
  String get share => _getText('Share', 'ចែករំលែក');
  String get settings => _getText('Settings', 'ការកំណត់');

  // Error messages
  String get pleaseEnterEmailAndPassword =>
      _getText('Please enter email and password', 'សូមបញ្ចូលអ៊ីមែល និងពាក្យសម្ងាត់');
  String get invalidEmailOrPassword =>
      _getText('Invalid email or password', 'អ៊ីមែល ឬពាក្យសម្ងាត់មិនត្រឹមត្រូវ');
  String get pleaseFillAllFields =>
      _getText('Please fill in all fields', 'សូមបំពេញគ្រប់វាល');
  String get passwordsDoNotMatch =>
      _getText('Passwords do not match', 'ពាក្យសម្ងាត់មិនត្រូវគ្នា');
  String get passwordMinLength =>
      _getText('Password must be at least 6 characters', 'ពាក្យសម្ងាត់ត្រូវតែមានយ៉ាងហោចណាស់ ៦ តួអក្សរ');
  String get areYouSureLogout =>
      _getText('Are you sure you want to logout?', 'តើអ្នកប្រាកដថាចង់ចេញទេ?');

  String _getText(String english, String khmer) {
    return _languageService.isEnglish ? english : khmer;
  }

  /// Get AppLocalizations from context
  static AppLocalizations of(BuildContext context) {
    return AppLocalizations();
  }
}
