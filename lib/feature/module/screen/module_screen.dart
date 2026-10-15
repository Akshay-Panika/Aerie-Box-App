import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:rent_hub/feature/accessories/home/screen/accessories_home_screen.dart';
import 'package:rent_hub/feature/book/home/screen/book_home_screen.dart';
import 'package:rent_hub/feature/food/home/screen/food_home_screen.dart';
import 'package:rent_hub/feature/travels/screen/travels_screen.dart';

import '../../accessories/dashboard/screen/accessories_dashboard_screen.dart';
import '../../book/dashboard/screen/book_dashboard_screen.dart';
import '../../food/dashboard/screen/food_dashboard_screen.dart';
import '../../room/screen/room_screen.dart';
import '../../special/screen/tech_services_screen.dart';

// ─────────────────────────────────────────────────────────────
// MODULE MODEL — single source of truth for all modules
// ─────────────────────────────────────────────────────────────
class ModuleModel {
  final String id;
  final String title;
  final String subtitle;
  final IconData icon;
  final Color color;
  final String category; // "room" | "special"
  final Widget Function() builder;

  const ModuleModel({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.color,
    required this.category,
    required this.builder,
  });
}

// ─────────────────────────────────────────────────────────────
// CENTRAL DATA STORE — edit here, everything updates
// ─────────────────────────────────────────────────────────────
class ModuleDataStore {
  static const List<ModuleModel> allModules = [
    // ── 8 ROOM MODULES ──
    ModuleModel(
      id: 'room_students',
      title: 'Students',
      subtitle: 'Student Rooms',
      icon: Icons.school_rounded,
      color: Color(0xFF6366F1),
      category: 'room',
      builder: _buildStudentsScreen,
    ),
    ModuleModel(
      id: 'room_professionals',
      title: 'Professionals',
      subtitle: 'Work & Stay',
      icon: Icons.business_center_rounded,
      color: Color(0xFF0EA5E9),
      category: 'room',
      builder: _buildProfessionalsScreen,
    ),
    ModuleModel(
      id: 'room_temporary',
      title: 'Temporary Stay',
      subtitle: 'Short-term',
      icon: Icons.hourglass_top_rounded,
      color: Color(0xFF10B981),
      category: 'room',
      builder: _buildTemporaryScreen,
    ),
    ModuleModel(
      id: 'room_freelancers',
      title: 'Freelancers',
      subtitle: 'Artist & Creators',
      icon: Icons.brush_rounded,
      color: Color(0xFFF43F5E),
      category: 'room',
      builder: _buildFreelancersScreen,
    ),
    ModuleModel(
      id: 'room_family',
      title: 'Family',
      subtitle: 'Family Stays',
      icon: Icons.family_restroom_rounded,
      color: Color(0xFF7986CB),
      category: 'room',
      builder: _buildFamilyScreen,
    ),
    ModuleModel(
      id: 'room_bachelor',
      title: 'Bachelor',
      subtitle: 'Bachelor Rooms',
      icon: Icons.person_outline_rounded,
      color: Color(0xFF8B5CF6),
      category: 'room',
      builder: _buildBachelorScreen,
    ),
    ModuleModel(
      id: 'room_pg_hostel',
      title: 'PG & Hostel',
      subtitle: 'PG / Hostel',
      icon: Icons.person_2_outlined,
      color: Color(0xFF8B5CF6),
      category: 'room',
      builder: _buildPgHostelScreen,
    ),
    ModuleModel(
      id: 'room_all',
      title: 'All Rooms',
      subtitle: 'Browse all',
      icon: Icons.dashboard_outlined,
      color: Color(0xFF5F259F),
      category: 'room',
      builder: _buildAllRoomsScreen,
    ),

    // ── 4 SPECIAL MODULES ──
    ModuleModel(
      id: 'special_food',
      title: 'Food',
      subtitle: 'Order meals & groceries',
      icon: Icons.restaurant_rounded,
      color: Color(0xFFE65100),
      category: 'special',
      builder: _buildFoodScreen,
    ),
    ModuleModel(
      id: 'special_travels',
      title: 'Travels',
      subtitle: 'Book cabs & trips',
      icon: Icons.directions_car_outlined,
      color: Color(0xFF0EA5E9),
      category: 'special',
      builder: _buildTravelsScreen,
    ),
    ModuleModel(
      id: 'special_books',
      title: 'Books',
      subtitle: 'Rent & buy books',
      icon: Icons.menu_book_rounded,
      color: Color(0xFF10B981),
      category: 'special',
      builder: _buildBookScreen,
    ),
    ModuleModel(
      id: 'special_accessories',
      title: 'Accessories',
      subtitle: 'Professional services',
      icon: Icons.work_outline_rounded,
      color: Color(0xFFF43F5E),
      category: 'special',
      builder: _buildAccessoriesScreen,
    ),
  ];

