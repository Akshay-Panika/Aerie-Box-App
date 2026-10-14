import 'package:flutter/material.dart';
import 'package:rent_hub/feature/food/screen/food_cart_screen.dart';

class CloudStoreScreen extends StatefulWidget {
  final String storeName;
  const CloudStoreScreen({super.key, required this.storeName});

  @override
  State<CloudStoreScreen> createState() => _CloudStoreScreenState();
}

class _CloudStoreScreenState extends State<CloudStoreScreen> {
  String _selectedVegFilter = 'All';
  String _selectedCategory = 'All';

  // Map to store quantities for each item
  Map<String, int> _quantities = {};

  final List<String> categories = [
    'All',
    'Biryani',
    'Burgers',
    'Pizza',
    'Pasta',
    'Desserts',
    'Beverages',
  ];
  final List<String> vegFilterOptions = ['All', 'Veg', 'Non-Veg'];

  // Complete Cloud Store Menu with ingredients and details
  final List<Map<String, dynamic>> menuItems = [
    {
      'id': 'm1',
      'title': 'Hyderabadi Chicken Biryani',
      'description': 'Aromatic basmati rice layered with tender chicken',
      'price': '₹299',
      'originalPrice': '₹399',
      'offer': '25% OFF',
      'rating': 4.9,
      'reviews': 567,
      'isVeg': false,
      'category': 'Biryani',
      'imageUrl':
          'https://images.unsplash.com/photo-1563379091339-03b21ab4a4f8?w=400&h=300&fit=crop',
      'prepTime': '35-40 min',
      'spicyLevel': 'Spicy',
      'ingredients': [
        'Basmati Rice',
        'Chicken',
        'Saffron',
        'Mint',
        'Coriander',
        'Spices',
        'Fried Onions',
      ],
      'serving': 'Serves 2',
      'calories': '650 kcal',
      'isPopular': true,
      'isNew': false,
    },
    {
      'id': 'm2',
      'title': 'Veg Biryani',
      'description': 'Fragrant basmati rice with fresh vegetables',
      'price': '₹199',
      'originalPrice': '₹249',
      'offer': '20% OFF',
      'rating': 4.6,
      'reviews': 234,
      'isVeg': true,
      'category': 'Biryani',
      'imageUrl':
          'https://images.unsplash.com/photo-1567188040759-fb8a883dc6d8?w=400&h=300&fit=crop',
      'prepTime': '30-35 min',
      'spicyLevel': 'Medium',
      'ingredients': [
        'Basmati Rice',
        'Mixed Vegetables',
        'Saffron',
        'Mint',
        'Coriander',
        'Spices',
        'Fried Onions',
      ],
      'serving': 'Serves 2',
      'calories': '480 kcal',
      'isPopular': false,
      'isNew': true,
    },
    {
      'id': 'm3',
      'title': 'Double Cheese Burger',
      'description': 'Juicy patty with cheddar and mozzarella cheese',
      'price': '₹249',
      'originalPrice': '₹299',
      'offer': '15% OFF',
      'rating': 4.7,
      'reviews': 423,
      'isVeg': false,
      'category': 'Burgers',
      'imageUrl':
          'https://images.unsplash.com/photo-1568901346375-23c9450c58cd?w=400&h=300&fit=crop',
      'prepTime': '15-20 min',
      'spicyLevel': 'Mild',
      'ingredients': [
        'Bun',
        'Chicken Patty',
        'Cheddar Cheese',
        'Mozzarella',
        'Lettuce',
        'Tomato',
        'Onions',
        'Sauce',
      ],
      'serving': 'Serves 1',
      'calories': '520 kcal',
      'isPopular': true,
      'isNew': false,
    },
    {
      'id': 'm4',
      'title': 'Veg Supreme Burger',
      'description': 'Grilled veggie patty with fresh vegetables',
      'price': '₹189',
      'originalPrice': '₹229',
      'offer': '18% OFF',
      'rating': 4.5,
      'reviews': 189,
      'isVeg': true,
      'category': 'Burgers',
      'imageUrl':
          'https://images.unsplash.com/photo-1568901346375-23c9450c58cd?w=400&h=300&fit=crop',
      'prepTime': '15-20 min',
      'spicyLevel': 'Mild',
      'ingredients': [
        'Bun',
        'Veggie Patty',
        'Cheese',
        'Lettuce',
        'Tomato',
        'Onions',
        'Mayo Sauce',
      ],
      'serving': 'Serves 1',
      'calories': '450 kcal',
      'isPopular': false,
      'isNew': false,
    },
    {
      'id': 'm5',
      'title': 'Margherita Pizza',
      'description': 'Classic pizza with mozzarella and fresh basil',
      'price': '₹349',
      'originalPrice': '₹429',
      'offer': '20% OFF',
      'rating': 4.8,
      'reviews': 345,
      'isVeg': true,
      'category': 'Pizza',
      'imageUrl':
          'https://images.unsplash.com/photo-1565299624946-b28f40a0ae38?w=400&h=300&fit=crop',
      'prepTime': '20-25 min',
      'spicyLevel': 'Mild',
      'ingredients': [
        'Pizza Base',
        'Mozzarella',
        'Tomato Sauce',
        'Basil',
        'Oregano',
        'Olive Oil',
      ],
      'serving': 'Serves 2',
      'calories': '580 kcal',
      'isPopular': true,
      'isNew': false,
    },
    {
      'id': 'm6',
      'title': 'Pepperoni Pizza',
      'description': 'Spicy pepperoni with extra cheese',
      'price': '₹449',
      'originalPrice': '₹549',
      'offer': '20% OFF',
      'rating': 4.7,
      'reviews': 289,
      'isVeg': false,
      'category': 'Pizza',
      'imageUrl':
          'https://images.unsplash.com/photo-1565299624946-b28f40a0ae38?w=400&h=300&fit=crop',
      'prepTime': '25-30 min',
      'spicyLevel': 'Spicy',
      'ingredients': [
        'Pizza Base',
        'Pepperoni',
        'Mozzarella',
        'Tomato Sauce',
        'Oregano',
        'Chilli Flakes',
      ],
      'serving': 'Serves 2',
      'calories': '650 kcal',
      'isPopular': true,
      'isNew': true,
    },
    {
      'id': 'm7',
      'title': 'Creamy Pasta Alfredo',
      'description': 'Pasta in creamy parmesan cheese sauce',
      'price': '₹219',
      'originalPrice': '₹259',
      'offer': '15% OFF',
      'rating': 4.6,
      'reviews': 189,
      'isVeg': true,
      'category': 'Pasta',
      'imageUrl':
          'https://images.unsplash.com/photo-1645112411342-4665a10da8b7?w=400&h=300&fit=crop',
      'prepTime': '18-22 min',
      'spicyLevel': 'Mild',
      'ingredients': [
        'Pasta',
        'Cream',
        'Parmesan',
        'Butter',
        'Garlic',
        'Parsley',
        'Black Pepper',
      ],
      'serving': 'Serves 1',
      'calories': '480 kcal',
      'isPopular': false,
      'isNew': false,
    },
    {
      'id': 'm8',
      'title': 'Chicken Pasta',
      'description': 'Pasta with grilled chicken in creamy sauce',
      'price': '₹279',
      'originalPrice': '₹329',
      'offer': '15% OFF',
      'rating': 4.7,
      'reviews': 234,
      'isVeg': false,
      'category': 'Pasta',
      'imageUrl':
          'https://images.unsplash.com/photo-1645112411342-4665a10da8b7?w=400&h=300&fit=crop',
      'prepTime': '20-25 min',
      'spicyLevel': 'Medium',
      'ingredients': [
        'Pasta',
        'Chicken',
        'Cream',
        'Parmesan',
        'Garlic',
        'Parsley',
        'Chilli Flakes',
      ],
      'serving': 'Serves 1',
      'calories': '520 kcal',
      'isPopular': true,
      'isNew': false,
    },
    {
      'id': 'm9',
      'title': 'Chocolate Brownie',
      'description': 'Warm brownie with vanilla ice cream',
      'price': '₹149',
      'originalPrice': '₹179',
      'offer': '15% OFF',
      'rating': 4.9,
      'reviews': 456,
      'isVeg': true,
      'category': 'Desserts',
      'imageUrl':
          'https://images.unsplash.com/photo-1606313564200-e75d5e30476c?w=400&h=300&fit=crop',
      'prepTime': '10-15 min',
      'spicyLevel': 'Sweet',
      'ingredients': [
        'Brownie',
        'Vanilla Ice Cream',
        'Chocolate Sauce',
        'Nuts',
      ],
      'serving': 'Serves 1',
      'calories': '380 kcal',
      'isPopular': true,
      'isNew': false,
    },
    {
      'id': 'm10',
      'title': 'Gulab Jamun',
      'description': 'Soft milk dumplings in sugar syrup',
      'price': '₹129',
      'originalPrice': '₹149',
      'offer': '10% OFF',
      'rating': 4.8,
      'reviews': 312,
      'isVeg': true,
      'category': 'Desserts',
      'imageUrl':
          'https://images.unsplash.com/photo-1589301760014-d929f3979dbc?w=400&h=300&fit=crop',
      'prepTime': '15-20 min',
      'spicyLevel': 'Sweet',
      'ingredients': [
        'Milk Powder',
        'Cardamom',
        'Sugar Syrup',
        'Saffron',
        'Pistachio',
      ],
      'serving': 'Serves 2',
      'calories': '320 kcal',
      'isPopular': false,
      'isNew': true,
    },
    {
      'id': 'm11',
      'title': 'Mango Shake',
      'description': 'Fresh mango shake with ice cream',
      'price': '₹149',
      'originalPrice': '₹179',
      'offer': '15% OFF',
      'rating': 4.5,
      'reviews': 167,
      'isVeg': true,
      'category': 'Beverages',
      'imageUrl':
          'https://images.unsplash.com/photo-1579871494447-9811cf80d66c?w=400&h=300&fit=crop',
      'prepTime': '10 min',
      'spicyLevel': 'Sweet',
      'ingredients': ['Mango', 'Milk', 'Sugar', 'Ice Cream', 'Cardamom'],
      'serving': 'Serves 1',
      'calories': '280 kcal',
      'isPopular': false,
      'isNew': false,
    },
    {
      'id': 'm12',
      'title': 'Cold Coffee',
      'description': 'Chilled coffee with ice cream',
      'price': '₹139',
      'originalPrice': '₹159',
      'offer': '10% OFF',
      'rating': 4.4,
      'reviews': 145,
      'isVeg': true,
      'category': 'Beverages',
      'imageUrl':
          'https://images.unsplash.com/photo-1579871494447-9811cf80d66c?w=400&h=300&fit=crop',
      'prepTime': '10 min',
      'spicyLevel': 'Sweet',
      'ingredients': [
        'Coffee',
        'Milk',
        'Ice Cream',
        'Sugar',
        'Chocolate Syrup',
      ],
      'serving': 'Serves 1',
      'calories': '250 kcal',
      'isPopular': false,
      'isNew': false,
    },
  ];

