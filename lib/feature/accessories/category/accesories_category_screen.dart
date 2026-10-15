import 'package:flutter/material.dart';

import '../home/screen/accessories_home_screen.dart';

class AccessoriesCategoryScreen extends StatefulWidget {
  final String initialCategory;   // 👈 NEW

  const AccessoriesCategoryScreen({
    super.key,
    this.initialCategory = 'All',   // 👈 NEW — default 'All'
  });

  @override
  State<AccessoriesCategoryScreen> createState() =>
      _AccessoriesCategoryScreenState();
}

class _AccessoriesCategoryScreenState extends State<AccessoriesCategoryScreen> {
  bool isGridView = true;
  String searchQuery = '';
  int _selectedCategoryIndex = 0;

  final List<CategoryTab> categoryTabs = [
    CategoryTab(name: 'All', icon: Icons.apps_rounded, color: Colors.purple),
    CategoryTab(name: 'Wearables', icon: Icons.watch_rounded, color: Colors.indigo),
    CategoryTab(name: 'Audio', icon: Icons.headphones_rounded, color: Colors.deepOrange),
    CategoryTab(name: 'Chargers', icon: Icons.battery_charging_full_rounded, color: Colors.green),
    CategoryTab(name: 'Photography', icon: Icons.camera_alt_rounded, color: Colors.teal),
    CategoryTab(name: 'Laptop', icon: Icons.laptop_rounded, color: Colors.blue),
    CategoryTab(name: 'Phone', icon: Icons.phone_android_rounded, color: Colors.pink),
  ];

  @override
  void initState() {
    super.initState();
    // ✅ Set initial category from widget param
    final idx = categoryTabs.indexWhere(
          (t) => t.name == widget.initialCategory,
    );
    if (idx != -1) _selectedCategoryIndex = idx;
  }

  // ── Filter helpers ──
  List<Accessory> _getFilteredAccessories(String category, String query) {
    final all = Accessory.getSampleAccessories();
    var list = category == 'All'
        ? all
        : all.where((a) => a.category == category).toList();

    if (query.isNotEmpty) {
      final q = query.toLowerCase();
      list = list.where((a) =>
      a.title.toLowerCase().contains(q) ||
          a.brand.toLowerCase().contains(q)).toList();
    }
    return list;
  }

