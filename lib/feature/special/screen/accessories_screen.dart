import 'package:flutter/material.dart';

class AccessoriesScreen extends StatefulWidget {
  const AccessoriesScreen({super.key});

  @override
  State<AccessoriesScreen> createState() => _AccessoriesScreenState();
}

class _AccessoriesScreenState extends State<AccessoriesScreen>
    with SingleTickerProviderStateMixin {
  String selectedCategory = 'All';
  String searchQuery = '';
  bool isGridView = true;
  List<Accessory> accessories = [];
  List<Accessory> filteredAccessories = [];
  String sortBy = 'nearby';
  bool isSearching = false;
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  int _selectedIndex = 0;

  final TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    accessories = Accessory.getSampleAccessories();
    filteredAccessories = accessories;

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );
    _fadeAnimation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    );
    _animationController.forward();
  }

  void filterAccessories() {
    setState(() {
      filteredAccessories = accessories.where((accessory) {
        final matchesCategory =
            selectedCategory == 'All' || accessory.category == selectedCategory;
        final matchesSearch =
            accessory.title.toLowerCase().contains(searchQuery.toLowerCase()) ||
            accessory.brand.toLowerCase().contains(searchQuery.toLowerCase());
        return matchesCategory && matchesSearch;
      }).toList();
      _sortAccessories();
    });
  }

  void _sortAccessories() {
    switch (sortBy) {
      case 'nearby':
        filteredAccessories.sort((a, b) => a.distance.compareTo(b.distance));
        break;
      case 'free':
        filteredAccessories.sort((a, b) {
          bool aIsFree = a.price.toLowerCase() == 'free';
          bool bIsFree = b.price.toLowerCase() == 'free';
          if (aIsFree && !bIsFree) return -1;
          if (!aIsFree && bIsFree) return 1;
          return _getPriceValue(a.price).compareTo(_getPriceValue(b.price));
        });
        break;
      case 'paid':
        filteredAccessories.sort((a, b) {
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
      backgroundColor: const Color(0xFFF8F9FE),
      body: Column(
        children: [
          _buildHeader(),
          Expanded(
            child: CustomScrollView(
              slivers: [
                SliverToBoxAdapter(child: _buildSearch()),
                SliverPersistentHeader(
                  pinned: true,
                  delegate: StickyHeaderDelegate(
                    height: 160,
                    child: StickyFilters(
                      selectedCategory: selectedCategory,
                      onCategorySelected: (category) {
                        setState(() {
                          selectedCategory = category;
                          filterAccessories();
                          _animationController.reset();
                          _animationController.forward();
                        });
                      },
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
                          _sortAccessories();
                          _animationController.reset();
                          _animationController.forward();
                        });
                      },
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                  child: filteredAccessories.isEmpty
                      ? SizedBox(
                          height: MediaQuery.of(context).size.height * 0.6,
                          child: _buildEmptyState(),
                        )
                      : FadeTransition(
                          opacity: _fadeAnimation,
                          child: _buildAccessoryList(),
                        ),
                ),
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    child: Center(
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 8,
                        ),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [Colors.purple[50]!, Colors.purple[100]!],
                          ),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.shopping_bag_rounded,
                              size: 16,
                              color: Colors.purple[700],
                            ),
                            const SizedBox(width: 8),
                            Text(
                              '${filteredAccessories.length} accessories available',
                              style: TextStyle(
                                fontSize: 13,
                                color: Colors.purple[700],
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
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

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.purple.withOpacity(0.05),
            spreadRadius: 2,
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.only(top: 40, left: 0, right: 0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: Colors.purple[50],
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: IconButton(
                    icon: const Icon(Icons.arrow_back_rounded),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    padding: const EdgeInsets.all(8),
                    iconSize: 22,
                    color: Colors.purple[700],
                  ),
                ),
                const SizedBox(width: 12),
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Colors.purple[600]!, Colors.purple[800]!],
                    ),
                    borderRadius: BorderRadius.circular(14),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.purple.withOpacity(0.3),
                        spreadRadius: 2,
                        blurRadius: 10,
                      ),
                    ],
                  ),
                  child: const Icon(
                    Icons.style_rounded,
                    color: Colors.white,
                    size: 22,
                  ),
                ),
                const SizedBox(width: 12),
                const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Accessories',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                    Text(
                      'Style your world ✨',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ],
            ),

            // _buildHeader mein ye badlav karein
            Container(
              padding: const EdgeInsets.all(2),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.purple[600]!, Colors.purple[800]!],
                ),
                borderRadius: BorderRadius.circular(25),
              ),
              child: CircleAvatar(
                backgroundColor: Colors.white,
                radius: 22,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.book_rounded,
                      size: 16,
                      color: Colors.purple[600],
                    ),
                    const SizedBox(width: 4),
                    Text(
                      '${filteredAccessories.length}', // Yahan variable change kiya
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.purple[600],
                      ),
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

  Widget _buildSearch() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      color: Colors.white,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        decoration: BoxDecoration(
          color: const Color(0xFFF5F3FF),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isSearching ? Colors.purple : Colors.transparent,
            width: 2,
          ),
          boxShadow: isSearching
              ? [
                  BoxShadow(
                    color: Colors.purple.withOpacity(0.15),
                    spreadRadius: 4,
                    blurRadius: 12,
                  ),
                ]
              : [],
        ),
        child: TextField(
          controller: searchController,
          onChanged: (value) {
            setState(() {
              searchQuery = value;
              filterAccessories();
              isSearching = value.isNotEmpty;
            });
          },
          onTap: () {
            setState(() {
              isSearching = true;
            });
          },
          decoration: InputDecoration(
            hintText: 'Find your perfect accessory...',
            hintStyle: TextStyle(color: Colors.grey[400], fontSize: 14),
            prefixIcon: Icon(
              Icons.search_rounded,
              color: isSearching ? Colors.purple : Colors.grey[400],
            ),
            suffixIcon: searchQuery.isNotEmpty
                ? IconButton(
                    icon: const Icon(Icons.close_rounded, color: Colors.grey),
                    onPressed: () {
                      setState(() {
                        searchController.clear();
                        searchQuery = '';
                        filterAccessories();
                        isSearching = false;
                      });
                    },
                  )
                : null,
            border: InputBorder.none,
            contentPadding: const EdgeInsets.symmetric(vertical: 14),
          ),
        ),
      ),
    );
  }

  Widget _buildAccessoryList() {
    if (isGridView) {
      return Padding(
        padding: const EdgeInsets.all(10.0),
        child: GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          padding: EdgeInsets.zero,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 0.56,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
          ),
          itemCount: filteredAccessories.length,
          itemBuilder: (context, index) {
            return TweenAnimationBuilder(
              duration: Duration(milliseconds: 300 + (index * 60)),
              tween: Tween<double>(begin: 0, end: 1),
              builder: (context, value, child) {
                return Transform.scale(
                  scale: value,
                  child: Opacity(opacity: value, child: child),
                );
              },
              child: AccessoryCard(
                accessory: filteredAccessories[index],
                onTap: () {
                  _showAccessoryDetails(filteredAccessories[index]);
                },
              ),
            );
          },
        ),
      );
    } else {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: ListView.builder(
          shrinkWrap: true,
          padding: EdgeInsets.zero,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: filteredAccessories.length,
          itemBuilder: (context, index) {
            return TweenAnimationBuilder(
              duration: Duration(milliseconds: 300 + (index * 60)),
              tween: Tween<double>(begin: 0, end: 1),
              builder: (context, value, child) {
                return Transform.translate(
                  offset: Offset(30 * (1 - value), 0),
                  child: Opacity(opacity: value, child: child),
                );
              },
              child: AccessoryListItem(
                accessory: filteredAccessories[index],
                onTap: () {
                  _showAccessoryDetails(filteredAccessories[index]);
                },
              ),
            );
          },
        ),
      );
    }
  }

  Widget _buildEmptyState() {
    return Center(
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
              size: 60,
              color: Colors.purple[300],
            ),
          ),
          const SizedBox(height: 20),
          const Text(
            'No Accessories Found',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Try different keywords or filters',
            style: TextStyle(fontSize: 14, color: Colors.grey[600]),
          ),
          const SizedBox(height: 24),
          ElevatedButton.icon(
            onPressed: () {
              setState(() {
                selectedCategory = 'All';
                searchController.clear();
                searchQuery = '';
                filterAccessories();
              });
            },
            icon: const Icon(Icons.refresh_rounded, size: 18),
            label: const Text('Reset Filters'),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.purple,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14),
              ),
              elevation: 2,
            ),
          ),
        ],
      ),
    );
  }

  void _showAccessoryDetails(Accessory accessory) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              spreadRadius: 4,
              blurRadius: 20,
            ),
          ],
        ),
        padding: const EdgeInsets.all(24),
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
            const SizedBox(height: 24),
            Row(
              children: [
                Hero(
                  tag: 'accessory_${accessory.id}',
                  child: Container(
                    width: 100,
                    height: 120,
                    decoration: BoxDecoration(
                      color: Colors.grey[100],
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.1),
                          spreadRadius: 2,
                          blurRadius: 8,
                        ),
                      ],
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: Image.network(
                        accessory.imageUrl,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return const Icon(
                            Icons.shopping_bag,
                            size: 50,
                            color: Colors.grey,
                          );
                        },
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        accessory.title,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        accessory.brand,
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey[600],
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: accessory.condition == 'Excellent'
                                ? [Colors.green[300]!, Colors.green[600]!]
                                : accessory.condition == 'Like New'
                                ? [Colors.blue[300]!, Colors.blue[600]!]
                                : [Colors.orange[300]!, Colors.orange[600]!],
                          ),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          '✨ ${accessory.condition}',
                          style: const TextStyle(
                            fontSize: 11,
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            const Divider(thickness: 1, height: 1),
            const SizedBox(height: 16),
            Row(
              children: [
                _buildDetailChip(
                  Icons.person_outline_rounded,
                  accessory.seller,
                  Colors.purple,
                ),
                const SizedBox(width: 8),
                _buildDetailChip(
                  Icons.location_on_outlined,
                  accessory.location,
                  Colors.blue,
                ),
                const SizedBox(width: 8),
                _buildDetailChip(
                  Icons.directions_walk_rounded,
                  '${accessory.distance} km',
                  Colors.green,
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                _buildTagChip(accessory.category, Colors.purple),
                const SizedBox(width: 8),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 14,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: accessory.type == 'Donate'
                          ? [Colors.green[400]!, Colors.green[600]!]
                          : [Colors.blue[400]!, Colors.blue[600]!],
                    ),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        accessory.type == 'Donate'
                            ? Icons.favorite
                            : Icons.shopping_cart,
                        color: Colors.white,
                        size: 14,
                      ),
                      const SizedBox(width: 6),
                      Text(
                        accessory.type,
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Price',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey[500],
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      accessory.price,
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: accessory.type == 'Donate'
                            ? Colors.green
                            : Colors.purple[700],
                      ),
                    ),
                  ],
                ),
                ElevatedButton.icon(
                  onPressed: () => Navigator.pop(context),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: accessory.type == 'Donate'
                        ? Colors.green
                        : Colors.purple,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 32,
                      vertical: 16,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                    elevation: 4,
                  ),
                  icon: Icon(
                    accessory.type == 'Donate'
                        ? Icons.favorite
                        : Icons.shopping_bag,
                    color: Colors.white,
                    size: 20,
                  ),
                  label: Text(
                    accessory.type == 'Donate' ? 'Request' : 'Buy Now',
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailChip(IconData icon, String label, MaterialColor color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: color[50],
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color[100]!),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 13, color: color[600]),
          const SizedBox(width: 4),
          Text(
            label,
            style: TextStyle(
              fontSize: 11,
              color: color[700],
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTagChip(String label, MaterialColor color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
      decoration: BoxDecoration(
        color: color[50],
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: color[200]!),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 12,
          color: color[700],
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}

// ============== STICKY HEADER DELEGATE ==============
class StickyHeaderDelegate extends SliverPersistentHeaderDelegate {
  final double height;
  final Widget child;

  StickyHeaderDelegate({required this.height, required this.child});

  @override
  double get minExtent => height;

  @override
  double get maxExtent => height;

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    return child;
  }

  @override
  bool shouldRebuild(StickyHeaderDelegate oldDelegate) {
    return oldDelegate.height != height || oldDelegate.child != child;
  }
}

// ============== STICKY FILTERS WIDGET ==============
class StickyFilters extends StatelessWidget {
  final String selectedCategory;
  final Function(String) onCategorySelected;
  final bool isGridView;
  final VoidCallback onViewToggle;
  final String sortBy;
  final Function(String) onSortChanged;

  const StickyFilters({
    super.key,
    required this.selectedCategory,
    required this.onCategorySelected,
    required this.isGridView,
    required this.onViewToggle,
    required this.sortBy,
    required this.onSortChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.purple.withOpacity(0.06),
            spreadRadius: 2,
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          Expanded(
            child: SizedBox(
              height: 100,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: Category.getCategories().length,
                separatorBuilder: (context, index) => const SizedBox(width: 8),
                itemBuilder: (context, index) {
                  final category = Category.getCategories()[index];
                  final isSelected = selectedCategory == category.name;

                  return GestureDetector(
                    onTap: () => onCategorySelected(category.name),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 250),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 10,
                      ),
                      decoration: BoxDecoration(
                        gradient: isSelected
                            ? LinearGradient(
                                colors: [
                                  Colors.purple[600]!,
                                  Colors.purple[800]!,
                                ],
                              )
                            : const LinearGradient(
                                colors: [Color(0xFFF5F3FF), Color(0xFFF5F3FF)],
                              ),
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          color: isSelected
                              ? Colors.purple
                              : Colors.transparent,
                          width: 1.5,
                        ),
                        boxShadow: isSelected
                            ? [
                                BoxShadow(
                                  color: Colors.purple.withOpacity(0.3),
                                  spreadRadius: 1,
                                  blurRadius: 10,
                                ),
                              ]
                            : [],
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            category.icon,
                            size: 20,
                            color: isSelected
                                ? Colors.white
                                : Colors.purple[700],
                          ),
                          const SizedBox(width: 8),
                          Text(
                            category.name,
                            style: TextStyle(
                              color: isSelected ? Colors.white : Colors.black87,
                              fontSize: 12,
                              fontWeight: isSelected
                                  ? FontWeight.w600
                                  : FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.purple[50],
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  children: [
                    const Icon(
                      Icons.sort_rounded,
                      size: 16,
                      color: Colors.purple,
                    ),
                    const SizedBox(width: 4),
                    const Text(
                      'Sort:',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.purple,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              _buildSortChip('📍 Nearby', 'nearby'),
              const SizedBox(width: 4),
              _buildSortChip('🆓 Free', 'free'),
              const SizedBox(width: 4),
              _buildSortChip('💰 Paid', 'paid'),
              const Spacer(),
              Container(
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: BorderRadius.circular(12),
                ),
                child: IconButton(
                  icon: AnimatedSwitcher(
                    duration: const Duration(milliseconds: 300),
                    child: Icon(
                      isGridView ? Icons.grid_view_rounded : Icons.list_rounded,
                      key: ValueKey(isGridView),
                      size: 22,
                      color: Colors.purple[700],
                    ),
                  ),
                  onPressed: onViewToggle,
                  padding: const EdgeInsets.all(8),
                  constraints: const BoxConstraints(),
                ),
              ),
            ],
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
        duration: const Duration(milliseconds: 250),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          gradient: isSelected
              ? LinearGradient(
                  colors: [Colors.purple[600]!, Colors.purple[800]!],
                )
              : const LinearGradient(
                  colors: [Color(0xFFF5F3FF), Color(0xFFF5F3FF)],
                ),
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: isSelected ? Colors.purple : Colors.transparent,
            width: 1.5,
          ),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: Colors.purple.withOpacity(0.2),
                    spreadRadius: 1,
                    blurRadius: 6,
                  ),
                ]
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

// ============== ACCESSORY LIST ITEM ==============
class AccessoryListItem extends StatelessWidget {
  final Accessory accessory;
  final VoidCallback onTap;

  const AccessoryListItem({
    super.key,
    required this.accessory,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 10),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.06),
              spreadRadius: 2,
              blurRadius: 12,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            Hero(
              tag: 'accessory_${accessory.id}',
              child: Container(
                width: 90,
                height: 110,
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: BorderRadius.circular(12),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.network(
                    accessory.imageUrl,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return const Icon(
                        Icons.shopping_bag,
                        size: 40,
                        color: Colors.grey,
                      );
                    },
                  ),
                ),
              ),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          accessory.title,
                          style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                            color: Colors.black87,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      if (accessory.isVerified)
                        Container(
                          padding: const EdgeInsets.all(2),
                          decoration: BoxDecoration(
                            color: Colors.purple,
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.check_rounded,
                            color: Colors.white,
                            size: 12,
                          ),
                        ),
                    ],
                  ),
                  const SizedBox(height: 2),
                  Text(
                    accessory.brand,
                    style: TextStyle(fontSize: 13, color: Colors.grey[600]),
                  ),
                  const SizedBox(height: 6),
                  Row(
                    children: [
                      Icon(
                        Icons.location_on_outlined,
                        size: 13,
                        color: Colors.grey[500],
                      ),
                      const SizedBox(width: 2),
                      Text(
                        accessory.location,
                        style: TextStyle(fontSize: 11, color: Colors.grey[600]),
                      ),
                      const SizedBox(width: 10),
                      Icon(
                        Icons.directions_walk_rounded,
                        size: 13,
                        color: Colors.grey[500],
                      ),
                      const SizedBox(width: 2),
                      Text(
                        '${accessory.distance} km',
                        style: TextStyle(fontSize: 11, color: Colors.grey[600]),
                      ),
                      const Spacer(),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 3,
                        ),
                        decoration: BoxDecoration(
                          color: accessory.condition == 'Excellent'
                              ? Colors.green[50]
                              : accessory.condition == 'Like New'
                              ? Colors.blue[50]
                              : Colors.orange[50],
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          accessory.condition,
                          style: TextStyle(
                            fontSize: 9,
                            fontWeight: FontWeight.w600,
                            color: accessory.condition == 'Excellent'
                                ? Colors.green[700]
                                : accessory.condition == 'Like New'
                                ? Colors.blue[700]
                                : Colors.orange[700],
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 3,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.purple[50],
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          accessory.category,
                          style: TextStyle(
                            fontSize: 10,
                            color: Colors.purple[700],
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      Text(
                        accessory.price,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: accessory.type == 'Donate'
                              ? Colors.green
                              : Colors.purple[700],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 6),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.person_outline_rounded,
                            size: 12,
                            color: Colors.grey[500],
                          ),
                          const SizedBox(width: 2),
                          Text(
                            accessory.seller,
                            style: TextStyle(
                              fontSize: 11,
                              color: Colors.grey[600],
                            ),
                          ),
                        ],
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 5,
                        ),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: accessory.type == 'Donate'
                                ? [Colors.green[400]!, Colors.green[600]!]
                                : [Colors.purple[500]!, Colors.purple[700]!],
                          ),
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              color:
                                  (accessory.type == 'Donate'
                                          ? Colors.green[400]!
                                          : Colors.purple[400]!)
                                      .withOpacity(0.3),
                              spreadRadius: 1,
                              blurRadius: 6,
                            ),
                          ],
                        ),
                        child: Text(
                          accessory.type == 'Donate' ? 'Request' : 'Buy',
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

// ============== ACCESSORY CARD ==============
class AccessoryCard extends StatelessWidget {
  final Accessory accessory;
  final VoidCallback onTap;

  const AccessoryCard({
    super.key,
    required this.accessory,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.08),
              spreadRadius: 2,
              blurRadius: 12,
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
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(16),
                  ),
                  child: Hero(
                    tag: 'accessory_${accessory.id}',
                    child: Image.network(
                      accessory.imageUrl,
                      width: double.infinity,
                      height: 180,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          height: 180,
                          width: double.infinity,
                          color: Colors.grey[100],
                          child: const Center(
                            child: Icon(
                              Icons.shopping_bag,
                              size: 50,
                              color: Colors.grey,
                            ),
                          ),
                        );
                      },
                      loadingBuilder: (context, child, loadingProgress) {
                        if (loadingProgress == null) return child;
                        return Container(
                          height: 180,
                          width: double.infinity,
                          color: Colors.grey[100],
                          child: Center(
                            child: CircularProgressIndicator(
                              value: loadingProgress.expectedTotalBytes != null
                                  ? loadingProgress.cumulativeBytesLoaded /
                                        loadingProgress.expectedTotalBytes!
                                  : null,
                              strokeWidth: 2,
                              color: Colors.purple,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
                if (accessory.type == 'Donate')
                  Positioned(
                    top: 10,
                    left: 10,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [Colors.green, Colors.greenAccent],
                        ),
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.green.withOpacity(0.4),
                            spreadRadius: 1,
                            blurRadius: 6,
                          ),
                        ],
                      ),
                      child: const Text(
                        'FREE',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                Positioned(
                  bottom: 10,
                  right: 10,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Colors.black.withOpacity(0.7),
                          Colors.black.withOpacity(0.5),
                        ],
                      ),
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.white.withOpacity(0.2)),
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 6,
                          height: 6,
                          decoration: BoxDecoration(
                            color: accessory.condition == 'Excellent'
                                ? Colors.green
                                : accessory.condition == 'Like New'
                                ? Colors.blue
                                : Colors.orange,
                            shape: BoxShape.circle,
                          ),
                        ),
                        const SizedBox(width: 4),
                        Text(
                          accessory.condition,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 10,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                if (accessory.isVerified)
                  Positioned(
                    top: 10,
                    right: 10,
                    child: Container(
                      padding: const EdgeInsets.all(4),
                      decoration: const BoxDecoration(
                        color: Colors.purple,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.check_rounded,
                        color: Colors.white,
                        size: 14,
                      ),
                    ),
                  ),
                Positioned(
                  bottom: 10,
                  left: 10,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Colors.black.withOpacity(0.7),
                          Colors.black.withOpacity(0.5),
                        ],
                      ),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.directions_walk_rounded,
                          size: 12,
                          color: Colors.white,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          '${accessory.distance} km',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 10,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    accessory.title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Colors.black87,
                      height: 1.2,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    accessory.brand,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontSize: 11, color: Colors.grey[600]),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 3,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.purple[50],
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          accessory.category,
                          style: TextStyle(
                            fontSize: 9,
                            color: Colors.purple[700],
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 6,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          color: accessory.condition == 'Excellent'
                              ? Colors.green[50]
                              : accessory.condition == 'Like New'
                              ? Colors.blue[50]
                              : Colors.orange[50],
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Text(
                          accessory.condition,
                          style: TextStyle(
                            fontSize: 8,
                            fontWeight: FontWeight.w600,
                            color: accessory.condition == 'Excellent'
                                ? Colors.green[700]
                                : accessory.condition == 'Like New'
                                ? Colors.blue[700]
                                : Colors.orange[700],
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 6),
                  Row(
                    children: [
                      Icon(
                        Icons.person_outline_rounded,
                        size: 10,
                        color: Colors.grey[500],
                      ),
                      const SizedBox(width: 2),
                      Expanded(
                        child: Text(
                          accessory.seller,
                          style: TextStyle(
                            fontSize: 10,
                            color: Colors.grey[600],
                          ),
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
                        accessory.price,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: accessory.type == 'Donate'
                              ? Colors.green
                              : Colors.purple[700],
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 5,
                        ),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: accessory.type == 'Donate'
                                ? [Colors.green[400]!, Colors.green[600]!]
                                : [Colors.purple[500]!, Colors.purple[700]!],
                          ),
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              color:
                                  (accessory.type == 'Donate'
                                          ? Colors.green[400]!
                                          : Colors.purple[400]!)
                                      .withOpacity(0.3),
                              spreadRadius: 1,
                              blurRadius: 6,
                            ),
                          ],
                        ),
                        child: Text(
                          accessory.type == 'Donate' ? 'Request' : 'Buy',
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

// ============== ACCESSORY MODEL ==============
class Accessory {
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

  Accessory({
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

  static List<Accessory> getSampleAccessories() {
    return [
      Accessory(
        id: '1',
        title: 'Premium Leather Watch Band',
        brand: 'Apple',
        category: 'Wearables',
        price: '₹2,499',
        type: 'Sell',
        imageUrl:
            'https://images.unsplash.com/photo-1523275335684-37898b6baf30?w=400&h=500&fit=crop',
        condition: 'Excellent',
        seller: 'Rahul Sharma',
        location: 'Delhi',
        isVerified: true,
        distance: 1.2,
      ),
      Accessory(
        id: '2',
        title: 'Wireless Bluetooth Earbuds',
        brand: 'Sony',
        category: 'Audio',
        price: 'Free',
        type: 'Donate',
        imageUrl:
            'https://images.unsplash.com/photo-1572569511254-d8f925fe2cbb?w=400&h=500&fit=crop',
        condition: 'Good',
        seller: 'Priya Singh',
        location: 'Mumbai',
        isVerified: true,
        distance: 2.5,
      ),
      Accessory(
        id: '3',
        title: 'Samsung Fast Charger Adapter',
        brand: 'Samsung',
        category: 'Chargers',
        price: '₹899',
        type: 'Sell',
        imageUrl:
            'https://images.unsplash.com/photo-1585336261022-680e2954883e?w=400&h=500&fit=crop',
        condition: 'Like New',
        seller: 'Amit Kumar',
        location: 'Bangalore',
        isVerified: false,
        distance: 3.8,
      ),
      Accessory(
        id: '4',
        title: 'Phone Camera Lens Kit',
        brand: 'Moment',
        category: 'Photography',
        price: 'Free',
        type: 'Donate',
        imageUrl:
            'https://images.unsplash.com/photo-1585060544813-6040b8208cf7?w=400&h=500&fit=crop',
        condition: 'Good',
        seller: 'Sneha Patel',
        location: 'Chennai',
        isVerified: true,
        distance: 0.8,
      ),
      Accessory(
        id: '5',
        title: 'Laptop Stand - Adjustable',
        brand: 'Amazon Basics',
        category: 'Laptop',
        price: '₹1,499',
        type: 'Sell',
        imageUrl:
            'https://images.unsplash.com/photo-1527864550417-7fd91fc51a46?w=400&h=500&fit=crop',
        condition: 'Used',
        seller: 'Mohan Das',
        location: 'Kolkata',
        isVerified: false,
        distance: 4.2,
      ),
      Accessory(
        id: '6',
        title: 'Smartphone Ring Holder',
        brand: 'Spigen',
        category: 'Phone',
        price: 'Free',
        type: 'Donate',
        imageUrl:
            'https://images.unsplash.com/photo-1603302576837-37561b2e2302?w=400&h=500&fit=crop',
        condition: 'Excellent',
        seller: 'Deepak Verma',
        location: 'Hyderabad',
        isVerified: true,
        distance: 1.9,
      ),
      Accessory(
        id: '7',
        title: 'Wireless Charging Pad',
        brand: 'Anker',
        category: 'Chargers',
        price: '₹2,199',
        type: 'Sell',
        imageUrl:
            'https://images.unsplash.com/photo-1585336261022-680e2954883e?w=400&h=500&fit=crop',
        condition: 'Excellent',
        seller: 'Vikram Patel',
        location: 'Delhi',
        isVerified: true,
        distance: 0.5,
      ),
      Accessory(
        id: '8',
        title: 'Noise Cancelling Headphones',
        brand: 'Bose',
        category: 'Audio',
        price: 'Free',
        type: 'Donate',
        imageUrl:
            'https://images.unsplash.com/photo-1505740420928-5e560c06d30e?w=400&h=500&fit=crop',
        condition: 'Good',
        seller: 'Ananya Reddy',
        location: 'Bangalore',
        isVerified: true,
        distance: 3.2,
      ),
    ];
  }
}

// ============== CATEGORY MODEL ==============
class Category {
  final String id;
  final String name;
  final IconData icon;

  Category({required this.id, required this.name, required this.icon});

  static List<Category> getCategories() {
    return [
      Category(id: '1', name: 'All', icon: Icons.apps_rounded),
      Category(id: '2', name: 'Wearables', icon: Icons.watch_rounded),
      Category(id: '3', name: 'Audio', icon: Icons.headphones_rounded),
      Category(
        id: '4',
        name: 'Chargers',
        icon: Icons.battery_charging_full_rounded,
      ),
      Category(id: '5', name: 'Photography', icon: Icons.camera_alt_rounded),
      Category(id: '6', name: 'Laptop', icon: Icons.laptop_rounded),
      Category(id: '7', name: 'Phone', icon: Icons.phone_android_rounded),
    ];
  }
}
