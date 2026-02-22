import 'package:flutter/foundation.dart';
import 'package:hotel_app/core/services/notification_service.dart';
import 'package:hotel_app/features/notifications/models/notification_model.dart';

/// Service for managing shopping cart and orders
class CartService extends ChangeNotifier {
  static final CartService _instance = CartService._internal();
  factory CartService() => _instance;
  CartService._internal();

  final List<Map<String, dynamic>> _cartItems = [];
  final List<Map<String, dynamic>> _orders = [];

  List<Map<String, dynamic>> get cartItems => List.unmodifiable(_cartItems);
  List<Map<String, dynamic>> get orders => List.unmodifiable(_orders);

  /// Add item to cart
  void addToCart(Map<String, dynamic> item) {
    _cartItems.add(item);
    notifyListeners();
  }

  /// Remove item from cart by index
  void removeFromCart(int index) {
    if (index >= 0 && index < _cartItems.length) {
      _cartItems.removeAt(index);
      notifyListeners();
    }
  }

  /// Clear cart
  void clearCart() {
    _cartItems.clear();
    notifyListeners();
  }

  /// Add order
  void addOrder(Map<String, dynamic> order) {
    _orders.add(order);
    notifyListeners();
  }

  /// Calculate total price
  double getTotalPrice() {
    double total = 0;
    for (var item in _cartItems) {
      final priceStr = item['price']?.toString().replaceAll('\$', '') ?? '0';
      final price = double.tryParse(priceStr) ?? 0;
      total += price;
    }
    return total;
  }

  /// Checkout - move cart items to orders
  void checkout() {
    final notificationService = NotificationService();
    double totalPrice = getTotalPrice();
    
    for (var item in _cartItems) {
      addOrder({
        ...item,
        'orderDate': DateTime.now().toString(),
        'status': 'confirmed',
      });
    }
    
    // Create notification for successful booking
    final hotelName = _cartItems.isNotEmpty 
        ? _cartItems[0]['hotelName']?.toString() ?? 'Hotel'
        : 'Hotel';
    
    notificationService.addNotification(
      NotificationModel(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        title: 'Booking Confirmed',
        message: 'Your booking at $hotelName has been confirmed. Total: \$${totalPrice.toStringAsFixed(2)}',
        type: 'booking',
        dateTime: DateTime.now(),
        actionUrl: '/orders',
      ),
    );
    
    clearCart();
  }

  /// Check if cart is empty
  bool get isEmpty => _cartItems.isEmpty;

  /// Get cart item count
  int get itemCount => _cartItems.length;
}

