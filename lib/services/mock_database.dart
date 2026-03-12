import 'dart:async';

class MockDatabase {
  static final MockDatabase _instance = MockDatabase._internal();
  factory MockDatabase() => _instance;
  MockDatabase._internal();

  // Observable state
  final _stateController = StreamController<Map<String, dynamic>>.broadcast();
  Stream<Map<String, dynamic>> get stateStream => _stateController.stream;

  // ─── Users ───
  final List<Map<String, dynamic>> _users = [
    {
      'id': '2023-00123',
      'name': 'Julian',
      'email': 'julian@example.com',
      'password': 'password123',
      'role': 'student',
    },
    {
      'id': 'ADMIN-001',
      'name': 'Lola Martha',
      'storeName': 'Lola\'s Kitchen',
      'email': 'lola@example.com',
      'password': 'owner123',
      'role': 'owner',
    },
  ];

  // ─── Food Items ───
  final List<Map<String, dynamic>> _foodItems = [
    {
      'id': '1',
      'title': 'Chicken Adobo',
      'price': 85.00,
      'category': 'Meals',
      'networkImage':
          'https://lh3.googleusercontent.com/aida-public/AB6AXuBcxVPH0bG8D6zJKiYsSJDRruWZXinVcef7FxvCyX6FRqwSOoqyJ24QgNxoUqkl-uUwf9BxioDYTVQAAzqzZTy2KFdfQsB2EbL2lKT80EjsPis-SZwL45tlBbw8AnYabszmh7HDYm2rxhMt7xp3vs1GRbEqiMfv5LmAztDnnr3YBxCwLm-b3Jr5I1KtAjs_IiSiyINd3vft-jrCuaeFJF_VHitYb-eJzsGCvic0duoWaSTxBwSXuwaGX2WtrXmAT6yx3ZL-WzStYG4',
      'isAvailable': true,
    },
    {
      'id': '2',
      'title': 'Pork Sisig Rice',
      'price': 95.00,
      'category': 'Meals',
      'networkImage':
          'https://lh3.googleusercontent.com/aida-public/AB6AXuDdgV_IVX8_XRIbzb6wKJ1T78o8zQ1GxE3zwLOAee_viLMWAe8t1Scz64AZ8zgaUkQ4K6bjgmK2dBdak3uJE5kw-dNPRhzfyvtEFShk6c9O62VP6pFB7k1_xGpt-syBkGEw3jY29wAGeOV8V9U2lYqYrE-TvlCyZYdxK99jTPo1hyYxHd96IGon7WCvzXDmrsYeFrdti37ZVn3aY7X7ICnm5DOfKhYNH_XIhiYwj3cL2jeKwYBUv6WYUvwXIof9jSGV10OxaxsRP_U',
      'isAvailable': true,
    },
    {
      'id': '3',
      'title': 'Garden Salad',
      'price': 65.00,
      'category': 'Meals',
      'networkImage':
          'https://lh3.googleusercontent.com/aida-public/AB6AXuAINQzvJeg21YG9TFplmEaXktGiH50UxWsr4f_SOmJ8A9jb2_VNGpU32_RrNU9Ibb1xj_h8BJe6oJB3bP5queSvLfzwQcS_C8AKJj7IifinmiyeMZvS0MQo77HVTMrVJxv53vtrbit8pwV46Y-UmLnmizsaNM2IP9O9DdQ9GtxHMnshvaoESemw6w2vQpMQwmWUoOM_SEgumexdTw_6EqW055o7HHSAQjxT69ll0Rph8AjBL7OgxZnGGE9btmNSawW5e8zC5PvPt9I',
      'isAvailable': true,
    },
    {
      'id': '4',
      'title': 'Beef Tapa',
      'price': 110.00,
      'category': 'Meals',
      'networkImage':
          'https://lh3.googleusercontent.com/aida-public/AB6AXuB0UEZWvqot3-w5HnDlzhbHs1g86lmu9-Ub7-OgTxWqFkKqgc-gXI3YiEjk67qNFGcf7iHpql8mdk5tccmOFmnVq-v8lNQofDW3077UubGe9o8x4jzf-P2_fldYv8AorqLBMZ8dWHEdfZNrlz2axOpmBN1fpVnX2N0MBqvkgZArqED7dPsJTzuZBmPMPdUaJDX8bGFqEsVdtvaJygbaLTdc6MZAOA2Y4g0sHXXElf8Bpo5ZZkDrfa8P1XohCbEQJ9QCrg62WfKpsiI',
      'isAvailable': true,
    },
    {
      'id': '5',
      'title': 'Fresh Fruit Cup',
      'price': 45.00,
      'category': 'Snacks',
      'networkImage':
          'https://lh3.googleusercontent.com/aida-public/AB6AXuDlMqz3KhWESyYa7wFtDJ7w1USbK_1c8SrCZYVN6uLHvHrenolQN7n3zCwFmivKrn1kIheuQjE7Ld-cqegErFZG0DSp87n7-DvWZGEJCO0jvFaitmTka8o2t6pnssJXYIjbMU0gyxxRg7-h_1GrORVou22SBqgKXgYoRDMwb91ZusNCo0RBhR9jGjzGDWNf5-F7XcdXQD0NFWt0161y4XmRxm-fZVvpWXAURx-CHOdQa2xA2UMTjGvciWxU0tF9ErMOtRV9VnrIqYc',
      'isAvailable': true,
    },
    {
      'id': '6',
      'title': 'House Iced Tea',
      'price': 35.00,
      'category': 'Drinks',
      'networkImage':
          'https://lh3.googleusercontent.com/aida-public/AB6AXuCZcs0lbtFpGTutHNql_8957KXM7LVMSl7gb-UJgEDhKY-tk0ohk4u6Dk-XyHOqNTNxPPwXc_h9TcePfOtu0f0_jwbd6LJw_xqzv5sd8-fg-6p7f0HOPectExAxJ0gc-rShwj5n4H1dx6xjeQ6XhKaXXEyiQHcZJzcnNLrbGHVruomRwIj6Ct8l1jVnTIky9YgXLTKme4o4WjdVLbMxvjl2i7OJBNaVGGMOQ5jqLjRZZAUVeRaC1-q8M_WhHn8cPT27m9n4pNPdM7M',
      'isAvailable': true,
    },
  ];

