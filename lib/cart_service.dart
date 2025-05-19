class CartService {
  static final CartService _instance = CartService._internal();
  factory CartService() => _instance;
  CartService._internal();

  final List<Map<String, dynamic>> _cartItems = [];
  
  List<Map<String, dynamic>> get cartItems => _cartItems;
  
  double get totalAmount => _cartItems.fold(0, (sum, item) => sum + (item["price"] as num) * (item["quantity"] ?? 1));

  void addToCart(Map<String, dynamic> item) {
    // Check if item already exists
    final existingIndex = _cartItems.indexWhere((element) => element["name"] == item["name"]);
    if (existingIndex != -1) {
      _cartItems[existingIndex]["quantity"] = (_cartItems[existingIndex]["quantity"] ?? 1) + 1;
    } else {
      _cartItems.add({...item, "quantity": 1});
    }
  }

  void removeFromCart(String itemName) {
    _cartItems.removeWhere((element) => element["name"] == itemName);
  }

  void clearCart() {
    _cartItems.clear();
  }

  void increaseQuantity(String itemName) {
    final index = _cartItems.indexWhere((element) => element["name"] == itemName);
    if (index != -1) {
      _cartItems[index]["quantity"] = (_cartItems[index]["quantity"] ?? 1) + 1;
    }
  }

  void decreaseQuantity(String itemName) {
    final index = _cartItems.indexWhere((element) => element["name"] == itemName);
    if (index != -1) {
      final currentQty = _cartItems[index]["quantity"] ?? 1;
      if (currentQty > 1) {
        _cartItems[index]["quantity"] = currentQty - 1;
      } else {
        _cartItems.removeAt(index);
      }
    }
  }
}