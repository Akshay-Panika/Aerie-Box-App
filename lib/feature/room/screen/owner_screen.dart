import 'package:flutter/material.dart';
import 'package:rent_hub/feature/room/screen/room_details_screen.dart';

class OwnerScreen extends StatefulWidget {
  final Map<String, dynamic>? owner;
  const OwnerScreen({super.key, this.owner});

  @override
  State<OwnerScreen> createState() => _OwnerScreenState();
}

class _OwnerScreenState extends State<OwnerScreen>
    with SingleTickerProviderStateMixin {
  bool _isFavorite = false;
  late TabController _tabController;

  // Room images
  final List<String> roomImages = const [
    'https://images.unsplash.com/photo-1522708323590-d24dbb6b0267?w=400&h=300&fit=crop',
    'https://images.unsplash.com/photo-1502672260266-1c1ef2d93688?w=400&h=300&fit=crop',
    'https://images.unsplash.com/photo-1560448204-e02f11c3d0e2?w=400&h=300&fit=crop',
    'https://images.unsplash.com/photo-1580587771525-78b9dba3b914?w=400&h=300&fit=crop',
    'https://images.unsplash.com/photo-1560185008-5a6f9d9d2e6b?w=400&h=300&fit=crop',
    'https://images.unsplash.com/photo-1560185127-6ed189bf02f4?w=400&h=300&fit=crop',
  ];

  Map<String, dynamic> get _owner {
    return widget.owner ?? {
      'name': 'Rahul Sharma',
      'email': 'rahul.sharma@email.com',
      'phone': '+91 98765 43210',
      'joinedDate': 'Jan 2024',
      'rating': 4.8,
      'totalProperties': 12,
      'totalBookings': 156,
      'responseRate': 98,
      'verified': true,
      'bio': 'Professional property manager with 5+ years of experience.',
      'image': 'https://i.pravatar.cc/300?img=11',
      'coverImage':
      'https://images.unsplash.com/photo-1560448204-e02f11c3d0e2?w=800&h=400&fit=crop',
    };
  }

  final List<Map<String, dynamic>> allRooms = const [
    {
      'id': '1',
      'title': '1RK',
      'location': 'Downtown, Near University Gate',
      'price': '₹500/month',
      'interest': 2,
      'reviews': 124,
      'imageColor': Color(0xFF4F46E5),
      'bedrooms': 1,
      'bathrooms': 1,
      'area': '450 sq ft',
      'isAvailable': true,
      'imageIndex': 0,
      'distance': '0.5 km',
      'priceValue': 500,
      'rating': 4.8,
      'features': ['Wi-Fi', 'AC', 'Parking'],
      'status': 'Available',
    },
    {
      'id': '2',
      'title': '2BHK',
      'location': 'City Center, Near Metro',
      'price': '₹1200/month',
      'interest': 15,
      'reviews': 89,
      'imageColor': Color(0xFF059669),
      'bedrooms': 2,
      'bathrooms': 2,
      'area': '950 sq ft',
      'isAvailable': true,
      'imageIndex': 1,
      'distance': '1.2 km',
      'priceValue': 1200,
      'rating': 4.9,
      'features': ['Wi-Fi', 'AC', 'Gym', 'Pool'],
      'status': 'Available',
    },
    {
      'id': '3',
      'title': 'Single Room',
      'location': 'Near Railway Station',
      'price': '₹50/day',
      'interest': 8,
      'reviews': 56,
      'imageColor': Color(0xFFD97706),
      'bedrooms': 1,
      'bathrooms': 1,
      'area': '350 sq ft',
      'isAvailable': true,
      'imageIndex': 2,
      'distance': '2.8 km',
      'priceValue': 50,
      'rating': 4.5,
      'features': ['Wi-Fi', 'TV'],
      'status': 'Available',
    },
    {
      'id': '4',
      'title': '1RK',
      'location': 'Art District',
      'price': '₹800/month',
      'interest': 11,
      'reviews': 78,
      'imageColor': Color(0xFFDC2626),
      'bedrooms': 1,
      'bathrooms': 1,
      'area': '600 sq ft',
      'isAvailable': false,
      'imageIndex': 3,
      'distance': '3.2 km',
      'priceValue': 800,
      'rating': 4.6,
      'features': ['Studio', 'Natural Light'],
      'status': 'Not Available',
    },
    {
      'id': '5',
      'title': '3BHK',
      'location': 'Green Valley Estate',
      'price': '₹1800/month',
      'interest': 25,
      'reviews': 67,
      'imageColor': Color(0xFF7C3AED),
      'bedrooms': 3,
      'bathrooms': 2,
      'area': '1500 sq ft',
      'isAvailable': true,
      'imageIndex': 4,
      'distance': '4.5 km',
      'priceValue': 1800,
      'rating': 4.7,
      'features': ['Garden', 'Parking', 'Security'],
      'status': 'Available',
    },
    {
      'id': '6',
      'title': '1RK',
      'location': 'High Street, Near Mall',
      'price': '₹650/month',
      'interest': 6,
      'reviews': 45,
      'imageColor': Color(0xFF8B5CF6),
      'bedrooms': 1,
      'bathrooms': 1,
      'area': '400 sq ft',
      'isAvailable': true,
      'imageIndex': 5,
      'distance': '1.8 km',
      'priceValue': 650,
      'rating': 4.4,
      'features': ['Wi-Fi', 'City View'],
      'status': 'Available',
    },
    {
      'id': '7',
      'title': '1BHK',
      'location': 'Tech Park Area',
      'price': '₹750/month',
      'interest': 18,
      'reviews': 92,
      'imageColor': Color(0xFFF59E0B),
      'bedrooms': 1,
      'bathrooms': 1,
      'area': '500 sq ft',
      'isAvailable': true,
      'imageIndex': 6,
      'distance': '0.3 km',
      'priceValue': 750,
      'rating': 4.8,
      'features': ['Wi-Fi', 'AC', 'Smart TV'],
      'status': 'Available',
    },
    {
      'id': '8',
      'title': '3BHK',
      'location': 'Skyline Towers',
      'price': '₹2500/month',
      'interest': 32,
      'reviews': 134,
      'imageColor': Color(0xFF6366F1),
      'bedrooms': 3,
      'bathrooms': 3,
      'area': '1800 sq ft',
      'isAvailable': true,
      'imageIndex': 7,
      'distance': '2.0 km',
      'priceValue': 2500,
      'rating': 4.9,
      'features': ['Pool', 'Gym', 'Security', 'Parking'],
      'status': 'Available',
    },
  ];

  final List<Map<String, dynamic>> reviews = [
    {
      'name': 'Priya Patel',
      'rating': 5.0,
      'date': '2 days ago',
      'comment': 'Great experience! Very responsive and helpful.',
      'image': 'https://i.pravatar.cc/150?img=5',
    },
    {
      'name': 'Amit Kumar',
      'rating': 4.0,
      'date': '1 week ago',
      'comment': 'Good property, clean and well-maintained.',
      'image': 'https://i.pravatar.cc/150?img=3',
    },
    {
      'name': 'Sneha Reddy',
      'rating': 5.0,
      'date': '2 weeks ago',
      'comment': 'Best owner I\'ve ever dealt with. Very professional.',
      'image': 'https://i.pravatar.cc/150?img=10',
    },
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final owner = _owner;
    const Color primaryColor = Color(0xFF5F259F);

    return Scaffold(
      backgroundColor: const Color(0xFFF5F6FA),
      appBar: AppBar(
        backgroundColor: primaryColor,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () => Navigator.pop(context),
          padding: EdgeInsets.zero,
        ),
        title: const Text(
          "Room Owner",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(
              _isFavorite ? Icons.favorite : Icons.favorite_border,
              color: _isFavorite ? Colors.red : Colors.white,
            ),
            onPressed: () => setState(() => _isFavorite = !_isFavorite),
          ),
          IconButton(
            icon: const Icon(Icons.share, color: Colors.white),
            onPressed: () => _showShareOptions(context),
          ),
        ],
      ),
      body: Column(
        children: [
          // Header - Fixed height
          SizedBox(
            height: 230,
            child: Stack(
              fit: StackFit.expand,
              children: [
                Image.network(
                  owner['coverImage'],
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(color: primaryColor);
                  },
                ),
                Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.black.withOpacity(0.1),
                        Colors.black.withOpacity(0.5),
                        primaryColor.withOpacity(0.8),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  bottom: 20,
                  left: 20,
                  right: 20,
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: 40,
                        backgroundImage: NetworkImage(owner['image']),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              owner['name'],
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Row(
                              children: [
                                const Icon(Icons.star,
                                    size: 16, color: Colors.amber),
                                const SizedBox(width: 4),
                                Text(
                                  owner['rating'].toString(),
                                  style: const TextStyle(color: Colors.white),
                                ),
                                const SizedBox(width: 8),
                                Text(
                                  '${owner['totalBookings']} bookings',
                                  style: TextStyle(
                                      color: Colors.white.withOpacity(0.8)),
                                ),
                                if (owner['verified']) ...[
                                  const SizedBox(width: 8),
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 6, vertical: 2),
                                    decoration: BoxDecoration(
                                      color: Colors.green,
                                      borderRadius: BorderRadius.circular(4),
                                    ),
                                    child: const Text(
                                      'Verified',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 9,
                                        fontWeight: FontWeight.bold,
                                      ),
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
                ),
              ],
            ),
          ),
          // TabBar
          Container(
            color: Colors.white,
            child: TabBar(
              controller: _tabController,
              indicatorColor: primaryColor,
              indicatorWeight: 3,
              labelColor: primaryColor,
              unselectedLabelColor: Colors.grey.shade600,
              labelStyle: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
              unselectedLabelStyle: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
              tabs: const [
                Tab(text: 'Properties'),
                Tab(text: 'Reviews'),
                Tab(text: 'About'),
              ],
            ),
          ),
          // TabBarView - Expanded to fill remaining space
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                _buildPropertiesTab(),
                _buildReviewsTab(),
                _buildAboutTab(owner),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPropertiesTab() {
    return GridView.builder(
      padding: const EdgeInsets.all(10),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        childAspectRatio: 0.8,
      ),
      itemCount: allRooms.length,
      itemBuilder: (context, index) {
        final property = allRooms[index];
        return _buildRoomCard(property);
      },
    );
  }

  Widget _buildRoomCard(Map<String, dynamic> room) {
    final color = room['imageColor'] as Color;
    final isAvailable = room['isAvailable'] as bool;
    final imageIndex = room['imageIndex'] as int;
    final interest = room['interest'] as int;
    final status = room['status'] as String? ?? (isAvailable ? 'Available' : 'Not Available');

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => RoomDetailsScreen(roomTitle: room['title'],),
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
                    borderRadius:
                    const BorderRadius.vertical(top: Radius.circular(14)),
                    child: Image.network(
                      roomImages[imageIndex % roomImages.length],
                      width: double.infinity,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          width: double.infinity,
                          color: color.withOpacity(0.2),
                          child: Center(
                            child: Icon(
                              Icons.home_rounded,
                              size: 40,
                              color: color,
                            ),
                          ),
                        );
                      },
                      loadingBuilder: (context, child, loadingProgress) {
                        if (loadingProgress == null) return child;
                        return Container(
                          width: double.infinity,
                          color: color.withOpacity(0.1),
                          child: const Center(
                            child: SizedBox(
                              width: 24,
                              height: 24,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
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
                          horizontal: 8, vertical: 3),
                      decoration: BoxDecoration(
                        color: isAvailable ? Colors.green : Colors.red,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
                        status,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 9,
                          fontWeight: FontWeight.bold,
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
                          horizontal: 8, vertical: 3),
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
                      Expanded(
                        child: Text(
                          room['title'],
                          style: const TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.bold,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Text(
                        room['distance'],
                        style: TextStyle(
                          fontSize: 11,
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
                            fontSize: 11,
                            color: Colors.grey.shade600,
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
                              fontSize: 11,
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
                              fontSize: 11,
                              color: Colors.grey.shade700,
                            ),
                          ),
                        ],
                      ),
                      Text(
                        room['price'],
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                          color: Color(0xFF5F259F),
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

  Widget _buildReviewsTab() {
    return ListView.builder(
      padding: const EdgeInsets.all(10),
      itemCount: reviews.length,
      itemBuilder: (context, index) {
        final review = reviews[index];
        return Container(
          padding: const EdgeInsets.all(16),
          margin: const EdgeInsets.only(bottom: 12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.06),
                blurRadius: 8,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CircleAvatar(
                radius: 24,
                backgroundImage: NetworkImage(review['image']),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          review['name'],
                          style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          review['date'],
                          style: TextStyle(
                              fontSize: 11, color: Colors.grey.shade500),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: List.generate(
                        5,
                            (index) => Icon(
                          index < review['rating']
                              ? Icons.star_rounded
                              : Icons.star_border_rounded,
                          size: 16,
                          color: Colors.amber.shade600,
                        ),
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      review['comment'],
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.grey.shade700,
                        height: 1.4,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildAboutTab(Map<String, dynamic> owner) {
    const Color primaryColor = Color(0xFF5F259F);

    return SingleChildScrollView(
      padding: const EdgeInsets.all(10),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.06),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'About',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              owner['bio'],
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey.shade700,
                height: 1.6,
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Contact Information',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            _buildContactTile(
                Icons.phone_rounded, owner['phone'], 'Phone', Colors.green),
            _buildContactTile(
                Icons.email_rounded, owner['email'], 'Email', Colors.blue),
            _buildContactTile(
              Icons.calendar_today_rounded,
              'Joined ${owner['joinedDate']}',
              'Member Since',
              primaryColor,
            ),
            const SizedBox(height: 20),
            const Text(
              'Quick Actions',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child:
                  _buildActionButton(Icons.chat_rounded, 'Message', Colors.blue),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child:
                  _buildActionButton(Icons.call_rounded, 'Call', Colors.green),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _buildActionButton(
                      Icons.share_rounded, 'Share', primaryColor),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildContactTile(IconData icon, String value, String label, Color color) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, size: 18, color: color),
          ),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: TextStyle(fontSize: 11, color: Colors.grey.shade500),
              ),
              Text(
                value,
                style:
                const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildActionButton(IconData icon, String label, Color color) {
    return InkWell(
      onTap: () {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('$label initiated...'),
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        );
      },
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color: color.withOpacity(0.08),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: color.withOpacity(0.15)),
        ),
        child: Column(
          children: [
            Icon(icon, color: color, size: 24),
            const SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w600,
                color: color,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showShareOptions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Share Profile',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildShareIcon(Icons.circle, 'WhatsApp', Colors.green),
                _buildShareIcon(Icons.telegram, 'Telegram', Colors.blue),
                _buildShareIcon(Icons.copy, 'Copy', Colors.grey),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildShareIcon(IconData icon, String label, Color color) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            shape: BoxShape.circle,
          ),
          child: Icon(icon, color: color, size: 28),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
        ),
      ],
    );
  }
}