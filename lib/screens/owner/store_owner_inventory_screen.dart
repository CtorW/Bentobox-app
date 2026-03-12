import 'package:flutter/material.dart';

class StoreOwnerInventoryScreen extends StatefulWidget {
  const StoreOwnerInventoryScreen({super.key});

  @override
  State<StoreOwnerInventoryScreen> createState() => _StoreOwnerInventoryScreenState();
}

class _StoreOwnerInventoryScreenState extends State<StoreOwnerInventoryScreen> {
  final List<Map<String, dynamic>> _inventoryItems = [
    {
      'name': 'Chicken Adobo',
      'price': 85.00,
      'category': 'Meals',
      'isAvailable': true,
      'image': 'https://lh3.googleusercontent.com/aida-public/AB6AXuBcxVPH0bG8D6zJKiYsSJDRruWZXinVcef7FxvCyX6FRqwSOoqyJ24QgNxoUqkl-uUwf9BxioDYTVQAAzqzZTy2KFdfQsB2EbL2lKT80EjsPis-SZwL45tlBbw8AnYabszmh7HDYm2rxhMt7xp3vs1GRbEqiMfv5LmAztDnnr3YBxCwLm-b3Jr5I1KtAjs_IiSiyINd3vft-jrCuaeFJF_VHitYb-eJzsGCvic0duoWaSTxBwSXuwaGX2WtrXmAT6yx3ZL-WzStYG4',
    },
    {
      'name': 'Pork Sisig Rice',
      'price': 95.00,
      'category': 'Meals',
      'isAvailable': true,
      'image': 'https://lh3.googleusercontent.com/aida-public/AB6AXuDdgV_IVX8_XRIbzb6wKJ1T78o8zQ1GxE3zwLOAee_viLMWAe8t1Scz64AZ8zgaUkQ4K6bjgmK2dBdak3uJE5kw-dNPRhzfyvtEFShk6c9O62VP6pFB7k1_xGpt-syBkGEw3jY29wAGeOV8V9U2lYqYrE-TvlCyZYdxK99jTPo1hyYxHd96IGon7WCvzXDmrsYeFrdti37ZVn3aY7X7ICnm5DOfKhYNH_XIhiYwj3cL2jeKwYBUv6WYUvwXIof9jSGV10OxaxsRP_U',
    },
    {
      'name': 'Garden Salad',
      'price': 65.00,
      'category': 'Meals',
      'isAvailable': false,
      'image': 'https://lh3.googleusercontent.com/aida-public/AB6AXuAINQzvJeg21YG9TFplmEaXktGiH50UxWsr4f_SOmJ8A9jb2_VNGpU32_RrNU9Ibb1xj_h8BJe6oJB3bP5queSvLfzwQcS_C8AKJj7IifinmiyeMZvS0MQo77HVTMrVJxv53vtrbit8pwV46Y-UmLnmizsaNM2IP9O9DdQ9GtxHMnshvaoESemw6w2vQpMQwmWUoOM_SEgumexdTw_6EqW055o7HHSAQjxT69ll0Rph8AjBL7OgxZnGGE9btmNSawW5e8zC5PvPt9I',
    },
    {
      'name': 'House Iced Tea',
      'price': 35.00,
      'category': 'Drinks',
      'isAvailable': true,
      'image': 'https://lh3.googleusercontent.com/aida-public/AB6AXuCZcs0lbtFpGTutHNql_8957KXM7LVMSl7gb-UJgEDhKY-tk0ohk4u6Dk-XyHOqNTNxPPwXc_h9TcePfOtu0f0_jwbd6LJw_xqzv5sd8-fg-6p7f0HOPectExAxJ0gc-rShwj5n4H1dx6xjeQ6XhKaXXEyiQHcZJzcnNLrbGHVruomRwIj6Ct8l1jVnTIky9YgXLTKme4o4WjdVLbMxvjl2i7OJBNaVGGMOQ5jqLjRZZAUVeRaC1-q8M_WhHn8cPT27m9n4pNPdM7M',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Inventory Management', style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Search coming soon!')),
              );
            },
          )
        ],
      ),
      body: SafeArea(
        child: ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: _inventoryItems.length,
          itemBuilder: (context, index) {
            final item = _inventoryItems[index];
            return _buildInventoryItemCard(item, index);
          },
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Add Item screen coming soon!')),
          );
        },
        backgroundColor: Theme.of(context).primaryColor,
        icon: const Icon(Icons.add, color: Colors.white),
        label: const Text('Add Item', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
      ),
    );
  }

  Widget _buildInventoryItemCard(Map<String, dynamic> item, int index) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Stack(
        children: [
          Row(
            children: [
              Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  image: DecorationImage(
                    image: NetworkImage(item['image']),
                    fit: BoxFit.cover,
                    colorFilter: item['isAvailable']
                        ? null
                        : ColorFilter.mode(Colors.black.withOpacity(0.5), BlendMode.darken),
                  ),
                ),
                child: !item['isAvailable']
                    ? const Center(
                        child: Text(
                          'SOLD OUT',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 10,
                          ),
                        ),
                      )
                    : null,
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade200,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        item['category'],
                        style: TextStyle(fontSize: 10, color: Colors.grey.shade700, fontWeight: FontWeight.bold),
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      item['name'],
                      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '₱${item['price'].toStringAsFixed(2)}',
                      style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Text(
                          item['isAvailable'] ? 'Available' : 'Out of Stock',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: item['isAvailable'] ? Colors.green : Colors.red,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Switch(
                          value: item['isAvailable'],
                          activeColor: Colors.green,
                          onChanged: (value) {
                            setState(() {
                              _inventoryItems[index]['isAvailable'] = value;
                            });
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          Positioned(
            top: 0,
            right: 0,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: const Icon(Icons.edit, size: 20, color: Colors.grey),
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Editing ${item['name']} coming soon!')),
                    );
                  },
                  constraints: const BoxConstraints(),
                  padding: const EdgeInsets.all(4),
                ),
                IconButton(
                  icon: const Icon(Icons.delete_outline, size: 20, color: Colors.red),
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Deleting ${item['name']} coming soon!')),
                    );
                  },
                  constraints: const BoxConstraints(),
                  padding: const EdgeInsets.all(4),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
