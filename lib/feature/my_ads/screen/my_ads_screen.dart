import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:rent_hub/core/utils/app_media_query.dart';
import 'dart:io';
import 'dart:convert';
import '../../../core/utils/app_color.dart';

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
// CENTRAL DATA STORE (only Rent tab)
// ─────────────────────────────────────────────────────────────
class MyAdsDataStore {
  static const List<AdTabModel> tabs = [
    // ══════════ 1. RENT ══════════
    AdTabModel(
      key: 'rent',
      label: 'Rent',
      icon: Icons.home_work_rounded,
      color: AppColor.primary,
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
  String _selectedFilter = 'All';

  AdTabModel get _currentTab => MyAdsDataStore.tabs.first;

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
      backgroundColor: AppColor.white,
      body: Column(
        children: [
          // ══════════ HEADER ══════════
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [AppColor.primary, AppColor.secondary],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
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
                      color: AppColor.white.withOpacity(0.2),
                      border:
                      Border.all(color: AppColor.white, width: 1.5),
                    ),
                    child: const Center(
                      child: Icon(
                        Icons.post_add_rounded,
                        color: AppColor.white,
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
                          color: AppColor.white,
                        ),
                      ),
                      Text(
                        'Manage all your listings',
                        style: TextStyle(
                          fontSize: 12,
                          color: AppColor.white,
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
                      color: AppColor.white.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.list_alt_rounded,
                          color: AppColor.white,
                          size: 18,
                        ),
                        const SizedBox(width: 6),
                        Text(
                          '$_totalAllCount',
                          style: const TextStyle(
                            color: AppColor.white,
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

          // ══════════ CONTENT AREA ══════════
          Expanded(
            child: Container(
              decoration: const BoxDecoration(color: AppColor.white),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
                    child: Row(
                      children: [
                        Icon(
                          _currentTab.icon,
                          color: AppColor.primary,
                          size: 20,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          '${_currentTab.label} Ads',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            color: AppColor.primary,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 2,
                          ),
                          decoration: BoxDecoration(
                            color: AppColor.primary.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            '$_totalCount',
                            style: const TextStyle(
                              fontSize: 11,
                              color: AppColor.primary,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        const Spacer(),
                        Text(
                          '${_currentAds.length} shown',
                          style: TextStyle(
                            fontSize: 11,
                            color: AppColor.subtitleBlack,
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
                      const EdgeInsets.fromLTRB(10, 4, 10, 180),
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
        margin: const EdgeInsets.only(bottom: 70),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [AppColor.primary, AppColor.primary],
          ),
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: AppColor.primary.withOpacity(0.4),
              blurRadius: 16,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: FloatingActionButton.small(
          onPressed: () => _openCreateAdPage(),
          backgroundColor: Colors.transparent,
          elevation: 0,
          child: const Icon(Icons.add_rounded,
              color: AppColor.white, size: 26),
        ),
      ),
    );
  }

  Future<void> _openCreateAdPage() async {
    final result = await Navigator.push<bool>(
      context,
      MaterialPageRoute(builder: (_) => const CreateAdScreen()),
    );

    if (result == true && mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Row(
            children: [
              Icon(Icons.check_circle_rounded, color: AppColor.white),
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
          color: isSelected ? AppColor.primary : AppColor.background.withOpacity(0.4),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected ? AppColor.primary : AppColor.border,
            width: 1.2,
          ),
        ),
        child: Center(
          child: Text(
            label,
            style: TextStyle(
              color: isSelected ? AppColor.white : AppColor.black,
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
              color: AppColor.primary.withOpacity(0.08),
              shape: BoxShape.circle,
            ),
            child: Icon(
              _currentTab.icon,
              size: 60,
              color: AppColor.primary.withOpacity(0.4),
            ),
          ),
          const SizedBox(height: 20),
          Text(
            'No ${_selectedFilter != 'All' ? _selectedFilter : ''} ${_currentTab.label} Ads',
            style: const TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.bold,
              color: AppColor.black,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Create your first ${_currentTab.label.toLowerCase()} ad now',
            style: TextStyle(
              fontSize: 13,
              color: AppColor.subtitleBlack,
            ),
          ),
          const SizedBox(height: 22),
          ElevatedButton.icon(
            onPressed: () => _openCreateAdPage(),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColor.primary,
              foregroundColor: AppColor.white,
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
        color: isSold
            ? AppColor.background.withOpacity(0.3)
            : AppColor.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: AppColor.black.withOpacity(0.04),
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
        border: Border.all(
          color: isSold
              ? AppColor.border.withOpacity(0.5)
              : AppColor.border,
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
                    color: AppColor.secondary.withOpacity(0.06),
                    border: Border.all(color: AppColor.primary, width: 0.3),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Center(
                    child: Icon(
                      _iconForType(ad.type),
                      size: 30,
                      color: AppColor.primary,
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
                              ? AppColor.subtitleBlack
                              : AppColor.black,
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
                            color: AppColor.subtitleBlack,
                          ),
                          const SizedBox(width: 3),
                          Expanded(
                            child: Text(
                              ad.location,
                              style: TextStyle(
                                fontSize: 11,
                                color: AppColor.subtitleBlack,
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
                  AppColor.primary,
                  isSold,
                      () {},
                ),
                const SizedBox(width: 6),
                _buildActionButton(
                  Icons.delete_rounded,
                  AppColor.red,
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
            ? AppColor.background
            : AppColor.primary.withOpacity(0.08))
            : AppColor.background.withOpacity(0.4),
        borderRadius: BorderRadius.circular(8),
        border: isPrimary
            ? Border.all(
          color: isSold
              ? AppColor.border
              : AppColor.primary.withOpacity(0.25),
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
                ? (isSold ? AppColor.subtitleBlack : AppColor.primary)
                : AppColor.subtitleBlack,
          ),
          const SizedBox(width: 4),
          Text(
            label,
            style: TextStyle(
              fontSize: 10,
              fontWeight: isPrimary ? FontWeight.bold : FontWeight.w500,
              color: isPrimary
                  ? (isSold ? AppColor.subtitleBlack : AppColor.primary)
                  : AppColor.subtitleBlack,
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
        color: AppColor.background.withOpacity(0.4),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Row(
        children: [
          Icon(icon, size: 12, color: AppColor.subtitleBlack),
          const SizedBox(width: 3),
          Text(
            label,
            style: TextStyle(
              fontSize: 10,
              color: AppColor.subtitleBlack,
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
          color: disabled
              ? AppColor.background
              : color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(9),
        ),
        child: Icon(
          icon,
          size: 15,
          color: disabled ? AppColor.subtitleBlack : color,
        ),
      ),
    );
  }

  IconData _iconForType(String type) {
    switch (type) {
      case 'Student Room':
        return Icons.school_rounded;
      case 'Professional':
        return Icons.work_rounded;
      case 'Family':
        return Icons.family_restroom_rounded;
      case 'Bachelor':
        return Icons.person_rounded;
      case 'PG & Hostel':
        return Icons.hotel_rounded;
      case 'Daily Stay':
        return Icons.today_rounded;
      case 'Exam Stay':
        return Icons.menu_book_rounded;
      case 'Temporary Stay':
        return Icons.timer_rounded;
      case 'Freelancer':
        return Icons.laptop_rounded;
      case 'Premium':
        return Icons.star_rounded;
      default:
        return Icons.home_work_rounded;
    }
  }

  IconData _areaIconForTab(String adCategory) {
    switch (adCategory) {
      case 'rent':
        return Icons.square_foot_rounded;
      default:
        return Icons.square_foot_rounded;
    }
  }
}

// ─────────────────────────────────────────────────────────────
// CREATE AD SCREEN  (DB-aligned)
// ─────────────────────────────────────────────────────────────
class CreateAdScreen extends StatefulWidget {
  const CreateAdScreen({super.key});

  @override
  State<CreateAdScreen> createState() => _CreateAdScreenState();
}

class _CreateAdScreenState extends State<CreateAdScreen> {
  final _formKey = GlobalKey<FormState>();

  // ── Text controllers ──
  final _titleCtrl = TextEditingController();
  final _descriptionCtrl = TextEditingController();
  final _nearCollageCtrl = TextEditingController();
  final _addressCtrl = TextEditingController();
  final _roomRentCtrl = TextEditingController();
  final _nearbyInputCtrl = TextEditingController();

  // ── Dropdowns ──
  String _roomType = '1bhk';

  // ── Dynamic data ──
  final List<String> _nearbyPlaces = [];
  final Map<String, bool> _inStock = {
    'wifi': false,
    'ac': false,
    'tv': false,
    'kitchen': false,
    'parking': false,
    'security': false,
    'gym': false,
    'swimming_pool': false,
    'garden': false,
    'elevator': false,
  };

  final List<File> _selectedImages = [];

  final List<String> _roomTypes = [
    '1bhk',
    '2bhk',
    '3bhk',
    '4bhk',
    'studio',
    'pg',
    'hostel',
    'single_room',
    'shared_room',
  ];

  @override
  void dispose() {
    _titleCtrl.dispose();
    _descriptionCtrl.dispose();
    _nearCollageCtrl.dispose();
    _addressCtrl.dispose();
    _roomRentCtrl.dispose();
    _nearbyInputCtrl.dispose();
    super.dispose();
  }

  Map<String, dynamic> _buildPayload() {
    return {
      'user_id': '2',
      'category_id': '2',
      'title': _titleCtrl.text.trim(),
      'room_type': _roomType,
      'description': _descriptionCtrl.text.trim(),
      'near_collage': _nearCollageCtrl.text.trim(),
      'address': _addressCtrl.text.trim(),
      'latitude': "28.613900",
      'longitude': "77.209000",
      'room_status': true,
      'room_rent': _roomRentCtrl.text.trim(),
      'nearby_places': jsonEncode(_nearbyPlaces),
      'in_stock': jsonEncode(_inStock),
      'images': _selectedImages.map((f) => f.path).toList(),
    };
  }

  void _submit() {
    if (!_formKey.currentState!.validate()) return;

    final payload = _buildPayload();
    debugPrint('PAYLOAD: $payload');

    Navigator.pop(context, true);
  }

  Future<void> _pickImages() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.image,
      allowMultiple: true,
    );
    if (result != null && result.files.isNotEmpty) {
      setState(() {
        _selectedImages.addAll(
          result.files
              .where((f) => f.path != null)
              .map((f) => File(f.path!))
              .toList(),
        );
      });
    }
  }

  void _removeImage(int i) => setState(() => _selectedImages.removeAt(i));

  void _addNearby() {
    final t = _nearbyInputCtrl.text.trim();
    if (t.isEmpty) return;
    setState(() {
      _nearbyPlaces.add(t);
      _nearbyInputCtrl.clear();
    });
  }

  void _removeNearby(int i) => setState(() => _nearbyPlaces.removeAt(i));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.white,
      body: Column(
        children: [
          // ══════════ HEADER ══════════
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 12),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [AppColor.primary, AppColor.secondary],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              boxShadow: [
                BoxShadow(
                  color: AppColor.primary.withOpacity(0.3),
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
                      color: AppColor.white,
                      size: 20,
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: AppColor.white.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Icon(
                      Icons.home_work_rounded,
                      color: AppColor.white,
                      size: 22,
                    ),
                  ),
                  const SizedBox(width: 12),
                  const Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Create New Ad',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: AppColor.white,
                            letterSpacing: -0.3,
                          ),
                        ),
                        Text(
                          'Category: Rent',
                          style: TextStyle(
                            fontSize: 12,
                            color: AppColor.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          // ══════════ FORM BODY ══════════
          Expanded(
            child: Container(
              color: AppColor.white,
              padding: const EdgeInsets.symmetric(
                horizontal: 10,
                vertical: 10,
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
                      const SizedBox(height: 6),

                      // ── IMAGES SECTION ──
                      Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: AppColor.white,
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(color: AppColor.border),
                          boxShadow: [
                            BoxShadow(
                              color: AppColor.black.withOpacity(0.03),
                              blurRadius: 10,
                              offset: const Offset(0, 3),
                            ),
                          ],
                        ),
                        child: Column(
                          children: [
                            _sectionLabel('Property Images',
                                Icons.photo_library_rounded),
                            const SizedBox(height: 8),
                            _buildImagePicker(),
                          ],
                        ),
                      ),
                      const SizedBox(height: 16),

                      Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: AppColor.white,
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(color: AppColor.border),
                          boxShadow: [
                            BoxShadow(
                              color: AppColor.black.withOpacity(0.03),
                              blurRadius: 10,
                              offset: const Offset(0, 3),
                            ),
                          ],
                        ),
                        child: Column(
                          children: [
                            _sectionLabel(
                                'Basic Info', Icons.info_outline_rounded),
                            const SizedBox(height: 8),

                            _buildTextField(
                              controller: _titleCtrl,
                              label: 'Title',
                              hint: 'e.g. 3BHK Room',
                              icon: Icons.title_rounded,
                            ),
                            const SizedBox(height: 12),

                            _buildDropdown(
                              label: 'Room Type',
                              icon: Icons.meeting_room_rounded,
                              value: _roomType,
                              items: _roomTypes,
                              onChanged: (v) =>
                                  setState(() => _roomType = v!),
                            ),
                            const SizedBox(height: 12),

                            _buildTextField(
                              controller: _descriptionCtrl,
                              label: 'Description',
                              hint: 'Its BHK Room',
                              icon: Icons.description_rounded,
                              isMultiline: true,
                              required: false,
                            ),
                            const SizedBox(height: 12),
                            _buildTextField(
                              controller: _roomRentCtrl,
                              label: 'Room Rent',
                              hint: 'e.g. 10000',
                              icon: Icons.currency_rupee_rounded,
                              isNumeric: true,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 16),

                      Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: AppColor.white,
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(color: AppColor.border),
                          boxShadow: [
                            BoxShadow(
                              color: AppColor.black.withOpacity(0.03),
                              blurRadius: 10,
                              offset: const Offset(0, 3),
                            ),
                          ],
                        ),
                        child: Column(
                          children: [
                            _sectionLabel(
                                'Location', Icons.location_on_rounded),
                            const SizedBox(height: 8),

                            _buildTextField(
                              controller: _nearCollageCtrl,
                              label: 'Near College',
                              hint: 'e.g. Test',
                              icon: Icons.school_rounded,
                              required: false,
                            ),
                            const SizedBox(height: 12),

                            _buildTextField(
                              controller: _addressCtrl,
                              label: 'Address',
                              hint: 'e.g. 123 MG Road, Delhi',
                              icon: Icons.home_rounded,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 16),

                      Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: AppColor.white,
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(color: AppColor.border),
                          boxShadow: [
                            BoxShadow(
                              color: AppColor.black.withOpacity(0.03),
                              blurRadius: 10,
                              offset: const Offset(0, 3),
                            ),
                          ],
                        ),
                        child: Column(
                          children: [
                            _sectionLabel(
                                'Nearby Places', Icons.place_rounded),
                            const SizedBox(height: 8),
                            _buildNearbyPlaces(),
                          ],
                        ),
                      ),
                      const SizedBox(height: 16),

                      Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: AppColor.white,
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(color: AppColor.border),
                          boxShadow: [
                            BoxShadow(
                              color: AppColor.black.withOpacity(0.03),
                              blurRadius: 10,
                              offset: const Offset(0, 3),
                            ),
                          ],
                        ),
                        child: Column(
                          children: [
                            _sectionLabel('In-Stock Amenities',
                                Icons.checklist_rounded),
                            const SizedBox(height: 8),
                            _buildInStockGrid(),
                          ],
                        ),
                      ),
                      const SizedBox(height: 16),
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
                      foregroundColor: AppColor.subtitleBlack,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      side: const BorderSide(
                        color: AppColor.border,
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
                        colors: [AppColor.primary, AppColor.secondary],
                      ),
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: AppColor.primary.withOpacity(0.4),
                          blurRadius: 12,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: ElevatedButton(
                      onPressed: _submit,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.transparent,
                        foregroundColor: AppColor.white,
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
                          Icon(Icons.check_rounded,
                              color: AppColor.white, size: 18),
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

  Widget _sectionLabel(String text, IconData icon) {
    return Row(
      children: [
        Container(
          width: 4,
          height: 16,
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [AppColor.primary, AppColor.secondary],
            ),
            borderRadius: BorderRadius.circular(2),
          ),
        ),
        const SizedBox(width: 8),
        Icon(icon, size: 15, color: AppColor.primary),
        const SizedBox(width: 6),
        Text(
          text,
          style: const TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.bold,
            color: AppColor.black,
          ),
        ),
      ],
    );
  }

  Widget _buildImagePicker() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 110,
          child: Row(
            spacing: 10,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: List.generate(_selectedImages.length + 1, (index) {
              if (index == _selectedImages.length) {
                return GestureDetector(
                  onTap: _pickImages,
                  child: Container(
                    width: _selectedImages.length == 0 ? 350 : 100,
                    height: 100,
                    decoration: BoxDecoration(
                      color: AppColor.primary.withOpacity(0.08),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: AppColor.primary.withOpacity(0.4),
                        width: 1.5,
                        style: BorderStyle.solid,
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.add_photo_alternate_rounded,
                            color: AppColor.primary, size: 26),
                        const SizedBox(height: 4),
                        Text(
                          'Add',
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w600,
                            color: AppColor.primary,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }
              return Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.file(
                      _selectedImages[index],
                      width: 100,
                      height: 100,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Positioned(
                    top: 4,
                    right: 4,
                    child: GestureDetector(
                      onTap: () => _removeImage(index),
                      child: Container(
                        padding: const EdgeInsets.all(3),
                        decoration: const BoxDecoration(
                          color: AppColor.red,
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(Icons.close_rounded,
                            color: AppColor.white, size: 14),
                      ),
                    ),
                  ),
                ],
              );
            }),
          ),
        ),
      ],
    );
  }

  Widget _buildNearbyPlaces() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: TextFormField(
                controller: _nearbyInputCtrl,
                style: const TextStyle(
                  fontSize: 13.5,
                  color: AppColor.black,
                  fontWeight: FontWeight.w500,
                ),
                decoration: InputDecoration(
                  hintText: 'e.g. metro station - 0.5km',
                  hintStyle: TextStyle(
                    fontSize: 12.5,
                    color: AppColor.subtitleBlack.withOpacity(0.6),
                  ),
                  filled: true,
                  fillColor: AppColor.background.withOpacity(0.4),
                  prefixIcon: const Icon(Icons.place_rounded,
                      color: AppColor.primary, size: 19),
                  prefixIconConstraints:
                  const BoxConstraints(minWidth: 44),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 14,
                    vertical: 14,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide:
                    const BorderSide(color: AppColor.border, width: 1.2),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide:
                    const BorderSide(color: AppColor.border, width: 1.2),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(
                      color: AppColor.primary,
                      width: 1.6,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 8),
            GestureDetector(
              onTap: _addNearby,
              child: Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [AppColor.primary, AppColor.secondary],
                  ),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(Icons.add_rounded,
                    color: AppColor.white, size: 20),
              ),
            ),
          ],
        ),
        if (_nearbyPlaces.isNotEmpty) ...[
          const SizedBox(height: 10),
          Wrap(
            spacing: 6,
            runSpacing: 6,
            children: List.generate(_nearbyPlaces.length, (i) {
              return Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: AppColor.primary.withOpacity(0.08),
                  borderRadius: BorderRadius.circular(10),
                  border:
                  Border.all(color: AppColor.primary.withOpacity(0.3)),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.place_rounded,
                        size: 13, color: AppColor.primary),
                    const SizedBox(width: 4),
                    Text(
                      _nearbyPlaces[i],
                      style: TextStyle(
                        fontSize: 11.5,
                        color: AppColor.primary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(width: 6),
                    GestureDetector(
                      onTap: () => _removeNearby(i),
                      child: Icon(Icons.close_rounded,
                          size: 14, color: AppColor.primary),
                    ),
                  ],
                ),
              );
            }),
          ),
        ],
      ],
    );
  }

  Widget _buildInStockGrid() {
    final keys = _inStock.keys.toList();
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: keys.map((key) {
        final isOn = _inStock[key] ?? false;
        return GestureDetector(
          onTap: () => setState(() => _inStock[key] = !isOn),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 180),
            padding: const EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 8,
            ),
            decoration: BoxDecoration(
              color: isOn
                  ? AppColor.primary.withOpacity(0.1)
                  : AppColor.background.withOpacity(0.4),
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: isOn ? AppColor.primary : AppColor.border,
                width: isOn ? 1.4 : 1.2,
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  _iconForAmenity(key),
                  size: 15,
                  color: isOn ? AppColor.primary : AppColor.subtitleBlack,
                ),
                const SizedBox(width: 6),
                Text(
                  _amenityLabel(key),
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight:
                    isOn ? FontWeight.bold : FontWeight.w500,
                    color:
                    isOn ? AppColor.primary : AppColor.subtitleBlack,
                  ),
                ),
                const SizedBox(width: 4),
                Icon(
                  isOn
                      ? Icons.check_circle_rounded
                      : Icons.radio_button_unchecked_rounded,
                  size: 14,
                  color: isOn
                      ? AppColor.primary
                      : AppColor.subtitleBlack,
                ),
              ],
            ),
          ),
        );
      }).toList(),
    );
  }

  IconData _iconForAmenity(String key) {
    switch (key) {
      case 'wifi':
        return Icons.wifi_rounded;
      case 'ac':
        return Icons.ac_unit_rounded;
      case 'tv':
        return Icons.tv_rounded;
      case 'kitchen':
        return Icons.kitchen_rounded;
      case 'parking':
        return Icons.local_parking_rounded;
      case 'security':
        return Icons.security_rounded;
      case 'gym':
        return Icons.fitness_center_rounded;
      case 'swimming_pool':
        return Icons.pool_rounded;
      case 'garden':
        return Icons.grass_rounded;
      case 'elevator':
        return Icons.elevator_rounded;
      default:
        return Icons.check_circle_rounded;
    }
  }

  String _amenityLabel(String key) {
    switch (key) {
      case 'wifi':
        return 'WiFi';
      case 'ac':
        return 'AC';
      case 'tv':
        return 'TV';
      case 'kitchen':
        return 'Kitchen';
      case 'parking':
        return 'Parking';
      case 'security':
        return 'Security';
      case 'gym':
        return 'Gym';
      case 'swimming_pool':
        return 'Pool';
      case 'garden':
        return 'Garden';
      case 'elevator':
        return 'Elevator';
      default:
        return key;
    }
  }

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
        Padding(
          padding: const EdgeInsets.only(left: 4, bottom: 6),
          child: Text(
            required ? '$label *' : label,
            style: const TextStyle(
              fontSize: 12.5,
              fontWeight: FontWeight.w600,
              color: AppColor.primary,
            ),
          ),
        ),
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
            color: AppColor.black,
            fontWeight: FontWeight.w500,
          ),
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: TextStyle(
              fontSize: 12.5,
              color: AppColor.subtitleBlack.withOpacity(0.6),
              fontWeight: FontWeight.w400,
            ),
            filled: true,
            fillColor: AppColor.background.withOpacity(0.4),
            prefixIcon: isMultiline
                ? null
                : Icon(icon, color: AppColor.primary, size: 19),
            prefixIconConstraints:
            isMultiline ? null : const BoxConstraints(minWidth: 44),
            contentPadding: EdgeInsets.symmetric(
              horizontal: 14,
              vertical: isMultiline ? 12 : 14,
            ),
            floatingLabelBehavior: FloatingLabelBehavior.never,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide:
              const BorderSide(color: AppColor.border, width: 1.2),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide:
              const BorderSide(color: AppColor.border, width: 1.2),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(
                color: AppColor.primary,
                width: 1.6,
              ),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide:
              const BorderSide(color: AppColor.red, width: 1.2),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: AppColor.red, width: 1.6),
            ),
          ),
          validator: (v) {
            if (required && (v == null || v.trim().isEmpty)) {
              return 'Please enter $label';
            }
            return null;
          },
        ),
      ],
    );
  }

  Widget _buildDropdown({
    required String label,
    required IconData icon,
    required String value,
    required List<String> items,
    required ValueChanged<String?> onChanged,
  }) {
    return DropdownButtonFormField<String>(
      value: value,
      isExpanded: true,
      dropdownColor: AppColor.white,
      icon: const Icon(
        Icons.keyboard_arrow_down_rounded,
        color: AppColor.primary,
      ),
      style: const TextStyle(
        fontSize: 13.5,
        color: AppColor.black,
        fontWeight: FontWeight.w500,
      ),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(
          color: AppColor.primary,
          fontWeight: FontWeight.w600,
          fontSize: 12.5,
        ),
        floatingLabelStyle: const TextStyle(
          color: AppColor.primary,
          fontWeight: FontWeight.w600,
          fontSize: 12.5,
        ),
        filled: true,
        fillColor: AppColor.background.withOpacity(0.4),
        prefixIcon: Icon(icon, color: AppColor.primary, size: 19),
        prefixIconConstraints: const BoxConstraints(minWidth: 44),
        contentPadding:
        const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColor.border, width: 1.2),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColor.border, width: 1.2),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(
            color: AppColor.primary,
            width: 1.6,
          ),
        ),
      ),
      items: items
          .map((t) => DropdownMenuItem<String>(
        value: t,
        child: Text(
          t,
          style: const TextStyle(
            fontSize: 13.5,
            color: AppColor.black,
            fontWeight: FontWeight.w500,
          ),
        ),
      ))
          .toList(),
      onChanged: onChanged,
    );
  }
}