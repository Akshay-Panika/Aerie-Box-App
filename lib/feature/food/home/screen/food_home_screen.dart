import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:rent_hub/feature/food/home/widget/cloud_store_screen.dart';
import 'package:rent_hub/feature/food/home/widget/tiffin_store_screen.dart';

class FoodHomeScreen extends StatefulWidget {
  const FoodHomeScreen({super.key});

  @override
  State<FoodHomeScreen> createState() => _FoodHomeScreenState();
}

class _FoodHomeScreenState extends State<FoodHomeScreen>
    with SingleTickerProviderStateMixin {
  int _selectedTab = 0;
  late TabController _tabController;
  String _selectedVegFilter = 'All';

  // Sample store data with more realistic images
  final List<Store> _tiffinStores = [
    Store(
      id: 't1',
      name: 'Annapurna Tiffin',
      location: 'MG Road, Pune',
      distance: '1.2 km',
      rating: 4.8,
      orderTiming: '10:00 AM - 2:00 PM',
      isVeg: true,
      isOpen: true,
      imageUrl:
          'https://images.unsplash.com/photo-1504674900247-0877df9cc836?w=400&h=300&fit=crop',
      deliveryTime: '25-30 min',
    ),
    Store(
      id: 't2',
      name: 'Swad Tiffin Service',
      location: 'FC Road, Pune',
      distance: '2.5 km',
      rating: 4.6,
      orderTiming: '11:00 AM - 3:00 PM',
      isVeg: true,
      isOpen: true,
      imageUrl:
          'https://images.unsplash.com/photo-1565299624946-b28f40a0ae38?w=400&h=300&fit=crop',
      deliveryTime: '30-35 min',
    ),
    Store(
      id: 't3',
      name: 'Spice Box Tiffin',
      location: 'Kothrud, Pune',
      distance: '3.8 km',
      rating: 4.3,
      orderTiming: '12:00 PM - 4:00 PM',
      isVeg: false,
      isOpen: false,
      imageUrl:
          'https://images.unsplash.com/photo-1555939594-58d7cb561ad1?w=400&h=300&fit=crop',
      deliveryTime: '35-40 min',
    ),
    Store(
      id: 't4',
      name: 'Healthy Bites',
      location: 'Baner, Pune',
      distance: '4.1 km',
      rating: 4.9,
      orderTiming: '9:00 AM - 1:00 PM',
      isVeg: true,
      isOpen: true,
      imageUrl:
          'https://images.unsplash.com/photo-1546069901-ba9599a7e63c?w=400&h=300&fit=crop',
      deliveryTime: '20-25 min',
    ),
    Store(
      id: 't5',
      name: 'Taste of Home',
      location: 'Deccan, Pune',
      distance: '2.8 km',
      rating: 4.7,
      orderTiming: '11:30 AM - 3:30 PM',
      isVeg: true,
      isOpen: true,
      imageUrl:
          'https://images.unsplash.com/photo-1567620905732-2d1ec7ab7445?w=400&h=300&fit=crop',
      deliveryTime: '25-30 min',
    ),
    Store(
      id: 't6',
      name: 'Royal Thali',
      location: 'Koregaon, Pune',
      distance: '5.3 km',
      rating: 4.4,
      orderTiming: '12:30 PM - 5:00 PM',
      isVeg: false,
      isOpen: false,
      imageUrl:
          'https://images.unsplash.com/photo-1559314809-0d155014e29e?w=400&h=300&fit=crop',
      deliveryTime: '40-45 min',
    ),
  ];

  final List<Store> _cloudKitchenStores = [
    Store(
      id: 'c1',
      name: 'Urban Tiffin Hub',
      location: 'Viman Nagar, Pune',
      distance: '6.7 km',
      rating: 4.2,
      orderTiming: '12:00 PM - 8:00 PM',
      isVeg: false,
      isOpen: false,
      imageUrl:
          'https://images.unsplash.com/photo-1574483768117-5bc0b0c1e0d1?w=400&h=300&fit=crop',
      deliveryTime: '35-40 min',
    ),
    Store(
      id: 'c2',
      name: 'Freshly Made',
      location: 'Kalyani Nagar, Pune',
      distance: '2.9 km',
      rating: 4.5,
      orderTiming: '8:00 AM - 12:00 PM',
      isVeg: true,
      isOpen: true,
      imageUrl:
          'https://images.unsplash.com/photo-1482049016688-2d3e1b311543?w=400&h=300&fit=crop',
      deliveryTime: '20-25 min',
    ),
    Store(
      id: 'c3',
      name: 'Gourmet Express',
      location: 'KP, Pune',
      distance: '4.3 km',
      rating: 4.8,
      orderTiming: '10:00 AM - 9:00 PM',
      isVeg: false,
      isOpen: true,
      imageUrl:
          'https://images.unsplash.com/photo-1550547660-d9450f859349?w=400&h=300&fit=crop',
      deliveryTime: '40-45 min',
    ),
    Store(
      id: 'c4',
      name: 'Wholesome Eats',
      location: 'Wakad, Pune',
      distance: '7.1 km',
      rating: 4.1,
      orderTiming: '11:00 AM - 4:00 PM',
      isVeg: true,
      isOpen: true,
      imageUrl:
          'https://images.unsplash.com/photo-1467003909585-2f8a72700288?w=400&h=300&fit=crop',
      deliveryTime: '30-35 min',
    ),
    Store(
      id: 'c5',
      name: "Chef's Table Cloud",
      location: 'Hinjewadi, Pune',
      distance: '5.2 km',
      rating: 4.7,
      orderTiming: '10:30 AM - 6:00 PM',
      isVeg: false,
      isOpen: true,
      imageUrl:
          'https://images.unsplash.com/photo-1514933651103-005eec06c04b?w=400&h=300&fit=crop',
      deliveryTime: '30-35 min',
    ),
    Store(
      id: 'c6',
      name: 'Fusion Kitchen',
      location: 'Aundh, Pune',
      distance: '3.0 km',
      rating: 4.4,
      orderTiming: '11:30 AM - 7:00 PM',
      isVeg: true,
      isOpen: true,
      imageUrl:
          'https://images.unsplash.com/photo-1543353071-873f17a7a088?w=400&h=300&fit=crop',
      deliveryTime: '25-30 min',
    ),
  ];

  // Get filtered stores based on veg filter
  List<Store> _getFilteredStores(List<Store> stores) {
    if (_selectedVegFilter == 'All') {
      return stores;
    } else if (_selectedVegFilter == 'Veg') {
      return stores.where((store) => store.isVeg == true).toList();
    } else {
      return stores.where((store) => store.isVeg == false).toList();
    }
  }

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _tabController.addListener(() {
      setState(() {
        _selectedTab = _tabController.index;
      });
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
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
                        'Food Center',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w800,
                          color: Colors.white,
                          letterSpacing: -0.5,
                        ),
                      ),
                      Text(
                        'Fresh meals delivered daily',
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
          Expanded(
            child: CustomScrollView(
              slivers: [
                // Banner
                SliverToBoxAdapter(child: _buildBanner()),

                // Tab Bar with persistent header
                SliverPersistentHeader(
                  pinned: true,
                  delegate: _SliverTabBarDelegate(
                    // ── TabBar with border ──
                    Container(
                      margin:  EdgeInsets.only(top: 10),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade100,
                        borderRadius: BorderRadius.circular(14),
                        border: Border.all(
                          color: Colors.orange[700]!.withOpacity(0.35),
                          width: 1.2,
                        ),
                      ),
                      child: TabBar(
                        controller: _tabController,
                        indicator: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight,
                            colors: [Colors.orange[500]!, Colors.orange[700]!],
                          ),
                          borderRadius: BorderRadius.circular(11), // border ke andar fit
                        ),
                        labelColor: Colors.white,
                        unselectedLabelColor: Colors.grey[600],
                        labelStyle: const TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 13,
                        ),
                        unselectedLabelStyle: const TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 12,
                        ),
                        indicatorSize: TabBarIndicatorSize.tab,
                        dividerColor: Colors.transparent,
                        padding: const EdgeInsets.all(4),
                        tabs: const [
                          Tab(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.food_bank, size: 16),
                                SizedBox(width: 6),
                                Text('Tiffin Center'),
                              ],
                            ),
                          ),
                          Tab(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.kitchen, size: 16),
                                SizedBox(width: 6),
                                Text('Cloud Kitchen'),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    // ── Veg filter row ──
                    Row(
                      children: [
                        _buildVegFilterChip('All'),
                        _buildVegFilterChip('Veg'),
                        _buildVegFilterChip('Non-Veg'),
                      ],
                    ),
                  ),
                ),

                // Tab Content
                SliverFillRemaining(
                  child: TabBarView(
                    controller: _tabController,
                    children: [
                      _buildStoreGrid(_tiffinStores, isTiffin: true),
                      _buildStoreGrid(_cloudKitchenStores, isTiffin: false),
                    ],
                  ),
                ),

                SliverToBoxAdapter(child: SizedBox(height: 50,),)
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Build Veg Filter Chip
  Widget _buildVegFilterChip(String filter) {
    final isSelected = _selectedVegFilter == filter;
    final Color chipColor = filter == 'All'
        ? Colors.purple
        : (filter == 'Veg' ? Colors.green : Colors.red);

    return Padding(
      padding: const EdgeInsets.only(right: 6),
      child: GestureDetector(
        onTap: () {
          setState(() {
            _selectedVegFilter = filter;
          });
        },
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
          decoration: BoxDecoration(
            color: isSelected ? chipColor : Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: isSelected ? chipColor : Colors.grey.shade300,
              width: 1.5,
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                filter == 'All'
                    ? Icons.filter_alt_rounded
                    : (filter == 'Veg'
                          ? Icons.eco_rounded
                          : Icons.restaurant_rounded),
                size: 12,
                color: isSelected ? Colors.white : chipColor,
              ),
              const SizedBox(width: 4),
              Text(
                filter == 'All' ? 'All' : filter,
                style: TextStyle(
                  color: isSelected ? Colors.white : Colors.grey[700],
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                  fontSize: 10,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBanner() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      height: 200,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Colors.orange[400]!, Colors.orange[700]!],
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.orange.withOpacity(0.3),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Stack(
        children: [
          // Background Pattern
          Positioned(
            right: -20,
            top: -20,
            child: Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white.withOpacity(0.1),
              ),
            ),
          ),
          Positioned(
            left: -30,
            bottom: -30,
            child: Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white.withOpacity(0.08),
              ),
            ),
          ),
          Positioned(
            right: 60,
            bottom: -10,
            child: Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white.withOpacity(0.05),
              ),
            ),
          ),

          // Content
          Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
              children: [
                Expanded(
                  flex: 2,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Text(
                          '🔥 SPECIAL OFFER',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 0.5,
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        'Get 20% Off\nYour First Order',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          height: 1.2,
                        ),
                      ),
                      const SizedBox(height: 6),
                      const Text(
                        'Use code: FIRST20',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: const Text(
                          'Order Now →',
                          style: TextStyle(
                            color: Colors.orange,
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Container(
                    height: 80,
                    width: 80,
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.15),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.restaurant,
                      color: Colors.white,
                      size: 50,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStoreGrid(List<Store> stores, {required bool isTiffin}) {
    final filteredStores = _getFilteredStores(stores);

    if (filteredStores.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.storefront_outlined, size: 64, color: Colors.grey[300]),
            const SizedBox(height: 16),
            Text(
              'No stores available',
              style: TextStyle(
                color: Colors.grey[500],
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Try changing the filter',
              style: TextStyle(color: Colors.grey[400], fontSize: 13),
            ),
          ],
        ),
      );
    }

    return GridView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 14,
        mainAxisSpacing: 14,
        childAspectRatio: 0.8,
      ),
      itemCount: filteredStores.length,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        final store = filteredStores[index];
        return GestureDetector(
          onTap: () {
            if (isTiffin) {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      TiffinStoreScreen(storeName: store.name),
                ),
              );
            } else {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CloudStoreScreen(storeName: store.name),
                ),
              );
            }
          },
          child: _buildStoreCard(store),
        );
      },
    );
  }

  Widget _buildStoreCard(Store store) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 16,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Premium Image with Overlays
          ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(18),
              topRight: Radius.circular(18),
            ),
            child: Stack(
              children: [
                Image.network(
                  store.imageUrl,
                  height: 130,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  loadingBuilder: (context, child, loadingProgress) {
                    if (loadingProgress == null) return child;
                    return Container(
                      height: 130,
                      color: Colors.grey[100],
                      child: Center(
                        child: SizedBox(
                          height: 24,
                          width: 24,
                          child: CircularProgressIndicator(
                            strokeWidth: 2.5,
                            valueColor: AlwaysStoppedAnimation<Color>(
                              Colors.orange[400]!,
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      height: 130,
                      color: Colors.grey[100],
                      child: Center(
                        child: Icon(
                          Icons.image_not_supported,
                          color: Colors.grey[400],
                          size: 32,
                        ),
                      ),
                    );
                  },
                ),

                // Premium Status Badge
                Positioned(
                  top: 10,
                  right: 10,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 5,
                    ),
                    decoration: BoxDecoration(
                      color: store.isOpen ? Colors.green[500] : Colors.red[500],
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.15),
                          blurRadius: 8,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          store.isOpen ? Icons.circle : Icons.circle,
                          color: Colors.white,
                          size: 6,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          store.isOpen ? 'Open' : 'Closed',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 10,
                            fontWeight: FontWeight.w700,
                            letterSpacing: 0.3,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                // Veg/Non-Veg Badge
                Positioned(
                  top: 10,
                  left: 10,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: store.isVeg ? Colors.green[700] : Colors.red[700],
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.15),
                          blurRadius: 8,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          store.isVeg ? Icons.eco : Icons.restaurant,
                          color: Colors.white,
                          size: 12,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          store.isVeg ? 'VEG' : 'NON-VEG',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 9,
                            fontWeight: FontWeight.w700,
                            letterSpacing: 0.3,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Premium Store Details
          Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Store Name
                Text(
                  store.name,
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                    color: Colors.grey[900],
                    letterSpacing: -0.3,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),

                // Location
                Row(
                  children: [
                    Icon(
                      Icons.location_on_outlined,
                      size: 13,
                      color: Colors.grey[500],
                    ),
                    const SizedBox(width: 3),
                    Expanded(
                      child: Text(
                        store.location,
                        style: TextStyle(
                          color: Colors.grey[600],
                          fontSize: 11,
                          fontWeight: FontWeight.w500,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),

                // Rating and Delivery Time
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Rating
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 6,
                        vertical: 3,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.amber[50],
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          color: Colors.amber[200]!,
                          width: 0.5,
                        ),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Icons.star_rate_rounded,
                            size: 14,
                            color: Colors.amber[700],
                          ),
                          const SizedBox(width: 2),
                          Text(
                            store.rating.toString(),
                            style: TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 12,
                              color: Colors.grey[800],
                            ),
                          ),
                        ],
                      ),
                    ),

                    // Delivery Time
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 6,
                        vertical: 3,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.blue[50],
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          color: Colors.blue[200]!,
                          width: 0.5,
                        ),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Icons.timer_outlined,
                            size: 13,
                            color: Colors.blue[700],
                          ),
                          const SizedBox(width: 3),
                          Text(
                            store.deliveryTime,
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 11,
                              color: Colors.blue[700],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// Store model with additional fields
class Store {
  final String id;
  final String name;
  final String location;
  final String distance;
  final double rating;
  final String orderTiming;
  final bool isVeg;
  final bool isOpen;
  final String imageUrl;
  final String deliveryTime;

  Store({
    required this.id,
    required this.name,
    required this.location,
    required this.distance,
    required this.rating,
    required this.orderTiming,
    required this.isVeg,
    required this.isOpen,
    required this.imageUrl,
    required this.deliveryTime,
  });
}

class _SliverTabBarDelegate extends SliverPersistentHeaderDelegate {
  final Widget tabBar;
  final Widget filterRow;

  _SliverTabBarDelegate(this.tabBar, this.filterRow);

  static const double _kHeaderHeight = 112;

  @override
  double get minExtent => _kHeaderHeight;

  @override
  double get maxExtent => _kHeaderHeight;

  @override
  Widget build(
      BuildContext context,
      double shrinkOffset,
      bool overlapsContent,
      ) {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.symmetric(horizontal: 10),
      height: _kHeaderHeight,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          tabBar,
          const SizedBox(height: 8),
          filterRow,
        ],
      ),
    );
  }

  @override
  bool shouldRebuild(_SliverTabBarDelegate oldDelegate) => true;
}