  // Helper getters (split by category)
  static List<ModuleModel> get roomModules =>
      allModules.where((m) => m.category == 'room').toList();

  static List<ModuleModel> get specialModules =>
      allModules.where((m) => m.category == 'special').toList();
}

// Static builder functions (needed because const list can't use closures)
Widget _buildStudentsScreen() =>
    const RoomScreen(categoryName: "Students");
Widget _buildProfessionalsScreen() =>
    const RoomScreen(categoryName: "Professionals");
Widget _buildTemporaryScreen() =>
    const RoomScreen(categoryName: "Temporary Stay");
Widget _buildFreelancersScreen() =>
    const RoomScreen(categoryName: "Freelancers");
Widget _buildFamilyScreen() =>
    const RoomScreen(categoryName: "Family");
Widget _buildBachelorScreen() =>
    const RoomScreen(categoryName: "Bachelor");
Widget _buildPgHostelScreen() =>
    const RoomScreen(categoryName: "PG & Hostel");
Widget _buildAllRoomsScreen() =>
    const RoomScreen(categoryName: "All");
Widget _buildFoodScreen() => const FoodDashboardScreen();
Widget _buildTravelsScreen() => const TravelsScreen();
Widget _buildBookScreen() => const BookDashboardScreen();
Widget _buildAccessoriesScreen() => const AccessoriesDashboardScreen();

// ─────────────────────────────────────────────────────────────
// SCREEN
// ─────────────────────────────────────────────────────────────
class ModuleScreen extends StatefulWidget {
  const ModuleScreen({super.key});

  @override
  State<ModuleScreen> createState() => _ModuleScreenState();
}

class _ModuleScreenState extends State<ModuleScreen> {
  double _currentSheetSize = 0.65;
  int _currentBannerIndex = 0;

