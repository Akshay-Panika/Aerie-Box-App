import 'package:flutter/material.dart';

import '../../../accessories/dashboard/screen/accessories_dashboard_screen.dart';
import '../../../book/dashboard/screen/book_dashboard_screen.dart';
import '../../../food/dashboard/screen/food_dashboard_screen.dart';
import '../../../travels/screen/travels_screen.dart';

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

class ModuleDataStore {
  static const List<ModuleModel> allModules = [
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

Widget _buildFoodScreen() => const FoodDashboardScreen();
Widget _buildTravelsScreen() => const TravelsScreen();
Widget _buildBookScreen() => const BookDashboardScreen();
Widget _buildAccessoriesScreen() => const AccessoriesDashboardScreen();


class SpecialCategoryWidget extends StatefulWidget {
  const SpecialCategoryWidget({super.key});

  @override
  State<SpecialCategoryWidget> createState() => _SpecialCategoryWidgetState();
}

class _SpecialCategoryWidgetState extends State<SpecialCategoryWidget> {

  final List<ModuleModel> specialCategories = ModuleDataStore.specialModules;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
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
        _buildModuleGrid(specialCategories),
      ],
    );
  }

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




