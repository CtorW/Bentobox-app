import 'package:flutter/material.dart';
import 'package:canteen_app/services/mock_database.dart';
import 'package:canteen_app/widgets/wavy_progress_indicator.dart';

class OwnerAnalyticsScreen extends StatelessWidget {
  const OwnerAnalyticsScreen({super.key});

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
                        _buildRevenueCards(context),
                        _buildOrderTrend(context),
                        _buildPopularItems(context),
                        _buildCustomerInsights(context),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 24, vertical: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Analytics',
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: Color(0xFF191d15),
            ),
          ),
          Icon(Icons.analytics, color: Color(0xFF4b652a), size: 28),
        ],
      ),
    );
  }

  Widget _buildRevenueCards(BuildContext context) {
    final db = MockDatabase();

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: _buildMetricCard(
                  title: 'Total Revenue',
                  value: '₱${db.totalRevenue.toStringAsFixed(0)}',
                  icon: Icons.account_balance_wallet,
                  color: const Color(0xFF4b652a),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _buildMetricCard(
                  title: 'Total Orders',
                  value: '${db.totalOrderCount}',
                  icon: Icons.shopping_bag,
                  color: Colors.blue,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: _buildMetricCard(
                  title: 'Avg. Order Value',
                  value: '₱${db.averageOrderValue.toStringAsFixed(0)}',
                  icon: Icons.trending_up,
                  color: Colors.orange,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _buildMetricCard(
                  title: 'Customers',
                  value: '${db.uniqueCustomerCount}',
                  icon: Icons.people,
                  color: Colors.purple,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildMetricCard({
    required String title,
    required String value,
    required IconData icon,
    required Color color,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.02),
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

  Widget _buildOrderTrend(BuildContext context) {
    final orders = MockDatabase().getAllOrders();
    // Simple bar chart for last 7-day trend
    final Map<String, int> dailyCounts = {};
    final now = DateTime.now();
    for (int i = 6; i >= 0; i--) {
      final day = now.subtract(Duration(days: i));
      final key = '${day.month}/${day.day}';
      dailyCounts[key] = 0;
    }
    for (final order in orders) {
      final ts = order['timestamp'] as DateTime;
      final key = '${ts.month}/${ts.day}';
      if (dailyCounts.containsKey(key)) {
        dailyCounts[key] = dailyCounts[key]! + 1;
      }
    }
    final maxCount = dailyCounts.values.isEmpty ? 1 : dailyCounts.values.reduce((a, b) => a > b ? a : b);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.fromLTRB(20, 24, 16, 12),
          child: Text(
            'Order Trend (7 Days)',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF0f172a)),
          ),
        ),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 16),
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.02),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: dailyCounts.entries.map((entry) {
              final heightFraction = maxCount == 0 ? 0.0 : entry.value / maxCount;
              return Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    '${entry.value}',
                    style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Color(0xFF64748b)),
                  ),
                  const SizedBox(height: 4),
                  Container(
                    width: 28,
                    height: (heightFraction * 80).clamp(4, 80),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                        colors: [
                          const Color(0xFF4b652a),
                          const Color(0xFF4b652a).withOpacity(0.6),
                        ],
                      ),
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    entry.key,
                    style: const TextStyle(fontSize: 9, color: Color(0xFF94a3b8)),
                  ),
                ],
              );
            }).toList(),
          ),
        ),
      ],
    );
  }

  Widget _buildPopularItems(BuildContext context) {
    final popular = MockDatabase().popularItems;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.fromLTRB(20, 24, 16, 12),
          child: Text(
            'Popular Items',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF0f172a)),
          ),
        ),
        if (popular.isEmpty)
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
                  Icon(Icons.bar_chart, size: 48, color: Colors.grey.shade300),
                  const SizedBox(height: 8),
                  Text('No data yet', style: TextStyle(color: Colors.grey.shade400)),
                  Text(
                    'Popular items will appear after orders.',
                    style: TextStyle(color: Colors.grey.shade400, fontSize: 12),
                  ),
                ],
              ),
            ),
          )
        else
          ...popular.entries.take(5).toList().asMap().entries.map((entry) {
            final idx = entry.key;
            final item = entry.value;
            final maxQty = popular.entries.first.value;
            return Container(
              margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(14),
              ),
              child: Row(
                children: [
                  Container(
                    width: 32,
                    height: 32,
                    decoration: BoxDecoration(
                      color: const Color(0xFF4b652a).withOpacity(0.1),
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: Text(
                        '#${idx + 1}',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                          color: Color(0xFF4b652a),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          item.key,
                          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                        ),
                        const SizedBox(height: 4),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(4),
                          child: WavyProgressIndicator(
                            value: maxQty == 0 ? 0 : item.value / maxQty,
                            height: 6,
                            backgroundColor: const Color(0xFFf1f5f9),
                            color: const Color(0xFF4b652a),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 12),
                  Text(
                    '${item.value} sold',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF4b652a),
                      fontSize: 13,
                    ),
                  ),
                ],
              ),
            );
          }),
      ],
    );
  }

  Widget _buildCustomerInsights(BuildContext context) {
    final completedOrders = MockDatabase().getAllOrders().where((o) => o['status'] == 'Completed').length;
    final pendingOrders = MockDatabase().getAllOrders().where((o) => o['status'] == 'Pending').length;
    final preparingOrders = MockDatabase().getAllOrders().where((o) => o['status'] == 'Preparing').length;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.fromLTRB(20, 24, 16, 12),
          child: Text(
            'Order Status Breakdown',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF0f172a)),
          ),
        ),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 16),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.02),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Column(
            children: [
              _buildStatusRow('Completed', completedOrders, Colors.green),
              const SizedBox(height: 8),
              _buildStatusRow('Preparing', preparingOrders, Colors.blue),
              const SizedBox(height: 8),
              _buildStatusRow('Pending', pendingOrders, Colors.orange),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildStatusRow(String label, int count, Color color) {
    return Row(
      children: [
        Container(
          width: 12,
          height: 12,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(child: Text(label, style: const TextStyle(fontWeight: FontWeight.w500))),
        Text(
          '$count',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
            color: color,
          ),
        ),
      ],
    );
  }
}
