import 'package:flutter/material.dart';
import '../home/screen/accessories_details_screen.dart';
import '../home/screen/accessories_home_screen.dart';

class AccessoriesCategoryScreen extends StatefulWidget {
  final String selectedCategory;

  const AccessoriesCategoryScreen({
    super.key,
    required this.selectedCategory,
  });

  @override
  State<AccessoriesCategoryScreen> createState() =>
      _AccessoriesCategoryScreenState();
}

class _AccessoriesCategoryScreenState extends State<AccessoriesCategoryScreen> {
  bool isGridView = true;
  String searchQuery = '';
  int _selectedCategoryIndex = 0;

  // ✅ Electronics Accessories Categories
  final List<CategoryTab> categoryTabs = [
    CategoryTab(name: 'All', icon: Icons.apps_rounded, color: Colors.purple),
    CategoryTab(name: 'Wearables', icon: Icons.watch_rounded, color: Colors.deepPurple),
    CategoryTab(name: 'Audio', icon: Icons.headphones_rounded, color: Colors.indigo),
    CategoryTab(name: 'Chargers', icon: Icons.battery_charging_full_rounded, color: Colors.purpleAccent),
    CategoryTab(name: 'Photography', icon: Icons.camera_alt_rounded, color: Colors.deepPurpleAccent),
    CategoryTab(name: 'Laptop', icon: Icons.laptop_rounded, color: Colors.indigoAccent),
    CategoryTab(name: 'Phone', icon: Icons.phone_android_rounded, color: Colors.purple),
    CategoryTab(name: 'Accessories', icon: Icons.cable_rounded, color: Colors.deepPurple),
  ];

  @override
  void initState() {
    super.initState();
    _applySelectedCategory(widget.selectedCategory);
  }