  List<Map<String, dynamic>> get _filteredItems {
    List<Map<String, dynamic>> items = List.from(menuItems);

    // Apply Veg/Non-Veg filter
    if (_selectedVegFilter == 'Veg') {
      items = items.where((item) => item['isVeg'] == true).toList();
    } else if (_selectedVegFilter == 'Non-Veg') {
      items = items.where((item) => item['isVeg'] == false).toList();
    }

    // Apply category filter
    if (_selectedCategory != 'All') {
      items = items
          .where((item) => item['category'] == _selectedCategory)
          .toList();
    }

    return items;
  }

  // Get quantity for an item
  int _getQuantity(String itemId) {
    return _quantities[itemId] ?? 0;
  }

  // Update quantity for an item
  void _updateQuantity(String itemId, int newQuantity) {
    setState(() {
      if (newQuantity <= 0) {
        _quantities.remove(itemId);
      } else {
        _quantities[itemId] = newQuantity;
      }
    });
  }

  // Get total items in cart
  int get _totalItemsInCart {
    return _quantities.values.fold(0, (sum, qty) => sum + qty);
  }

  // Get total price
  int get _totalPrice {
    int total = 0;
    _quantities.forEach((id, qty) {
      final item = menuItems.firstWhere((item) => item['id'] == id);
      final priceString = item['price'] as String;
      final price = int.parse(
        priceString.replaceAll('₹', '').replaceAll(',', ''),
      );
      total += price * qty;
    });
    return total;
  }

