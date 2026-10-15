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

class _AccessoriesDashboardScreenState extends State<AccessoriesDashboardScreen> {
  int _currentIndex = 0;

  // ✅ Selected category state
  String _selectedCategory = '';

  // ✅ Switch tab (Home / Category / Orders)
  void _switchTab(int index) {
    if (_currentIndex == index) return;
    setState(() => _currentIndex = index);
  }

  void _switchToCategory(String category) {
    setState(() {
      _selectedCategory = (category == 'More') ? 'All' : category;
      _currentIndex = 1;
    });
  }

  // ══════════ BACK HANDLER ══════════
  // Returns:
  //   true  → pop allowed (app exit)
  //   false → pop blocked (kuch handle kiya)
  bool _handleBack() {
    // 1️⃣ Agar Category tab pe hain
    if (_currentIndex == 1) {
      // Category tab pe back → Home tab pe jao
      setState(() {
        _currentIndex = 0;
        _selectedCategory = '';
      });
      return false; // pop block
    }

    // 2️⃣ Agar Orders tab pe hain
    if (_currentIndex == 2) {
      // Orders tab pe back → Home tab pe jao
      setState(() => _currentIndex = 0);
      return false; // pop block
    }

    // 3️⃣ Home tab pe hain → pop allow (app exit ya previous screen)
    return true;
  }

  @override
  Widget build(BuildContext context) {
    final screens = [
      AccessoriesHomeScreen(
        onSwitchToCategoryTab: _switchToCategory,
      ),
      AccessoriesCategoryScreen(
        selectedCategory: _selectedCategory,
      ),
      const AccessoriesOrderScreen(),
    ];

    final navItems = const [
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

    return PopScope(
      canPop: false, // 👈 manual control
      onPopInvokedWithResult: (didPop, result) {
        if (didPop) return;

        final shouldPop = _handleBack();
        if (shouldPop && context.mounted) {
          Navigator.of(context).pop();
        }
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        body: IndexedStack(
          index: _currentIndex,
          children: screens,
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
              items: navItems,
            ),
          ),
        ),
      ),
    );
  }
}