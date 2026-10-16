import 'package:flutter/material.dart';
import 'package:rent_hub/feature/room/screen/room_details_screen.dart';

import '../../../core/utils/app_color.dart';

class SearchRoomScreen extends StatefulWidget {
  const SearchRoomScreen({super.key});

  @override
  State<SearchRoomScreen> createState() => _SearchRoomScreenState();
}

class _SearchRoomScreenState extends State<SearchRoomScreen> {
  final TextEditingController _searchController = TextEditingController();

  // ── Sample network images for room cards ──
  final List<String> roomImages = const [
    'https://images.unsplash.com/photo-1522708323590-d24dbb6b0267?w=400&h=300&fit=crop',
    'https://images.unsplash.com/photo-1502672260266-1c1ef2d93688?w=400&h=300&fit=crop',
    'https://images.unsplash.com/photo-1560448204-e02f11c3d0e2?w=400&h=300&fit=crop',
    'https://images.unsplash.com/photo-1580587771525-78b9dba3b914?w=400&h=300&fit=crop',
    'https://images.unsplash.com/photo-1560185008-5a6f9d9d2e6b?w=400&h=300&fit=crop',
    'https://images.unsplash.com/photo-1560185127-6ed189bf02f4?w=400&h=300&fit=crop',
    'https://images.unsplash.com/photo-1560448204-603b3fc33ddc?w=400&h=300&fit=crop',
    'https://images.unsplash.com/photo-1586023492125-27b2c045efd7?w=400&h=300&fit=crop',
  ];

  // ── All rooms (searchable dataset) ──
  final List<Map<String, dynamic>> allRooms = [
    {
      'id': '1',
      'title': '1RK',
      'location': 'Downtown, Near University Gate',
      'price': '₹500/month',
      'interest': 2,
      'reviews': 124,
      'imageColor': const Color(0xFF4F46E5),
      'bedrooms': 1,
      'bathrooms': 1,
      'area': '450 sq ft',
      'isAvailable': true,
      'imageIndex': 0,
      'distance': '0.5 km',
      'priceValue': 500,
      'rating': 4.8,
      'features': ['Wi-Fi', 'AC', 'Parking'],
      'category': 'Students',
    },
    {
      'id': '2',
      'title': '2BHK',
      'location': 'City Center, Near Metro',
      'price': '₹1200/month',
      'interest': 15,
      'reviews': 89,
      'imageColor': const Color(0xFF059669),
      'bedrooms': 2,
      'bathrooms': 2,
      'area': '950 sq ft',
      'isAvailable': true,
      'imageIndex': 1,
      'distance': '1.2 km',
      'priceValue': 1200,
      'rating': 4.9,
      'features': ['Wi-Fi', 'AC', 'Gym', 'Pool'],
      'category': 'Professionals',
    },
    {
      'id': '3',
      'title': '1BHK',
      'location': 'Green Park Colony',
      'price': '₹800/month',
      'interest': 8,
      'reviews': 56,
      'imageColor': const Color(0xFF0891B2),
      'bedrooms': 1,
      'bathrooms': 1,
      'area': '600 sq ft',
      'isAvailable': true,
      'imageIndex': 2,
      'distance': '0.8 km',
      'priceValue': 800,
      'rating': 4.6,
      'features': ['Wi-Fi', 'AC'],
      'category': 'Bachelor',
    },
    {
      'id': '4',
      'title': 'PG Room',
      'location': 'Near College Gate',
      'price': '₹450/month',
      'interest': 20,
      'reviews': 203,
      'imageColor': const Color(0xFFDC2626),
      'bedrooms': 1,
      'bathrooms': 1,
      'area': '300 sq ft',
      'isAvailable': true,
      'imageIndex': 3,
      'distance': '0.3 km',
      'priceValue': 450,
      'rating': 4.5,
      'features': ['Wi-Fi', 'Mess'],
      'category': 'PG & Hostel',
    },
    {
      'id': '5',
      'title': '3BHK',
      'location': 'Green Valley Estate',
      'price': '₹1800/month',
      'interest': 25,
      'reviews': 67,
      'imageColor': const Color(0xFF7C3AED),
      'bedrooms': 3,
      'bathrooms': 2,
      'area': '1500 sq ft',
      'isAvailable': true,
      'imageIndex': 4,
      'distance': '4.5 km',
      'priceValue': 1800,
      'rating': 4.7,
      'features': ['Garden', 'Parking', 'Security'],
      'category': 'Family',
    },
    {
      'id': '6',
      'title': 'Studio',
      'location': 'Lake View Apartments',
      'price': '₹900/month',
      'interest': 12,
      'reviews': 45,
      'imageColor': const Color(0xFFF59E0B),
      'bedrooms': 1,
      'bathrooms': 1,
      'area': '400 sq ft',
      'isAvailable': true,
      'imageIndex': 5,
      'distance': '1.5 km',
      'priceValue': 900,
      'rating': 4.8,
      'features': ['Wi-Fi', 'AC', 'Smart TV'],
      'category': 'Freelancers',
    },
    {
      'id': '7',
      'title': '1BHK',
      'location': 'Tech Park Area',
      'price': '₹750/month',
      'interest': 18,
      'reviews': 92,
      'imageColor': const Color(0xFFF59E0B),
      'bedrooms': 1,
      'bathrooms': 1,
      'area': '500 sq ft',
      'isAvailable': true,
      'imageIndex': 6,
      'distance': '0.3 km',
      'priceValue': 750,
      'rating': 4.8,
      'features': ['Wi-Fi', 'AC', 'Smart TV'],
      'category': 'Professionals',
    },
    {
      'id': '8',
      'title': '3BHK',
      'location': 'Skyline Towers',
      'price': '₹2500/month',
      'interest': 32,
      'reviews': 134,
      'imageColor': const Color(0xFF6366F1),
      'bedrooms': 3,
      'bathrooms': 3,
      'area': '1800 sq ft',
      'isAvailable': true,
      'imageIndex': 7,
      'distance': '2.0 km',
      'priceValue': 2500,
      'rating': 4.9,
      'features': ['Pool', 'Gym', 'Security', 'Parking'],
      'category': 'Family',
    },
  ];

