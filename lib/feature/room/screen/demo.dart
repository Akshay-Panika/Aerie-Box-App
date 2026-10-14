// import 'package:flutter/material.dart';
// import 'package:rent_hub/feature/room/screen/room_details_screen.dart';
//
// class RoomScreen extends StatefulWidget {
//   final String categoryName;
//   const RoomScreen({super.key, required this.categoryName});
//
//   @override
//   State<RoomScreen> createState() => _RoomScreenState();
// }
//
// class _RoomScreenState extends State<RoomScreen> {
//   // Filter states
//   String _selectedFilter = 'All';
//   String _selectedPriceRange = 'Any';
//   String _selectedRoomType = 'All';
//   bool _showOnlyAvailable = false;
//
//   // Random home/room related network images for header
//   final List<String> headerImages = const [
//     'https://images.unsplash.com/photo-1580587771525-78b9dba3b914?w=1200&h=400&fit=crop',
//     'https://images.unsplash.com/photo-1502672260266-1c1ef2d93688?w=1200&h=400&fit=crop',
//     'https://images.unsplash.com/photo-1560448204-e02f11c3d0e2?w=1200&h=400&fit=crop',
//     'https://images.unsplash.com/photo-1586023492125-27b2c045efd7?w=1200&h=400&fit=crop',
//     'https://images.unsplash.com/photo-1560185127-6ed189bf02f4?w=1200&h=400&fit=crop',
//   ];
//
//   // Random home/room related network images for room cards
//   final List<String> roomImages = const [
//     'https://images.unsplash.com/photo-1522708323590-d24dbb6b0267?w=400&h=300&fit=crop',
//     'https://images.unsplash.com/photo-1502672260266-1c1ef2d93688?w=400&h=300&fit=crop',
//     'https://images.unsplash.com/photo-1560448204-e02f11c3d0e2?w=400&h=300&fit=crop',
//     'https://images.unsplash.com/photo-1580587771525-78b9dba3b914?w=400&h=300&fit=crop',
//     'https://images.unsplash.com/photo-1560185008-5a6f9d9d2e6b?w=400&h=300&fit=crop',
//     'https://images.unsplash.com/photo-1560185127-6ed189bf02f4?w=400&h=300&fit=crop',
//     'https://images.unsplash.com/photo-1560448204-603b3fc33ddc?w=400&h=300&fit=crop',
//     'https://images.unsplash.com/photo-1560448204-e02f11c3d0e2?w=400&h=300&fit=crop',
//     'https://images.unsplash.com/photo-1586023492125-27b2c045efd7?w=400&h=300&fit=crop',
//     'https://images.unsplash.com/photo-1560185127-6ed189bf02f4?w=400&h=300&fit=crop',
//   ];
//
//   final List<Map<String, dynamic>> allRooms = const [
//     {
//       'id': '1',
//       'title': 'Cozy Studio Near University',
//       'location': 'Downtown, Near University Gate',
//       'price': '₹500/month',
//       'interest': 2,
//       'reviews': 124,
//       'imageColor': Color(0xFF4F46E5),
//       'bedrooms': 1,
//       'bathrooms': 1,
//       'area': '450 sq ft',
//       'isAvailable': true,
//       'imageIndex': 0,
//       'distance': '0.5 km',
//       'priceValue': 500,
//       'rating': 4.8,
//       'features': ['Wi-Fi', 'AC', 'Parking'],
//     },
//     {
//       'id': '2',
//       'title': 'Premium 2BHK Business Hub',
//       'location': 'City Center, Near Metro',
//       'price': '₹1200/month',
//       'interest': 15,
//       'reviews': 89,
//       'imageColor': Color(0xFF059669),
//       'bedrooms': 2,
//       'bathrooms': 2,
//       'area': '950 sq ft',
//       'isAvailable': true,
//       'imageIndex': 1,
//       'distance': '1.2 km',
//       'priceValue': 1200,
//       'rating': 4.9,
//       'features': ['Wi-Fi', 'AC', 'Gym', 'Pool'],
//     },
//     {
//       'id': '3',
//       'title': 'Daily Rental Near Station',
//       'location': 'Near Railway Station',
//       'price': '₹50/day',
//       'interest': 8,
//       'reviews': 56,
//       'imageColor': Color(0xFFD97706),
//       'bedrooms': 1,
//       'bathrooms': 1,
//       'area': '350 sq ft',
//       'isAvailable': true,
//       'imageIndex': 2,
//       'distance': '2.8 km',
//       'priceValue': 50,
//       'rating': 4.5,
//       'features': ['Wi-Fi', 'TV'],
//     },
//     {
//       'id': '4',
//       'title': 'Artist Loft Creative Space',
//       'location': 'Art District',
//       'price': '₹800/month',
//       'interest': 11,
//       'reviews': 78,
//       'imageColor': Color(0xFFDC2626),
//       'bedrooms': 1,
//       'bathrooms': 1,
//       'area': '600 sq ft',
//       'isAvailable': false,
//       'imageIndex': 3,
//       'distance': '3.2 km',
//       'priceValue': 800,
//       'rating': 4.6,
//       'features': ['Studio', 'Natural Light'],
//     },
//     {
//       'id': '5',
//       'title': 'Family Villa with Garden',
//       'location': 'Green Valley Estate',
//       'price': '₹1800/month',
//       'interest': 25,
//       'reviews': 67,
//       'imageColor': Color(0xFF7C3AED),
//       'bedrooms': 3,
//       'bathrooms': 2,
//       'area': '1500 sq ft',
//       'isAvailable': true,
//       'imageIndex': 4,
//       'distance': '4.5 km',
//       'priceValue': 1800,
//       'rating': 4.7,
//       'features': ['Garden', 'Parking', 'Security'],
//     },
//     {
//       'id': '6',
//       'title': 'Bachelor Pad City View',
//       'location': 'High Street, Near Mall',
//       'price': '₹650/month',
//       'interest': 6,
//       'reviews': 45,
//       'imageColor': Color(0xFF8B5CF6),
//       'bedrooms': 1,
//       'bathrooms': 1,
//       'area': '400 sq ft',
//       'isAvailable': true,
//       'imageIndex': 5,
//       'distance': '1.8 km',
//       'priceValue': 650,
//       'rating': 4.4,
//       'features': ['Wi-Fi', 'City View'],
//     },
//     {
//       'id': '7',
//       'title': 'Modern Studio Apartment',
//       'location': 'Tech Park Area',
//       'price': '₹750/month',
//       'interest': 18,
//       'reviews': 92,
//       'imageColor': Color(0xFFF59E0B),
//       'bedrooms': 1,
//       'bathrooms': 1,
//       'area': '500 sq ft',
//       'isAvailable': true,
//       'imageIndex': 6,
//       'distance': '0.3 km',
//       'priceValue': 750,
//       'rating': 4.8,
//       'features': ['Wi-Fi', 'AC', 'Smart TV'],
//     },
//     {
//       'id': '8',
//       'title': 'Luxury 3BHK Penthouse',
//       'location': 'Skyline Towers',
//       'price': '₹2500/month',
//       'interest': 32,
//       'reviews': 134,
//       'imageColor': Color(0xFF6366F1),
//       'bedrooms': 3,
//       'bathrooms': 3,
//       'area': '1800 sq ft',
//       'isAvailable': true,
//       'imageIndex': 7,
//       'distance': '2.0 km',
//       'priceValue': 2500,
//       'rating': 4.9,
//       'features': ['Pool', 'Gym', 'Security', 'Parking'],
//     },
//   ];
//
//   // Get filtered rooms based on category and filters
//   List<Map<String, dynamic>> get _filteredRooms {
//     List<Map<String, dynamic>> rooms = [];
//
//     // Category filter
//     if (widget.categoryName == 'Students') {
//       rooms = allRooms.where((room) =>
//       room['title'].contains('Studio') ||
//           room['title'].contains('Student') ||
//           room['price'].contains('500') ||
//           room['bedrooms'] == 1
//       ).toList();
//     } else if (widget.categoryName == 'Professionals') {
//       rooms = allRooms.where((room) =>
//       room['title'].contains('Premium') ||
//           room['title'].contains('Business') ||
//           room['price'].contains('1200')
//       ).toList();
//     } else if (widget.categoryName == 'Temporary Stay') {
//       rooms = allRooms.where((room) =>
//       room['title'].contains('Daily') ||
//           room['price'].contains('/day')
//       ).toList();
//     } else if (widget.categoryName == 'Freelancers') {
//       rooms = allRooms.where((room) =>
//       room['title'].contains('Artist') ||
//           room['title'].contains('Loft') ||
//           room['price'].contains('800')
//       ).toList();
//     } else if (widget.categoryName == 'Family') {
//       rooms = allRooms.where((room) =>
//       room['title'].contains('Family') ||
//           room['title'].contains('Villa') ||
//           room['bedrooms'] >= 3
//       ).toList();
//     } else if (widget.categoryName == 'Bachelor') {
//       rooms = allRooms.where((room) =>
//       room['title'].contains('Bachelor') ||
//           room['title'].contains('Pad') ||
//           room['price'].contains('650')
//       ).toList();
//     } else {
//       rooms = allRooms;
//     }
//
//     // Apply filters
//     if (_selectedPriceRange != 'Any') {
//       rooms = rooms.where((room) {
//         final price = room['priceValue'] as int;
//         switch (_selectedPriceRange) {
//           case '₹0-₹500':
//             return price <= 500;
//           case '₹500-₹1000':
//             return price > 500 && price <= 1000;
//           case '₹1000+':
//             return price > 1000;
//           default:
//             return true;
//         }
//       }).toList();
//     }
//
//     if (_selectedRoomType != 'All') {
//       rooms = rooms.where((room) {
//         final bedrooms = room['bedrooms'] as int;
//         switch (_selectedRoomType) {
//           case '1 BHK':
//             return bedrooms == 1;
//           case '2 BHK':
//             return bedrooms == 2;
//           case '3 BHK':
//             return bedrooms >= 3;
//           case 'Studio':
//             return room['title'].contains('Studio');
//           default:
//             return true;
//         }
//       }).toList();
//     }
//
//     if (_showOnlyAvailable) {
//       rooms = rooms.where((room) => room['isAvailable'] == true).toList();
//     }
//
//     switch (_selectedFilter) {
//       case 'Nearby':
//         rooms.sort((a, b) => a['distance'].toString().compareTo(b['distance'].toString()));
//         break;
//       case 'Price: Low':
//         rooms.sort((a, b) => (a['priceValue'] as int).compareTo(b['priceValue'] as int));
//         break;
//       case 'Price: High':
//         rooms.sort((a, b) => (b['priceValue'] as int).compareTo(a['priceValue'] as int));
//         break;
//       case 'Popular':
//         rooms.sort((a, b) => (b['interest'] as int).compareTo(a['interest'] as int));
//         break;
//       default:
//         break;
//     }
//
//     return rooms;
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     const Color primaryColor = Color(0xFF5F259F);
//     const Color primaryLight = Color(0xFF7C3AED);
//
//     final filteredRooms = _filteredRooms;
//     final randomHeaderImage = headerImages[DateTime.now().millisecondsSinceEpoch % headerImages.length];
//
//     return Scaffold(
//       backgroundColor: const Color(0xFFF5F6FA),
//       body: CustomScrollView(
//         slivers: [
//           // Professional Large AppBar
//           SliverAppBar(
//             expandedHeight: 280,
//             floating: false,
//             pinned: true,
//             elevation: 0,
//             backgroundColor: primaryColor,
//             leading: Padding(
//               padding: const EdgeInsets.all(10),
//               child: Container(
//                 decoration: BoxDecoration(
//                   color: Colors.white.withOpacity(0.2),
//                   shape: BoxShape.circle,
//                   border: Border.all(
//                     color: Colors.white.withOpacity(0.3),
//                     width: 1.5,
//                   ),
//                 ),
//                 child: IconButton(
//                   icon: const Icon(Icons.arrow_back_rounded, color: Colors.white, size: 22),
//                   onPressed: () => Navigator.pop(context),
//                   padding: EdgeInsets.zero,
//                 ),
//               ),
//             ),
//             title: Text(
//               widget.categoryName,
//               style: const TextStyle(
//                 color: Colors.white,
//                 fontWeight: FontWeight.w800,
//                 fontSize: 20,
//                 letterSpacing: 0.5,
//                 shadows: [
//                   Shadow(
//                     blurRadius: 10,
//                     color: Colors.black26,
//                     offset: Offset(0, 2),
//                   ),
//                 ],
//               ),
//             ),
//             actions: [
//               Padding(
//                 padding: const EdgeInsets.all(10),
//                 child: Container(
//                   decoration: BoxDecoration(
//                     color: Colors.white.withOpacity(0.2),
//                     shape: BoxShape.circle,
//                     border: Border.all(
//                       color: Colors.white.withOpacity(0.3),
//                       width: 1.5,
//                     ),
//                   ),
//                   child: IconButton(
//                     icon: const Icon(Icons.favorite_border_rounded, color: Colors.white, size: 22),
//                     onPressed: () {},
//                     padding: EdgeInsets.zero,
//                   ),
//                 ),
//               ),
//               Padding(
//                 padding: const EdgeInsets.all(10),
//                 child: Container(
//                   decoration: BoxDecoration(
//                     color: Colors.white.withOpacity(0.2),
//                     shape: BoxShape.circle,
//                     border: Border.all(
//                       color: Colors.white.withOpacity(0.3),
//                       width: 1.5,
//                     ),
//                   ),
//                   child: IconButton(
//                     icon: const Icon(Icons.filter_list_rounded, color: Colors.white, size: 22),
//                     onPressed: () => _showFilterDialog(context),
//                     padding: EdgeInsets.zero,
//                   ),
//                 ),
//               ),
//             ],
//             flexibleSpace: FlexibleSpaceBar(
//               background: Stack(
//                 fit: StackFit.expand,
//                 children: [
//                   Image.network(
//                     randomHeaderImage,
//                     fit: BoxFit.cover,
//                     errorBuilder: (context, error, stackTrace) {
//                       return Container(
//                         decoration: BoxDecoration(
//                           gradient: LinearGradient(
//                             colors: [primaryColor, primaryLight],
//                             begin: Alignment.topLeft,
//                             end: Alignment.bottomRight,
//                           ),
//                         ),
//                       );
//                     },
//                     loadingBuilder: (context, child, loadingProgress) {
//                       if (loadingProgress == null) return child;
//                       return Container(
//                         decoration: BoxDecoration(
//                           gradient: LinearGradient(
//                             colors: [primaryColor, primaryLight],
//                             begin: Alignment.topLeft,
//                             end: Alignment.bottomRight,
//                           ),
//                         ),
//                       );
//                     },
//                   ),
//                   Container(
//                     decoration: BoxDecoration(
//                       gradient: LinearGradient(
//                         begin: Alignment.topCenter,
//                         end: Alignment.bottomCenter,
//                         colors: [
//                           Colors.black.withOpacity(0.1),
//                           Colors.black.withOpacity(0.4),
//                           primaryColor.withOpacity(0.85),
//                         ],
//                       ),
//                     ),
//                   ),
//                   Positioned(
//                     bottom: 10,left: 10,
//                     child: Row(
//                       children: [
//                         Container(
//                           padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
//                           decoration: BoxDecoration(
//                             color: Colors.white.withOpacity(0.2),
//                             borderRadius: BorderRadius.circular(20),
//                             border: Border.all(
//                               color: Colors.white.withOpacity(0.3),
//                             ),
//                           ),
//                           child: Row(
//                             mainAxisSize: MainAxisSize.min,
//                             children: [
//                               Icon(
//                                 Icons.home_rounded,
//                                 size: 14,
//                                 color: Colors.white.withOpacity(0.9),
//                               ),
//                               const SizedBox(width: 6),
//                               Text(
//                                 '${filteredRooms.length} Properties Available',
//                                 style: TextStyle(
//                                   color: Colors.white.withOpacity(0.95),
//                                   fontSize: 13,
//                                   fontWeight: FontWeight.w600,
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                         const SizedBox(width: 10),
//                         Container(
//                           padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
//                           decoration: BoxDecoration(
//                             color: Colors.white.withOpacity(0.2),
//                             borderRadius: BorderRadius.circular(20),
//                             border: Border.all(
//                               color: Colors.white.withOpacity(0.3),
//                             ),
//                           ),
//                           child: Row(
//                             mainAxisSize: MainAxisSize.min,
//                             children: [
//                               Icon(
//                                 Icons.people_rounded,
//                                 size: 14,
//                                 color: Colors.white.withOpacity(0.9),
//                               ),
//                               const SizedBox(width: 6),
//                               Text(
//                                 '${filteredRooms.where((r) => r['isAvailable'] == true).length} Available',
//                                 style: TextStyle(
//                                   color: Colors.white.withOpacity(0.95),
//                                   fontSize: 13,
//                                   fontWeight: FontWeight.w600,
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//
//           // Quick Filter Chips
//           SliverPersistentHeader(
//             pinned: true, // This makes it sticky
//             delegate: _SliverAppBarDelegate(
//               child: Container(
//                 color: Colors.white,
//                 height: 60,
//                 padding: EdgeInsets.all(10),
//                 child: ListView(
//                   scrollDirection: Axis.horizontal,
//                   padding: EdgeInsets.zero,
//                   children: [
//                     _buildQuickFilterChip('All', _selectedFilter == 'All'),
//                     _buildQuickFilterChip('Nearby', _selectedFilter == 'Nearby'),
//                     _buildQuickFilterChip('Price: Low', _selectedFilter == 'Price: Low'),
//                     _buildQuickFilterChip('Price: High', _selectedFilter == 'Price: High'),
//                     _buildQuickFilterChip('Popular', _selectedFilter == 'Popular'),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//
//           // Rooms List - New Premium Card Design
//           SliverPadding(
//             padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 16),
//             sliver: filteredRooms.isEmpty
//                 ? SliverToBoxAdapter(
//               child: _buildEmptyState(),
//             )
//                 : SliverList(
//               delegate: SliverChildBuilderDelegate(
//                     (context, index) {
//                   final room = filteredRooms[index];
//                   return Padding(
//                     padding: const EdgeInsets.only(bottom: 20),
//                     child: _buildPremiumRoomCard(context, room),
//                   );
//                 },
//                 childCount: filteredRooms.length,
//               ),
//             ),
//           ),
//           const SliverPadding(padding: EdgeInsets.only(bottom: 20)),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildQuickFilterChip(String label, bool isSelected) {
//     const Color primaryColor = Color(0xFF5F259F);
//
//     return GestureDetector(
//       onTap: () {
//         setState(() {
//           _selectedFilter = label;
//         });
//       },
//       child: Padding(
//         padding: const EdgeInsets.only(right: 10),
//         child: Container(
//           padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
//           decoration: BoxDecoration(
//             color: isSelected ? primaryColor : Colors.white,
//             borderRadius: BorderRadius.circular(25),
//             border: Border.all(
//               color: isSelected ? primaryColor : Colors.grey.shade300,
//               width: 1.5,
//             ),
//             boxShadow: isSelected ? [
//               BoxShadow(
//                 color: primaryColor.withOpacity(0.3),
//                 blurRadius: 12,
//                 offset: const Offset(0, 4),
//               ),
//             ] : [
//               BoxShadow(
//                 color: Colors.grey.withOpacity(0.08),
//                 blurRadius: 8,
//                 offset: const Offset(0, 2),
//               ),
//             ],
//           ),
//           child: Center(
//             child: Text(
//               label,
//               style: TextStyle(
//                 color: isSelected ? Colors.white : Colors.grey.shade700,
//                 fontWeight: isSelected ? FontWeight.bold : FontWeight.w600,
//                 fontSize: 13,
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
//
//   void _showFilterDialog(BuildContext context) {
//     showModalBottomSheet(
//       context: context,
//       isScrollControlled: true,
//       shape: const RoundedRectangleBorder(
//         borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
//       ),
//       builder: (context) => StatefulBuilder(
//         builder: (context, setState) {
//           return Container(
//             padding: const EdgeInsets.all(24),
//             child: Column(
//               mainAxisSize: MainAxisSize.min,
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     const Text(
//                       'Filter Properties',
//                       style: TextStyle(
//                         fontSize: 24,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                     TextButton(
//                       onPressed: () {
//                         setState(() {
//                           _selectedPriceRange = 'Any';
//                           _selectedRoomType = 'All';
//                           _showOnlyAvailable = false;
//                         });
//                       },
//                       child: const Text(
//                         'Reset All',
//                         style: TextStyle(
//                           color: Color(0xFF5F259F),
//                           fontWeight: FontWeight.w600,
//                           fontSize: 14,
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//                 const SizedBox(height: 24),
//
//                 const Text(
//                   'Price Range',
//                   style: TextStyle(
//                     fontSize: 16,
//                     fontWeight: FontWeight.w600,
//                   ),
//                 ),
//                 const SizedBox(height: 12),
//                 Wrap(
//                   spacing: 10,
//                   runSpacing: 10,
//                   children: [
//                     _buildFilterChip('Any', _selectedPriceRange == 'Any', () {
//                       setState(() {
//                         _selectedPriceRange = 'Any';
//                       });
//                     }),
//                     _buildFilterChip('₹0-₹500', _selectedPriceRange == '₹0-₹500', () {
//                       setState(() {
//                         _selectedPriceRange = '₹0-₹500';
//                       });
//                     }),
//                     _buildFilterChip('₹500-₹1000', _selectedPriceRange == '₹500-₹1000', () {
//                       setState(() {
//                         _selectedPriceRange = '₹500-₹1000';
//                       });
//                     }),
//                     _buildFilterChip('₹1000+', _selectedPriceRange == '₹1000+', () {
//                       setState(() {
//                         _selectedPriceRange = '₹1000+';
//                       });
//                     }),
//                   ],
//                 ),
//                 const SizedBox(height: 20),
//
//                 const Text(
//                   'Room Type',
//                   style: TextStyle(
//                     fontSize: 16,
//                     fontWeight: FontWeight.w600,
//                   ),
//                 ),
//                 const SizedBox(height: 12),
//                 Wrap(
//                   spacing: 10,
//                   runSpacing: 10,
//                   children: [
//                     _buildFilterChip('All', _selectedRoomType == 'All', () {
//                       setState(() {
//                         _selectedRoomType = 'All';
//                       });
//                     }),
//                     _buildFilterChip('1 BHK', _selectedRoomType == '1 BHK', () {
//                       setState(() {
//                         _selectedRoomType = '1 BHK';
//                       });
//                     }),
//                     _buildFilterChip('2 BHK', _selectedRoomType == '2 BHK', () {
//                       setState(() {
//                         _selectedRoomType = '2 BHK';
//                       });
//                     }),
//                     _buildFilterChip('3 BHK', _selectedRoomType == '3 BHK', () {
//                       setState(() {
//                         _selectedRoomType = '3 BHK';
//                       });
//                     }),
//                     _buildFilterChip('Studio', _selectedRoomType == 'Studio', () {
//                       setState(() {
//                         _selectedRoomType = 'Studio';
//                       });
//                     }),
//                   ],
//                 ),
//                 const SizedBox(height: 20),
//
//                 Row(
//                   children: [
//                     Checkbox(
//                       value: _showOnlyAvailable,
//                       onChanged: (value) {
//                         setState(() {
//                           _showOnlyAvailable = value!;
//                         });
//                       },
//                       activeColor: const Color(0xFF5F259F),
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(6),
//                       ),
//                     ),
//                     const Text(
//                       'Show only available properties',
//                       style: TextStyle(
//                         fontSize: 14,
//                         fontWeight: FontWeight.w500,
//                       ),
//                     ),
//                   ],
//                 ),
//                 const SizedBox(height: 24),
//
//                 SizedBox(
//                   width: double.infinity,
//                   child: ElevatedButton(
//                     onPressed: () {
//                       Navigator.pop(context);
//                       setState(() {});
//                     },
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: const Color(0xFF5F259F),
//                       foregroundColor: Colors.white,
//                       padding: const EdgeInsets.symmetric(vertical: 16),
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(16),
//                       ),
//                       elevation: 4,
//                     ),
//                     child: const Text(
//                       'Apply Filters',
//                       style: TextStyle(
//                         fontSize: 16,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                   ),
//                 ),
//                 const SizedBox(height: 10),
//               ],
//             ),
//           );
//         },
//       ),
//     );
//   }
//
//   Widget _buildFilterChip(String label, bool isSelected, VoidCallback onTap) {
//     return GestureDetector(
//       onTap: onTap,
//       child: Container(
//         padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
//         decoration: BoxDecoration(
//           color: isSelected ? const Color(0xFF5F259F) : Colors.grey.shade100,
//           borderRadius: BorderRadius.circular(25),
//           border: Border.all(
//             color: isSelected ? const Color(0xFF5F259F) : Colors.grey.shade300,
//             width: 1.5,
//           ),
//           boxShadow: isSelected ? [
//             BoxShadow(
//               color: const Color(0xFF5F259F).withOpacity(0.2),
//               blurRadius: 8,
//               offset: const Offset(0, 2),
//             ),
//           ] : null,
//         ),
//         child: Text(
//           label,
//           style: TextStyle(
//             color: isSelected ? Colors.white : Colors.grey.shade700,
//             fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
//             fontSize: 13,
//           ),
//         ),
//       ),
//     );
//   }
//
//   Widget _buildEmptyState() {
//     const Color primaryColor = Color(0xFF5F259F);
//
//     return Center(
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Container(
//             padding: const EdgeInsets.all(24),
//             decoration: BoxDecoration(
//               color: primaryColor.withOpacity(0.08),
//               shape: BoxShape.circle,
//             ),
//             child: Icon(
//               Icons.home_rounded,
//               size: 80,
//               color: primaryColor.withOpacity(0.4),
//             ),
//           ),
//           const SizedBox(height: 20),
//           Text(
//             'No Properties Available',
//             style: TextStyle(
//               fontSize: 20,
//               fontWeight: FontWeight.bold,
//               color: Colors.grey.shade700,
//             ),
//           ),
//           const SizedBox(height: 8),
//           Text(
//             'No rooms found for ${widget.categoryName} category',
//             style: TextStyle(
//               fontSize: 14,
//               color: Colors.grey.shade500,
//             ),
//           ),
//           const SizedBox(height: 24),
//           ElevatedButton(
//             onPressed: () => Navigator.pop(context),
//             style: ElevatedButton.styleFrom(
//               backgroundColor: primaryColor,
//               foregroundColor: Colors.white,
//               padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 14),
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(14),
//               ),
//               elevation: 4,
//             ),
//             child: const Text(
//               'Go Back',
//               style: TextStyle(
//                 fontSize: 16,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   // Premium Room Card Design
//   Widget _buildPremiumRoomCard(BuildContext context, Map<String, dynamic> room) {
//     final color = room['imageColor'] as Color;
//     final interest = room['interest'] as int;
//     final reviews = room['reviews'] as int;
//     final isAvailable = room['isAvailable'] as bool;
//     final imageIndex = room['imageIndex'] as int;
//     final distance = room['distance'] as String;
//     final rating = room['rating'] as double? ?? 4.5;
//     final features = room['features'] as List<String>? ?? [];
//
//     return GestureDetector(
//       onTap: () {
//         Navigator.push(context, MaterialPageRoute(builder: (context) => RoomDetailsScreen()));
//       },
//       child: Container(
//         decoration: BoxDecoration(
//           color: Colors.white,
//           borderRadius: BorderRadius.circular(20),
//           boxShadow: [
//             BoxShadow(
//               color: Colors.grey.withOpacity(0.1),
//               blurRadius: 20,
//               offset: const Offset(0, 8),
//               spreadRadius: 2,
//             ),
//           ],
//           border: Border.all(
//             color: isAvailable ? Colors.transparent : Colors.grey.shade200,
//             width: 1,
//           ),
//         ),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             // Image Section
//             Stack(
//               children: [
//                 ClipRRect(
//                   borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
//                   child: Image.network(
//                     roomImages[imageIndex % roomImages.length],
//                     height: 220,
//                     width: double.infinity,
//                     fit: BoxFit.cover,
//                     errorBuilder: (context, error, stackTrace) {
//                       return Container(
//                         height: 220,
//                         width: double.infinity,
//                         decoration: BoxDecoration(
//                           gradient: LinearGradient(
//                             colors: [
//                               color.withOpacity(0.3),
//                               color.withOpacity(0.1),
//                             ],
//                           ),
//                           borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
//                         ),
//                         child: Center(
//                           child:  Icon(
//                             Icons.home_rounded,
//                             size: 60,
//                             color: isAvailable ? const Color(0xFF5F259F) : Colors.grey.shade400,
//                           ),
//                         ),
//                       );
//                     },
//                     loadingBuilder: (context, child, loadingProgress) {
//                       if (loadingProgress == null) return child;
//                       return Container(
//                         height: 220,
//                         width: double.infinity,
//                         decoration: BoxDecoration(
//                           gradient: LinearGradient(
//                             colors: [
//                               color.withOpacity(0.2),
//                               color.withOpacity(0.05),
//                             ],
//                           ),
//                           borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
//                         ),
//                         child: Center(
//                           child: SizedBox(
//                             width: 40,
//                             height: 40,
//                             child: CircularProgressIndicator(
//                               strokeWidth: 3,
//                               color: color,
//                             ),
//                           ),
//                         ),
//                       );
//                     },
//                   ),
//                 ),
//                 // Gradient Overlay
//                 Container(
//                   height: 220,
//                   decoration: BoxDecoration(
//                     gradient: LinearGradient(
//                       begin: Alignment.topCenter,
//                       end: Alignment.bottomCenter,
//                       colors: [
//                         Colors.transparent,
//                         Colors.transparent,
//                         Colors.black.withOpacity(0.2),
//                       ],
//                     ),
//                     borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
//                   ),
//                 ),
//                 // Status Badge
//                 Positioned(
//                   top: 16,
//                   left: 16,
//                   child: Container(
//                     padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
//                     decoration: BoxDecoration(
//                       color: isAvailable ? Colors.green.shade600 : Colors.red.shade600,
//                       borderRadius: BorderRadius.circular(20),
//                       boxShadow: [
//                         BoxShadow(
//                           color: Colors.black.withOpacity(0.2),
//                           blurRadius: 8,
//                           offset: const Offset(0, 2),
//                         ),
//                       ],
//                     ),
//                     child: Row(
//                       mainAxisSize: MainAxisSize.min,
//                       children: [
//                         Icon(
//                           isAvailable ? Icons.check_circle_rounded : Icons.cancel_rounded,
//                           color: Colors.white,
//                           size: 14,
//                         ),
//                         const SizedBox(width: 6),
//                         Text(
//                           isAvailable ? 'Available' : 'Booked',
//                           style: const TextStyle(
//                             color: Colors.white,
//                             fontWeight: FontWeight.bold,
//                             fontSize: 12,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//                 // Favorite Button
//                 Positioned(
//                   top: 16,
//                   right: 16,
//                   child: Container(
//                     decoration: BoxDecoration(
//                       color: Colors.white.withOpacity(0.9),
//                       shape: BoxShape.circle,
//                       boxShadow: [
//                         BoxShadow(
//                           color: Colors.black.withOpacity(0.1),
//                           blurRadius: 8,
//                           offset: const Offset(0, 2),
//                         ),
//                       ],
//                     ),
//                     child: IconButton(
//                       icon: Icon(
//                         Icons.favorite_border_rounded,
//                         color: Colors.grey.shade700,
//                         size: 22,
//                       ),
//                       onPressed: () {},
//                       padding: EdgeInsets.zero,
//                       constraints: const BoxConstraints(
//                         minWidth: 40,
//                         minHeight: 40,
//                       ),
//                     ),
//                   ),
//                 ),
//                 // Rating Badge
//                 Positioned(
//                   bottom: 16,
//                   right: 16,
//                   child: Container(
//                     padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
//                     decoration: BoxDecoration(
//                       color: Colors.black.withOpacity(0.75),
//                       borderRadius: BorderRadius.circular(20),
//                       border: Border.all(
//                         color: Colors.white.withOpacity(0.2),
//                       ),
//                     ),
//                     child: Row(
//                       mainAxisSize: MainAxisSize.min,
//                       children: [
//                         const Icon(
//                           Icons.star_rounded,
//                           color: Colors.amber,
//                           size: 16,
//                         ),
//                         const SizedBox(width: 4),
//                         Text(
//                           rating.toStringAsFixed(1),
//                           style: const TextStyle(
//                             color: Colors.white,
//                             fontWeight: FontWeight.bold,
//                             fontSize: 13,
//                           ),
//                         ),
//                         const SizedBox(width: 4),
//                         Text(
//                           '($reviews)',
//                           style: TextStyle(
//                             color: Colors.white.withOpacity(0.7),
//                             fontSize: 11,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//                 // Distance Badge
//                 Positioned(
//                   bottom: 16,
//                   left: 16,
//                   child: Container(
//                     padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
//                     decoration: BoxDecoration(
//                       color: Colors.black.withOpacity(0.75),
//                       borderRadius: BorderRadius.circular(20),
//                       border: Border.all(
//                         color: Colors.white.withOpacity(0.2),
//                       ),
//                     ),
//                     child: Row(
//                       mainAxisSize: MainAxisSize.min,
//                       children: [
//                         Icon(
//                           Icons.location_on_rounded,
//                           color: Colors.white,
//                           size: 14,
//                         ),
//                         const SizedBox(width: 4),
//                         Text(
//                           distance,
//                           style: const TextStyle(
//                             color: Colors.white,
//                             fontWeight: FontWeight.w600,
//                             fontSize: 12,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//             // Content Section
//             Padding(
//               padding: const EdgeInsets.all(16),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   // Title and Price Row
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Expanded(
//                         child: Text(
//                           room['title'],
//                           style: const TextStyle(
//                             fontSize: 18,
//                             fontWeight: FontWeight.bold,
//                             color: Color(0xFF1E293B),
//                             letterSpacing: -0.2,
//                           ),
//                           maxLines: 1,
//                           overflow: TextOverflow.ellipsis,
//                         ),
//                       ),
//                       Column(
//                         crossAxisAlignment: CrossAxisAlignment.end,
//                         children: [
//                           Text(
//                             room['price'],
//                             style: const TextStyle(
//                               fontSize: 20,
//                               fontWeight: FontWeight.bold,
//                               color: Color(0xFF5F259F),
//                             ),
//                           ),
//                           if (room['price'].contains('/day'))
//                             const Text(
//                               'per day',
//                               style: TextStyle(
//                                 fontSize: 10,
//                                 color: Colors.grey,
//                                 fontWeight: FontWeight.w500,
//                               ),
//                             )
//                           else
//                             const Text(
//                               'per month',
//                               style: TextStyle(
//                                 fontSize: 10,
//                                 color: Colors.grey,
//                                 fontWeight: FontWeight.w500,
//                               ),
//                             ),
//                         ],
//                       ),
//                     ],
//                   ),
//                   const SizedBox(height: 6),
//                   // Location
//                   Row(
//                     children: [
//                       Icon(
//                         Icons.location_on_rounded,
//                         size: 16,
//                         color: Colors.grey.shade500,
//                       ),
//                       const SizedBox(width: 4),
//                       Expanded(
//                         child: Text(
//                           room['location'],
//                           style: TextStyle(
//                             fontSize: 13,
//                             color: Colors.grey.shade600,
//                           ),
//                           maxLines: 1,
//                           overflow: TextOverflow.ellipsis,
//                         ),
//                       ),
//                     ],
//                   ),
//                   const SizedBox(height: 12),
//                   // Features Row
//                   if (features.isNotEmpty) ...[
//                     Row(
//                       children: features.take(4).map((feature) {
//                         return Padding(
//                           padding: const EdgeInsets.only(right: 8),
//                           child: Container(
//                             padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
//                             decoration: BoxDecoration(
//                               color: const Color(0xFF5F259F).withOpacity(0.08),
//                               borderRadius: BorderRadius.circular(12),
//                               border: Border.all(
//                                 color: const Color(0xFF5F259F).withOpacity(0.1),
//                               ),
//                             ),
//                             child: Text(
//                               feature,
//                               style: const TextStyle(
//                                 fontSize: 10,
//                                 color: Color(0xFF5F259F),
//                                 fontWeight: FontWeight.w600,
//                               ),
//                             ),
//                           ),
//                         );
//                       }).toList(),
//                     ),
//                     const SizedBox(height: 12),
//                   ],
//                   // Bottom Row - Details & Interest
//                   Row(
//                     children: [
//                       // Room Details
//                       Container(
//                         padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
//                         decoration: BoxDecoration(
//                           color: Colors.grey.shade100,
//                           borderRadius: BorderRadius.circular(10),
//                         ),
//                         child: Row(
//                           mainAxisSize: MainAxisSize.min,
//                           children: [
//                             Icon(
//                               Icons.bed_rounded,
//                               size: 14,
//                               color: Colors.grey.shade600,
//                             ),
//                             const SizedBox(width: 4),
//                             Text(
//                               '${room['bedrooms']} BHK',
//                               style: TextStyle(
//                                 fontSize: 11,
//                                 color: Colors.grey.shade700,
//                                 fontWeight: FontWeight.w600,
//                               ),
//                             ),
//                             const SizedBox(width: 8),
//                             Icon(
//                               Icons.bathtub_rounded,
//                               size: 14,
//                               color: Colors.grey.shade600,
//                             ),
//                             const SizedBox(width: 4),
//                             Text(
//                               '${room['bathrooms']}',
//                               style: TextStyle(
//                                 fontSize: 11,
//                                 color: Colors.grey.shade700,
//                                 fontWeight: FontWeight.w600,
//                               ),
//                             ),
//                             const SizedBox(width: 8),
//                             Icon(
//                               Icons.square_foot_rounded,
//                               size: 14,
//                               color: Colors.grey.shade600,
//                             ),
//                             const SizedBox(width: 4),
//                             Text(
//                               room['area'].toString().replaceAll(' sq ft', ''),
//                               style: TextStyle(
//                                 fontSize: 11,
//                                 color: Colors.grey.shade700,
//                                 fontWeight: FontWeight.w600,
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                       const Spacer(),
//                       // Interest
//                       Container(
//                         padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
//                         decoration: BoxDecoration(
//                           color: const Color(0xFF5F259F).withOpacity(0.08),
//                           borderRadius: BorderRadius.circular(20),
//                           border: Border.all(
//                             color: const Color(0xFF5F259F).withOpacity(0.15),
//                           ),
//                         ),
//                         child: Row(
//                           mainAxisSize: MainAxisSize.min,
//                           children: [
//                             Icon(
//                               Icons.people_outline_rounded,
//                               size: 14,
//                               color: const Color(0xFF5F259F),
//                             ),
//                             const SizedBox(width: 4),
//                             Text(
//                               '$interest interested',
//                               style: const TextStyle(
//                                 fontSize: 11,
//                                 fontWeight: FontWeight.w600,
//                                 color: Color(0xFF5F259F),
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ],
//                   ),
//                   // View Details Button
//                   const SizedBox(height: 12),
//                   Container(
//                     padding: const EdgeInsets.symmetric(vertical: 6),
//                     decoration: BoxDecoration(
//                       gradient: LinearGradient(
//                         colors: [
//                           const Color(0xFF5F259F).withOpacity(0.05),
//                           const Color(0xFF5F259F).withOpacity(0.1),
//                         ],
//                       ),
//                       borderRadius: BorderRadius.circular(12),
//                     ),
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         const Text(
//                           'View Details',
//                           style: TextStyle(
//                             fontSize: 13,
//                             fontWeight: FontWeight.w600,
//                             color: Color(0xFF5F259F),
//                           ),
//                         ),
//                         const SizedBox(width: 6),
//                         Icon(
//                           Icons.arrow_forward_rounded,
//                           size: 16,
//                           color: const Color(0xFF5F259F),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
//
// class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
//   final Widget child;
//
//   _SliverAppBarDelegate({required this.child});
//
//   @override
//   double get minExtent => 60;
//   @override
//   double get maxExtent => 60;
//
//   @override
//   Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
//     return SizedBox.expand(child: child);
//   }
//
//   @override
//   bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {
//     return false;
//   }
// }