  // ✅ Naya: Jab parent se category change ho
  @override
  void didUpdateWidget(covariant AccessoriesCategoryScreen oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.selectedCategory != widget.selectedCategory) {
      _applySelectedCategory(widget.selectedCategory);
    }
  }

  void _applySelectedCategory(String category) {
    if (category.isEmpty) {
      _selectedCategoryIndex = 0;
      return;
    }
    // "More" → "All" jaisa index 0
    if (category == 'All' || category == 'More') {
      _selectedCategoryIndex = 0;
      return;
    }
    final index = categoryTabs.indexWhere((tab) => tab.name == category);
    if (index != -1) {
      _selectedCategoryIndex = index;
    }
  }

  List<Product> _getFilteredProducts(String category, String query) {
    final allProducts = Product.getSampleProducts();

    // 👇 "All" aur "More" dono me saare products dikhao
    var products = (category == 'All' || category == 'More')
        ? allProducts
        : allProducts.where((p) => p.category == category).toList();

    if (query.isNotEmpty) {
      products = products.where((p) =>
      p.title.toLowerCase().contains(query.toLowerCase()) ||
          p.brand.toLowerCase().contains(query.toLowerCase())
      ).toList();
    }

    return products;
  }

  void _navigateToProductDetails(Product product) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AccessoriesDetailsScreen(product: product),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final currentCategory = categoryTabs[_selectedCategoryIndex].name;
    final products = _getFilteredProducts(currentCategory, searchQuery);

    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: Column(
        children: [
          _buildHeader(),
          _buildSearchBar(),
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildCategorySidebar(),
                Expanded(child: _buildProductContent(products, currentCategory)),
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
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.only(top: 40),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: Colors.grey[100],
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: IconButton(
                    icon: const Icon(Icons.devices_rounded, color: Colors.purple),
                    onPressed: () => null,
                    padding: const EdgeInsets.all(8),
                    iconSize: 22,
                  ),
                ),
                const SizedBox(width: 10),
                Column(
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
                      'Browse by category',
                      style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                    ),
                  ],
                ),
              ],
            ),
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: Colors.purple[50],
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.devices_rounded, size: 16, color: Colors.purple),
                      const SizedBox(width: 4),
                      Text(
                        '${Product.getSampleProducts().length}',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Colors.purple[700],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 8),
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
        onChanged: (value) => setState(() => searchQuery = value),
        decoration: InputDecoration(
          hintText: 'Search by name or brand...',
          hintStyle: TextStyle(color: Colors.grey[500], fontSize: 14),
          prefixIcon: const Icon(Icons.search, color: Colors.grey, size: 22),
          suffixIcon: searchQuery.isNotEmpty
              ? IconButton(
            icon: const Icon(Icons.clear, size: 20, color: Colors.grey),
            onPressed: () => setState(() => searchQuery = ''),
          )
              : null,
          filled: true,
          fillColor: Colors.grey.shade100,
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
  Widget _buildCategorySidebar() {
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
              ? Product.getSampleProducts().length
              : _getFilteredProducts(tab.name, '').length;

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
                      fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                      color: isSelected ? Colors.black87 : Colors.grey[700],
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  if (tab.name != 'All') ...[
                    const SizedBox(height: 4),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 1),
                      decoration: BoxDecoration(
                        color: isSelected ? tab.color.withOpacity(0.15) : Colors.grey[200],
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
  Widget _buildProductContent(List<Product> products, String categoryName) {
    if (products.isEmpty) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.devices_other, size: 64, color: Colors.grey[300]),
              const SizedBox(height: 14),
              Text(
                searchQuery.isNotEmpty
                    ? 'No matching products'
                    : 'No products in $categoryName',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Colors.grey[600],
                ),
              ),
              const SizedBox(height: 6),
              Text(
                searchQuery.isNotEmpty
                    ? 'Try adjusting your search'
                    : 'Check other categories',
                textAlign: TextAlign.center,
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
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  ),
                ),
              ],
            ],
          ),
        ),
      );
    }

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
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                decoration: BoxDecoration(
                  color: Colors.purple[50],
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  '${products.length}',
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
          child: isGridView ? _buildGrid(products) : _buildList(products),
        ),
      ],
    );
  }

  // ══════════ GRID ══════════
  Widget _buildGrid(List<Product> products) {
    return GridView.builder(
      padding: const EdgeInsets.fromLTRB(10, 8, 10, 20),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.65,
        crossAxisSpacing: 8,
        mainAxisSpacing: 8,
      ),
      itemCount: products.length,
      itemBuilder: (context, index) => _buildCompactProductCard(products[index]),
    );
  }

  // ══════════ LIST ══════════
  Widget _buildList(List<Product> products) {
    return ListView.builder(
      padding: const EdgeInsets.fromLTRB(10, 8, 10, 20),
      itemCount: products.length,
      itemBuilder: (context, index) => _buildCompactProductListItem(products[index]),
    );
  }

  // ══════════ COMPACT CARD ══════════
  Widget _buildCompactProductCard(Product product) {
    return GestureDetector(
      onTap: () => _navigateToProductDetails(product),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.08),
              blurRadius: 6,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
                  child: Hero(
                    tag: 'product_${product.id}',
                    child: Image.network(
                      product.imageUrl,
                      height: 120,
                      width: double.infinity,
                      fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) => Container(
                        height: 120,
                        width: double.infinity,
                        color: Colors.grey[200],
                        child: const Icon(Icons.devices_other, size: 32, color: Colors.grey),
                      ),
                    ),
                  ),
                ),
                if (product.type == 'Donate')
                  Positioned(
                    top: 6,
                    left: 6,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                            colors: [Colors.green, Colors.greenAccent]),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Text(
                        'FREE',
                        style: TextStyle(
                            color: Colors.white, fontSize: 8, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                if (product.isVerified)
                  Positioned(
                    top: 6,
                    right: 6,
                    child: Container(
                      padding: const EdgeInsets.all(2),
                      decoration: const BoxDecoration(
                          color: Colors.purple, shape: BoxShape.circle),
                      child: const Icon(Icons.verified_rounded,
                          color: Colors.white, size: 11),
                    ),
                  ),
              ],
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      product.title,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 11.5,
                        fontWeight: FontWeight.w700,
                        color: Colors.black87,
                        height: 1.25,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      product.brand,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(fontSize: 9.5, color: Colors.grey),
                    ),
                    const Spacer(),
                    Row(
                      children: [
                        const Icon(Icons.directions_walk_rounded,
                            size: 10, color: Colors.grey),
                        const SizedBox(width: 2),
                        Text(
                          '${product.distance} km',
                          style: const TextStyle(fontSize: 9, color: Colors.grey),
                        ),
                        const Spacer(),
                        Text(
                          product.price,
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: product.type == 'Donate' ? Colors.green : Colors.purple,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ══════════ COMPACT LIST ITEM ══════════
  Widget _buildCompactProductListItem(Product product) {
    return GestureDetector(
      onTap: () => _navigateToProductDetails(product),
      child: Container(
        margin: const EdgeInsets.only(bottom: 8),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.06),
              blurRadius: 6,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            Hero(
              tag: 'product_${product.id}',
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.network(
                  product.imageUrl,
                  width: 65,
                  height: 80,
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) => Container(
                    width: 65,
                    height: 80,
                    color: Colors.grey[200],
                    child: const Icon(Icons.devices_other, size: 30, color: Colors.grey),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          product.title,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w700,
                            color: Colors.black87,
                          ),
                        ),
                      ),
                      if (product.isVerified)
                        const Icon(Icons.verified_rounded, color: Colors.purple, size: 14),
                    ],
                  ),
                  const SizedBox(height: 2),
                  Text(
                    product.brand,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(fontSize: 11, color: Colors.grey),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      const Icon(Icons.directions_walk_rounded, size: 12, color: Colors.grey),
                      const SizedBox(width: 2),
                      Text('${product.distance} km',
                          style: const TextStyle(fontSize: 10.5, color: Colors.grey)),
                      const SizedBox(width: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 1),
                        decoration: BoxDecoration(
                          color: product.condition == 'New'
                              ? Colors.green[50]
                              : product.condition == 'Like New'
                              ? Colors.purple[50]
                              : Colors.orange[50],
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Text(
                          product.condition,
                          style: TextStyle(
                            fontSize: 9,
                            fontWeight: FontWeight.w600,
                            color: product.condition == 'New'
                                ? Colors.green[700]
                                : product.condition == 'Like New'
                                ? Colors.purple[700]
                                : Colors.orange[700],
                          ),
                        ),
                      ),
                      const Spacer(),
                      Text(
                        product.price,
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                          color: product.type == 'Donate' ? Colors.green : Colors.purple,
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