  // ── Category filter ──
  String _selectedCategory = 'All';

  final List<String> _categories = const [
    'All',
    'Students',
    'Professionals',
    'Family',
    'Bachelor',
    'PG & Hostel',
    'Freelancers',
  ];

  // ── Filtered results ──
  List<Map<String, dynamic>> get filteredRooms {
    final query = _searchController.text.trim().toLowerCase();
    return allRooms.where((room) {
      final matchesCategory = _selectedCategory == 'All' ||
          room['category'] == _selectedCategory;
      final matchesQuery = query.isEmpty ||
          room['title'].toString().toLowerCase().contains(query) ||
          room['location'].toString().toLowerCase().contains(query);
      return matchesCategory && matchesQuery;
    }).toList();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final rooms = filteredRooms;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          // ── HEADER with search bar ──
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [AppColor.primary, AppColor.secondary],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
            child: SafeArea(
              bottom: false,
              child: Column(
                children: [
                  // Title row
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () => Navigator.pop(context),
                        child: Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white.withOpacity(0.2),
                            border:
                            Border.all(color: Colors.white, width: 1.5),
                          ),
                          child: const Center(
                            child: Icon(
                              Icons.arrow_back_ios_new_rounded,
                              color: Colors.white,
                              size: 18,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Search Rooms',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                              color: Colors.white,
                            ),
                          ),
                          Text(
                            'Find your perfect stay',
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.white70,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                      const Spacer(),
                      IconButton(
                        icon: const Icon(
                          Icons.favorite_border,
                          color: Colors.white,
                          size: 26,
                        ),
                        onPressed: () {},
                      ),
                    ],
                  ),
                  const SizedBox(height: 14),

                  // Search bar
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(14),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.06),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: TextField(
                      controller: _searchController,
                      onChanged: (_) => setState(() {}),
                      textInputAction: TextInputAction.search,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: Colors.black87,
                      ),
                      decoration: InputDecoration(
                        hintText: 'Search by title or location...',
                        hintStyle: TextStyle(
                          color: Colors.grey.shade500,
                          fontSize: 13.5,
                          fontWeight: FontWeight.w400,
                        ),
                        prefixIcon: const Icon(
                          Icons.search_rounded,
                          color: AppColor.primary,
                          size: 22,
                        ),
                        suffixIcon: _searchController.text.isNotEmpty
                            ? GestureDetector(
                          onTap: () {
                            setState(() {
                              _searchController.clear();
                            });
                          },
                          child: const Icon(
                            Icons.close_rounded,
                            color: Colors.grey,
                            size: 20,
                          ),
                        )
                            : null,
                        border: InputBorder.none,
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 14,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                ],
              ),
            ),
          ),

          // ── CATEGORY CHIPS ──
          Container(
            color: Colors.white,
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: SizedBox(
              height: 36,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 12),
                itemCount: _categories.length,
                itemBuilder: (context, index) {
                  final cat = _categories[index];
                  final isSelected = _selectedCategory == cat;
                  return Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: GestureDetector(
                      onTap: () =>
                          setState(() => _selectedCategory = cat),
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 180),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 14,
                          vertical: 8,
                        ),
                        decoration: BoxDecoration(
                          color: isSelected
                              ? AppColor.primary
                              : AppColor.white,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: isSelected
                                ? AppColor.primary
                                : AppColor.border,
                            width: 1.2,
                          ),
                        ),
                        child: Center(
                          child: Text(
                            cat,
                            style: TextStyle(
                              color: isSelected
                                  ? Colors.white
                                  : Colors.black87,
                              fontWeight: isSelected
                                  ? FontWeight.bold
                                  : FontWeight.w500,
                              fontSize: 12,
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),

          const SizedBox(height: 10),

          // ── RESULTS ──
          Expanded(
            child: rooms.isEmpty
                ? _buildEmptyState()
                : ListView(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              children: [
                GridView.builder(
                  shrinkWrap: true,
                  padding: EdgeInsets.zero,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate:
                  const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 6,
                    mainAxisSpacing: 6,
                    childAspectRatio: 0.8,
                  ),
                  itemCount: rooms.length,
                  itemBuilder: (context, index) {
                    return _buildRoomCard(rooms[index]);
                  },
                ),
                const SizedBox(height: 150),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ─────────────────────────────────────────────
  // Empty state
  // ─────────────────────────────────────────────
  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: AppColor.primary.withOpacity(0.08),
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.search_off_rounded,
              size: 60,
              color: AppColor.primary.withOpacity(0.6),
            ),
          ),
          const SizedBox(height: 20),
          const Text(
            'No Rooms Found',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: Color(0xFF1E293B),
            ),
          ),
          const SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: Text(
              'Try changing your search or filter',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 13,
                color: Colors.grey.shade600,
              ),
            ),
          ),
          const SizedBox(height: 24),
          ElevatedButton.icon(
            onPressed: () {
              setState(() {
                _searchController.clear();
                _selectedCategory = 'All';
              });
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColor.primary,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(
                horizontal: 24,
                vertical: 12,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            icon: const Icon(Icons.refresh_rounded, size: 18),
            label: const Text(
              'Reset Filters',
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
          ),
        ],
      ),
    );
  }

  // ─────────────────────────────────────────────
  // Room card — same design as FavoriteScreen
  // ─────────────────────────────────────────────
  Widget _buildRoomCard(Map<String, dynamic> room) {
    final color = room['imageColor'] as Color;
    final isAvailable = room['isAvailable'] as bool;
    final imageIndex = room['imageIndex'] as int;
    final interest = room['interest'] as int;

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>
                RoomDetailsScreen(roomTitle: room['title']),
          ),
        );
      },
      child: Card(
        elevation: 0.2,
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(14),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image
            Expanded(
              child: Stack(
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(14),
                    ),
                    child: Image.network(
                      roomImages[imageIndex % roomImages.length],
                      width: double.infinity,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          width: double.infinity,
                          color: AppColor.secondary.withOpacity(0.3),
                          child: Center(
                            child: Icon(
                              Icons.home_rounded,
                              size: 40,
                              color: AppColor.primary,
                            ),
                          ),
                        );
                      },
                      loadingBuilder: (context, child, loadingProgress) {
                        if (loadingProgress == null) return child;
                        return Container(
                          width: double.infinity,
                          color: color.withOpacity(0.1),
                          child: Center(
                            child: SizedBox(
                              width: 24,
                              height: 24,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                color: color,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),

                  // Status badge
                  Positioned(
                    top: 8,
                    left: 8,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 3,
                      ),
                      decoration: BoxDecoration(
                        color: isAvailable ? Colors.green : Colors.red,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
                        isAvailable ? 'Available' : 'Booked',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 9,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),

                  // Favorite heart (visual only)
                  Positioned(
                    top: 8,
                    right: 8,
                    child: Container(
                      padding: const EdgeInsets.all(5),
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.favorite_border,
                        color: Colors.red,
                        size: 16,
                      ),
                    ),
                  ),

                  // Interest count
                  Positioned(
                    bottom: 8,
                    right: 8,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 3,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.7),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(
                            Icons.people_outline_rounded,
                            size: 10,
                            color: Colors.white,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            '$interest',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 10,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Content
            Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        room['title'],
                        style: const TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const Spacer(),
                      Text(
                        room['distance'],
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.green.shade700,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 2),
                  Row(
                    children: [
                      Icon(
                        Icons.location_on_rounded,
                        size: 12,
                        color: Colors.grey.shade500,
                      ),
                      const SizedBox(width: 2),
                      Expanded(
                        child: Text(
                          room['location'],
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey.shade700,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.bed_rounded,
                            size: 12,
                            color: Colors.grey.shade700,
                          ),
                          const SizedBox(width: 2),
                          Text(
                            '${room['bedrooms']}',
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey.shade700,
                            ),
                          ),
                          const SizedBox(width: 6),
                          Icon(
                            Icons.bathtub_rounded,
                            size: 12,
                            color: Colors.grey.shade700,
                          ),
                          const SizedBox(width: 2),
                          Text(
                            '${room['bathrooms']}',
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey.shade700,
                            ),
                          ),
                        ],
                      ),
                      Text(
                        room['price'],
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                          color: AppColor.primary,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}