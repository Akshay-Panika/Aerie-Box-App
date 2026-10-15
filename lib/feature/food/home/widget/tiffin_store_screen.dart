import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TiffinStoreScreen extends StatefulWidget {
  final String storeName;
  const TiffinStoreScreen({super.key, required this.storeName});

  @override
  State<TiffinStoreScreen> createState() => _TiffinStoreScreenState();
}

class _TiffinStoreScreenState extends State<TiffinStoreScreen> {
  String _selectedVegFilter = 'All';
  DateTime _selectedDate = DateTime.now();

  // Fixed weekly menu (same every week)
  final Map<String, Map<String, dynamic>> weeklyMenu = {
    'Monday': {
      'veg': {
        'items': [
          '🍛 Dal Tadka',
          '🍚 Jeera Rice',
          '🥘 Mix Veg',
          '🫓 Roti',
          '🥗 Salad',
        ],
        'price': 120,
      },
      'nonVeg': {
        'items': [
          '🍗 Chicken Curry',
          '🍚 Jeera Rice',
          '🍛 Dal Tadka',
          '🫓 Roti',
          '🥗 Salad',
        ],
        'price': 180,
      },
      'special': '🌟 Butter Chicken',
    },
    'Tuesday': {
      'veg': {
        'items': [
          '🧀 Paneer Masala',
          '🍚 Steam Rice',
          '🍛 Dal Fry',
          '🫓 Butter Naan',
          '🥗 Salad',
        ],
        'price': 140,
      },
      'nonVeg': {
        'items': [
          '🥩 Mutton Curry',
          '🍚 Steam Rice',
          '🍛 Dal Fry',
          '🧄 Garlic Naan',
          '🥗 Salad',
        ],
        'price': 210,
      },
      'special': '🌟 Mutton Rogan Josh',
    },
    'Wednesday': {
      'veg': {
        'items': [
          '🫘 Chole',
          '🍞 Bhature',
          '🥔 Aloo Sabji',
          '🍚 Rice',
          '🥛 Lassi',
        ],
        'price': 130,
      },
      'nonVeg': {
        'items': [
          '🥚 Egg Curry',
          '🍞 Bhature',
          '🫘 Chole',
          '🍚 Rice',
          '🥛 Mint Raita',
        ],
        'price': 170,
      },
      'special': '🌟 Chole Bhature',
    },
    'Thursday': {
      'veg': {
        'items': [
          '🥞 Masala Dosa',
          '🍲 Sambhar',
          '🥥 Chutney',
          '🍥 Idli',
          '☕ Coffee',
        ],
        'price': 110,
      },
      'nonVeg': {
        'items': [
          '🐔 Chicken Chettinad',
          '🍚 Rice',
          '🍛 Dal',
          '🫓 Roti',
          '🥗 Salad',
        ],
        'price': 190,
      },
      'special': '🌟 Chettinad Chicken',
    },
    'Friday': {
      'veg': {
        'items': [
          '🍲 Kadhi Pakora',
          '🍚 Jeera Rice',
          '🌿 Bhindi Sabji',
          '🫓 Roti',
          '🥭 Pickle',
        ],
        'price': 115,
      },
      'nonVeg': {
        'items': [
          '🐟 Fish Curry',
          '🍚 Rice',
          '🍛 Dal',
          '🫓 Roti',
          '🍋 Lemon Rice',
        ],
        'price': 200,
      },
      'special': '🌟 Fish Curry',
    },
    'Saturday': {
      'veg': {
        'items': [
          '🍚 Veg Pulao',
          '🥛 Raita',
          '🧀 Paneer Tikka',
          '🍡 Gulab Jamun',
          '🥤 Drink',
        ],
        'price': 150,
      },
      'nonVeg': {
        'items': [
          '🍗 Chicken Biryani',
          '🥛 Raita',
          '🍗 Chicken Tikka',
          '🍡 Gulab Jamun',
          '🥤 Cool Drink',
        ],
        'price': 230,
      },
      'special': '🌟 Chicken Biryani',
    },
    'Sunday': {
      'veg': {
        'items': [
          '🍱 Special Thali',
          '🍛 Dal',
          '🥘 Mix Veg',
          '🍚 Rice',
          '🫓 Roti',
          '🍮 Kheer',
        ],
        'price': 160,
      },
      'nonVeg': {
        'items': [
          '🍱 Special Thali',
          '🍗 Chicken Curry',
          '🍛 Dal',
          '🍚 Rice',
          '🫓 Roti',
          '🍮 Kheer',
        ],
        'price': 250,
      },
      'special': '🌟 Grand Thali',
    },
  };

