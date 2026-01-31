class CartService {
  static final CartService _instance = CartService._internal();
  factory CartService() => _instance;
  CartService._internal();

  final List<Map<String, dynamic>> _cartItems = [];
  final List<Map<String, dynamic>> _orders = [];

  List<Map<String, dynamic>> get cartItems => _cartItems;
  List<Map<String, dynamic>> get orders => _orders;

  void addToCart(Map<String, dynamic> item) {
    _cartItems.add(item);
  }

  void removeFromCart(int index) {
    if (index >= 0 && index < _cartItems.length) {
      _cartItems.removeAt(index);
    }
  }

  void clearCart() {
    _cartItems.clear();
  }

  void addOrder(Map<String, dynamic> order) {
    _orders.add(order);
  }

  double getTotalPrice() {
    double total = 0;
    for (var item in _cartItems) {
      final priceStr = item['price']?.toString().replaceAll('\$', '') ?? '0';
      final price = double.tryParse(priceStr) ?? 0;
      total += price;
    }
    return total;
  }
}

