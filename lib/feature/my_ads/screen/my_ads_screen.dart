import 'package:flutter/material.dart';

// ─────────────────────────────────────────────────────────────
// THEME COLORS (used everywhere)
// ─────────────────────────────────────────────────────────────
class AppColors {
  static const Color primary = Color(0xFF5F259F);
  static const Color primaryLight = Color(0xFF7C3AED);
  static const Color primaryTint = Color(0xFFF5F0FF);
  static const Color bg = Color(0xFFF8F9FA);
  static const Color cardBg = Colors.white;
  static const Color textMain = Color(0xFF1E293B);
  static const Color textSecondary = Color(0xFF64748B);
  static const Color border = Color(0xFFE2E8F0);
  static const Color inputFill = Color(0xFFF8FAFC);
}

// ─────────────────────────────────────────────────────────────
// AD MODEL
// ─────────────────────────────────────────────────────────────
class AdModel {
  final String id;
  final String title;
  final String location;
  final String price;
  final String status;
  final Color statusColor;
  final Color imageColor;
  final int views;
  final int inquiries;
  final String date;
  final String type;
  final int bedrooms;
  final int bathrooms;
  final String area;
  final String adCategory;
  final Map<String, dynamic> extra;

  const AdModel({
    required this.id,
    required this.title,
    required this.location,
    required this.price,
    required this.status,
    required this.statusColor,
    required this.imageColor,
    required this.views,
    required this.inquiries,
    required this.date,
    required this.type,
    required this.bedrooms,
    required this.bathrooms,
    required this.area,
    required this.adCategory,
    this.extra = const {},
  });
}

// ─────────────────────────────────────────────────────────────
// AD TAB MODEL
// ─────────────────────────────────────────────────────────────
class AdTabModel {
  final String key;
  final String label;
  final IconData icon;
  final Color color;
  final List<String> statuses;
  final List<AdModel> ads;
  final List<String> typeOptions;
  final List<FormFieldConfig> formFields;

  const AdTabModel({
    required this.key,
    required this.label,
    required this.icon,
    required this.color,
    required this.statuses,
    required this.ads,
    required this.typeOptions,
    required this.formFields,
  });
}

// ─────────────────────────────────────────────────────────────
// FORM FIELD CONFIG
// ─────────────────────────────────────────────────────────────
class FormFieldConfig {
  final String label;
  final String hint;
  final IconData icon;
  final bool required;
  final bool isNumeric;
  final bool isMultiline;
  final bool isDropdown;
  final List<String>? dropdownItems;

  const FormFieldConfig({
    required this.label,
    required this.hint,
    required this.icon,
    this.required = true,
    this.isNumeric = false,
    this.isMultiline = false,
    this.isDropdown = false,
    this.dropdownItems,
  });
}

