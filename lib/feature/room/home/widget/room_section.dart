
import 'package:flutter/material.dart';
import 'package:rent_hub/feature/room/home/screen/room_details_screen.dart';

import '../../../../core/utils/app_color.dart';
import '../../search/screen/search_room_screen.dart';

class RoomSection extends StatefulWidget {
  final ScrollController scrollController;
  const RoomSection({super.key, required this.scrollController});

  @override
  State<RoomSection> createState() => _RoomSectionState();
}

class _RoomSectionState extends State<RoomSection> {
  // Filter states
  String _selectedFilter = 'All';
  String _selectedPriceRange = 'Any';
  String _selectedRoomType = 'All';
  bool _showOnlyAvailable = false;

  final List<String> _filterList = ["All", "Nearby", "Low Price", "High Price", "Popular"];

  // Random home/room related network images for room cards
  final List<String> roomImages = const [
    'https://images.unsplash.com/photo-1522708323590-d24dbb6b0267?w=400&h=300&fit=crop',
    'https://images.unsplash.com/photo-1502672260266-1c1ef2d93688?w=400&h=300&fit=crop',
    'https://images.unsplash.com/photo-1560448204-e02f11c3d0e2?w=400&h=300&fit=crop',
    'https://images.unsplash.com/photo-1580587771525-78b9dba3b914?w=400&h=300&fit=crop',
    'https://images.unsplash.com/photo-1560185008-5a6f9d9d2e6b?w=400&h=300&fit=crop',
    'https://images.unsplash.com/photo-1560185127-6ed189bf02f4?w=400&h=300&fit=crop',
    'https://images.unsplash.com/photo-1560448204-603b3fc33ddc?w=400&h=300&fit=crop',
    'https://images.unsplash.com/photo-1560448204-e02f11c3d0e2?w=400&h=300&fit=crop',
    'https://images.unsplash.com/photo-1586023492125-27b2c045efd7?w=400&h=300&fit=crop',
    'https://images.unsplash.com/photo-1560185127-6ed189bf02f4?w=400&h=300&fit=crop',
  ];

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
    },
  ];

  // Get filtered rooms
  List<Map<String, dynamic>> get _filteredRooms {
    List<Map<String, dynamic>> rooms = List.from(allRooms);

    // Apply price filter
    if (_selectedPriceRange != 'Any') {
      rooms = rooms.where((room) {
        final price = room['priceValue'] as int;
        switch (_selectedPriceRange) {
          case '₹0-₹500':
            return price <= 500;
          case '₹500-₹1000':
            return price > 500 && price <= 1000;
          case '₹1000+':
            return price > 1000;
          default:
            return true;
        }
      }).toList();
    }

    // Apply room type filter
    if (_selectedRoomType != 'All') {
      rooms = rooms.where((room) {
        final bedrooms = room['bedrooms'] as int;
        switch (_selectedRoomType) {
          case '1 BHK':
            return bedrooms == 1;
          case '2 BHK':
            return bedrooms == 2;
          case '3 BHK':
            return bedrooms >= 3;
          case 'Studio':
            return room['title'].contains('Studio');
          default:
            return true;
        }
      }).toList();
    }

    // Apply availability filter
    if (_showOnlyAvailable) {
      rooms = rooms.where((room) => room['isAvailable'] == true).toList();
    }

    // Apply sorting
    switch (_selectedFilter) {
      case 'Nearby':
        rooms.sort((a, b) => a['distance'].toString().compareTo(b['distance'].toString()));
        break;
      case 'Low Price':
        rooms.sort((a, b) => (a['priceValue'] as int).compareTo(b['priceValue'] as int));
        break;
      case 'High Price':
        rooms.sort((a, b) => (b['priceValue'] as int).compareTo(a['priceValue'] as int));
        break;
      case 'Popular':
        rooms.sort((a, b) => (b['interest'] as int).compareTo(a['interest'] as int));
        break;
      default:
        break;
    }

    return rooms;
  }

  @override
  Widget build(BuildContext context) {
    final filteredRooms = _filteredRooms;

    return Column(
      spacing: 10,
      children: [
        // Drag handle
        Center(
          child: Container(
            width: 50,
            height: 5,
            margin: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: const Color(0xFFCBD5E1),
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),

        // Search bar
        Row(
          children: [
            Expanded(
              child: Card(
                elevation: 0.5,
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const SearchRoomScreen()),
                    );
                  },
                  borderRadius: BorderRadius.circular(12),
                  child: const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12.0),
                    child: Row(
                      children: [
                        Icon(Icons.search, color: Colors.grey),
                        SizedBox(width: 12),
                        Text(
                          "Search room...",
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Card(
              elevation: 0.5,
              color: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: InkWell(
                onTap: () => _showFilterDialog(context),
                borderRadius: BorderRadius.circular(12),
                child: const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12.0),
                  child: Icon(Icons.filter_list, color: Colors.grey),
                ),
              ),
            ),
          ],
        ),

        // Filter chips
        SizedBox(
          height: 46,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: _filterList.length,
            padding: EdgeInsets.zero,
            itemBuilder: (context, index) {
              final filter = _filterList[index];
              final isSelected = _selectedFilter == filter;

              return GestureDetector(
                onTap: () {
                  setState(() {
                    _selectedFilter = filter;
                  });
                },
                child: Card(
                  elevation: 0.2,
                  color: isSelected ? AppColor.primary : Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Center(
                      child: Text(
                        filter,
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: isSelected ? Colors.white : Colors.grey.shade700,
                        ),
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),

        // Room Grid
        Expanded(
          child: filteredRooms.isEmpty
              ? Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.home_rounded,
                  size: 60,
                  color: Colors.grey.shade400,
                ),
                const SizedBox(height: 12),
                Text(
                  'No rooms found',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.grey.shade600,
                  ),
                ),
              ],
            ),
          )
              : ListView(
            controller: widget.scrollController,
            physics: const ClampingScrollPhysics(),
            padding: EdgeInsets.zero,
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
                itemCount: filteredRooms.length,
                itemBuilder: (context, index) {
                  final room = filteredRooms[index];
                  return _buildRoomCard(room);
                },
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildRoomCard(Map<String, dynamic> room) {
    final color = room['imageColor'] as Color;
    final isAvailable = room['isAvailable'] as bool;
    final imageIndex = room['imageIndex'] as int;
    final interest = room['interest'] as int;

    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => RoomDetailsScreen(roomTitle: room['title'],),));
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
                    borderRadius: const BorderRadius.vertical(top: Radius.circular(14)),
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
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
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
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
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
                            fontWeight: FontWeight.w500
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

  void _showFilterDialog(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) => StatefulBuilder(
        builder: (context, setState) {
          return Container(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Filter Properties',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        setState(() {
                          _selectedPriceRange = 'Any';
                          _selectedRoomType = 'All';
                          _showOnlyAvailable = false;
                        });
                      },
                      child: const Text(
                        'Reset All',
                        style: TextStyle(
                          color: Color(0xFF5F259F),
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),

                const Text(
                  'Price Range',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 12),
                Wrap(
                  spacing: 10,
                  runSpacing: 10,
                  children: [
                    _buildFilterChip('Any', _selectedPriceRange == 'Any', () {
                      setState(() {
                        _selectedPriceRange = 'Any';
                      });
                    }),
                    _buildFilterChip('₹0-₹500', _selectedPriceRange == '₹0-₹500', () {
                      setState(() {
                        _selectedPriceRange = '₹0-₹500';
                      });
                    }),
                    _buildFilterChip('₹500-₹1000', _selectedPriceRange == '₹500-₹1000', () {
                      setState(() {
                        _selectedPriceRange = '₹500-₹1000';
                      });
                    }),
                    _buildFilterChip('₹1000+', _selectedPriceRange == '₹1000+', () {
                      setState(() {
                        _selectedPriceRange = '₹1000+';
                      });
                    }),
                  ],
                ),
                const SizedBox(height: 20),

                const Text(
                  'Room Type',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 12),
                Wrap(
                  spacing: 10,
                  runSpacing: 10,
                  children: [
                    _buildFilterChip('All', _selectedRoomType == 'All', () {
                      setState(() {
                        _selectedRoomType = 'All';
                      });
                    }),
                    _buildFilterChip('1 BHK', _selectedRoomType == '1 BHK', () {
                      setState(() {
                        _selectedRoomType = '1 BHK';
                      });
                    }),
                    _buildFilterChip('2 BHK', _selectedRoomType == '2 BHK', () {
                      setState(() {
                        _selectedRoomType = '2 BHK';
                      });
                    }),
                    _buildFilterChip('3 BHK', _selectedRoomType == '3 BHK', () {
                      setState(() {
                        _selectedRoomType = '3 BHK';
                      });
                    }),
                    _buildFilterChip('Studio', _selectedRoomType == 'Studio', () {
                      setState(() {
                        _selectedRoomType = 'Studio';
                      });
                    }),
                  ],
                ),
                const SizedBox(height: 20),

                Row(
                  children: [
                    Checkbox(
                      value: _showOnlyAvailable,
                      onChanged: (value) {
                        setState(() {
                          _showOnlyAvailable = value!;
                        });
                      },
                      activeColor: const Color(0xFF5F259F),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6),
                      ),
                    ),
                    const Text(
                      'Show only available properties',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),

                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                      setState(() {});
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF5F259F),
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      elevation: 4,
                    ),
                    child: const Text(
                      'Apply Filters',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildFilterChip(String label, bool isSelected, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFF5F259F) : Colors.grey.shade100,
          borderRadius: BorderRadius.circular(25),
          border: Border.all(
            color: isSelected ? const Color(0xFF5F259F) : Colors.grey.shade300,
            width: 1.5,
          ),
          boxShadow: isSelected ? [
            BoxShadow(
              color: const Color(0xFF5F259F).withOpacity(0.2),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ] : null,
        ),
        child: Text(
          label,
          style: TextStyle(
            color: isSelected ? Colors.white : Colors.grey.shade700,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
            fontSize: 13,
          ),
        ),
      ),
    );
  }
}