  final List<String> vegFilterOptions = ['All', 'Veg', 'Non-Veg'];
  final List<String> planOptions = ['Weekly', 'Monthly'];

  // Get day of week for selected date
  String get _selectedDayName {
    return DateFormat('EEEE').format(_selectedDate);
  }

  // Check if selected day has menu
  bool get _hasMenuForSelectedDay {
    return weeklyMenu.containsKey(_selectedDayName);
  }

  // Get menu for selected day
  Map<String, dynamic>? get _selectedDayMenu {
    return weeklyMenu[_selectedDayName];
  }

  // Get filtered days for display (only the selected day)
  List<Map<String, dynamic>> get _filteredDays {
    if (!_hasMenuForSelectedDay) return [];

    return [
      {'day': _selectedDayName, 'data': _selectedDayMenu},
    ];
  }

  // Get current week dates (Monday to Sunday)
  List<DateTime> get _currentWeekDays {
    DateTime now = DateTime.now();
    DateTime monday = now.subtract(Duration(days: now.weekday - 1));
    return List.generate(7, (index) => monday.add(Duration(days: index)));
  }

  // Navigate to previous/next week
  void _navigateWeek(int offset) {
    setState(() {
      _selectedDate = _selectedDate.add(Duration(days: offset * 7));
    });
  }

