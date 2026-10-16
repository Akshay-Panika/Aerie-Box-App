import 'package:flutter/material.dart';
import '../../../../core/utils/app_color.dart';
import '../../account/screen/account_screen.dart';
import '../../ads/screen/room_ads_screen.dart';
import '../../favorite/screen/room_favorite_screen.dart';
import '../../module/screen/room_module_screen.dart';


class RoomDashboardScreen extends StatefulWidget {
  const RoomDashboardScreen({super.key});

  @override
  State<RoomDashboardScreen> createState() => _RoomDashboardScreenState();
}

class _RoomDashboardScreenState extends State<RoomDashboardScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  int _selectedIndex = 0;
  int? _lastSelectedIndex;

  late final List<Widget> _screens;

  @override
  void initState() {
    super.initState();
    _screens = [
      RoomModuleScreen(
        onAccountTap: () => _onItemTapped(3),
      ),
      const RoomFavoriteScreen(),
      const RoomAdsScreen(),
      const AccountScreen(),
    ];
  }


  final List<NavItemData> _navItems = const [
    NavItemData(
      icon: Icons.home_outlined,
      activeIcon: Icons.home_rounded,
      label: 'Home',
    ),
    NavItemData(
      icon: Icons.favorite_border,
      activeIcon: Icons.favorite,
      label: 'Favorite',
    ),
    NavItemData(
      icon: Icons.post_add_outlined,
      activeIcon: Icons.post_add_rounded,
      label: 'My Ads',
    ),
    NavItemData(
      icon: Icons.person_outline_rounded,
      activeIcon: Icons.person_rounded,
      label: 'Account',
    ),
  ];

  void _onItemTapped(int index) {
    if (_selectedIndex == index) return;
    setState(() {
      _lastSelectedIndex = _selectedIndex;
      _selectedIndex = index;
    });
  }

  Future<void> _handleBack() async {
    if (_selectedIndex != 0) {
      setState(() => _selectedIndex = 0);
      return;
    }
    _showExitBottomSheet();
  }

  void _showExitBottomSheet() {
    _scaffoldKey.currentState?.showBottomSheet(
          (context) => Container(
        padding: const EdgeInsets.all(16),
        margin: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.all(Radius.circular(15)),
          border: Border.symmetric(
            horizontal:  BorderSide(color: AppColor.primary),
            vertical: const BorderSide(color: AppColor.primary),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Row(
              children: [
                Icon(Icons.exit_to_app, color: Colors.red, size: 20),
                SizedBox(width: 6),
                Text(
                  'Exit App?',
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
                ),
              ],
            ),
            const SizedBox(height: 6),
            const Text(
              'Do you really want to close the app?',
              style: TextStyle(fontSize: 13, color: Colors.black54),
            ),
            const SizedBox(height: 14),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: const Text(
                      'Cancel',
                      style: TextStyle(color: Colors.red),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColor.primary,
                    ),
                    onPressed: () => Navigator.of(context).pop(),
                    child: const Text(
                      'Exit',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      backgroundColor: Colors.transparent,
      elevation: 0,
    );
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) async {
        if (didPop) return;
        await _handleBack();
      },
      child: Scaffold(
        key: _scaffoldKey,
        body: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            IndexedStack(
              index: _selectedIndex,
              children: _screens,
            ),
            NotchNavBar(
              items: _navItems,
              selectedIndex: _selectedIndex,
              onTap: _onItemTapped,
              primaryColor: AppColor.primary,
            )
          ],
        ),
      ),
    );
  }
}

class NotchNavBar extends StatelessWidget {
  final List<NavItemData> items;
  final int selectedIndex;
  final ValueChanged<int> onTap;
  final Color primaryColor;

  const NotchNavBar({
    super.key,
    required this.items,
    required this.selectedIndex,
    required this.onTap,
    required this.primaryColor,
  });

  static const double barHeight = 68;
  static const double circleSize = 52;
  static const double circleLift = 18;

  @override
  Widget build(BuildContext context) {
    final bottomPadding = MediaQuery.of(context).padding.bottom;

    return SizedBox(
      height: barHeight + bottomPadding + circleLift,
      child: Stack(
        clipBehavior: Clip.none,
        alignment: Alignment.bottomCenter,
        children: [
          // ── Simple white rounded bar (notch removed) ──
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              height: barHeight + bottomPadding,
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.06),
                    blurRadius: 10,
                    offset: const Offset(0, -2),
                  ),
                ],
              ),
            ),
          ),

          // ── Nav items + floating circle ──
          Positioned(
            bottom: bottomPadding,
            left: 0,
            right: 0,
            height: barHeight,
            child: LayoutBuilder(
              builder: (context, constraints) {
                final itemWidth = constraints.maxWidth / items.length;
                final centerX = (selectedIndex * itemWidth) + (itemWidth / 2);

                return Stack(
                  clipBehavior: Clip.none,
                  alignment: Alignment.bottomCenter,
                  children: [
                    // Floating circle
                    AnimatedPositioned(
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeInOut,
                      top: -circleLift,
                      left: centerX - (circleSize / 2),
                      child: Container(
                        width: circleSize,
                        height: circleSize,
                        decoration: BoxDecoration(
                          color: primaryColor,
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: primaryColor.withOpacity(0.28),
                              blurRadius: 14,
                              offset: const Offset(0, 6),
                            ),
                          ],
                        ),
                        child: Center(
                          child: AnimatedSwitcher(
                            duration: const Duration(milliseconds: 200),
                            transitionBuilder: (child, animation) =>
                                FadeTransition(
                                  opacity: animation,
                                  child: child,
                                ),
                            child: Icon(
                              items[selectedIndex].activeIcon,
                              key: ValueKey(selectedIndex),
                              color: Colors.white,
                              size: 24,
                            ),
                          ),
                        ),
                      ),
                    ),

                    // Nav items row
                    Row(
                      children: List.generate(items.length, (index) {
                        return Expanded(
                          child: _NavBarItem(
                            item: items[index],
                            isSelected: selectedIndex == index,
                            onTap: () => onTap(index),
                            primaryColor: primaryColor,
                          ),
                        );
                      }),
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _NavBarItem extends StatelessWidget {
  final NavItemData item;
  final bool isSelected;
  final VoidCallback onTap;
  final Color primaryColor;

  const _NavBarItem({
    required this.item,
    required this.isSelected,
    required this.onTap,
    required this.primaryColor,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onTap,
      child: SizedBox(
        height: NotchNavBar.barHeight,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            SizedBox(
              height: 26,
              child: isSelected
                  ? const SizedBox.shrink()
                  : Icon(
                item.icon,
                color: primaryColor.withOpacity(0.85),
                size: 26,
              ),
            ),
            const SizedBox(height: 4),
            AnimatedDefaultTextStyle(
              duration: const Duration(milliseconds: 200),
              style: TextStyle(
                color: isSelected ? primaryColor : Colors.grey.shade600,
                fontSize: 11,
                fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                letterSpacing: 0.6,
              ),
              child: Text(item.label.toUpperCase()),
            ),
          ],
        ),
      ),
    );
  }
}

// ══════════════════════════════════════════════
// NAV ITEM DATA MODEL
// ══════════════════════════════════════════════
class NavItemData {
  final IconData icon;
  final IconData activeIcon;
  final String label;

  const NavItemData({
    required this.icon,
    required this.activeIcon,
    required this.label,
  });
}