  // ─── Cart ───
  final List<Map<String, dynamic>> _cart = [];

  // ─── Orders ───
  final List<Map<String, dynamic>> _orders = [];

  // ─── Notifications ───
  final List<Map<String, dynamic>> _notifications = [
    {
      'id': 'notif-1',
      'title': 'Welcome!',
      'body': 'Welcome to BENTOBOX Canteen App! Start ordering now.',
      'type': 'system',
      'icon': 'favorite',
      'timestamp': DateTime.now().subtract(const Duration(days: 1)),
      'isRead': false,
    },
    {
      'id': 'notif-2',
      'title': 'Special Offer',
      'body': '20% OFF on all healthy meals today only!',
      'type': 'promo',
      'icon': 'local_offer',
      'timestamp': DateTime.now().subtract(const Duration(hours: 2)),
      'isRead': false,
    },
  ];

  // ─── Current User ───
  Map<String, dynamic>? _currentUser;

  // ═══════════════════════════════════════════════════════════
  // GETTERS
  // ═══════════════════════════════════════════════════════════
  Map<String, dynamic>? get currentUser => _currentUser;
  List<Map<String, dynamic>> get foodItems => _foodItems;
  List<Map<String, dynamic>> get orders => _orders;
  List<Map<String, dynamic>> get cart => _cart;
  List<Map<String, dynamic>> get notifications => _notifications;

  int get cartItemCount =>
      _cart.fold(0, (sum, item) => sum + (item['quantity'] as int));
  double get cartTotal => _cart.fold(
    0.0,
    (sum, item) => sum + (item['price'] as double) * (item['quantity'] as int),
  );

  // ═══════════════════════════════════════════════════════════
  // AUTH METHODS
  // ═══════════════════════════════════════════════════════════
  bool login(String id, String password) {
    try {
      final user = _users.firstWhere(
        (u) => (u['id'] == id || u['email'] == id) && u['password'] == password,
      );
      _currentUser = user;
      _notify();
      return true;
    } catch (e) {
      return false;
    }
  }

  void signup({
    required String id,
    required String name,
    required String email,
    required String password,
    required String role,
    String? storeName,
  }) {
    final newUser = {
      'id': id,
      'name': name,
      'email': email,
      'password': password,
      'role': role,
    };
    if (storeName != null) newUser['storeName'] = storeName;
    _users.add(newUser);
    _currentUser = newUser;
    _notify();
  }

  void logout() {
    _currentUser = null;
    _cart.clear();
    _notify();
  }

  // ═══════════════════════════════════════════════════════════
  // PASSWORD RESET (Simulated)
  // ═══════════════════════════════════════════════════════════
  bool userExistsById(String studentId) {
    return _users.any((u) => u['id'] == studentId);
  }

  bool resetPassword(String studentId, String newPassword) {
    try {
      final user = _users.firstWhere((u) => u['id'] == studentId);
      user['password'] = newPassword;
      return true;
    } catch (e) {
      return false;
    }
  }

  // ═══════════════════════════════════════════════════════════
  // CART METHODS
  // ═══════════════════════════════════════════════════════════
  void addToCart(Map<String, dynamic> foodItem) {
    final existingIndex = _cart.indexWhere(
      (item) => item['id'] == foodItem['id'],
    );
    if (existingIndex >= 0) {
      _cart[existingIndex]['quantity'] =
          (_cart[existingIndex]['quantity'] as int) + 1;
    } else {
      _cart.add({...foodItem, 'quantity': 1});
    }
    _notify();
  }

  void updateCartQuantity(String itemId, int quantity) {
    if (quantity <= 0) {
      _cart.removeWhere((item) => item['id'] == itemId);
    } else {
      final index = _cart.indexWhere((item) => item['id'] == itemId);
      if (index >= 0) {
        _cart[index]['quantity'] = quantity;
      }
    }
    _notify();
  }

  void removeFromCart(String itemId) {
    _cart.removeWhere((item) => item['id'] == itemId);
    _notify();
  }