  @override
  Widget build(BuildContext context) {
    final filteredDays = _filteredDays;
    final String selectedDayName = _selectedDayName;
    final String formattedDate = DateFormat('d MMM yyyy').format(_selectedDate);

    // Get week range for display
    DateTime weekStart = _selectedDate.subtract(
      Duration(days: _selectedDate.weekday - 1),
    );
    DateTime weekEnd = weekStart.add(Duration(days: 6));
    String weekRange =
        '${DateFormat('d MMM').format(weekStart)} - ${DateFormat('d MMM yyyy').format(weekEnd)}';

    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      body: Column(
        children: [
          // Top App Bar
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
                // Banner
                SliverAppBar(
                  expandedHeight: 180,
                  floating: false,
                  pinned: false,
                  elevation: 0,
                  backgroundColor: Colors.orange[700],
                  automaticallyImplyLeading: false,
                  flexibleSpace: FlexibleSpaceBar(
                    background: Stack(
                      fit: StackFit.expand,
                      children: [
                        Image.network(
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
                      ],
                    ),
                  ),
                ),

                // Weekly Calendar
                SliverToBoxAdapter(child: _buildWeeklyCalendar(weekRange)),

                // Selected Date Info
                SliverToBoxAdapter(
                  child: Container(
                    margin: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          Colors.orange[400]!.withOpacity(0.1),
                          Colors.orange[700]!.withOpacity(0.1),
                        ],
                      ),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: Colors.orange[400]!.withOpacity(0.3),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            const Icon(
                              Icons.calendar_today,
                              color: Colors.orange,
                              size: 18,
                            ),
                            const SizedBox(width: 8),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  selectedDayName,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14,
                                  ),
                                ),
                                Text(
                                  formattedDate,
                                  style: TextStyle(
                                    color: Colors.grey[600],
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: _hasMenuForSelectedDay
                                ? Colors.green
                                : Colors.red,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            _hasMenuForSelectedDay
                                ? 'Menu Available'
                                : 'Closed',
                            style: const TextStyle(
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

                // Veg/Non-Veg Filter
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
                    child: Row(
                      children: vegFilterOptions.map((filter) {
                        return _buildVegFilterChip(filter);
                      }).toList(),
                    ),
                  ),
                ),

                // Menu Cards
                if (filteredDays.isEmpty || !_hasMenuForSelectedDay)
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
                            'No menu available',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.grey.shade600,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'The tiffin center is closed on ${selectedDayName}s',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey.shade400,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Please select another day',
                            style: TextStyle(
                              fontSize: 13,
                              color: Colors.grey.shade400,
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                else
                  SliverPadding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                    sliver: SliverList(
                      delegate: SliverChildBuilderDelegate((context, index) {
                        final dayData = filteredDays[index];
                        final day = dayData['day'] as String;
                        final data = dayData['data'] as Map<String, dynamic>;

                        bool showVeg = _selectedVegFilter != 'Non-Veg';
                        bool showNonVeg = _selectedVegFilter != 'Veg';

                        List<Widget> menuWidgets = [];

                        if (showVeg && data['veg'] != null) {
                          menuWidgets.add(
                            _buildMealCard(
                              day: day,
                              type: 'Veg 🌿',
                              items: data['veg']['items'],
                              price: data['veg']['price'],
                              special: data['special'],
                              isVeg: true,
                            ),
                          );
                        }

                        if (showNonVeg && data['nonVeg'] != null) {
                          menuWidgets.add(
                            _buildMealCard(
                              day: day,
                              type: 'Non-Veg 🍖',
                              items: data['nonVeg']['items'],
                              price: data['nonVeg']['price'],
                              special: data['special'],
                              isVeg: false,
                            ),
                          );
                        }

                        return Column(children: menuWidgets);
                      }, childCount: filteredDays.length),
                    ),
                  ),
                const SliverPadding(padding: EdgeInsets.only(bottom: 80)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildWeeklyCalendar(String weekRange) {
    List<DateTime> weekDays = _currentWeekDays;

    // Find which week the selected date is in
    DateTime selectedWeekStart = _selectedDate.subtract(
      Duration(days: _selectedDate.weekday - 1),
    );
    DateTime currentWeekStart = DateTime.now().subtract(
      Duration(days: DateTime.now().weekday - 1),
    );

    // If selected date is in a different week, update weekDays
    if (selectedWeekStart.difference(currentWeekStart).inDays.abs() >= 7) {
      weekDays = List.generate(
        7,
        (index) => selectedWeekStart.add(Duration(days: index)),
      );
    }

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.08),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          // Week Navigation
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                onPressed: () => _navigateWeek(-1),
                icon: Icon(Icons.chevron_left, color: Colors.orange[700]),
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(),
              ),
              Text(
                weekRange,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey[800],
                ),
              ),
              IconButton(
                onPressed: () => _navigateWeek(1),
                icon: Icon(Icons.chevron_right, color: Colors.orange[700]),
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(),
              ),
            ],
          ),
          const SizedBox(height: 8),