// ─────────────────────────────────────────────────────────────
// CENTRAL DATA STORE (5 tabs only)
// ─────────────────────────────────────────────────────────────
class MyAdsDataStore {
  static const List<AdTabModel> tabs = [
    // ══════════ 1. RENT ══════════
    AdTabModel(
      key: 'rent',
      label: 'Rent',
      icon: Icons.home_work_rounded,
      color: AppColors.primary,
      statuses: ['All', 'Active', 'Pending', 'Booked', 'Expired'],
      typeOptions: [
        'Student Room',
        'Professional',
        'Family',
        'Bachelor',
        'PG & Hostel',
        'Daily Stay',
        'Exam Stay',
        'Temporary Stay',
        'Freelancer',
        'Premium',
      ],
      formFields: [
        FormFieldConfig(
            label: 'Property Title',
            hint: 'e.g. Cozy Studio Room',
            icon: Icons.title_rounded),
        FormFieldConfig(
            label: 'Location',
            hint: 'e.g. Downtown, Near University',
            icon: Icons.location_on_rounded),
        FormFieldConfig(
            label: 'Monthly Rent',
            hint: 'e.g. 500',
            icon: Icons.currency_rupee_rounded,
            isNumeric: true),
        FormFieldConfig(
            label: 'Deposit',
            hint: 'e.g. 1000',
            icon: Icons.savings_rounded,
            isNumeric: true,
            required: false),
        FormFieldConfig(
            label: 'Bedrooms',
            hint: 'e.g. 1',
            icon: Icons.bed_rounded,
            isNumeric: true),
        FormFieldConfig(
            label: 'Bathrooms',
            hint: 'e.g. 1',
            icon: Icons.bathtub_rounded,
            isNumeric: true),
        FormFieldConfig(
            label: 'Area',
            hint: 'e.g. 450 sq ft',
            icon: Icons.square_foot_rounded),
        FormFieldConfig(
            label: 'Furnishing',
            hint: 'Select',
            icon: Icons.chair_rounded,
            isDropdown: true,
            dropdownItems: [
              'Fully Furnished',
              'Semi Furnished',
              'Unfurnished'
            ]),
        FormFieldConfig(
            label: 'Available From',
            hint: 'e.g. 2024-02-01',
            icon: Icons.calendar_today_rounded,
            required: false),
        FormFieldConfig(
            label: 'Description',
            hint: 'Describe your property...',
            icon: Icons.description_rounded,
            isMultiline: true,
            required: false),
      ],
      ads: [
        AdModel(
          id: 'r1',
          title: 'Cozy Studio Room',
          location: 'Downtown, Near University',
          price: '₹500/month',
          status: 'Active',
          statusColor: Colors.green,
          imageColor: Colors.blue,
          views: 245,
          inquiries: 12,
          date: '2024-01-15',
          type: 'Student Room',
          bedrooms: 1,
          bathrooms: 1,
          area: '450 sq ft',
          adCategory: 'rent',
        ),
        AdModel(
          id: 'r2',
          title: 'Premium 2BHK Apartment',
          location: 'City Center, Near Metro',
          price: '₹1200/month',
          status: 'Booked',
          statusColor: Colors.orange,
          imageColor: Colors.green,
          views: 189,
          inquiries: 8,
          date: '2024-01-10',
          type: 'Professional',
          bedrooms: 2,
          bathrooms: 2,
          area: '950 sq ft',
          adCategory: 'rent',
        ),
        AdModel(
          id: 'r3',
          title: 'Daily Rental Room',
          location: 'Near Railway Station',
          price: '₹50/day',
          status: 'Pending',
          statusColor: Colors.blue,
          imageColor: Colors.orange,
          views: 67,
          inquiries: 3,
          date: '2024-01-12',
          type: 'Daily Stay',
          bedrooms: 1,
          bathrooms: 1,
          area: '350 sq ft',
          adCategory: 'rent',
        ),
        AdModel(
          id: 'r4',
          title: 'Family 3BHK Flat',
          location: 'Green Valley',
          price: '₹1800/month',
          status: 'Active',
          statusColor: Colors.green,
          imageColor: Colors.purple,
          views: 312,
          inquiries: 15,
          date: '2024-01-18',
          type: 'Family',
          bedrooms: 3,
          bathrooms: 2,
          area: '1500 sq ft',
          adCategory: 'rent',
        ),
        AdModel(
          id: 'r5',
          title: 'Bachelor PG Room',
          location: 'Near College Gate',
          price: '₹6000/month',
          status: 'Active',
          statusColor: Colors.green,
          imageColor: Colors.teal,
          views: 98,
          inquiries: 7,
          date: '2024-01-14',
          type: 'PG & Hostel',
          bedrooms: 1,
          bathrooms: 1,
          area: '300 sq ft',
          adCategory: 'rent',
        ),
      ],
    ),

    // ══════════ 2. FOOD ══════════
    AdTabModel(
      key: 'food',
      label: 'Food',
      icon: Icons.restaurant_rounded,
      color: Color(0xFFE65100),
      statuses: ['All', 'Active', 'Paused', 'Expired'],
      typeOptions: [
        'Grocery',
        'Bakery',
        'Snacks',
        'Beverages',
        'Cloud Kitchen',
        'Restaurant',
      ],
      formFields: [
        FormFieldConfig(
            label: 'Store Name',
            hint: 'e.g. Fresh Grocery Store',
            icon: Icons.store_rounded),
        FormFieldConfig(
            label: 'Location',
            hint: 'e.g. Main Market',
            icon: Icons.location_on_rounded),
        FormFieldConfig(
            label: 'Minimum Order',
            hint: 'e.g. 200',
            icon: Icons.currency_rupee_rounded,
            isNumeric: true),
        FormFieldConfig(
            label: 'Cuisine / Category',
            hint: 'e.g. North Indian',
            icon: Icons.restaurant_menu_rounded),
        FormFieldConfig(
            label: 'Delivery Time',
            hint: 'Select',
            icon: Icons.timer_rounded,
            isDropdown: true,
            dropdownItems: [
              '15-20 min',
              '20-30 min',
              '30-45 min',
              '45-60 min'
            ]),
        FormFieldConfig(
            label: 'Contact Number',
            hint: 'e.g. 9876543210',
            icon: Icons.phone_rounded,
            isNumeric: true),
        FormFieldConfig(
            label: 'Menu Highlights',
            hint: 'Describe popular items...',
            icon: Icons.description_rounded,
            isMultiline: true,
            required: false),
      ],
      ads: [
        AdModel(
          id: 'f1',
          title: 'Fresh Grocery Store',
          location: 'Main Market',
          price: '₹200/order',
          status: 'Active',
          statusColor: Colors.green,
          imageColor: Colors.green,
          views: 512,
          inquiries: 41,
          date: '2024-01-20',
          type: 'Grocery',
          bedrooms: 0,
          bathrooms: 0,
          area: 'Min Order',
          adCategory: 'food',
        ),
        AdModel(
          id: 'f2',
          title: 'Home Bakery',
          location: 'Civil Lines',
          price: '₹300/box',
          status: 'Active',
          statusColor: Colors.green,
          imageColor: Colors.amber,
          views: 387,
          inquiries: 29,
          date: '2024-01-18',
          type: 'Bakery',
          bedrooms: 0,
          bathrooms: 0,
          area: 'Per Box',
          adCategory: 'food',
        ),
        AdModel(
          id: 'f3',
          title: 'Snacks Corner',
          location: 'Sadar Bazaar',
          price: '₹150/200g',
          status: 'Paused',
          statusColor: Colors.orange,
          imageColor: Colors.orange,
          views: 221,
          inquiries: 16,
          date: '2024-01-15',
          type: 'Snacks',
          bedrooms: 0,
          bathrooms: 0,
          area: 'Per 200g',
          adCategory: 'food',
        ),
      ],
    ),

    // ══════════ 3. TRAVELS ══════════
    AdTabModel(
      key: 'travels',
      label: 'Travels',
      icon: Icons.directions_car_rounded,
      color: Color(0xFF0284C7),
      statuses: ['All', 'Active', 'Paused', 'Expired'],
      typeOptions: ['Cab', 'Auto', 'E-Rickshaw', 'Driver', 'Outstation'],
      formFields: [
        FormFieldConfig(
            label: 'Service Title',
            hint: 'e.g. Cab Service in Jabalpur',
            icon: Icons.title_rounded),
        FormFieldConfig(
            label: 'Pickup Location',
            hint: 'e.g. Jabalpur',
            icon: Icons.location_on_rounded),
        FormFieldConfig(
            label: 'Base Fare',
            hint: 'e.g. 350',
            icon: Icons.currency_rupee_rounded,
            isNumeric: true),
        FormFieldConfig(
            label: 'Per KM Rate',
            hint: 'e.g. 12',
            icon: Icons.speed_rounded,
            isNumeric: true,
            required: false),
        FormFieldConfig(
            label: 'Vehicle Type',
            hint: 'Select',
            icon: Icons.directions_car_rounded,
            isDropdown: true,
            dropdownItems: [
              'Sedan',
              'SUV',
              'Hatchback',
              'Auto',
              'E-Rickshaw'
            ]),
        FormFieldConfig(
            label: 'Availability',
            hint: 'Select',
            icon: Icons.schedule_rounded,
            isDropdown: true,
            dropdownItems: [
              '24/7',
              'Day Only',
              'Night Only',
              'Weekdays'
            ]),
        FormFieldConfig(
            label: 'Driver Name',
            hint: 'e.g. Rahul Kumar',
            icon: Icons.person_rounded),
        FormFieldConfig(
            label: 'Contact Number',
            hint: 'e.g. 9876543210',
            icon: Icons.phone_rounded,
            isNumeric: true),
      ],
      ads: [
        AdModel(
          id: 'tr1',
          title: 'City Cab Service',
          location: 'Jabalpur, MP',
          price: '₹12/km',
          status: 'Active',
          statusColor: Colors.green,
          imageColor: Colors.blue,
          views: 289,
          inquiries: 24,
          date: '2024-01-19',
          type: 'Cab',
          bedrooms: 0,
          bathrooms: 0,
          area: 'Sedan',
          adCategory: 'travels',
        ),
        AdModel(
          id: 'tr2',
          title: 'Auto Booking',
          location: 'Napier Town',
          price: '₹10/km',
          status: 'Active',
          statusColor: Colors.green,
          imageColor: Colors.amber,
          views: 198,
          inquiries: 16,
          date: '2024-01-15',
          type: 'Auto',
          bedrooms: 0,
          bathrooms: 0,
          area: 'Auto',
          adCategory: 'travels',
        ),
        AdModel(
          id: 'tr3',
          title: 'E-Rickshaw Service',
          location: 'Wright Town',
          price: '₹8/km',
          status: 'Paused',
          statusColor: Colors.orange,
          imageColor: Colors.green,
          views: 145,
          inquiries: 9,
          date: '2024-01-12',
          type: 'E-Rickshaw',
          bedrooms: 0,
          bathrooms: 0,
          area: 'E-Rickshaw',
          adCategory: 'travels',
        ),
      ],
    ),

    // ══════════ 4. BOOKS ══════════
    AdTabModel(
      key: 'books',
      label: 'Books',
      icon: Icons.menu_book_rounded,
      color: Color(0xFF10B981),
      statuses: ['All', 'Active', 'Sold', 'Donated'],
      typeOptions: ['Academic', 'Fiction', 'Comics', 'Novels', 'Competitive'],
      formFields: [
        FormFieldConfig(
            label: 'Book Title',
            hint: 'e.g. Concepts of Physics',
            icon: Icons.menu_book_rounded),
        FormFieldConfig(
            label: 'Author',
            hint: 'e.g. HC Verma',
            icon: Icons.person_rounded),
        FormFieldConfig(
            label: 'Price',
            hint: 'e.g. 250 (or 0 for donation)',
            icon: Icons.currency_rupee_rounded,
            isNumeric: true),
        FormFieldConfig(
            label: 'Edition',
            hint: 'e.g. 3rd Edition',
            icon: Icons.bookmark_rounded,
            required: false),
        FormFieldConfig(
            label: 'Condition',
            hint: 'Select',
            icon: Icons.star_rounded,
            isDropdown: true,
            dropdownItems: ['Like New', 'Excellent', 'Good', 'Used']),
        FormFieldConfig(
            label: 'Location',
            hint: 'e.g. Delhi',
            icon: Icons.location_on_rounded),
        FormFieldConfig(
            label: 'Contact',
            hint: 'e.g. 9876543210',
            icon: Icons.phone_rounded,
            isNumeric: true),
      ],
      ads: [
        AdModel(
          id: 'bk1',
          title: 'Concepts of Physics',
          location: 'Delhi',
          price: '₹250',
          status: 'Active',
          statusColor: Colors.green,
          imageColor: Colors.indigo,
          views: 245,
          inquiries: 18,
          date: '2024-01-20',
          type: 'Academic',
          bedrooms: 0,
          bathrooms: 0,
          area: 'Excellent',
          adCategory: 'books',
        ),
        AdModel(
          id: 'bk2',
          title: 'The Psychology of Money',
          location: 'Mumbai',
          price: '₹450',
          status: 'Active',
          statusColor: Colors.green,
          imageColor: Colors.teal,
          views: 189,
          inquiries: 14,
          date: '2024-01-18',
          type: 'Fiction',
          bedrooms: 0,
          bathrooms: 0,
          area: 'Like New',
          adCategory: 'books',
        ),
      ],
    ),

    // ══════════ 5. ACCESSORIES ══════════
    AdTabModel(
      key: 'accessories',
      label: 'Accessories',
      icon: Icons.watch_rounded,
      color: Color(0xFFF43F5E),
      statuses: ['All', 'Active', 'Sold', 'Donated'],
      typeOptions: [
        'Wearables',
        'Audio',
        'Chargers',
        'Photography',
        'Laptop',
        'Phone',
      ],
      formFields: [
        FormFieldConfig(
            label: 'Product Title',
            hint: 'e.g. Premium Leather Watch Band',
            icon: Icons.title_rounded),
        FormFieldConfig(
            label: 'Brand',
            hint: 'e.g. Apple',
            icon: Icons.branding_watermark_rounded),
        FormFieldConfig(
            label: 'Price',
            hint: 'e.g. 2499',
            icon: Icons.currency_rupee_rounded,
            isNumeric: true),
        FormFieldConfig(
            label: 'Condition',
            hint: 'Select',
            icon: Icons.star_rounded,
            isDropdown: true,
            dropdownItems: ['Like New', 'Excellent', 'Good', 'Used']),
        FormFieldConfig(
            label: 'Location',
            hint: 'e.g. Delhi',
            icon: Icons.location_on_rounded),
        FormFieldConfig(
            label: 'Description',
            hint: 'Describe the product...',
            icon: Icons.description_rounded,
            isMultiline: true,
            required: false),
        FormFieldConfig(
            label: 'Contact Number',
            hint: 'e.g. 9876543210',
            icon: Icons.phone_rounded,
            isNumeric: true),
      ],
      ads: [
        AdModel(
          id: 'ac1',
          title: 'Premium Leather Watch Band',
          location: 'Delhi',
          price: '₹2,499',
          status: 'Active',
          statusColor: Colors.green,
          imageColor: Colors.brown,
          views: 178,
          inquiries: 12,
          date: '2024-01-18',
          type: 'Wearables',
          bedrooms: 0,
          bathrooms: 0,
          area: 'Excellent',
          adCategory: 'accessories',
        ),
        AdModel(
          id: 'ac2',
          title: 'Wireless Bluetooth Earbuds',
          location: 'Mumbai',
          price: '₹1,899',
          status: 'Active',
          statusColor: Colors.green,
          imageColor: Colors.blueGrey,
          views: 320,
          inquiries: 25,
          date: '2024-01-15',
          type: 'Audio',
          bedrooms: 0,
          bathrooms: 0,
          area: 'Like New',
          adCategory: 'accessories',
        ),
      ],
    ),
  ];