  @override
  Widget build(BuildContext context) {
    const Color rentPurple = Color(0xFF5F259F);
    const Color primaryColor = Color(0xFF5F259F);
    const Color primaryLight = Color(0xFF7C3AED);

    final double dynamicRadius = _currentSheetSize >= 0.98 ? 0.0 : 32.0;

    // Pull data from central store
    final List<ModuleModel> categories = ModuleDataStore.roomModules;
    final List<ModuleModel> specialCategories = ModuleDataStore.specialModules;

    final List<Map<String, String>> bannerItems = [
      {
        'tag': '🏠 FIND YOUR DREAM ROOM',
        'title':
        'Thousands of Verified Rooms\nAvailable for Students & Professionals',
        'action': 'Explore Now',
      },
      {
        'tag': '💰 BEST DEALS',
        'title': 'Get Amazing Discounts on\nLong Term & Short Term Stays',
        'action': 'View Offers',
      },
      {
        'tag': '🤝 ROOMMATE FINDER',
        'title': 'Find Trusted Roommates\nSave Money & Share Rent',
        'action': 'Find Now',
      },
    ];

    return Column(
      children: [
        // ── HEADER ──
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [primaryColor, primaryLight],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            boxShadow: [
              BoxShadow(
                color: primaryColor.withOpacity(0.3),
                blurRadius: 15,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: SafeArea(
            child: Row(
              children: [
                Stack(
                  children: [
                    Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: const Color(0xFFF1F5F9),
                        border: Border.all(color: rentPurple, width: 1.5),
                      ),
                      child: const Center(
                        child: Icon(
                          Icons.person_rounded,
                          color: rentPurple,
                          size: 22,
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: Container(
                        padding: const EdgeInsets.all(2),
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.verified,
                          size: 8,
                          color: Colors.green,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(width: 12),
                const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'AB User',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      'Jabalpur, MP',
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
                const Spacer(),
                IconButton(
                  icon: const Icon(
                    Icons.shopping_cart,
                    color: Colors.white,
                    size: 26,
                  ),
                  onPressed: () {},
                ),
                IconButton(
                  icon: const Icon(
                    Icons.notifications_active,
                    color: Colors.white,
                    size: 26,
                  ),
                  onPressed: () {},
                ),
              ],
            ),
          ),
        ),

        // ── BODY ──
        Expanded(
          child: NotificationListener<DraggableScrollableNotification>(
            onNotification: (DraggableScrollableNotification notification) {
              setState(() {
                _currentSheetSize = notification.extent;
              });
              return true;
            },
            child: LayoutBuilder(
              builder: (context, constraints) {
                final double remainingHeight = constraints.maxHeight;
                final double backgroundBannerHeight =
                    remainingHeight * (1.0 - 0.65);

                return Stack(
                  children: [
                    // Background + Banner
                    Positioned(
                      top: 0,
                      left: 0,
                      right: 0,
                      height: backgroundBannerHeight + 10,
                      child: Container(
                        color: const Color(0xFFF5F7FA),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: backgroundBannerHeight - 20,
                              child: CarouselSlider(
                                items: bannerItems.map((item) {
                                  return Container(
                                    width: double.infinity,
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 24,
                                      vertical: 12,
                                    ),
                                    child: Row(
                                      children: [
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                            MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                item['tag']!,
                                                style: const TextStyle(
                                                  color: rentPurple,
                                                  fontSize: 11,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              const SizedBox(height: 4),
                                              Text(
                                                item['title']!,
                                                style: const TextStyle(
                                                  color: Color(0xFF1E293B),
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.bold,
                                                  height: 1.3,
                                                ),
                                                maxLines: 2,
                                              ),
                                              const SizedBox(height: 8),
                                              Container(
                                                padding:
                                                const EdgeInsets.symmetric(
                                                  horizontal: 12,
                                                  vertical: 6,
                                                ),
                                                decoration: BoxDecoration(
                                                  color: rentPurple,
                                                  borderRadius:
                                                  BorderRadius.circular(8),
                                                ),
                                                child: Text(
                                                  item['action']!,
                                                  style: const TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 10,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        const SizedBox(width: 12),
                                        Container(
                                          padding: const EdgeInsets.all(12),
                                          decoration: BoxDecoration(
                                            color: rentPurple.withOpacity(0.1),
                                            borderRadius:
                                            BorderRadius.circular(12),
                                          ),
                                          child: const Icon(
                                            Icons.home_work_rounded,
                                            size: 40,
                                            color: rentPurple,
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                }).toList(),
                                options: CarouselOptions(
                                  height: backgroundBannerHeight - 20,
                                  viewportFraction: 1.0,
                                  autoPlay: true,
                                  autoPlayInterval: const Duration(seconds: 4),
                                  autoPlayCurve: Curves.fastOutSlowIn,
                                  onPageChanged: (index, reason) {
                                    setState(() {
                                      _currentBannerIndex = index;
                                    });
                                  },
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(right: 10.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: List.generate(bannerItems.length, (
                                    index,
                                    ) {
                                  bool isActive = _currentBannerIndex == index;
                                  return AnimatedContainer(
                                    duration: const Duration(milliseconds: 300),
                                    margin: const EdgeInsets.symmetric(
                                      horizontal: 4,
                                    ),
                                    width: isActive ? 18 : 6,
                                    height: 4,
                                    decoration: BoxDecoration(
                                      color: isActive
                                          ? rentPurple
                                          : Colors.grey.withOpacity(0.4),
                                      borderRadius: BorderRadius.circular(2),
                                    ),
                                  );
                                }),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    // Draggable Sheet
                    DraggableScrollableSheet(
                      initialChildSize: 0.65,
                      minChildSize: 0.65,
                      maxChildSize: 1.0,
                      builder:
                          (BuildContext context, ScrollController scrollController) {
                        return AnimatedContainer(
                          duration: const Duration(milliseconds: 100),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(dynamicRadius),
                              topRight: Radius.circular(dynamicRadius),
                            ),
                            boxShadow: [
                              if (_currentSheetSize < 0.98)
                                const BoxShadow(
                                  color: Color(0x12000000),
                                  blurRadius: 16,
                                  offset: Offset(0, -4),
                                ),
                            ],
                          ),
                          child: ListView(
                            controller: scrollController,
                            physics: const ClampingScrollPhysics(),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 12,
                            ),
                            children: [
                              if (_currentSheetSize < 0.98)
                                Center(
                                  child: Container(
                                    width: 44,
                                    height: 5,
                                    margin: const EdgeInsets.all(20),
                                    decoration: BoxDecoration(
                                      color: const Color(0xFFCBD5E1),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                ),

                              const Text(
                                '🏠 Find Your Perfect Stay',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700,
                                  color: Color(0xFF1E293B),
                                ),
                              ),
                              const Text(
                                'Choose from a variety of room categories for your needs',
                                style: TextStyle(
                                  fontSize: 13,
                                  color: Color(0xFF64748B),
                                ),
                              ),
                              const SizedBox(height: 16),

                              // Room categories grid (now 8 items, 4x2)
                              _buildModuleGrid(categories),

                              const SizedBox(height: 14),
                              const Divider(
                                color: Color(0xFFF1F5F9),
                                thickness: 2,
                              ),
                              const SizedBox(height: 14),

                              const Text(
                                '✨ Special Offers & Deals',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700,
                                  color: Color(0xFF1E293B),
                                ),
                              ),
                              const Text(
                                'Exclusive discounts and offers for our valued customers',
                                style: TextStyle(
                                  fontSize: 13,
                                  color: Color(0xFF64748B),
                                ),
                              ),
                              const SizedBox(height: 16),

                              // Special modules grid
                              _buildModuleGrid(specialCategories),
                              const SizedBox(height: 20),

                              Container(
                                height: 300,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(14),
                                  border: Border.all(color: Colors.grey.shade200, width: 1.2),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.04),
                                      blurRadius: 6,
                                      offset: const Offset(0, 3),
                                    ),
                                  ],
                                  image: const DecorationImage(
                                    image: AssetImage('assets/image/aerie-banner.png'),
                                    fit: BoxFit.fill,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 20),
                            ],
                          ),
                        );
                      },
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ],
    );
  }

  // ── Reusable grid builder for both sections ──
  Widget _buildModuleGrid(List<ModuleModel> modules) {
    return GridView.builder(
      shrinkWrap: true,
      padding: EdgeInsets.zero,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4,
        childAspectRatio: 1,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
      ),
      itemCount: modules.length,
      itemBuilder: (context, index) {
        return _buildModuleCard(modules[index]);
      },
    );
  }

  // ── Module card ──
  Widget _buildModuleCard(ModuleModel module) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => module.builder()),
        );
      },
      child: Container(
        padding: const EdgeInsets.all(4),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: Colors.grey.shade200, width: 1.2),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.04),
              blurRadius: 6,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(module.icon, color: module.color, size: 26),
            const SizedBox(height: 10),
            Flexible(
              child: Text(
                module.title,
                style: const TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 9,
                  color: Color(0xFF1E293B),
                ),
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }
}