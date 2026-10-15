import 'package:flutter/material.dart';
import '../../home/screen/food_home_screen.dart';
import '../../order/screen/food_order_screen.dart';

class FoodDashboardScreen extends StatefulWidget {
  const FoodDashboardScreen({super.key});

  @override
  State<FoodDashboardScreen> createState() => _FoodDashboardScreenState();
}

class _FoodDashboardScreenState extends State<FoodDashboardScreen> {
  int _currentIndex = 0;

  // ══════════ BACK HANDLER ══════════
  // true  → pop allowed (app exit)
  // false → pop blocked (kuch handle kiya)
  bool _handleBack() {
    // 1️⃣ Orders tab → Home tab pe jao
    if (_currentIndex == 1) {
      setState(() => _currentIndex = 0);
      return false; // pop block
    }

    // 2️⃣ Home tab → pop allow (app exit)
    return true;
  }

  @override
  Widget build(BuildContext context) {
    // 🔹 Screens (index order must match nav items)
    final screens = const [
      FoodHomeScreen(),
      FoodOrderScreen(),
    ];

    final navItems = const [
      BottomNavigationBarItem(
        icon: Icon(Icons.home_outlined),
        activeIcon: Icon(Icons.home_rounded),
        label: 'Home',
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
        backgroundColor: const Color(0xFFF8F9FA),
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
              selectedItemColor: Colors.orange[700],
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