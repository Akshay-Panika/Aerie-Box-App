import 'package:flutter/material.dart';

import '../../category/accesories_category_screen.dart';
import 'accessories_details_screen.dart';

class AccessoriesHomeScreen extends StatefulWidget {
  final Function(String category)? onSwitchToCategoryTab;
  const AccessoriesHomeScreen({
    super.key,
    this.onSwitchToCategoryTab,
  });

  @override
  State<AccessoriesHomeScreen> createState() => _AccessoriesHomeScreenState();
}

class _AccessoriesHomeScreenState extends State<AccessoriesHomeScreen>
    with SingleTickerProviderStateMixin {
  bool isGridView = true;
  List<Product> products = [];
  List<Product> filteredProducts = [];
  String sortBy = 'nearby';
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;

  final TextEditingController searchController = TextEditingController();

  // ✅ Big categories
  final List<CategoryItem> categories = [
    CategoryItem(
      title: 'New Arrivals',
      subtitle: 'Latest gadgets',
      icon: Icons.fiber_new,
      iconColor: Colors.purple,
    ),
    CategoryItem(
      title: 'Best Sellers',
      subtitle: 'Top rated',
      icon: Icons.star,
      iconColor: Colors.amber,
    ),
  ];

  // ✅ Electronics Accessories Categories
  final List<SmallCategoryItem> smallCategories = [
    SmallCategoryItem(title: 'Wearables', icon: Icons.watch_rounded, iconColor: Colors.purple),
    SmallCategoryItem(title: 'Audio', icon: Icons.headphones_rounded, iconColor: Colors.deepPurple),
    SmallCategoryItem(title: 'Chargers', icon: Icons.battery_charging_full_rounded, iconColor: Colors.indigo),
    SmallCategoryItem(title: 'Photography', icon: Icons.camera_alt_rounded, iconColor: Colors.purpleAccent),
    SmallCategoryItem(title: 'Laptop', icon: Icons.laptop_rounded, iconColor: Colors.deepPurpleAccent),
    SmallCategoryItem(title: 'Phone', icon: Icons.phone_android_rounded, iconColor: Colors.indigoAccent),
    SmallCategoryItem(title: 'Accessories', icon: Icons.cable_rounded, iconColor: Colors.deepPurple),
    SmallCategoryItem(title: 'More', icon: Icons.apps, iconColor: Colors.purple),
  ];

  @override
  void initState() {
    super.initState();
    products = Product.getSampleProducts();
    filteredProducts = products;

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _fadeAnimation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    );
    _animationController.forward();
  }

  void _sortProducts() {
    switch (sortBy) {
      case 'nearby':
        filteredProducts.sort((a, b) => a.distance.compareTo(b.distance));
        break;
      case 'free':
        filteredProducts.sort((a, b) {
          bool aIsFree = a.price.toLowerCase() == 'free';
          bool bIsFree = b.price.toLowerCase() == 'free';
          if (aIsFree && !bIsFree) return -1;
          if (!aIsFree && bIsFree) return 1;
          return _getPriceValue(a.price).compareTo(_getPriceValue(b.price));
        });
        break;
      case 'paid':
        filteredProducts.sort((a, b) {
          bool aIsPaid = a.price.toLowerCase() != 'free';
          bool bIsPaid = b.price.toLowerCase() != 'free';
          if (aIsPaid && !bIsPaid) return -1;
          if (!aIsPaid && bIsPaid) return 1;
          return _getPriceValue(a.price).compareTo(_getPriceValue(b.price));
        });
        break;
    }
  }

  double _getPriceValue(String price) {
    if (price.toLowerCase() == 'free') return 0;
    final match = RegExp(r'(\d+)').firstMatch(price);
    return match != null ? double.parse(match.group(1)!) : double.infinity;
  }

  @override
  void dispose() {
    searchController.dispose();
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: Column(
        children: [
          _buildHeader(),
          Expanded(
            child: CustomScrollView(
              slivers: [
                SliverToBoxAdapter(child: _buildSearch()),
                SliverToBoxAdapter(child: _buildBanner()),
                SliverToBoxAdapter(child: _buildCategoriesSection()),
                SliverPersistentHeader(
                  pinned: true,
                  delegate: StickyHeaderDelegate(
                    height: 60,
                    child: StickyFilters(
                      isGridView: isGridView,
                      onViewToggle: () {
                        setState(() {
                          isGridView = !isGridView;
                          _animationController.reset();
                          _animationController.forward();
                        });
                      },
                      sortBy: sortBy,
                      onSortChanged: (value) {
                        setState(() {
                          sortBy = value;
                          _sortProducts();
                          _animationController.reset();
                          _animationController.forward();
                        });
                      },
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                  child: FadeTransition(
                    opacity: _fadeAnimation,
                    child: _buildProductList(),
                  ),
                ),
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    child: Center(
                      child: Text(
                        '${filteredProducts.length} products available',
                        style: TextStyle(
                          fontSize: 13,
                          color: Colors.grey[500],
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                ),
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
                      'Accessories',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                    Text(
                      'Find your next gadget',
                      style: TextStyle(fontSize: 12, color: Colors.grey.shade700),
                    ),
                  ],
                ),
              ],
            ),
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
                    '${products.length}',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.purple[700],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ══════════ SEARCH ══════════
  Widget _buildSearch() {
    return Container(
      height: 80,
      padding: const EdgeInsets.all(12),
      child: Card(
        elevation: 0.2,
        color: Colors.grey.shade100,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: InkWell(
          onTap: () => print("Search tapped!"),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              children: [
                const Icon(Icons.search, color: Colors.grey),
                const SizedBox(width: 10),
                const Text(
                  "Search accessories...",
                  style: TextStyle(color: Colors.grey, fontSize: 16),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // ══════════ BANNER ══════════
  Widget _buildBanner() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      child: Container(
        height: 180,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.purple.shade700, Colors.purple.shade400],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Stack(
          children: [
            Positioned(
              right: -20,
              bottom: -20,
              child: Icon(Icons.devices_other,
                  size: 150, color: Colors.white.withOpacity(0.2)),
            ),
            const Padding(
              padding: EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Discover New Gadgets",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    "Explore our collection of top-rated\nelectronics accessories.",
                    style: TextStyle(color: Colors.white70, fontSize: 14),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ══════════ CATEGORIES ══════════
  Widget _buildCategoriesSection() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: _BigCategoryCard(
                  title: categories[0].title,
                  subtitle: categories[0].subtitle,
                  icon: categories[0].icon,
                  iconColor: categories[0].iconColor,
                  onTap: () => _navigateToCategory(categories[0].title),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: _BigCategoryCard(
                  title: categories[1].title,
                  subtitle: categories[1].subtitle,
                  icon: categories[1].icon,
                  iconColor: categories[1].iconColor,
                  onTap: () => _navigateToCategory(categories[1].title),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            children: smallCategories.sublist(0, 4).map((item) {
              return Expanded(
                child: _SmallCategoryItem(
                  title: item.title,
                  icon: item.icon,
                  iconColor: item.iconColor,
                  onTap: () => _navigateToCategory(item.title),
                ),
              );
            }).toList(),
          ),
          const SizedBox(height: 10),
          Row(
            children: smallCategories.sublist(4).map((item) {
              return Expanded(
                child: _SmallCategoryItem(
                  title: item.title,
                  icon: item.icon,
                  iconColor: item.iconColor,
                  onTap: () => _navigateToCategory(item.title),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  void _navigateToCategory(String category) {
    widget.onSwitchToCategoryTab?.call(category);
  }

  void _navigateToProductDetails(Product product) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AccessoriesDetailsScreen(product: product),
      ),
    );
  }

  // ══════════ PRODUCT LIST ══════════
  Widget _buildProductList() {
    if (isGridView) {
      return Padding(
        padding: const EdgeInsets.all(10),
        child: GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          padding: EdgeInsets.zero,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 0.58,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
          ),
          itemCount: filteredProducts.length,
          itemBuilder: (context, index) {
            return TweenAnimationBuilder(
              duration: Duration(milliseconds: 300 + (index * 50)),
              tween: Tween<double>(begin: 0, end: 1),
              builder: (context, value, child) {
                return Transform.scale(
                  scale: value,
                  child: Opacity(opacity: value, child: child),
                );
              },
              child: ProductCard(
                product: filteredProducts[index],
                onTap: () => _navigateToProductDetails(filteredProducts[index]),
              ),
            );
          },
        ),
      );
    } else {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: ListView.builder(
          shrinkWrap: true,
          padding: EdgeInsets.zero,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: filteredProducts.length,
          itemBuilder: (context, index) {
            return TweenAnimationBuilder(
              duration: Duration(milliseconds: 300 + (index * 50)),
              tween: Tween<double>(begin: 0, end: 1),
              builder: (context, value, child) {
                return Transform.translate(
                  offset: Offset(50 * (1 - value), 0),
                  child: Opacity(opacity: value, child: child),
                );
              },
              child: ProductListItem(
                product: filteredProducts[index],
                onTap: () => _navigateToProductDetails(filteredProducts[index]),
              ),
            );
          },
        ),
      );
    }
  }
}

// ============== STICKY HEADER ==============
class StickyHeaderDelegate extends SliverPersistentHeaderDelegate {
  final double height;
  final Widget child;
  StickyHeaderDelegate({required this.height, required this.child});

  @override
  double get minExtent => height;
  @override
  double get maxExtent => height;

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) => child;

  @override
  bool shouldRebuild(StickyHeaderDelegate oldDelegate) =>
      oldDelegate.height != height || oldDelegate.child != child;
}

// ============== STICKY FILTERS ==============
class StickyFilters extends StatelessWidget {
  final bool isGridView;
  final VoidCallback onViewToggle;
  final String sortBy;
  final Function(String) onSortChanged;

  const StickyFilters({
    super.key,
    required this.isGridView,
    required this.onViewToggle,
    required this.sortBy,
    required this.onSortChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.08),
            spreadRadius: 2,
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Text(
            'Sort:',
            style: TextStyle(
              fontSize: 18,
              color: Colors.grey.shade700,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(width: 8),
          _buildSortChip('📍 Nearby', 'nearby'),
          const SizedBox(width: 4),
          _buildSortChip('🆓 Free', 'free'),
          const SizedBox(width: 4),
          _buildSortChip('💰 Paid', 'paid'),
          const Spacer(),
          IconButton(
            icon: AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              child: Icon(
                isGridView ? Icons.grid_view_rounded : Icons.list_rounded,
                key: ValueKey(isGridView),
                size: 22,
                color: Colors.black87,
              ),
            ),
            onPressed: onViewToggle,
            padding: const EdgeInsets.all(8),
            constraints: const BoxConstraints(),
          ),
        ],
      ),
    );
  }

  Widget _buildSortChip(String label, String value) {
    final isSelected = sortBy == value;
    return GestureDetector(
      onTap: () => onSortChanged(value),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        decoration: BoxDecoration(
          color: isSelected ? Colors.purple : Colors.grey[100],
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: isSelected ? Colors.purple : Colors.transparent,
            width: 1.5,
          ),
          boxShadow: isSelected
              ? [BoxShadow(color: Colors.purple.withOpacity(0.2), spreadRadius: 1, blurRadius: 4)]
              : [],
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 11,
            color: isSelected ? Colors.white : Colors.black87,
            fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
          ),
        ),
      ),
    );
  }
}

// ============== CATEGORY WIDGETS ==============
class _BigCategoryCard extends StatelessWidget {
  final String title, subtitle;
  final IconData icon;
  final Color iconColor;
  final VoidCallback onTap;

  const _BigCategoryCard({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.iconColor,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.06),
              spreadRadius: 2,
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title,
                      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                  const SizedBox(height: 2),
                  Text(subtitle,
                      style: TextStyle(fontSize: 11, color: Colors.grey.shade600)),
                ],
              ),
            ),
            Icon(icon, color: iconColor, size: 28),
          ],
        ),
      ),
    );
  }
}

class _SmallCategoryItem extends StatelessWidget {
  final String title;
  final IconData icon;
  final Color iconColor;
  final VoidCallback onTap;

  const _SmallCategoryItem({
    required this.title,
    required this.icon,
    required this.iconColor,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 4),
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.04),
              spreadRadius: 1,
              blurRadius: 4,
              offset: const Offset(0, 1),
            ),
          ],
        ),
        child: Column(
          children: [
            Icon(icon, color: iconColor, size: 26),
            const SizedBox(height: 6),
            Text(
              title,
              style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w500),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}

// ============== PRODUCT LIST ITEM ==============
class ProductListItem extends StatelessWidget {
  final Product product;
  final VoidCallback onTap;

  const ProductListItem({super.key, required this.product, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 6),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.06),
              spreadRadius: 2,
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            Hero(
              tag: 'product_${product.id}',
              child: Container(
                width: 80,
                height: 100,
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Image.network(
                  product.imageUrl,
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) =>
                  const Icon(Icons.devices_other, size: 40, color: Colors.grey),
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          product.title,
                          style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                            color: Colors.black87,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      if (product.isVerified)
                        const Icon(Icons.verified_rounded, color: Colors.purple, size: 16),
                    ],
                  ),
                  const SizedBox(height: 2),
                  Text(product.brand,
                      style: const TextStyle(fontSize: 13, color: Colors.grey)),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Icon(Icons.location_on_outlined, size: 14, color: Colors.grey[600]),
                      const SizedBox(width: 2),
                      Text(product.location,
                          style: TextStyle(fontSize: 12, color: Colors.grey[600])),
                      const SizedBox(width: 8),
                      Icon(Icons.directions_walk_rounded, size: 14, color: Colors.grey[600]),
                      const SizedBox(width: 2),
                      Text('${product.distance} km',
                          style: TextStyle(fontSize: 12, color: Colors.grey[600])),
                      const Spacer(),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
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
                            fontSize: 10,
                            fontWeight: FontWeight.w600,
                            color: product.condition == 'New'
                                ? Colors.green[700]
                                : product.condition == 'Like New'
                                ? Colors.purple[700]
                                : Colors.orange[700],
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 6),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                        decoration: BoxDecoration(
                          color: Colors.purple[50],
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Text(
                          product.category,
                          style: TextStyle(
                            fontSize: 11,
                            color: Colors.purple[700],
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      Text(
                        product.price,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: product.type == 'Donate' ? Colors.green : Colors.purple,
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
                          const Icon(Icons.person_outline_rounded, size: 12, color: Colors.grey),
                          const SizedBox(width: 2),
                          Text(product.seller,
                              style: const TextStyle(fontSize: 11, color: Colors.grey)),
                        ],
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 4),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: product.type == 'Donate'
                                ? [Colors.green, Colors.green[700]!]
                                : [Colors.purple, Colors.purple[700]!],
                          ),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Text(
                          product.type == 'Donate' ? 'Request' : 'Buy',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 11,
                            fontWeight: FontWeight.w600,
                          ),
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

// ============== PRODUCT CARD ==============
class ProductCard extends StatelessWidget {
  final Product product;
  final VoidCallback onTap;

  const ProductCard({super.key, required this.product, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.08),
              spreadRadius: 2,
              blurRadius: 8,
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
                      width: double.infinity,
                      height: 180,
                      fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) => Container(
                        height: 180,
                        width: double.infinity,
                        color: Colors.grey[200],
                        child: const Center(
                          child: Icon(Icons.devices_other, size: 50, color: Colors.grey),
                        ),
                      ),
                    ),
                  ),
                ),
                if (product.type == 'Donate')
                  Positioned(
                    top: 8,
                    left: 8,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                            colors: [Colors.green, Colors.greenAccent]),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Text(
                        'FREE',
                        style: TextStyle(
                            color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                Positioned(
                  bottom: 8,
                  right: 8,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.7),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(product.condition,
                        style: const TextStyle(color: Colors.white, fontSize: 10)),
                  ),
                ),
                if (product.isVerified)
                  Positioned(
                    top: 8,
                    right: 8,
                    child: Container(
                      padding: const EdgeInsets.all(4),
                      decoration: const BoxDecoration(
                          color: Colors.purple, shape: BoxShape.circle),
                      child: const Icon(Icons.verified_rounded,
                          color: Colors.white, size: 14),
                    ),
                  ),
                Positioned(
                  bottom: 8,
                  left: 8,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.7),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      children: [
                        const Icon(Icons.directions_walk_rounded,
                            size: 12, color: Colors.white),
                        const SizedBox(width: 4),
                        Text(
                          '${product.distance} km',
                          style: const TextStyle(
                              color: Colors.white, fontSize: 10, fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: Colors.black87,
                      height: 1.3,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    product.brand,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(fontSize: 11, color: Colors.grey),
                  ),
                  const SizedBox(height: 6),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                        decoration: BoxDecoration(
                          color: Colors.purple[50],
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Text(
                          product.category,
                          style: TextStyle(
                            fontSize: 9,
                            color: Colors.purple[700],
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
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
                    ],
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      const Icon(Icons.person_outline_rounded, size: 10, color: Colors.grey),
                      const SizedBox(width: 2),
                      Expanded(
                        child: Text(
                          product.seller,
                          style: const TextStyle(fontSize: 10, color: Colors.grey),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        product.price,
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: product.type == 'Donate' ? Colors.green : Colors.purple,
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: product.type == 'Donate'
                                ? [Colors.green, Colors.green[700]!]
                                : [Colors.purple, Colors.purple[700]!],
                          ),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Text(
                          product.type == 'Donate' ? 'Request' : 'Buy',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 10,
                            fontWeight: FontWeight.w600,
                          ),
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

// ============== DATA MODELS ==============
class CategoryItem {
  final String title, subtitle;
  final IconData icon;
  final Color iconColor;
  CategoryItem({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.iconColor,
  });
}

class SmallCategoryItem {
  final String title;
  final IconData icon;
  final Color iconColor;
  SmallCategoryItem({
    required this.title,
    required this.icon,
    required this.iconColor,
  });
}

// ============== PRODUCT MODEL ==============
class Product {
  final String id;
  final String title;
  final String brand;
  final String category;
  final String price;
  final String type;
  final String imageUrl;
  final String condition;
  final String seller;
  final String location;
  final bool isVerified;
  final double distance;

  Product({
    required this.id,
    required this.title,
    required this.brand,
    required this.category,
    required this.price,
    required this.type,
    required this.imageUrl,
    required this.condition,
    required this.seller,
    required this.location,
    required this.isVerified,
    required this.distance,
  });

  static List<Product> getSampleProducts() {
    return [
      Product(
        id: '1',
        title: 'Apple Watch Series 9',
        brand: 'Apple',
        category: 'Wearables',
        price: '₹32,000',
        type: 'Sell',
        imageUrl: 'https://images.unsplash.com/photo-1546868871-7041f2a55e12?w=400&h=500&fit=crop',
        condition: 'Like New',
        seller: 'Rahul Sharma',
        location: 'Delhi',
        isVerified: true,
        distance: 1.2,
      ),
      Product(
        id: '2',
        title: 'Sony WH-1000XM5 Headphones',
        brand: 'Sony',
        category: 'Audio',
        price: 'Free',
        type: 'Donate',
        imageUrl: 'https://images.unsplash.com/photo-1505740420928-5e560c06d30e?w=400&h=500&fit=crop',
        condition: 'Excellent',
        seller: 'Priya Singh',
        location: 'Mumbai',
        isVerified: true,
        distance: 2.5,
      ),
      Product(
        id: '3',
        title: 'Anker 65W Fast Charger',
        brand: 'Anker',
        category: 'Chargers',
        price: '₹1,800',
        type: 'Sell',
        imageUrl: 'https://images.unsplash.com/photo-1583863788434-e58a36330cf0?w=400&h=500&fit=crop',
        condition: 'New',
        seller: 'Amit Kumar',
        location: 'Bangalore',
        isVerified: false,
        distance: 3.8,
      ),
      Product(
        id: '4',
        title: 'Canon EOS 200D DSLR',
        brand: 'Canon',
        category: 'Photography',
        price: 'Free',
        type: 'Donate',
        imageUrl: 'https://images.unsplash.com/photo-1502920917128-1aa500764cbd?w=400&h=500&fit=crop',
        condition: 'Good',
        seller: 'Sneha Patel',
        location: 'Chennai',
        isVerified: true,
        distance: 0.8,
      ),
      Product(
        id: '5',
        title: 'MacBook Pro M2 14"',
        brand: 'Apple',
        category: 'Laptop',
        price: '₹1,25,000',
        type: 'Sell',
        imageUrl: 'https://images.unsplash.com/photo-1517336714731-489689fd1ca8?w=400&h=500&fit=crop',
        condition: 'Like New',
        seller: 'Mohan Das',
        location: 'Kolkata',
        isVerified: false,
        distance: 4.2,
      ),
      Product(
        id: '6',
        title: 'Samsung Galaxy S24 Ultra',
        brand: 'Samsung',
        category: 'Phone',
        price: 'Free',
        type: 'Donate',
        imageUrl: 'https://images.unsplash.com/photo-1610945265064-0e34e5519bbf?w=400&h=500&fit=crop',
        condition: 'Good',
        seller: 'Deepak Verma',
        location: 'Hyderabad',
        isVerified: true,
        distance: 1.9,
      ),
      Product(
        id: '7',
        title: 'AirPods Pro 2nd Gen',
        brand: 'Apple',
        category: 'Audio',
        price: '₹18,500',
        type: 'Sell',
        imageUrl: 'https://images.unsplash.com/photo-1600294037681-c80b4cb5b434?w=400&h=500&fit=crop',
        condition: 'Excellent',
        seller: 'Vikram Patel',
        location: 'Delhi',
        isVerified: true,
        distance: 0.5,
      ),
      Product(
        id: '8',
        title: 'Logitech MX Master 3S',
        brand: 'Logitech',
        category: 'Accessories',
        price: 'Free',
        type: 'Donate',
        imageUrl: 'https://images.unsplash.com/photo-1527864550417-7fd91fc51a46?w=400&h=500&fit=crop',
        condition: 'Good',
        seller: 'Ananya Reddy',
        location: 'Bangalore',
        isVerified: true,
        distance: 3.2,
      ),
      Product(
        id: '9',
        title: 'Fitbit Charge 6',
        brand: 'Fitbit',
        category: 'Wearables',
        price: '₹12,000',
        type: 'Sell',
        imageUrl: 'https://images.unsplash.com/photo-1575311373937-040b8e1fd5b6?w=400&h=500&fit=crop',
        condition: 'Like New',
        seller: 'Karan Mehta',
        location: 'Pune',
        isVerified: true,
        distance: 2.1,
      ),
      Product(
        id: '10',
        title: 'JBL Flip 6 Speaker',
        brand: 'JBL',
        category: 'Audio',
        price: '₹8,500',
        type: 'Sell',
        imageUrl: 'https://images.unsplash.com/photo-1608043152269-423dbba4e7e1?w=400&h=500&fit=crop',
        condition: 'New',
        seller: 'Neha Gupta',
        location: 'Jaipur',
        isVerified: false,
        distance: 5.0,
      ),
      Product(
        id: '11',
        title: 'GoPro Hero 12 Black',
        brand: 'GoPro',
        category: 'Photography',
        price: '₹38,000',
        type: 'Sell',
        imageUrl: 'https://images.unsplash.com/photo-1526170375885-4d8ecf77b99f?w=400&h=500&fit=crop',
        condition: 'Excellent',
        seller: 'Rohit Singh',
        location: 'Goa',
        isVerified: true,
        distance: 6.5,
      ),
      Product(
        id: '12',
        title: 'Dell XPS 15 Laptop',
        brand: 'Dell',
        category: 'Laptop',
        price: 'Free',
        type: 'Donate',
        imageUrl: 'https://images.unsplash.com/photo-1593642632823-8f785ba67e45?w=400&h=500&fit=crop',
        condition: 'Good',
        seller: 'Sanjay Kapoor',
        location: 'Ahmedabad',
        isVerified: true,
        distance: 4.8,
      ),
    ];
  }
}