  @override
  Widget build(BuildContext context) {
    final currentCategory = categoryTabs[_selectedCategoryIndex].name;
    final items = _getFilteredAccessories(currentCategory, searchQuery);
    final isAllCategory = _selectedCategoryIndex == 0;

    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FE),
      body: Column(
        children: [
          _buildHeader(),
          _buildSearchBar(),
          Expanded(
            child: isAllCategory
                ? _buildContent(items, currentCategory)
                : Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildSidebar(),
                Expanded(child: _buildContent(items, currentCategory)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ══════════ HEADER ══════════
  Widget _buildHeader() {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
      child: SafeArea(
        bottom: false,
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Categories',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  Text(
                    'Browse accessories',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
            ),
            // view toggle
            Container(
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(10),
              ),
              child: IconButton(
                icon: Icon(
                  isGridView ? Icons.list_rounded : Icons.grid_view_rounded,
                  color: Colors.black87,
                  size: 22,
                ),
                onPressed: () => setState(() => isGridView = !isGridView),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ══════════ SEARCH ══════════
  Widget _buildSearchBar() {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.fromLTRB(12, 0, 12, 12),
      child: TextField(
        onChanged: (v) => setState(() => searchQuery = v),
        decoration: InputDecoration(
          hintText: 'Search by title or brand...',
          hintStyle: TextStyle(color: Colors.grey[500], fontSize: 14),
          prefixIcon: const Icon(Icons.search, color: Colors.grey, size: 22),
          suffixIcon: searchQuery.isNotEmpty
              ? IconButton(
            icon: const Icon(Icons.clear, size: 20, color: Colors.grey),
            onPressed: () => setState(() => searchQuery = ''),
          )
              : null,
          filled: true,
          fillColor: const Color(0xFFF5F3FF),
          contentPadding: const EdgeInsets.symmetric(vertical: 12),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }

  // ══════════ SIDEBAR ══════════
  Widget _buildSidebar() {
    return Container(
      width: 100,
      color: Colors.grey[100],
      child: ListView.builder(
        padding: const EdgeInsets.symmetric(vertical: 8),
        itemCount: categoryTabs.length,
        itemBuilder: (context, index) {
          final tab = categoryTabs[index];
          final isSelected = _selectedCategoryIndex == index;
          final count = tab.name == 'All'
              ? Accessory.getSampleAccessories().length
              : _getFilteredAccessories(tab.name, '').length;

          return GestureDetector(
            onTap: () => setState(() => _selectedCategoryIndex = index),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 180),
              margin: const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 6),
              decoration: BoxDecoration(
                color: isSelected ? Colors.white : Colors.transparent,
                borderRadius: BorderRadius.circular(12),
                border: isSelected
                    ? Border(left: BorderSide(color: tab.color, width: 4))
                    : null,
                boxShadow: isSelected
                    ? [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ]
                    : null,
              ),
              child: Column(
                children: [
                  Icon(
                    tab.icon,
                    size: 22,
                    color: isSelected ? tab.color : Colors.grey[600],
                  ),
                  const SizedBox(height: 6),
                  Text(
                    tab.name,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 10.5,
                      fontWeight:
                      isSelected ? FontWeight.w700 : FontWeight.w500,
                      color:
                      isSelected ? Colors.black87 : Colors.grey[700],
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  if (tab.name != 'All') ...[
                    const SizedBox(height: 4),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 6,
                        vertical: 1,
                      ),
                      decoration: BoxDecoration(
                        color: isSelected
                            ? tab.color.withOpacity(0.15)
                            : Colors.grey[200],
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        '$count',
                        style: TextStyle(
                          fontSize: 9,
                          color: isSelected ? tab.color : Colors.grey[600],
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ],
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  // ══════════ CONTENT ══════════
  Widget _buildContent(List<Accessory> items, String categoryName) {
    if (items.isEmpty) return _buildEmptyState();

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(12, 12, 12, 4),
          child: Row(
            children: [
              Text(
                categoryName,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(width: 6),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 8,
                  vertical: 2,
                ),
                decoration: BoxDecoration(
                  color: Colors.purple[50],
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  '${items.length}',
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    color: Colors.purple[700],
                  ),
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: isGridView ? _buildGrid(items) : _buildList(items),
        ),
      ],
    );
  }

  Widget _buildGrid(List<Accessory> items) {
    return GridView.builder(
      padding: const EdgeInsets.fromLTRB(10, 8, 10, 20),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.56,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
      itemCount: items.length,
      itemBuilder: (_, i) => AccessoryCard(
        accessory: items[i],
        onTap: () => _showDetails(items[i]),
      ),
    );
  }

  Widget _buildList(List<Accessory> items) {
    return ListView.builder(
      padding: const EdgeInsets.fromLTRB(10, 8, 10, 20),
      itemCount: items.length,
      itemBuilder: (_, i) => AccessoryListItem(
        accessory: items[i],
        onTap: () => _showDetails(items[i]),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.purple[50],
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.shopping_bag_outlined,
                size: 56,
                color: Colors.purple[300],
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'No accessories found',
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w600,
                color: Colors.grey[700],
              ),
            ),
            const SizedBox(height: 6),
            Text(
              searchQuery.isNotEmpty
                  ? 'Try adjusting your search'
                  : 'Check other categories',
              style: TextStyle(fontSize: 12, color: Colors.grey[500]),
            ),
            if (searchQuery.isNotEmpty) ...[
              const SizedBox(height: 16),
              ElevatedButton.icon(
                onPressed: () => setState(() => searchQuery = ''),
                icon: const Icon(Icons.clear_rounded, size: 16),
                label: const Text('Clear'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.purple,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  // Bottom sheet details
  void _showDetails(Accessory a) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
        ),
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: 50,
                height: 4,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.network(
                    a.imageUrl,
                    width: 90,
                    height: 100,
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) => Container(
                      width: 90,
                      height: 100,
                      color: Colors.grey[200],
                      child: const Icon(Icons.shopping_bag, size: 40),
                    ),
                  ),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        a.title,
                        style: const TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        a.brand,
                        style: TextStyle(color: Colors.grey[600]),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        a.price,
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: a.type == 'Donate'
                              ? Colors.green
                              : Colors.purple[700],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => Navigator.pop(context),
                style: ElevatedButton.styleFrom(
                  backgroundColor: a.type == 'Donate'
                      ? Colors.green
                      : Colors.purple,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Text(
                  a.type == 'Donate' ? 'Request' : 'Buy Now',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ══════════ CATEGORY MODEL ══════════
class CategoryTab {
  final String name;
  final IconData icon;
  final Color color;

  CategoryTab({
    required this.name,
    required this.icon,
    required this.color,
  });
}