  static AdTabModel getTab(String key) =>
      tabs.firstWhere((t) => t.key == key);
}

// ─────────────────────────────────────────────────────────────
// MY ADS SCREEN
// ─────────────────────────────────────────────────────────────
class MyAdsScreen extends StatefulWidget {
  const MyAdsScreen({super.key});

  @override
  State<MyAdsScreen> createState() => _MyAdsScreenState();
}

class _MyAdsScreenState extends State<MyAdsScreen> {
  int _selectedTabIndex = 0;
  String _selectedFilter = 'All';

  AdTabModel get _currentTab => MyAdsDataStore.tabs[_selectedTabIndex];

  List<AdModel> get _currentAds {
    final ads = _currentTab.ads;
    if (_selectedFilter == 'All') return ads;
    return ads.where((ad) => ad.status == _selectedFilter).toList();
  }

  int get _totalCount => _currentTab.ads.length;

  int get _totalAllCount =>
      MyAdsDataStore.tabs.fold(0, (sum, tab) => sum + tab.ads.length);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          // ══════════ HEADER ══════════
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [AppColors.primary, AppColors.primaryLight],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              boxShadow: [
                BoxShadow(
                  color: AppColors.primary.withOpacity(0.3),
                  blurRadius: 15,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: SafeArea(
              bottom: false,
              child: Row(
                children: [
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white.withOpacity(0.2),
                      border: Border.all(color: Colors.white, width: 1.5),
                    ),
                    child: const Center(
                      child: Icon(
                        Icons.post_add_rounded,
                        color: Colors.white,
                        size: 22,
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'My Ads',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        'Manage all your listings',
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.white70,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                  const Spacer(),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.list_alt_rounded,
                          color: Colors.white,
                          size: 18,
                        ),
                        const SizedBox(width: 6),
                        Text(
                          '$_totalAllCount',
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          // ══════════ CATEGORY TILES ══════════
          Container(
            color: Colors.white,
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            child: SizedBox(
              height: 70,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: MyAdsDataStore.tabs.length,
                itemBuilder: (context, index) {
                  final tab = MyAdsDataStore.tabs[index];
                  final isSelected = _selectedTabIndex == index;
                  return Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child: _buildCategoryTile(tab, isSelected, index),
                  );
                },
              ),
            ),
          ),

          // ══════════ CONTENT AREA ══════════
          Expanded(
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(28),
                  topRight: Radius.circular(28),
                ),
              ),
              child: Column(
                children: [
                  Center(
                    child: Container(
                      width: 44,
                      height: 5,
                      margin: const EdgeInsets.only(top: 10, bottom: 6),
                      decoration: BoxDecoration(
                        color: const Color(0xFFCBD5E1),
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
                    child: Row(
                      children: [
                        Icon(
                          _currentTab.icon,
                          color: AppColors.primary,
                          size: 20,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          '${_currentTab.label} Ads',
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            color: AppColors.textMain,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 2,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.primary.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            '$_totalCount',
                            style: const TextStyle(
                              fontSize: 11,
                              color: AppColors.primary,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        const Spacer(),
                        Text(
                          '${_currentAds.length} shown',
                          style: const TextStyle(
                            fontSize: 11,
                            color: AppColors.textSecondary,
                          ),
                        ),
                      ],
                    ),
                  ),

                  SizedBox(
                    height: 40,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      itemCount: _currentTab.statuses.length,
                      itemBuilder: (context, index) {
                        final label = _currentTab.statuses[index];
                        return Padding(
                          padding: const EdgeInsets.only(right: 8),
                          child: _buildFilterChip(label),
                        );
                      },
                    ),
                  ),

                  const SizedBox(height: 12),

                  Expanded(
                    child: _currentAds.isEmpty
                        ? _buildEmptyState()
                        : ListView.separated(
                      padding:
                      const EdgeInsets.fromLTRB(10, 4, 10, 100),
                      itemCount: _currentAds.length,
                      separatorBuilder: (_, __) =>
                      const SizedBox(height: 10),
                      itemBuilder: (context, index) =>
                          _buildAdCard(_currentAds[index]),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: Container(
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [AppColors.primary, AppColors.primaryLight],
          ),
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: AppColors.primary.withOpacity(0.4),
              blurRadius: 16,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: FloatingActionButton(
          onPressed: () => _openCreateAdPage(),
          backgroundColor: Colors.transparent,
          elevation: 0,
          child: const Icon(Icons.add_rounded, color: Colors.white, size: 26),
        ),
      ),
    );
  }

  Future<void> _openCreateAdPage() async {
    final result = await Navigator.push<bool>(
      context,
      MaterialPageRoute(
        builder: (_) => CreateAdScreen(initialTabIndex: _selectedTabIndex),
      ),
    );

    if (result == true && mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Row(
            children: [
              Icon(Icons.check_circle_rounded, color: Colors.white),
              SizedBox(width: 10),
              Expanded(child: Text('Ad created successfully!')),
            ],
          ),
          backgroundColor: Colors.green,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          margin: const EdgeInsets.all(16),
        ),
      );
    }
  }

  // ══════════ CATEGORY TILE ══════════
  Widget _buildCategoryTile(AdTabModel tab, bool isSelected, int index) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedTabIndex = index;
          _selectedFilter = 'All';
        });
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        width: 80,
        decoration: BoxDecoration(
          color: isSelected
              ? AppColors.primary.withOpacity(0.08)
              : Colors.white,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: isSelected ? AppColors.primary : AppColors.border,
            width: isSelected ? 1.5 : 1.2,
          ),
          boxShadow: isSelected
              ? [
            BoxShadow(
              color: AppColors.primary.withOpacity(0.15),
              blurRadius: 8,
              offset: const Offset(0, 3),
            ),
          ]
              : [
            BoxShadow(
              color: Colors.black.withOpacity(0.03),
              blurRadius: 6,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: isSelected
                    ? AppColors.primary.withOpacity(0.15)
                    : Colors.grey.shade100,
                shape: BoxShape.circle,
              ),
              child: Icon(
                tab.icon,
                color: isSelected ? AppColors.primary : Colors.grey.shade600,
                size: 22,
              ),
            ),
            const SizedBox(height: 6),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [

                Text(
                  '${tab.ads.length}',
                  style: TextStyle(
                    fontSize: 9,
                    fontWeight: FontWeight.w600,
                    color: isSelected
                        ? AppColors.primary.withOpacity(0.7)
                        : Colors.grey.shade900,
                  ),
                ),
                const SizedBox(width: 6),
                Text(
                  tab.label,
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                    color: isSelected ? AppColors.primary : Colors.grey.shade900,
                  ),
                  textAlign: TextAlign.center,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),

              ],
            )
          ],
        ),
      ),
    );
  }

  Widget _buildFilterChip(String label) {
    final isSelected = _selectedFilter == label;
    return GestureDetector(
      onTap: () {
        setState(() => _selectedFilter = label);
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
        decoration: BoxDecoration(
          gradient: isSelected
              ? const LinearGradient(
            colors: [AppColors.primary, AppColors.primaryLight],
          )
              : null,
          color: isSelected ? null : Colors.grey.shade100,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected ? AppColors.primary : AppColors.border,
            width: 1.2,
          ),
        ),
        child: Center(
          child: Text(
            label,
            style: TextStyle(
              color: isSelected ? Colors.white : Colors.black87,
              fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
              fontSize: 12,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: AppColors.primary.withOpacity(0.08),
              shape: BoxShape.circle,
            ),
            child: Icon(
              _currentTab.icon,
              size: 60,
              color: AppColors.primary.withOpacity(0.4),
            ),
          ),
          const SizedBox(height: 20),
          Text(
            'No ${_selectedFilter != 'All' ? _selectedFilter : ''} ${_currentTab.label} Ads',
            style: const TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.bold,
              color: AppColors.textMain,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Create your first ${_currentTab.label.toLowerCase()} ad now',
            style: const TextStyle(
              fontSize: 13,
              color: AppColors.textSecondary,
            ),
          ),
          const SizedBox(height: 22),
          ElevatedButton.icon(
            onPressed: () => _openCreateAdPage(),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              foregroundColor: Colors.white,
              padding:
              const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              elevation: 2,
            ),
            icon: const Icon(Icons.add_rounded, size: 18),
            label: Text(
              'Create ${_currentTab.label} Ad',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAdCard(AdModel ad) {
    final statusColor = ad.statusColor;
    final isSold = ad.status == 'Sold' || ad.status == 'Expired';

    return Container(
      decoration: BoxDecoration(
        color: isSold ? Colors.grey.shade50 : Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
        border: Border.all(
          color: isSold ? Colors.grey.shade200 : AppColors.border,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        AppColors.primary.withOpacity(0.15),
                        AppColors.primary.withOpacity(0.04),
                      ],
                    ),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Center(
                    child: Icon(
                      _iconForType(ad.type),
                      size: 30,
                      color: AppColors.primary,
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        ad.title,
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: isSold
                              ? Colors.grey.shade600
                              : AppColors.textMain,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 3),
                      Row(
                        children: [
                          Icon(
                            Icons.location_on_rounded,
                            size: 12,
                            color: Colors.grey.shade500,
                          ),
                          const SizedBox(width: 3),
                          Expanded(
                            child: Text(
                              ad.location,
                              style: TextStyle(
                                fontSize: 11,
                                color: Colors.grey.shade600,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 5),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 3,
                        ),
                        decoration: BoxDecoration(
                          color: statusColor.withOpacity(0.12),
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                            color: statusColor.withOpacity(0.3),
                          ),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                              width: 5,
                              height: 5,
                              decoration: BoxDecoration(
                                color: statusColor,
                                shape: BoxShape.circle,
                              ),
                            ),
                            const SizedBox(width: 5),
                            Text(
                              ad.status,
                              style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.w600,
                                color: statusColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            const SizedBox(height: 10),

            Wrap(
              spacing: 6,
              runSpacing: 6,
              children: [
                _buildDetailChip(
                  Icons.currency_rupee_rounded,
                  ad.price,
                  isPrimary: true,
                  isSold: isSold,
                ),
                if (ad.bedrooms > 0)
                  _buildDetailChip(
                    Icons.bed_rounded,
                    '${ad.bedrooms} BHK',
                  ),
                if (ad.bathrooms > 0)
                  _buildDetailChip(
                    Icons.bathtub_rounded,
                    '${ad.bathrooms} Bath',
                  ),
                if (ad.area.isNotEmpty && ad.area != '0')
                  _buildDetailChip(
                    _areaIconForTab(ad.adCategory),
                    ad.area,
                  ),
                _buildDetailChip(_iconForType(ad.type), ad.type),
              ],
            ),

            const SizedBox(height: 10),

            Row(
              children: [
                _buildStatPill(Icons.visibility_rounded, '${ad.views}'),
                const SizedBox(width: 8),
                _buildStatPill(Icons.people_rounded, '${ad.inquiries}'),
                const SizedBox(width: 8),
                _buildStatPill(Icons.calendar_today_rounded, ad.date),
                const Spacer(),
                _buildActionButton(
                  Icons.edit_rounded,
                  AppColors.primary,
                  isSold,
                      () {},
                ),
                const SizedBox(width: 6),
                _buildActionButton(
                  Icons.delete_rounded,
                  Colors.red,
                  isSold,
                      () {},
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailChip(
      IconData icon,
      String label, {
        bool isPrimary = false,
        bool isSold = false,
      }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: isPrimary
            ? (isSold
            ? Colors.grey.shade200
            : AppColors.primary.withOpacity(0.08))
            : Colors.grey.shade100,
        borderRadius: BorderRadius.circular(8),
        border: isPrimary
            ? Border.all(
          color: isSold
              ? Colors.grey.shade300
              : AppColors.primary.withOpacity(0.25),
        )
            : null,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            size: 12,
            color: isPrimary
                ? (isSold ? Colors.grey.shade500 : AppColors.primary)
                : Colors.grey.shade600,
          ),
          const SizedBox(width: 4),
          Text(
            label,
            style: TextStyle(
              fontSize: 10,
              fontWeight: isPrimary ? FontWeight.bold : FontWeight.w500,
              color: isPrimary
                  ? (isSold ? Colors.grey.shade500 : AppColors.primary)
                  : Colors.grey.shade700,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatPill(IconData icon, String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        borderRadius: BorderRadius.circular(6),
      ),
      child: Row(
        children: [
          Icon(icon, size: 12, color: Colors.grey.shade500),
          const SizedBox(width: 3),
          Text(
            label,
            style: TextStyle(
              fontSize: 10,
              color: Colors.grey.shade600,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButton(
      IconData icon,
      Color color,
      bool disabled,
      VoidCallback onTap,
      ) {
    return GestureDetector(
      onTap: disabled ? null : onTap,
      child: Container(
        padding: const EdgeInsets.all(7),
        decoration: BoxDecoration(
          color: disabled ? Colors.grey.shade100 : color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(9),
        ),
        child: Icon(
          icon,
          size: 15,
          color: disabled ? Colors.grey.shade400 : color,
        ),
      ),
    );
  }

  IconData _iconForType(String type) {
    switch (type) {
      case 'Commercial':
      case 'Office':
      case 'Shop':
        return Icons.storefront_rounded;
      case 'Land':
      case 'Plot':
        return Icons.terrain_rounded;
      case 'Villa':
        return Icons.villa_rounded;
      case 'Warehouse':
        return Icons.warehouse_rounded;
      case 'House':
      case 'Apartment':
        return Icons.home_work_rounded;
      case 'Veg Tiffin':
        return Icons.rice_bowl_rounded;
      case 'Non-Veg Tiffin':
        return Icons.set_meal_rounded;
      case 'Student Tiffin':
        return Icons.school_rounded;
      case 'Diet Tiffin':
        return Icons.eco_rounded;
      case 'Wash & Fold':
      case 'Wash & Iron':
        return Icons.local_laundry_service_rounded;
      case 'Dry Clean':
        return Icons.dry_cleaning_rounded;
      case 'Express':
        return Icons.flash_on_rounded;
      case 'Grocery':
        return Icons.shopping_basket_rounded;
      case 'Bakery':
        return Icons.cake_rounded;
      case 'Snacks':
        return Icons.cookie_rounded;
      case 'Beverages':
        return Icons.local_drink_rounded;
      case 'Cab':
        return Icons.local_taxi_rounded;
      case 'Auto':
        return Icons.electric_rickshaw_rounded;
      case 'Driver':
        return Icons.person_pin_circle_rounded;
      case 'Wearables':
        return Icons.watch_rounded;
      case 'Audio':
        return Icons.headphones_rounded;
      case 'Chargers':
        return Icons.battery_charging_full_rounded;
      case 'App Development':
        return Icons.phone_android_rounded;
      case 'Web Development':
        return Icons.web_rounded;
      case 'Academic':
      case 'Fiction':
      case 'Comics':
      case 'Novels':
      case 'Competitive':
        return Icons.menu_book_rounded;
      default:
        return Icons.home_work_rounded;
    }
  }

  IconData _areaIconForTab(String adCategory) {
    switch (adCategory) {
      case 'tiffin':
      case 'food':
      case 'travels':
      case 'tech':
        return Icons.schedule_rounded;
      case 'laundry':
        return Icons.scale_rounded;
      case 'books':
      case 'accessories':
        return Icons.star_rounded;
      default:
        return Icons.square_foot_rounded;
    }
  }
}

// ═════════════════════════════════════════════════════════════
// CREATE AD SCREEN
// ═════════════════════════════════════════════════════════════
class CreateAdScreen extends StatefulWidget {
  final int initialTabIndex;

  const CreateAdScreen({
    super.key,
    this.initialTabIndex = 0,
  });

  @override
  State<CreateAdScreen> createState() => _CreateAdScreenState();
}

class _CreateAdScreenState extends State<CreateAdScreen> {
  final _formKey = GlobalKey<FormState>();

  late int _selectedTabIndex;
  late String _selectedAdType;

  final Map<String, TextEditingController> _controllers = {};
  final Map<String, String?> _dropdownValues = {};

  AdTabModel get _currentTab => MyAdsDataStore.tabs[_selectedTabIndex];

  @override
  void initState() {
    super.initState();
    _selectedTabIndex = widget.initialTabIndex;
    _selectedAdType = _currentTab.typeOptions.first;
    _buildControllersForTab(_selectedTabIndex);
  }

  void _buildControllersForTab(int index) {
    for (final c in _controllers.values) {
      c.dispose();
    }
    _controllers.clear();
    _dropdownValues.clear();

    for (final field in MyAdsDataStore.tabs[index].formFields) {
      _controllers[field.label] = TextEditingController();
      if (field.isDropdown) {
        _dropdownValues[field.label] = field.dropdownItems?.first;
      }
    }
  }

  @override
  void dispose() {
    for (final c in _controllers.values) {
      c.dispose();
    }
    super.dispose();
  }

  void _switchTab(int index) {
    setState(() {
      _selectedTabIndex = index;
      _selectedAdType = MyAdsDataStore.tabs[index].typeOptions.first;
      _buildControllersForTab(index);
    });
  }

  void _submit() {
    if (!_formKey.currentState!.validate()) return;
    Navigator.pop(context, true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          // ══════════ HEADER ══════════
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 12),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [AppColors.primary, AppColors.primaryLight],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              boxShadow: [
                BoxShadow(
                  color: AppColors.primary.withOpacity(0.3),
                  blurRadius: 15,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: SafeArea(
              bottom: false,
              child: Row(
                children: [
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(
                      Icons.arrow_back_ios_new_rounded,
                      color: Colors.white,
                      size: 20,
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Icon(
                      _currentTab.icon,
                      color: Colors.white,
                      size: 22,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Create New Ad',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            letterSpacing: -0.3,
                          ),
                        ),
                        Text(
                          'Category: ${_currentTab.label}',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.white.withOpacity(0.9),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          // ══════════ CATEGORY TAB SWITCHER ══════════
          Container(
            color: Colors.white,
            padding: const EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 10,
            ),
            child: Column(
              spacing: 10,
              children: [
                SizedBox(
                  height: 36,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: MyAdsDataStore.tabs.length,
                    itemBuilder: (context, index) {
                      final tab = MyAdsDataStore.tabs[index];
                      final isSel = _selectedTabIndex == index;
                      return Padding(
                        padding: const EdgeInsets.only(right: 6),
                        child: GestureDetector(
                          onTap: () => _switchTab(index),
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 14,
                              vertical: 6,
                            ),
                            decoration: BoxDecoration(
                              gradient: isSel
                                  ? const LinearGradient(
                                colors: [
                                  AppColors.primary,
                                  AppColors.primaryLight
                                ],
                              )
                                  : null,
                              color: isSel ? null : AppColors.primaryTint,
                              borderRadius: BorderRadius.circular(18),
                              border: Border.all(
                                color: isSel
                                    ? AppColors.primary
                                    : AppColors.primary.withOpacity(0.15),
                              ),
                            ),
                            child: Center(
                              child: Text(
                                tab.label,
                                style: TextStyle(
                                  fontSize: 11.5,
                                  color:
                                  isSel ? Colors.white : AppColors.primary,
                                  fontWeight: isSel
                                      ? FontWeight.bold
                                      : FontWeight.w600,
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                Divider(color: Colors.grey,thickness: 0.3,),
                Row(
                  children: [
                    Container(
                      width: 4,
                      height: 16,
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [
                            AppColors.primary,
                            AppColors.primaryLight
                          ],
                        ),
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                    const SizedBox(width: 8),
                    const Text(
                      'Ad Details',
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                        color: AppColors.textMain,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // ══════════ FORM BODY ══════════
          Expanded(
            child: Container(
              margin: const EdgeInsets.symmetric(
                horizontal: 10,
                vertical: 10,
              ),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: AppColors.border),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.03),
                    blurRadius: 10,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Form(
                key: _formKey,
                child: SingleChildScrollView(
                  padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).viewInsets.bottom + 20,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                      const SizedBox(height: 14),

                      // Ad Type dropdown
                      _buildFieldDropdown(
                        label: 'Ad Type',
                        icon: Icons.category_rounded,
                        value: _selectedAdType,
                        items: _currentTab.typeOptions,
                        onChanged: (v) {
                          setState(() => _selectedAdType = v!);
                        },
                      ),
                      const SizedBox(height: 12),

                      // Dynamic fields
                      ..._currentTab.formFields.map((field) {
                        if (field.isDropdown) {
                          _dropdownValues[field.label] ??=
                              field.dropdownItems?.first;
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 12),
                            child: _buildFieldDropdown(
                              label: field.label,
                              icon: field.icon,
                              value: _dropdownValues[field.label] ??
                                  field.dropdownItems!.first,
                              items: field.dropdownItems!,
                              onChanged: (v) {
                                setState(() {
                                  _dropdownValues[field.label] = v;
                                });
                              },
                            ),
                          );
                        }
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 12),
                          child: _buildTextField(
                            controller: _controllers[field.label]!,
                            label: field.label,
                            hint: field.hint,
                            icon: field.icon,
                            isNumeric: field.isNumeric,
                            isMultiline: field.isMultiline,
                            required: field.required,
                          ),
                        );
                      }).toList(),
                    ],
                  ),
                ),
              ),
            ),
          ),

          // ══════════ SUBMIT BUTTONS ══════════
          Padding(
            padding: const EdgeInsets.fromLTRB(12, 0, 12, 30),
            child: Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => Navigator.pop(context),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: AppColors.textSecondary,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      side: const BorderSide(
                        color: AppColors.border,
                        width: 1.2,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text(
                      'Cancel',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  flex: 2,
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [
                          AppColors.primary,
                          AppColors.primaryLight
                        ],
                      ),
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.primary.withOpacity(0.4),
                          blurRadius: 12,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: ElevatedButton(
                      onPressed: _submit,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.transparent,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        elevation: 0,
                        shadowColor: Colors.transparent,
                      ),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.check_rounded,
                            color: Colors.white,
                            size: 18,
                          ),
                          SizedBox(width: 6),
                          Text(
                            'Create Ad',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
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

  // ══════════ TEXT FIELD (label on top-left) ══════════
  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required String hint,
    required IconData icon,
    bool isNumeric = false,
    bool isMultiline = false,
    bool required = true,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // ── Label on top-left ──
        Padding(
          padding: const EdgeInsets.only(left: 4, bottom: 6),
          child: Row(
            children: [
              Text(
                required ? '$label *' : label,
                style: const TextStyle(
                  fontSize: 12.5,
                  fontWeight: FontWeight.w600,
                  color: AppColors.primary,
                ),
              ),
            ],
          ),
        ),

        // ── Input field (no floating label) ──
        TextFormField(
          controller: controller,
          keyboardType: isNumeric
              ? TextInputType.number
              : isMultiline
              ? TextInputType.multiline
              : TextInputType.text,
          maxLines: isMultiline ? 3 : 1,
          style: const TextStyle(
            fontSize: 13.5,
            color: AppColors.textMain,
            fontWeight: FontWeight.w500,
          ),
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: TextStyle(
              fontSize: 12.5,
              color: AppColors.textSecondary.withOpacity(0.6),
              fontWeight: FontWeight.w400,
            ),
            filled: true,
            fillColor: AppColors.inputFill,

            // ✅ Icon only for non-multiline fields
            prefixIcon:
            isMultiline ? null : Icon(icon, color: AppColors.primary, size: 19),
            prefixIconConstraints:
            isMultiline ? null : const BoxConstraints(minWidth: 44),

            contentPadding: EdgeInsets.symmetric(
              horizontal: 14,
              vertical: isMultiline ? 12 : 14,
            ),

            // No floating label — label is above
            floatingLabelBehavior: FloatingLabelBehavior.never,

            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: AppColors.border, width: 1.2),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: AppColors.border, width: 1.2),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(
                color: AppColors.primary,
                width: 1.6,
              ),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Colors.red, width: 1.2),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Colors.red, width: 1.6),
            ),
          ),
          validator: (value) {
            if (required && (value == null || value.trim().isEmpty)) {
              return 'Please enter $label';
            }
            return null;
          },
        ),
      ],
    );
  }

  // ══════════ DROPDOWN FIELD ══════════
  Widget _buildFieldDropdown({
    required String label,
    required IconData icon,
    required String value,
    required List<String> items,
    required ValueChanged<String?> onChanged,
  }) {
    return DropdownButtonFormField<String>(
      value: value,
      isExpanded: true,
      dropdownColor: Colors.white,
      icon: const Icon(
        Icons.keyboard_arrow_down_rounded,
        color: AppColors.primary,
      ),
      style: const TextStyle(
        fontSize: 13.5,
        color: AppColors.textMain,
        fontWeight: FontWeight.w500,
      ),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(
          color: AppColors.primary,
          fontWeight: FontWeight.w600,
          fontSize: 12.5,
        ),
        floatingLabelStyle: const TextStyle(
          color: AppColors.primary,
          fontWeight: FontWeight.w600,
          fontSize: 12.5,
        ),
        filled: true,
        fillColor: AppColors.inputFill,
        prefixIcon: Icon(icon, color: AppColors.primary, size: 19),
        prefixIconConstraints: const BoxConstraints(minWidth: 44),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 14,
          vertical: 12,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.border, width: 1.2),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.border, width: 1.2),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(
            color: AppColors.primary,
            width: 1.6,
          ),
        ),
      ),
      items: items
          .map(
            (t) => DropdownMenuItem<String>(
          value: t,
          child: Text(
            t,
            style: const TextStyle(
              fontSize: 13.5,
              color: AppColors.textMain,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      )
          .toList(),
      onChanged: onChanged,
    );
  }
}