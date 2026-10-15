import 'package:flutter/material.dart';

class AccessoriesOrderScreen extends StatefulWidget {
  const AccessoriesOrderScreen({super.key});

  @override
  State<AccessoriesOrderScreen> createState() =>
      _AccessoriesOrderScreenState();
}

class _AccessoriesOrderScreenState extends State<AccessoriesOrderScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final List<String> _tabs = ['All', 'Ongoing', 'Completed', 'Cancelled'];

  // ── Sample orders ──
  final List<Map<String, dynamic>> _orders = [
    {
      'id': 'AO-2024-001',
      'sellerName': 'Rahul Sharma',
      'sellerImage':
      'https://images.unsplash.com/photo-1523275335684-37898b6baf30?w=400&h=500&fit=crop',
      'status': 'Ongoing',
      'statusColor': Colors.orange,
      'placedAt': 'Today, 10:15 AM',
      'deliveryEta': '30-35 min',
      'total': 2499,
      'type': 'Buy',
      'items': [
        {'name': 'Premium Leather Watch Band', 'qty': 1, 'price': 2499},
      ],
      'canTrack': true,
      'canCancel': true,
      'canReorder': false,
      'canReturn': false,
    },
    {
      'id': 'AO-2024-002',
      'sellerName': 'Priya Singh',
      'sellerImage':
      'https://images.unsplash.com/photo-1572569511254-d8f925fe2cbb?w=400&h=500&fit=crop',
      'status': 'Completed',
      'statusColor': Colors.green,
      'placedAt': 'Yesterday, 5:40 PM',
      'deliveryEta': 'Delivered',
      'total': 0,
      'type': 'Donate',
      'items': [
        {'name': 'Wireless Bluetooth Earbuds', 'qty': 1, 'price': 0},
      ],
      'canTrack': false,
      'canCancel': false,
      'canReorder': false,
      'canReturn': false,
    },
    {
      'id': 'AO-2024-003',
      'sellerName': 'Amit Kumar',
      'sellerImage':
      'https://images.unsplash.com/photo-1585336261022-680e2954883e?w=400&h=500&fit=crop',
      'status': 'Completed',
      'statusColor': Colors.green,
      'placedAt': '12 Feb, 7:30 PM',
      'deliveryEta': 'Delivered',
      'total': 3098,
      'type': 'Buy',
      'items': [
        {'name': 'Samsung Fast Charger Adapter', 'qty': 1, 'price': 899},
        {'name': 'Wireless Charging Pad', 'qty': 1, 'price': 2199},
      ],
      'canTrack': false,
      'canCancel': false,
      'canReorder': true,
      'canReturn': true,
    },
    {
      'id': 'AO-2024-004',
      'sellerName': 'Mohan Das',
      'sellerImage':
      'https://images.unsplash.com/photo-1527864550417-7fd91fc51a46?w=400&h=500&fit=crop',
      'status': 'Cancelled',
      'statusColor': Colors.red,
      'placedAt': '10 Feb, 3:00 PM',
      'deliveryEta': 'Cancelled',
      'total': 1499,
      'type': 'Buy',
      'items': [
        {'name': 'Laptop Stand - Adjustable', 'qty': 1, 'price': 1499},
      ],
      'canTrack': false,
      'canCancel': false,
      'canReorder': true,
      'canReturn': false,
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
      backgroundColor: const Color(0xFFF8F9FE),
      body: Column(
        children: [
          // Header
          Container(
            color: Colors.white,
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
            child: SafeArea(
              bottom: false,
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Colors.purple[400]!, Colors.purple[700]!],
                      ),
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: const Icon(
                      Icons.receipt_long_rounded,
                      color: Colors.white,
                      size: 22,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'My Orders',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w800,
                          color: Colors.grey[900],
                          letterSpacing: -0.5,
                        ),
                      ),
                      Text(
                        '${_orders.length} orders placed',
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey[500],
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),

          // Tabs
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
                  colors: [Colors.purple[500]!, Colors.purple[700]!],
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

          // List
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

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: Colors.purple[700]!.withOpacity(0.08),
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.receipt_long_outlined,
              size: 64,
              color: Colors.purple[700]!.withOpacity(0.5),
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

  Widget _buildOrderCard(Map<String, dynamic> order) {
    final statusColor = order['statusColor'] as Color;
    final List items = order['items'];
    final isDonate = order['type'] == 'Donate';

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
          // Header
          Padding(
            padding: const EdgeInsets.fromLTRB(12, 12, 12, 8),
            child: Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.network(
                    order['sellerImage'],
                    width: 48,
                    height: 48,
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) => Container(
                      width: 48,
                      height: 48,
                      color: Colors.grey.shade200,
                      child: Icon(
                        Icons.person_rounded,
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
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              order['sellerName'],
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF1E293B),
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          if (isDonate)
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 6,
                                vertical: 2,
                              ),
                              decoration: BoxDecoration(
                                gradient: const LinearGradient(
                                  colors: [Colors.green, Colors.greenAccent],
                                ),
                                borderRadius: BorderRadius.circular(6),
                              ),
                              child: const Text(
                                'DONATED',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 8.5,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 0.3,
                                ),
                              ),
                            ),
                        ],
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
                const SizedBox(width: 8),
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

          // Items
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
                            color: Colors.purple[700],
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
                          item['price'] == 0 ? 'FREE' : '₹${item['price']}',
                          style: TextStyle(
                            fontSize: 11,
                            color: item['price'] == 0
                                ? Colors.green[700]
                                : Colors.grey[700],
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
                        color: Colors.purple[700],
                        fontWeight: FontWeight.w600,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ),
              ],
            ),
          ),

          const Divider(height: 1, thickness: 0.5),

          // Footer
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
                      Icon(Icons.local_shipping_rounded,
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
                      order['total'] == 0 ? 'FREE' : '₹${order['total']}',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: order['total'] == 0
                            ? Colors.green[700]
                            : const Color(0xFF1E293B),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    if (order['canTrack'] == true)
                      Expanded(
                        child: _actionButton(
                          label: 'Track',
                          icon: Icons.location_on_rounded,
                          primary: true,
                          onTap: () => ScaffoldMessenger.of(context)
                              .showSnackBar(SnackBar(
                            content: Text('Tracking ${order['id']}...'),
                            behavior: SnackBarBehavior.floating,
                            backgroundColor: Colors.purple[700],
                          )),
                        ),
                      ),
                    if (order['canReorder'] == true)
                      Expanded(
                        child: _actionButton(
                          label: 'Reorder',
                          icon: Icons.refresh_rounded,
                          primary: false,
                          onTap: () => ScaffoldMessenger.of(context)
                              .showSnackBar(SnackBar(
                            content: Text(
                                'Reordering from ${order['sellerName']}...'),
                            behavior: SnackBarBehavior.floating,
                            backgroundColor: Colors.purple[700],
                          )),
                        ),
                      ),
                    if (order['canReturn'] == true)
                      Expanded(
                        child: _actionButton(
                          label: 'Return',
                          icon: Icons.assignment_return_rounded,
                          primary: false,
                          onTap: () => ScaffoldMessenger.of(context)
                              .showSnackBar(SnackBar(
                            content:
                            Text('Return requested for ${order['id']}'),
                            behavior: SnackBarBehavior.floating,
                            backgroundColor: Colors.orange[700],
                          )),
                        ),
                      ),
                    if (order['canCancel'] == true) ...[
                      if (order['canTrack'] == true) const SizedBox(width: 8),
                      Expanded(
                        child: _actionButton(
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

  Widget _actionButton({
    required String label,
    required IconData icon,
    required bool primary,
    required VoidCallback onTap,
    bool danger = false,
  }) {
    final color = danger
        ? Colors.red
        : (primary ? Colors.purple[700]! : Colors.grey[700]!);

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
          backgroundColor: primary
              ? color
              : (danger ? Colors.red.shade50 : Colors.grey.shade100),
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