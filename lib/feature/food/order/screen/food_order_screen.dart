import 'package:flutter/material.dart';

class FoodOrderScreen extends StatefulWidget {
  const FoodOrderScreen({super.key});

  @override
  State<FoodOrderScreen> createState() => _FoodOrderScreenState();
}

class _FoodOrderScreenState extends State<FoodOrderScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  // ── Filter tabs (like Zomato/Swiggy) ──
  final List<String> _tabs = ['All', 'Ongoing', 'Delivered', 'Cancelled'];

  // ── Sample orders ──
  final List<Map<String, dynamic>> _orders = [
    {
      'id': 'ORD-2024-001',
      'storeName': 'Gourmet Express',
      'storeImage':
      'https://images.unsplash.com/photo-1550547660-d9450f859349?w=400&h=300&fit=crop',
      'status': 'Ongoing',
      'statusColor': Colors.orange,
      'placedAt': 'Today, 12:45 PM',
      'deliveryEta': '25-30 min',
      'total': 598,
      'items': [
        {'name': 'Hyderabadi Chicken Biryani', 'qty': 1, 'price': 299},
        {'name': 'Double Cheese Burger', 'qty': 1, 'price': 249},
      ],
      'itemCount': 2,
      'canTrack': true,
      'canReorder': false,
      'canCancel': true,
    },
    {
      'id': 'ORD-2024-002',
      'storeName': 'Annapurna Tiffin',
      'storeImage':
      'https://images.unsplash.com/photo-1504674900247-0877df9cc836?w=400&h=300&fit=crop',
      'status': 'Delivered',
      'statusColor': Colors.green,
      'placedAt': 'Yesterday, 1:15 PM',
      'deliveryEta': 'Delivered',
      'total': 240,
      'items': [
        {'name': 'Weekly Tiffin Plan (Veg)', 'qty': 1, 'price': 240},
      ],
      'itemCount': 1,
      'canTrack': false,
      'canReorder': true,
      'canCancel': false,
    },
    {
      'id': 'ORD-2024-003',
      'storeName': 'Freshly Made',
      'storeImage':
      'https://images.unsplash.com/photo-1482049016688-2d3e1b311543?w=400&h=300&fit=crop',
      'status': 'Delivered',
      'statusColor': Colors.green,
      'placedAt': '12 Feb, 8:30 PM',
      'deliveryEta': 'Delivered',
      'total': 897,
      'items': [
        {'name': 'Margherita Pizza', 'qty': 1, 'price': 349},
        {'name': 'Pepperoni Pizza', 'qty': 1, 'price': 449},
        {'name': 'Cold Coffee', 'qty': 1, 'price': 99},
      ],
      'itemCount': 3,
      'canTrack': false,
      'canReorder': true,
      'canCancel': false,
    },
    {
      'id': 'ORD-2024-004',
      'storeName': 'Wholesome Eats',
      'storeImage':
      'https://images.unsplash.com/photo-1467003909585-2f8a72700288?w=400&h=300&fit=crop',
      'status': 'Cancelled',
      'statusColor': Colors.red,
      'placedAt': '10 Feb, 2:00 PM',
      'deliveryEta': 'Cancelled',
      'total': 448,
      'items': [
        {'name': 'Chicken Pasta', 'qty': 1, 'price': 279},
        {'name': 'Chocolate Brownie', 'qty': 1, 'price': 169},
      ],
      'itemCount': 2,
      'canTrack': false,
      'canReorder': true,
      'canCancel': false,
    },
  ];

  List<Map<String, dynamic>> get _filteredOrders {
    final tab = _tabs[_tabController.index];
    if (tab == 'All') return _orders;
    return _orders.where((o) => o['status'] == tab).toList();
  }

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: _tabs.length, vsync: this);
    _tabController.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            color: Colors.orange,
            child: SafeArea(
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.orange,
                      border: Border.all(color: Colors.white,width: 0.6),
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: const Icon(
                      Icons.fastfood_rounded,
                      color: Colors.white,
                      size: 24,
                    ),
                  ),
                  const SizedBox(width: 14),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'My Orders',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w800,
                          color: Colors.white,
                          letterSpacing: -0.5,
                        ),
                      ),
                      Text(
                        '${_orders.length} orders placed',
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                          letterSpacing: 0.2,
                        ),
                      ),
                    ],
                  ),
                  const Spacer(),
                  Stack(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.grey[100],
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Icon(
                          Icons.notifications_none,
                          color: Colors.grey[700],
                          size: 24,
                        ),
                      ),
                      Positioned(
                        right: 6,
                        top: 6,
                        child: Container(
                          width: 10,
                          height: 10,
                          decoration: BoxDecoration(
                            color: Colors.red[500],
                            borderRadius: BorderRadius.circular(5),
                            border: Border.all(color: Colors.white, width: 2),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),


          // ── Filter Tabs ──
          Container(
            color: Colors.white,
            padding: const EdgeInsets.only(bottom: 8),
            child: TabBar(
              controller: _tabController,
              isScrollable: true,
              tabAlignment: TabAlignment.start,
              padding: const EdgeInsets.symmetric(horizontal: 12),
              indicator: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.orange[500]!, Colors.orange[700]!],
                ),
                borderRadius: BorderRadius.circular(20),
              ),
              indicatorSize: TabBarIndicatorSize.tab,
              indicatorPadding: const EdgeInsets.symmetric(
                horizontal: 4,
                vertical: 4,
              ),
              dividerColor: Colors.transparent,
              labelColor: Colors.white,
              unselectedLabelColor: Colors.grey[600],
              labelStyle: const TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 12,
              ),
              unselectedLabelStyle: const TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 12,
              ),
              tabs: _tabs.map((t) => Tab(text: t)).toList(),
            ),
          ),

          // ── Orders List / Empty State ──
          Expanded(
            child: _filteredOrders.isEmpty
                ? _buildEmptyState()
                : ListView.separated(
              padding: const EdgeInsets.all(16),
              itemCount: _filteredOrders.length,
              separatorBuilder: (_, __) => const SizedBox(height: 12),
              itemBuilder: (context, i) =>
                  _buildOrderCard(_filteredOrders[i]),
            ),
          ),
        ],
      ),
    );
  }

  // ══════════ EMPTY STATE ══════════
  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: Colors.orange[700]!.withOpacity(0.08),
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.receipt_long_outlined,
              size: 64,
              color: Colors.orange[700]!.withOpacity(0.5),
            ),
          ),
          const SizedBox(height: 20),
          Text(
            'No Orders Yet',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.grey[800],
            ),
          ),
          const SizedBox(height: 8),
          Text(
            "You haven't placed any orders yet",
            style: TextStyle(fontSize: 13, color: Colors.grey[500]),
          ),
        ],
      ),
    );
  }

  // ══════════ ORDER CARD ══════════
  Widget _buildOrderCard(Map<String, dynamic> order) {
    final statusColor = order['statusColor'] as Color;
    final List items = order['items'];

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 12,
            offset: const Offset(0, 3),
          ),
        ],
        border: Border.all(color: Colors.grey.shade100),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ── Header: store + status ──
          Padding(
            padding: const EdgeInsets.fromLTRB(12, 12, 12, 8),
            child: Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.network(
                    order['storeImage'],
                    width: 48,
                    height: 48,
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) => Container(
                      width: 48,
                      height: 48,
                      color: Colors.grey.shade200,
                      child: Icon(
                        Icons.storefront_rounded,
                        color: Colors.grey.shade500,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        order['storeName'],
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF1E293B),
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 2),
                      Text(
                        'Order ID: ${order['id']}',
                        style: TextStyle(
                          fontSize: 10.5,
                          color: Colors.grey[500],
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
                // Status badge
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: statusColor.withOpacity(0.12),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: statusColor.withOpacity(0.35)),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        width: 6,
                        height: 6,
                        decoration: BoxDecoration(
                          color: statusColor,
                          shape: BoxShape.circle,
                        ),
                      ),
                      const SizedBox(width: 4),
                      Text(
                        order['status'],
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                          color: statusColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          const Divider(height: 1, thickness: 0.5),

          // ── Items preview ──
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ...items.take(2).map((item) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 2),
                    child: Row(
                      children: [
                        Container(
                          width: 5,
                          height: 5,
                          decoration: BoxDecoration(
                            color: Colors.orange[700],
                            shape: BoxShape.circle,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            item['name'],
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey[800],
                              fontWeight: FontWeight.w500,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Text(
                          'x${item['qty']}',
                          style: TextStyle(
                            fontSize: 11,
                            color: Colors.grey[600],
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          '₹${item['price']}',
                          style: TextStyle(
                            fontSize: 11,
                            color: Colors.grey[700],
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  );
                }).toList(),
                if (items.length > 2)
                  Padding(
                    padding: const EdgeInsets.only(top: 4, left: 13),
                    child: Text(
                      '+ ${items.length - 2} more item${items.length - 2 > 1 ? 's' : ''}',
                      style: TextStyle(
                        fontSize: 11,
                        color: Colors.orange[700],
                        fontWeight: FontWeight.w600,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ),
              ],
            ),
          ),

          const Divider(height: 1, thickness: 0.5),

          // ── Footer: total, time, actions ──
          Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              children: [
                Row(
                  children: [
                    Icon(Icons.access_time_rounded,
                        size: 13, color: Colors.grey[500]),
                    const SizedBox(width: 4),
                    Text(
                      order['placedAt'],
                      style: TextStyle(
                        fontSize: 11,
                        color: Colors.grey[600],
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(width: 12),
                    if (order['status'] == 'Ongoing') ...[
                      Icon(Icons.delivery_dining_rounded,
                          size: 14, color: Colors.green[700]),
                      const SizedBox(width: 4),
                      Text(
                        'ETA ${order['deliveryEta']}',
                        style: TextStyle(
                          fontSize: 11,
                          color: Colors.green[700],
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                    const Spacer(),
                    Text(
                      '₹${order['total']}',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF1E293B),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),

                // ── Action buttons ──
                Row(
                  children: [
                    // Track
                    if (order['canTrack'] == true)
                      Expanded(
                        child: _buildActionButton(
                          label: 'Track Order',
                          icon: Icons.location_on_rounded,
                          primary: true,
                          onTap: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                    'Tracking ${order['id']}...'),
                                behavior: SnackBarBehavior.floating,
                                backgroundColor: Colors.orange[700],
                              ),
                            );
                          },
                        ),
                      ),
                    // Reorder
                    if (order['canReorder'] == true)
                      Expanded(
                        child: _buildActionButton(
                          label: 'Reorder',
                          icon: Icons.refresh_rounded,
                          primary: false,
                          onTap: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                    'Reordering from ${order['storeName']}...'),
                                behavior: SnackBarBehavior.floating,
                                backgroundColor: Colors.orange[700],
                              ),
                            );
                          },
                        ),
                      ),
                    // Cancel
                    if (order['canCancel'] == true) ...[
                      if (order['canTrack'] == true ||
                          order['canReorder'] == true)
                        const SizedBox(width: 8),
                      Expanded(
                        child: _buildActionButton(
                          label: 'Cancel',
                          icon: Icons.close_rounded,
                          primary: false,
                          danger: true,
                          onTap: () => _confirmCancel(order),
                        ),
                      ),
                    ],
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ══════════ ACTION BUTTON ══════════
  Widget _buildActionButton({
    required String label,
    required IconData icon,
    required bool primary,
    required VoidCallback onTap,
    bool danger = false,
  }) {
    final color = danger
        ? Colors.red
        : (primary ? Colors.orange[700]! : Colors.grey[700]!);

    return SizedBox(
      height: 38,
      child: ElevatedButton.icon(
        onPressed: onTap,
        icon: Icon(icon, size: 15),
        label: Text(
          label,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 12,
          ),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor:
          primary ? color : (danger ? Colors.red.shade50 : Colors.grey.shade100),
          foregroundColor: primary
              ? Colors.white
              : (danger ? Colors.red[700] : Colors.grey[800]),
          elevation: 0,
          padding: const EdgeInsets.symmetric(horizontal: 8),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
            side: primary
                ? BorderSide.none
                : BorderSide(
              color: danger
                  ? Colors.red.shade200
                  : Colors.grey.shade300,
            ),
          ),
        ),
      ),
    );
  }

  // ══════════ CANCEL CONFIRM ══════════
  void _confirmCancel(Map<String, dynamic> order) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        title: const Text(
          'Cancel Order?',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        content: Text(
          'Are you sure you want to cancel order ${order['id']}?',
          style: TextStyle(color: Colors.grey[700], fontSize: 13),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('No'),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
            ),
            onPressed: () {
              Navigator.pop(context);
              setState(() {
                order['status'] = 'Cancelled';
                order['statusColor'] = Colors.red;
                order['canTrack'] = false;
                order['canCancel'] = false;
                order['canReorder'] = true;
              });
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Order ${order['id']} cancelled'),
                  behavior: SnackBarBehavior.floating,
                  backgroundColor: Colors.red,
                ),
              );
            },
            child: const Text('Yes, Cancel'),
          ),
        ],
      ),
    );
  }
}