  void clearCart() {
    _cart.clear();
    _notify();
  }

  // ═══════════════════════════════════════════════════════════
  // ORDER METHODS
  // ═══════════════════════════════════════════════════════════
  void placeOrder() {
    if (_cart.isEmpty || _currentUser == null) return;

    final itemsSummary = _cart
        .map((item) => '${item['quantity']}x ${item['title']}')
        .join(', ');
    final total = cartTotal;

    final order = {
      'id': '#ORD-${(_orders.length + 101).toString().padLeft(3, '0')}',
      'studentName': _currentUser!['name'],
      'studentId': _currentUser!['id'],
      'items': itemsSummary,
      'cartItems': List<Map<String, dynamic>>.from(
        _cart.map((e) => Map<String, dynamic>.from(e)),
      ),
      'total': total,
      'timestamp': DateTime.now(),
      'status': 'Pending',
    };

    _orders.add(order);

    // Add notification for the student
    addNotification(
      title: 'Order Placed',
      body:
          'Your order ${order['id']} has been placed successfully! Total: ₱${total.toStringAsFixed(2)}',
      type: 'order',
    );

    _cart.clear();
    _notify();
  }

  void updateOrderStatus(String orderId, String newStatus) {
    final index = _orders.indexWhere((o) => o['id'] == orderId);
    if (index >= 0) {
      _orders[index]['status'] = newStatus;

      // Add notification
      addNotification(
        title: 'Order $newStatus',
        body: 'Your order $orderId is now $newStatus.',
        type: 'order',
      );

      _notify();
    }
  }

  List<Map<String, dynamic>> getOrdersForCurrentUser() {
    if (_currentUser == null) return [];
    return _orders.where((o) => o['studentId'] == _currentUser!['id']).toList();
  }

  List<Map<String, dynamic>> getAllOrders() {
    return _orders;
  }

  // ═══════════════════════════════════════════════════════════
  // FOOD METHODS
  // ═══════════════════════════════════════════════════════════
  void addFoodItem(Map<String, dynamic> item) {
    _foodItems.add({
      ...item,
      'id': DateTime.now().millisecondsSinceEpoch.toString(),
      'isAvailable': true,
    });
    _notify();
  }

  void removeFoodItem(String id) {
    _foodItems.removeWhere((item) => item['id'] == id);
    _notify();
  }

  void updateFoodItem(String id, Map<String, dynamic> updates) {
    final index = _foodItems.indexWhere((item) => item['id'] == id);
    if (index >= 0) {
      _foodItems[index] = {..._foodItems[index], ...updates};
      _notify();
    }
  }

  void toggleFoodAvailability(String id) {
    final index = _foodItems.indexWhere((item) => item['id'] == id);
    if (index >= 0) {
      _foodItems[index]['isAvailable'] =
          !(_foodItems[index]['isAvailable'] as bool);
      _notify();
    }
  }

  // ═══════════════════════════════════════════════════════════
  // NOTIFICATION METHODS
  // ═══════════════════════════════════════════════════════════
  void addNotification({
    required String title,
    required String body,
    required String type,
  }) {
    _notifications.insert(0, {
      'id': 'notif-${DateTime.now().millisecondsSinceEpoch}',
      'title': title,
      'body': body,
      'type': type,
      'timestamp': DateTime.now(),
      'isRead': false,
    });
    _notify();
  }

  void markNotificationRead(String id) {
    final index = _notifications.indexWhere((n) => n['id'] == id);
    if (index >= 0) {
      _notifications[index]['isRead'] = true;
      _notify();
    }
  }

  void markAllNotificationsRead() {
    for (var n in _notifications) {
      n['isRead'] = true;
    }
    _notify();
  }

  int get unreadNotificationCount =>
      _notifications.where((n) => n['isRead'] == false).length;

  // ═══════════════════════════════════════════════════════════
  // ANALYTICS HELPERS
  // ═══════════════════════════════════════════════════════════
  double get totalRevenue =>
      _orders.fold(0.0, (sum, o) => sum + (o['total'] as double));
  int get totalOrderCount => _orders.length;
  double get averageOrderValue =>
      _orders.isEmpty ? 0 : totalRevenue / totalOrderCount;
  int get uniqueCustomerCount =>
      _orders.map((o) => o['studentId']).toSet().length;

  Map<String, int> get popularItems {
    final Map<String, int> counts = {};
    for (final order in _orders) {
      final items = order['cartItems'] as List<Map<String, dynamic>>?;
      if (items != null) {
        for (final item in items) {
          final title = item['title'] as String;
          counts[title] = (counts[title] ?? 0) + (item['quantity'] as int);
        }
      }
    }
    return Map.fromEntries(
      counts.entries.toList()..sort((a, b) => b.value.compareTo(a.value)),
    );
  }

  // ═══════════════════════════════════════════════════════════
  // INTERNAL
  // ═══════════════════════════════════════════════════════════
  void _notify() {
    _stateController.add({
      'currentUser': _currentUser,
      'orders': _orders,
      'foodItems': _foodItems,
      'cart': _cart,
      'notifications': _notifications,
    });
  }
}
