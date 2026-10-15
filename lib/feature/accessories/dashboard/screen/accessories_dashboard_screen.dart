import 'package:flutter/material.dart';

import '../../category/accesories_category_screen.dart';
import '../../home/screen/accessories_home_screen.dart';
import '../../order/screen/accessories_order_screen.dart';

class AccessoriesDashboardScreen extends StatefulWidget {
  const AccessoriesDashboardScreen({super.key});

  @override
  State<AccessoriesDashboardScreen> createState() =>
      _AccessoriesDashboardScreenState();
}

class _AccessoriesDashboardScreenState
    extends State<AccessoriesDashboardScreen> {
  int _currentIndex = 0;

  // ✅ Selected category for Category screen
  String _selectedCategory = 'All';

  void _switchTab(int index) {
    if (_currentIndex == index) return;
    setState(() => _currentIndex = index);
  }

  // ✅ Home se category tap → switch to Category tab + set category
  void _openCategory(String category) {
    setState(() {
      _selectedCategory = category;
      _currentIndex = 1;
    });
  }

  late final List<Widget> _screens = [
    AccessoriesHomeScreen(
      onSwitchToCategoryTab: _openCategory,
    ),
    AccessoriesCategoryScreen(
      key: ValueKey(_selectedCategory),    // 👈 force rebuild when category changes
      initialCategory: _selectedCategory,  // 👈 pass pre-selected category
    ),
    const AccessoriesOrderScreen(),
  ];

  final List<BottomNavigationBarItem> _navItems = const [
    BottomNavigationBarItem(
      icon: Icon(Icons.home_outlined),
      activeIcon: Icon(Icons.home_rounded),
      label: 'Home',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.category_outlined),
      activeIcon: Icon(Icons.category),
      label: 'Category',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.receipt_long_outlined),
      activeIcon: Icon(Icons.receipt_long_rounded),
      label: 'Orders',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: IndexedStack(
        index: _currentIndex,
        children: _screens,
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.06),
              blurRadius: 12,
              offset: const Offset(0, -3),
            ),
          ],
        ),
        child: SafeArea(
          top: false,
          child: BottomNavigationBar(
            currentIndex: _currentIndex,
            onTap: (index) => setState(() => _currentIndex = index),
            type: BottomNavigationBarType.fixed,
            backgroundColor: Colors.white,
            selectedItemColor: Colors.purple[700],
            unselectedItemColor: Colors.grey.shade500,
            selectedLabelStyle: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 11,
            ),
            unselectedLabelStyle: const TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 11,
            ),
            elevation: 0,
            items: _navItems,
          ),
        ),
      ),
    );
  }
}