  @override
  Widget build(BuildContext context) {
    final filteredItems = _filteredItems;

    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      body: Stack(
        children: [
          Column(
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                color: Colors.white,
                child: SafeArea(
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [Colors.orange[400]!, Colors.orange[700]!],
                          ),
                          borderRadius: BorderRadius.circular(14),
                        ),
                        child: InkWell(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(left: 8.0),
                            child: const Icon(
                              Icons.arrow_back_ios,
                              color: Colors.white,
                              size: 24,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 14),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '${widget.storeName}',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w800,
                              color: Colors.grey[900],
                              letterSpacing: -0.5,
                            ),
                          ),
                          Row(
                            children: [
                              Text(
                                '4.2 Km',
                                style: TextStyle(
                                  color: Colors.green.shade700,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              const SizedBox(width: 4),
                              const Icon(
                                Icons.star_rounded,
                                color: Colors.amber,
                                size: 16,
                              ),
                              const SizedBox(width: 4),
                              Text(
                                '4.8',
                                style: TextStyle(
                                  color: Colors.grey.shade700,
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(width: 8),
                              Text(
                                '(245 reviews)',
                                style: TextStyle(
                                  color: Colors.grey.shade700,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      const Spacer(),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 3,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.green,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Text(
                          'OPEN',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              Expanded(
                child: CustomScrollView(
                  slivers: [
                    // App Bar
                    SliverAppBar(
                      expandedHeight: 160,
                      pinned: false,
                      elevation: 0,
                      backgroundColor: Colors.orange[700],
                      automaticallyImplyLeading: false,
                      flexibleSpace: FlexibleSpaceBar(
                        background: Image.network(
                          'https://images.unsplash.com/photo-1505253758473-96b7015fcd40?w=1200&h=400&fit=crop',
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return Container(
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                  colors: [
                                    Colors.orange[400]!,
                                    Colors.orange[700]!,
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),

                    SliverPersistentHeader(
                      pinned: true,
                      delegate: _StoreFilterDelegate(
                        // Argument 1: Filter Row
                        Padding(
                          padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
                          child: Row(
                            children: vegFilterOptions
                                .map((filter) => _buildVegFilterChip(filter))
                                .toList(),
                          ),
                        ),
                        // Argument 2: Category List
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: SizedBox(
                            height: 36,
                            child: ListView(
                              scrollDirection: Axis.horizontal,
                              children: categories
                                  .map(
                                    (category) => _buildCategoryChip(category),
                                  )
                                  .toList(),
                            ),
                          ),
                        ),
                      ),
                    ),

                    // Item Count
                    SliverToBoxAdapter(
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              '${filteredItems.length} items available',
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey.shade600,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            if (_totalItemsInCart > 0)
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 10,
                                  vertical: 4,
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.orange[700]!.withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(12),
                                  border: Border.all(
                                    color: Colors.orange[700]!.withOpacity(0.2),
                                  ),
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(
                                      Icons.shopping_cart,
                                      size: 14,
                                      color: Colors.orange[700],
                                    ),
                                    const SizedBox(width: 4),
                                    Text(
                                      '$_totalItemsInCart items',
                                      style: TextStyle(
                                        fontSize: 11,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.orange[700],
                                      ),
                                    ),
                                    const SizedBox(width: 4),
                                    Text(
                                      '· ₹$_totalPrice',
                                      style: TextStyle(
                                        fontSize: 11,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.green,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                          ],
                        ),
                      ),
                    ),

                    // Menu Grid
                    if (filteredItems.isEmpty)
                      SliverFillRemaining(
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.restaurant_menu_rounded,
                                size: 80,
                                color: Colors.grey.shade300,
                              ),
                              const SizedBox(height: 16),
                              Text(
                                'No items found',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey.shade600,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                'Try changing the filters',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey.shade400,
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                    else
                      SliverPadding(
                        padding: const EdgeInsets.all(12),
                        sliver: SliverGrid(
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                childAspectRatio: 0.8,
                                crossAxisSpacing: 10,
                                mainAxisSpacing: 10,
                              ),
                          delegate: SliverChildBuilderDelegate((
                            context,
                            index,
                          ) {
                            return _buildMenuItemCard(filteredItems[index]);
                          }, childCount: filteredItems.length),
                        ),
                      ),
                    const SliverPadding(padding: EdgeInsets.only(bottom: 100)),
                  ],
                ),
              ),
            ],
          ),

          // Bottom Cart Button - Shows when items in cart
          if (_totalItemsInCart > 0)
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.15),
                      blurRadius: 16,
                      offset: const Offset(0, -4),
                    ),
                  ],
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                ),
                child: Row(
                  children: [
                    // Cart Items Count
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.orange[700]!.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Icons.shopping_cart_rounded,
                            color: Colors.orange[700],
                            size: 20,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            '$_totalItemsInCart',
                            style: TextStyle(
                              color: Colors.orange[700],
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 12),
                    // Total Price
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Text(
                            'Total Amount',
                            style: TextStyle(fontSize: 11, color: Colors.grey),
                          ),
                          Text(
                            '₹$_totalPrice',
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.green,
                            ),
                          ),
                        ],
                      ),
                    ),
                    // View Cart Button
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => FoodCartScreen(),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.orange[700],
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 12,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                      ),
                      child: const Row(
                        children: [
                          Text(
                            'View Cart',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                            ),
                          ),
                          SizedBox(width: 4),
                          Icon(Icons.arrow_forward_rounded, size: 16),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildVegFilterChip(String filter) {
    final isSelected = _selectedVegFilter == filter;

    Color getChipColor() {
      if (filter == 'Veg') return Colors.green;
      if (filter == 'Non-Veg') return Colors.red;
      return Colors.orange[700]!;
    }

    IconData getIcon() {
      if (filter == 'Veg') return Icons.eco_rounded;
      if (filter == 'Non-Veg') return Icons.restaurant_rounded;
      return Icons.filter_alt_rounded;
    }

    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: GestureDetector(
        onTap: () {
          setState(() {
            _selectedVegFilter = filter;
          });
        },
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: isSelected ? getChipColor() : Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: isSelected ? getChipColor() : Colors.grey.shade300,
              width: 1.5,
            ),
            boxShadow: isSelected
                ? [
                    BoxShadow(
                      color: getChipColor().withOpacity(0.3),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ]
                : null,
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                getIcon(),
                size: 14,
                color: isSelected ? Colors.white : Colors.grey.shade600,
              ),
              const SizedBox(width: 4),
              Text(
                filter == 'All' ? 'All' : filter,
                style: TextStyle(
                  color: isSelected ? Colors.white : Colors.grey.shade700,
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                  fontSize: 11,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCategoryChip(String category) {
    final isSelected = _selectedCategory == category;

    return Padding(
      padding: const EdgeInsets.only(right: 6),
      child: GestureDetector(
        onTap: () {
          setState(() {
            _selectedCategory = category;
          });
        },
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
          decoration: BoxDecoration(
            color: isSelected ? Colors.orange[700] : Colors.white,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(
              color: isSelected ? Colors.orange[700]! : Colors.grey.shade300,
            ),
          ),
          child: Center(
            child: Text(
              category,
              style: TextStyle(
                color: isSelected ? Colors.white : Colors.grey.shade700,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                fontSize: 10,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildMenuItemCard(Map<String, dynamic> item) {
    final isVeg = item['isVeg'] as bool;
    final isPopular = item['isPopular'] as bool;
    final isNew = item['isNew'] as bool;
    final rating = item['rating'] as double;
    final price = item['price'] as String;
    final originalPrice = item['originalPrice'] as String;
    final offer = item['offer'] as String;
    final ingredients = item['ingredients'] as List;
    final spicyLevel = item['spicyLevel'] as String;
    final itemId = item['id'] as String;
    final quantity = _getQuantity(itemId);

    Color getSpicyColor() {
      if (spicyLevel == 'Mild') return Colors.green;
      if (spicyLevel == 'Medium') return Colors.orange;
      if (spicyLevel == 'Spicy') return Colors.red;
      return Colors.purple;
    }

    return Card(
      elevation: 0.2,
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image Section
          Expanded(
            child: Stack(
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(12),
                    topRight: Radius.circular(12),
                  ),
                  child: Image.network(
                    item['imageUrl'],

                    width: double.infinity,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              Colors.orange[700]!.withOpacity(0.2),
                              Colors.orange[700]!.withOpacity(0.05),
                            ],
                          ),
                        ),
                        child: Center(
                          child: Icon(
                            Icons.food_bank_rounded,
                            size: 40,
                            color: Colors.orange[700],
                          ),
                        ),
                      );
                    },
                  ),
                ),
                // Veg/Non-Veg indicator
                Positioned(
                  top: 6,
                  left: 6,
                  child: Container(
                    padding: const EdgeInsets.all(3),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                    child: Container(
                      width: 12,
                      height: 12,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: isVeg ? Colors.green : Colors.red,
                          width: 2,
                        ),
                        shape: BoxShape.circle,
                      ),
                      child: Center(
                        child: Container(
                          width: 5,
                          height: 5,
                          decoration: BoxDecoration(
                            color: isVeg ? Colors.green : Colors.red,
                            shape: BoxShape.circle,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                // Offer Badge
                Positioned(
                  top: 6,
                  right: 6,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 6,
                      vertical: 2,
                    ),
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [Colors.red, Colors.orange],
                      ),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      offer,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 8,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                // Popular/New Badge
                Positioned(
                  bottom: 6,
                  left: 6,
                  child: Row(
                    children: [
                      if (isPopular)
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 6,
                            vertical: 2,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.amber,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: const Text(
                            '⭐ Popular',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 7,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      if (isPopular && isNew) const SizedBox(width: 4),
                      if (isNew)
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 6,
                            vertical: 2,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.blue,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: const Text(
                            '🆕 New',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 7,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
                // Quantity Badge
                if (quantity > 0)
                  Positioned(
                    bottom: 6,
                    right: 6,
                    child: Container(
                      padding: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        color: Colors.orange[700],
                        shape: BoxShape.circle,
                      ),
                      child: Text(
                        '$quantity',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),

          // Content
          Padding(
            padding: const EdgeInsets.all(8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Title
                Text(
                  item['title'],
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF1E293B),
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 2),

                // Description
                Text(
                  item['description'],
                  style: TextStyle(fontSize: 9, color: Colors.grey.shade600),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),

                // Rating & Spicy Level
                Row(
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.star_rounded,
                          size: 10,
                          color: Colors.amber.shade600,
                        ),
                        const SizedBox(width: 2),
                        Text(
                          rating.toString(),
                          style: TextStyle(
                            fontSize: 9,
                            fontWeight: FontWeight.w600,
                            color: Colors.grey.shade700,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(width: 4),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 4,
                        vertical: 1,
                      ),
                      decoration: BoxDecoration(
                        color: getSpicyColor().withOpacity(0.1),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(
                        spicyLevel,
                        style: TextStyle(
                          fontSize: 7,
                          fontWeight: FontWeight.w600,
                          color: getSpicyColor(),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),

                // Ingredients
                Text(
                  '🧂 ${ingredients.take(3).join(', ')}${ingredients.length > 3 ? '...' : ''}',
                  style: TextStyle(fontSize: 8, color: Colors.grey.shade500),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),

                // Price
                Row(
                  children: [
                    Text(
                      price,
                      style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                        color: Colors.green,
                      ),
                    ),
                    const SizedBox(width: 4),
                    Text(
                      originalPrice,
                      style: TextStyle(
                        fontSize: 9,
                        decoration: TextDecoration.lineThrough,
                        color: Colors.grey.shade500,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),

                // Quantity Selector
                Row(
                  children: [
                    // Minus Button
                    GestureDetector(
                      onTap: () {
                        if (quantity > 0) {
                          _updateQuantity(itemId, quantity - 1);
                        }
                      },
                      child: Container(
                        padding: const EdgeInsets.all(3),
                        decoration: BoxDecoration(
                          color: quantity > 0
                              ? Colors.red.shade100
                              : Colors.grey.shade100,
                          borderRadius: BorderRadius.circular(6),
                          border: Border.all(
                            color: quantity > 0
                                ? Colors.red.shade300
                                : Colors.grey.shade300,
                          ),
                        ),
                        child: Icon(
                          Icons.remove,
                          size: 14,
                          color: quantity > 0
                              ? Colors.red.shade700
                              : Colors.grey.shade400,
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    // Quantity Display
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 6),
                      child: Text(
                        '$quantity',
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF1E293B),
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    // Plus Button
                    GestureDetector(
                      onTap: () {
                        _updateQuantity(itemId, quantity + 1);
                      },
                      child: Container(
                        padding: const EdgeInsets.all(3),
                        decoration: BoxDecoration(
                          color: Colors.green.shade100,
                          borderRadius: BorderRadius.circular(6),
                          border: Border.all(color: Colors.green.shade300),
                        ),
                        child: Icon(
                          Icons.add,
                          size: 14,
                          color: Colors.green.shade700,
                        ),
                      ),
                    ),
                    const Spacer(),
                    // Add to Cart Button
                    if (quantity == 0)
                      SizedBox(
                        height: 24,
                        child: ElevatedButton(
                          onPressed: () {
                            _updateQuantity(itemId, 1);
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.orange[700],
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            minimumSize: const Size(0, 24),
                          ),
                          child: const Text(
                            'Add',
                            style: TextStyle(
                              fontSize: 9,
                              fontWeight: FontWeight.bold,
                            ),
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
    );
  }
}

class _StoreFilterDelegate extends SliverPersistentHeaderDelegate {
  final Widget filterRow; // The Veg/Non-Veg row
  final Widget categoryList; // The Category horizontal list

  _StoreFilterDelegate(this.filterRow, this.categoryList);

  @override
  double get minExtent => 100; // Increased to fit both items + padding
  @override
  double get maxExtent => 100;

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    return Container(
      color: const Color(0xFFF8F9FA),
      // Use Column to stack them vertically
      child: Column(children: [filterRow, categoryList]),
    );
  }

  @override
  bool shouldRebuild(_StoreFilterDelegate oldDelegate) => true;
}