          // Day Headers with Dates
          Row(
            children: ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'].map((
              day,
            ) {
              return Expanded(
                child: Center(
                  child: Column(
                    children: [
                      Text(
                        day,
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                          color: Colors.grey[500],
                        ),
                      ),
                      const SizedBox(height: 2),
                      // Show date numbers
                      Text(
                        weekDays[[
                              'Mon',
                              'Tue',
                              'Wed',
                              'Thu',
                              'Fri',
                              'Sat',
                              'Sun',
                            ].indexOf(day)]
                            .day
                            .toString(),
                        style: TextStyle(fontSize: 10, color: Colors.grey[400]),
                      ),
                    ],
                  ),
                ),
              );
            }).toList(),
          ),
          const SizedBox(height: 8),

          // Day Selector Grid
          Row(
            children: weekDays.asMap().entries.map((entry) {
              int index = entry.key;
              DateTime date = entry.value;
              bool isSelected =
                  date.year == _selectedDate.year &&
                  date.month == _selectedDate.month &&
                  date.day == _selectedDate.day;
              bool isToday =
                  date.year == DateTime.now().year &&
                  date.month == DateTime.now().month &&
                  date.day == DateTime.now().day;

              // Check if this day has a menu
              String dayName = DateFormat('EEEE').format(date);
              bool hasMenu = weeklyMenu.containsKey(dayName);

              return Expanded(
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      _selectedDate = date;
                    });
                  },
                  child: Container(
                    margin: const EdgeInsets.all(2),
                    height: 50,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: isSelected
                          ? Colors.orange[700]
                          : (isToday && !isSelected
                                ? Colors.orange[100]
                                : Colors.transparent),
                      border: isToday && !isSelected
                          ? Border.all(color: Colors.orange[400]!, width: 1.5)
                          : null,
                    ),
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              [
                                'Mon',
                                'Tue',
                                'Wed',
                                'Thu',
                                'Fri',
                                'Sat',
                                'Sun',
                              ][index],
                              style: TextStyle(
                                fontSize: 10,
                                fontWeight: isSelected
                                    ? FontWeight.bold
                                    : FontWeight.normal,
                                color: isSelected
                                    ? Colors.white
                                    : (isToday
                                          ? Colors.orange[700]
                                          : Colors.grey[600]),
                              ),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              date.day.toString(),
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: isSelected
                                    ? FontWeight.bold
                                    : FontWeight.normal,
                                color: isSelected
                                    ? Colors.white
                                    : (isToday
                                          ? Colors.orange[700]
                                          : Colors.grey[700]),
                              ),
                            ),
                            if (hasMenu)
                              Container(
                                width: 4,
                                height: 4,
                                margin: const EdgeInsets.only(top: 2),
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: isSelected
                                      ? Colors.white
                                      : Colors.green,
                                ),
                              ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildVegFilterChip(String filter) {
    final isSelected = _selectedVegFilter == filter;

    Map<String, dynamic> filterData = {
      'All': {
        'icon': Icons.filter_alt_rounded,
        'color': Colors.orange[700],
        'label': 'All',
      },
      'Veg': {
        'icon': Icons.eco_rounded,
        'color': Colors.green,
        'label': '🌿 Veg',
      },
      'Non-Veg': {
        'icon': Icons.restaurant_rounded,
        'color': Colors.red,
        'label': '🍖 Non-Veg',
      },
    };

    final data = filterData[filter]!;

    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: GestureDetector(
        onTap: () {
          setState(() {
            _selectedVegFilter = filter;
          });
        },
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
          decoration: BoxDecoration(
            color: isSelected ? data['color'] : Colors.white,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: isSelected ? data['color'] : Colors.grey.shade300,
              width: 1.5,
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                data['icon'],
                size: 16,
                color: isSelected ? Colors.white : Colors.grey.shade600,
              ),
              const SizedBox(width: 6),
              Text(
                data['label'],
                style: TextStyle(
                  color: isSelected ? Colors.white : Colors.grey.shade700,
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMealCard({
    required String day,
    required String type,
    required List<String> items,
    required int price,
    required String special,
    required bool isVeg,
  }) {
    int weeklyPrice = price * 6;
    int monthlyPrice = price * 26;

    Color typeColor = isVeg ? Colors.green : Colors.red;

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: typeColor.withOpacity(0.2), width: 1),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.06),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          // Header
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            decoration: BoxDecoration(
              color: typeColor.withOpacity(0.08),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(16),
                topRight: Radius.circular(16),
              ),
            ),
            child: Row(
              children: [
                Container(
                  width: 10,
                  height: 10,
                  decoration: BoxDecoration(
                    color: typeColor,
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    '$day - $type',
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF1E293B),
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 3,
                  ),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Colors.amber.shade400, Colors.amber.shade600],
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    special,
                    style: TextStyle(
                      fontSize: 9,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Items
          Padding(
            padding: const EdgeInsets.all(12),
            child: Wrap(
              spacing: 6,
              runSpacing: 6,
              children: items.map((item) {
                return Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 3,
                  ),
                  decoration: BoxDecoration(
                    color: typeColor.withOpacity(0.05),
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: typeColor.withOpacity(0.15)),
                  ),
                  child: Text(
                    item,
                    style: TextStyle(fontSize: 11, color: Colors.grey.shade700),
                  ),
                );
              }).toList(),
            ),
          ),

          // Pricing & Actions
          Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildPriceChip('₹$price/day', Colors.green),
                    const SizedBox(width: 6),
                    _buildPriceChip('₹$weeklyPrice/week', Colors.blue),
                    const SizedBox(width: 6),
                    _buildPriceChip('₹$monthlyPrice/month', Colors.purple),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Expanded(
                      child: _buildActionButton(
                        '🛒 Order',
                        Colors.orange[700]!,
                        () {
                          final dayData = weeklyMenu[day];
                          _showDialog(
                            context,
                            '$day - Menu',
                            dayData!['veg']['price'],
                            dayData['nonVeg']['price'],
                          );
                        },
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

  Widget _buildPriceChip(String text, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: color.withOpacity(0.2)),
      ),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 10,
          fontWeight: FontWeight.bold,
          color: color,
        ),
      ),
    );
  }

  Widget _buildActionButton(String label, Color color, VoidCallback onTap) {
    return ElevatedButton(
      onPressed: onTap,
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(vertical: 10),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        elevation: 1,
        textStyle: const TextStyle(fontSize: 13, fontWeight: FontWeight.w700),
        minimumSize: const Size(0, 36),
      ),
      child: Text(label),
    );
  }

  void _showDialog(
    BuildContext context,
    String day,
    int vegPrice,
    int nonVegPrice,
  ) {
    showDialog(
      context: context,
      builder: (context) {
        String selectedPlan = 'Weekly';
        bool isVeg = true;

        return StatefulBuilder(
          builder: (context, setDialogState) {
            int basePrice = isVeg ? vegPrice : nonVegPrice;
            int multiplier = selectedPlan == 'Weekly' ? 6 : 26;
            int total = basePrice * multiplier;

            return AlertDialog(
              insetPadding: const EdgeInsets.symmetric(horizontal: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              contentPadding: EdgeInsets.zero,
              title: const Text(
                'Order Details',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              content: SizedBox(
                width: MediaQuery.of(context).size.width,
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        day,
                        style: TextStyle(
                          color: Colors.grey.shade600,
                          fontSize: 13,
                        ),
                      ),
                      const SizedBox(height: 16),

                      Row(
                        children: [
                          Expanded(
                            child: _buildTypeOption(
                              'Veg 🌿',
                              true,
                              isVeg,
                              () => setDialogState(() => isVeg = true),
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: _buildTypeOption(
                              'Non-Veg 🍖',
                              false,
                              isVeg,
                              () => setDialogState(() => isVeg = false),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),

                      Row(
                        children: [
                          Expanded(
                            child: _buildPlanOption(
                              'Weekly',
                              selectedPlan,
                              () =>
                                  setDialogState(() => selectedPlan = 'Weekly'),
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: _buildPlanOption(
                              'Monthly',
                              selectedPlan,
                              () => setDialogState(
                                () => selectedPlan = 'Monthly',
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),

                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.orange[700]!.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Total Amount:',
                              style: TextStyle(fontWeight: FontWeight.w600),
                            ),
                            Text(
                              '₹$total',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                                color: Colors.orange[700],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Cancel'),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange[700],
                  ),
                  onPressed: () => Navigator.pop(context),
                  child: const Text(
                    'Confirm Order',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }

  Widget _buildTypeOption(
    String label,
    bool value,
    bool isVeg,
    VoidCallback onTap,
  ) {
    bool isSelected = (isVeg == value);
    Color activeColor = value ? Colors.green : Colors.red;
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
          color: isSelected ? activeColor : Colors.grey.shade200,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Center(
          child: Text(
            label,
            style: TextStyle(
              color: isSelected ? Colors.white : Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPlanOption(
    String plan,
    String selectedPlan,
    VoidCallback onTap,
  ) {
    bool isSelected = plan == selectedPlan;
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
          color: isSelected ? Colors.orange[700] : Colors.grey.shade200,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Center(
          child: Text(
            plan,
            style: TextStyle(
              color: isSelected ? Colors.white : Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
