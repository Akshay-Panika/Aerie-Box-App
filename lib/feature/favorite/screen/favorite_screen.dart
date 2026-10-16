import 'package:flutter/material.dart';
import 'package:rent_hub/feature/room/screen/room_details_screen.dart';

import '../../../core/utils/app_color.dart';

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({super.key});

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  // Random home/room related network images for room cards
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

  // Same data structure as RoomSection — but only favorites
  final List<Map<String, dynamic>> favoriteRooms = [
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
    },
  ];

  void _removeFavorite(int index) {
    final removed = favoriteRooms[index];
    setState(() {
      favoriteRooms.removeAt(index);
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('${removed['title']} removed from favorites'),
        duration: const Duration(seconds: 2),
        behavior: SnackBarBehavior.floating,
        action: SnackBarAction(
          label: 'Undo',
          onPressed: () {
            setState(() {
              favoriteRooms.insert(index, removed);
            });
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    const Color primaryColor = Color(0xFF5F259F);
    const Color primaryLight = Color(0xFF7C3AED);

    return Scaffold(
      backgroundColor: Colors.white,

      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  AppColor.primary,
                  AppColor.secondary],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
            child: SafeArea(
              bottom: false,
              child: Row(
                children: [
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white.withOpacity(0.2),
                      border: Border.all(color: Colors.white, width: 1.5),
                    ),
                    child: const Center(
                      child: Icon(
                        Icons.post_add_rounded,
                        color: Colors.white,
                        size: 22,
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'My Favorite',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        'Manage all your listings',
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.white70,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                  const Spacer(),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 14,
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.post_add_rounded,
                          color: Colors.white,
                          size: 20,
                        ),
                        const SizedBox(width: 6),
                        Text(
                          '${favoriteRooms.length}',
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 10),
          Expanded(
            child: favoriteRooms.isEmpty
                ? _buildEmptyState(primaryColor)
                : ListView(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              children: [
                GridView.builder(
                  shrinkWrap: true,
                  padding: EdgeInsets.zero,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 6,
                    mainAxisSpacing: 6,
                    childAspectRatio: 0.8,
                  ),
                  itemCount: favoriteRooms.length,
                  itemBuilder: (context, index) {
                    final room = favoriteRooms[index];
                    return _buildRoomCard(room, index);
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
  Widget _buildEmptyState(Color primaryColor) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: primaryColor.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.favorite_border,
              size: 60,
              color: primaryColor,
            ),
          ),
          const SizedBox(height: 20),
          const Text(
            'No Favorites Yet',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: Color(0xFF1E293B),
            ),
          ),
          const SizedBox(height: 8),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 40),
            child: Text(
              'Start adding rooms you love to see them here',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 13,
                color: Color(0xFF64748B),
              ),
            ),
          ),
          const SizedBox(height: 24),
          ElevatedButton.icon(
            onPressed: () => Navigator.pop(context),
            style: ElevatedButton.styleFrom(
              backgroundColor: primaryColor,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(
                horizontal: 24,
                vertical: 12,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            icon: const Icon(Icons.search, size: 18),
            label: const Text(
              'Explore Rooms',
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
          ),
        ],
      ),
    );
  }

  // ─────────────────────────────────────────────
  // Room card — identical to RoomSection design
  // ─────────────────────────────────────────────
  Widget _buildRoomCard(Map<String, dynamic> room, int index) {
    final color = room['imageColor'] as Color;
    final isAvailable = room['isAvailable'] as bool;
    final imageIndex = room['imageIndex'] as int;
    final interest = room['interest'] as int;

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => RoomDetailsScreen(roomTitle: room['title']),
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
                  // Status Badge
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
                  Positioned(
                    top: 8,
                    right: 8,
                    child: InkWell(
                      onTap: () => _removeFavorite(index),
                      child: Container(
                        padding: const EdgeInsets.all(5),
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.favorite,
                          color: Colors.red,
                          size: 16,
                        ),
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
                        style:  TextStyle(
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