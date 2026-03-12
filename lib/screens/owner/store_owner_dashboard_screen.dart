import 'package:flutter/material.dart';
import 'package:canteen_app/services/mock_database.dart';

class StoreOwnerDashboardScreen extends StatefulWidget {
  const StoreOwnerDashboardScreen({super.key});

  @override
  State<StoreOwnerDashboardScreen> createState() => _StoreOwnerDashboardScreenState();
}

class _StoreOwnerDashboardScreenState extends State<StoreOwnerDashboardScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFf7f7f6),
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(context),
            Expanded(
              child: StreamBuilder<Map<String, dynamic>>(
                stream: MockDatabase().stateStream,
                builder: (context, snapshot) {
                  return SingleChildScrollView(
                    padding: const EdgeInsets.only(bottom: 120),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildSummaryCards(context),
                        _buildPendingOrders(context),
                        _buildMenuItems(context),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 80),
        child: FloatingActionButton.extended(
          onPressed: () => _showAddFoodDialog(context),
          backgroundColor: const Color(0xFF4b652a),
          icon: const Icon(Icons.add, color: Colors.white),
          label: const Text('Add Item', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    final user = MockDatabase().currentUser;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    width: 16,
                    height: 16,
                    decoration: BoxDecoration(
                      color: const Color(0xFF4b652a),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: const Icon(Icons.school, color: Colors.white, size: 10),
                  ),
                  const SizedBox(width: 6),
                  const Text(
                    'PHINMA SAINT JUDE COLLEGE MANILA',
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF4b652a),
                      letterSpacing: 1.0,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                'Hello, ${user?['name'] ?? 'Owner'}',
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF191d15),
                ),
              ),
              const SizedBox(height: 4),
              Text(
                user?['storeName'] ?? 'Your Store',
                style: const TextStyle(
                  color: Color(0xFF4b652a),
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                ),
              ),
            ],
          ),
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: const Color(0xFF4b652a).withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.store,
              color: Color(0xFF4b652a),
              size: 24,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryCards(BuildContext context) {
    final orders = MockDatabase().getAllOrders();
    final todayOrders = orders.where((o) {
      final ts = o['timestamp'] as DateTime;
      final now = DateTime.now();
      return ts.day == now.day && ts.month == now.month && ts.year == now.year;
    }).toList();
    final todaySales = todayOrders.fold<double>(0, (sum, o) => sum + (o['total'] as double));
    final pendingCount = orders.where((o) => o['status'] == 'Pending').length;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          Expanded(
            child: _buildSummaryCard(
              context,
              icon: Icons.payments,
              title: 'Today\'s Sales',
              value: '₱${todaySales.toStringAsFixed(0)}',
              color: const Color(0xFF4b652a),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: _buildSummaryCard(
              context,
              icon: Icons.pending_actions,
              title: 'Pending',
              value: '$pendingCount',
              color: Colors.orange,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: _buildSummaryCard(
              context,
              icon: Icons.fastfood,
              title: 'Menu Items',
              value: '${MockDatabase().foodItems.length}',
              color: Colors.blue,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryCard(BuildContext context,
      {required IconData icon, required String title, required String value, required Color color}) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, color: color, size: 20),
          ),
          const SizedBox(height: 12),
          Text(
            value,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            title,
            style: const TextStyle(color: Color(0xFF94a3b8), fontSize: 12),
          ),
        ],
      ),
    );
  }

  Widget _buildPendingOrders(BuildContext context) {
    final pendingOrders = MockDatabase().getAllOrders().where((o) => o['status'] == 'Pending').toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.fromLTRB(20, 24, 16, 12),
          child: Text(
            'Pending Orders',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF0f172a)),
          ),
        ),
        if (pendingOrders.isEmpty)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                children: [
                  Icon(Icons.check_circle_outline, size: 48, color: Colors.grey.shade300),
                  const SizedBox(height: 8),
                  Text('No pending orders', style: TextStyle(color: Colors.grey.shade400)),
                ],
              ),
            ),
          )
        else
          ...pendingOrders.reversed.take(3).map((order) => _buildPendingOrderCard(context, order)),
      ],
    );
  }

  Widget _buildPendingOrderCard(BuildContext context, Map<String, dynamic> order) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                order['id'],
                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.orange.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Text(
                  'Pending',
                  style: TextStyle(color: Colors.orange, fontSize: 12, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            '${order['studentName']} • ${order['items']}',
            style: const TextStyle(color: Color(0xFF64748b), fontSize: 13),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: () {
                    MockDatabase().updateOrderStatus(order['id'], 'Declined');
                    setState(() {});
                  },
                  style: OutlinedButton.styleFrom(
                    foregroundColor: Colors.red,
                    side: const BorderSide(color: Colors.red),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  child: const Text('Decline'),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    MockDatabase().updateOrderStatus(order['id'], 'Preparing');
                    setState(() {});
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF4b652a),
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  child: const Text('Accept'),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildMenuItems(BuildContext context) {
    final items = MockDatabase().foodItems;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.fromLTRB(20, 24, 16, 12),
          child: Text(
            'Your Menu',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF0f172a)),
          ),
        ),
        ...items.map((item) => _buildMenuItem(context, item)),
      ],
    );
  }

  Widget _buildMenuItem(BuildContext context, Map<String, dynamic> item) {
    final isAvailable = item['isAvailable'] as bool;
    final imageUrl = item['networkImage'] ?? '';

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: const Color(0xFF4b652a).withOpacity(0.05),
              image: imageUrl.isNotEmpty
                  ? DecorationImage(image: NetworkImage(imageUrl), fit: BoxFit.cover)
                  : null,
            ),
            child: imageUrl.isEmpty
                ? const Icon(Icons.fastfood, color: Color(0xFF4b652a))
                : null,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item['title'],
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                ),
                Text(
                  '₱${(item['price'] as double).toStringAsFixed(2)} • ${item['category'] ?? 'Other'}',
                  style: const TextStyle(color: Color(0xFF64748b), fontSize: 13),
                ),
              ],
            ),
          ),
          Switch(
            value: isAvailable,
            onChanged: (value) {
              MockDatabase().toggleFoodAvailability(item['id']);
              setState(() {});
            },
            activeColor: const Color(0xFF4b652a),
          ),
        ],
      ),
    );
  }

  void _showAddFoodDialog(BuildContext context) {
    final nameController = TextEditingController();
    final priceController = TextEditingController();
    String selectedCategory = 'Meals';

    showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setDialogState) {
          return AlertDialog(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            title: const Text('Add Menu Item', style: TextStyle(fontWeight: FontWeight.bold)),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: nameController,
                  decoration: InputDecoration(
                    labelText: 'Food Name',
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: priceController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: 'Price (₱)',
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                ),
                const SizedBox(height: 12),
                DropdownButtonFormField<String>(
                  value: selectedCategory,
                  onChanged: (value) {
                    setDialogState(() {
                      selectedCategory = value ?? 'Meals';
                    });
                  },
                  items: ['Meals', 'Snacks', 'Drinks']
                      .map((c) => DropdownMenuItem(value: c, child: Text(c)))
                      .toList(),
                  decoration: InputDecoration(
                    labelText: 'Category',
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                ),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Cancel'),
              ),
              ElevatedButton(
                onPressed: () {
                  if (nameController.text.isNotEmpty && priceController.text.isNotEmpty) {
                    MockDatabase().addFoodItem({
                      'title': nameController.text,
                      'price': double.tryParse(priceController.text) ?? 0.0,
                      'category': selectedCategory,
                      'networkImage': '',
                    });
                    setState(() {}); // Rebuild dashboard
                    Navigator.pop(context);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('${nameController.text} added to menu!'),
                        behavior: SnackBarBehavior.floating,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      ),
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF4b652a),
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
                child: const Text('Add'),
              ),
            ],
          );
        },
      ),
    );
  }
}
