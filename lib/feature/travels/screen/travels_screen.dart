import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

// ═════════════════════════════════════════════════════════════
// LOCATION MODEL
// ═════════════════════════════════════════════════════════════
class TravelLocation {
  final String title;
  final String subtitle;
  final IconData icon;
  final double latitude;
  final double longitude;

  const TravelLocation({
    required this.title,
    required this.subtitle,
    required this.icon,
    this.latitude = 0.0,
    this.longitude = 0.0,
  });
}

class TravelsScreen extends StatefulWidget {
  const TravelsScreen({super.key});

  @override
  State<TravelsScreen> createState() => _TravelsScreenState();
}

class _TravelsScreenState extends State<TravelsScreen> {
  int _selectedTab = 0;

  // ══════════ CAB BOOKING DATA ══════════
  TravelLocation? _cabPickup;
  TravelLocation? _cabDrop;
  String _selectedCabDriver = 'Rahul Kumar';
  double _cabDistance = 12.5;
  double _cabPrice = 350.0;
  bool _cabBooked = false;

  // ══════════ AUTO BOOKING DATA ══════════
  TravelLocation? _autoPickup;
  TravelLocation? _autoDrop;
  String _selectedAutoDriver = 'Ramesh Kumar';
  double _autoDistance = 8.5;
  double _autoPrice = 120.0;
  bool _autoBooked = false;

  // ══════════ E-RICKSHAW BOOKING DATA ══════════
  TravelLocation? _rickshawPickup;
  TravelLocation? _rickshawDrop;
  String _selectedRickshawDriver = 'Shyam Singh';
  double _rickshawDistance = 5.0;
  double _rickshawPrice = 60.0;
  bool _rickshawBooked = false;

  // ══════════ LOCAL DRIVER BOOKING DATA ══════════
  TravelLocation? _driverPickup;
  TravelLocation? _driverDrop;
  String _selectedDriver = 'Vikram Singh';
  double _driverDistance = 15.0;
  double _driverPrice = 450.0;
  bool _driverBooked = false;

  // ══════════ SAVED ADDRESSES ══════════
  final List<TravelLocation> savedAddresses = const [
    TravelLocation(
      title: 'Home',
      subtitle: '123 MG Road, Napier Town, Jabalpur',
      icon: Icons.home_rounded,
    ),
    TravelLocation(
      title: 'Work',
      subtitle: 'Tech Park, Wright Town, Jabalpur',
      icon: Icons.work_rounded,
    ),
    TravelLocation(
      title: 'College',
      subtitle: 'Govt. Engineering College, Ranji, Jabalpur',
      icon: Icons.school_rounded,
    ),
  ];

  // ══════════ POPULAR PLACES ══════════
  final List<TravelLocation> popularPlaces = const [
    TravelLocation(
      title: 'Jabalpur Railway Station',
      subtitle: 'Station Road, Jabalpur',
      icon: Icons.train_rounded,
    ),
    TravelLocation(
      title: 'Jabalpur Airport',
      subtitle: 'Dumna, Jabalpur',
      icon: Icons.flight_rounded,
    ),
    TravelLocation(
      title: 'Bus Stand',
      subtitle: 'Vijay Nagar, Jabalpur',
      icon: Icons.directions_bus_rounded,
    ),
    TravelLocation(
      title: 'Medical College',
      subtitle: 'Napier Town, Jabalpur',
      icon: Icons.local_hospital_rounded,
    ),
    TravelLocation(
      title: 'City Mall',
      subtitle: 'South Civil Lines, Jabalpur',
      icon: Icons.shopping_bag_rounded,
    ),
    TravelLocation(
      title: 'Dumna Nature Reserve',
      subtitle: 'Dumna Island, Jabalpur',
      icon: Icons.park_rounded,
    ),
  ];

  // ══════════ DRIVERS ══════════
  final List<Map<String, dynamic>> cabDrivers = [
    {
      'name': 'Rahul Kumar',
      'rating': 4.8,
      'vehicle': 'White Sedan',
      'phone': '+919876543210',
    },
    {
      'name': 'Amit Singh',
      'rating': 4.9,
      'vehicle': 'Black SUV',
      'phone': '+919876543211',
    },
    {
      'name': 'Vikram Sharma',
      'rating': 4.7,
      'vehicle': 'Red Mini',
      'phone': '+919876543212',
    },
  ];

  final List<Map<String, dynamic>> autoDrivers = [
    {
      'name': 'Ramesh Kumar',
      'rating': 4.6,
      'vehicle': 'Green Auto',
      'phone': '+919876543213',
    },
    {
      'name': 'Suresh Singh',
      'rating': 4.8,
      'vehicle': 'Yellow Auto',
      'phone': '+919876543214',
    },
    {
      'name': 'Mohan Sharma',
      'rating': 4.5,
      'vehicle': 'CNG Auto',
      'phone': '+919876543215',
    },
  ];

  final List<Map<String, dynamic>> rickshawDrivers = [
    {
      'name': 'Shyam Singh',
      'rating': 4.5,
      'vehicle': 'Green E-Rickshaw',
      'phone': '+919876543216',
    },
    {
      'name': 'Raju Kumar',
      'rating': 4.3,
      'vehicle': 'Yellow E-Rickshaw',
      'phone': '+919876543217',
    },
    {
      'name': 'Manoj Sharma',
      'rating': 4.6,
      'vehicle': 'Manual Rickshaw',
      'phone': '+919876543218',
    },
  ];

  final List<Map<String, dynamic>> driverList = [
    {
      'name': 'Vikram Singh',
      'rating': 4.9,
      'vehicle': 'White Sedan',
      'experience': '8 years',
      'phone': '+919876543219',
    },
    {
      'name': 'Deepak Kumar',
      'rating': 4.8,
      'vehicle': 'Black SUV',
      'experience': '10 years',
      'phone': '+919876543220',
    },
    {
      'name': 'Sanjay Sharma',
      'rating': 4.7,
      'vehicle': 'Red Hatchback',
      'experience': '5 years',
      'phone': '+919876543221',
    },
  ];

  // ══════════ COLORS ══════════
  static const Color primaryColor = Color(0xFF1A73E8);
  static const Color primaryDark = Color(0xFF1557B0);
  static const Color primaryLight = Color(0xFF4A90E2);
  static const Color accentColor = Color(0xFF00BCD4);
  static const Color successColor = Color(0xFF0F9D58);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(
        slivers: [
          // ══════════ APP BAR ══════════
          SliverAppBar(
            expandedHeight: 150,
            floating: true,
            pinned: true,
            elevation: 0,
            backgroundColor: primaryColor,
            title: const Text(
              'Local Travels',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            flexibleSpace: FlexibleSpaceBar(
              background: Stack(
                fit: StackFit.expand,
                children: [
                  Image.network(
                    'https://images.unsplash.com/photo-1436491865332-7a61a109cc05?w=1200&h=400&fit=crop',
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [primaryColor, primaryLight],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                        ),
                      );
                    },
                  ),
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.black.withOpacity(0.1),
                          Colors.black.withOpacity(0.5),
                          primaryColor.withOpacity(0.7),
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 16,
                    left: 16,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Book Your Ride',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          'Choose your vehicle type',
                          style: TextStyle(
                            color: Colors.white.withOpacity(0.8),
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            leading: Container(
              margin: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.2),
                shape: BoxShape.circle,
              ),
              child: IconButton(
                icon: const Icon(
                  Icons.arrow_back_rounded,
                  color: Colors.white,
                  size: 20,
                ),
                onPressed: () => Navigator.pop(context),
                padding: EdgeInsets.zero,
              ),
            ),
            actions: [
              Container(
                margin: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  shape: BoxShape.circle,
                ),
                child: IconButton(
                  icon: const Icon(
                    Icons.more_vert,
                    color: Colors.white,
                    size: 20,
                  ),
                  onPressed: () {},
                  padding: EdgeInsets.zero,
                ),
              ),
            ],
          ),

          // ══════════ TAB BAR ══════════
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(12, 10, 12, 0),
            sliver: SliverToBoxAdapter(
              child: Container(
                padding: const EdgeInsets.all(3),
                decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children: [
                    _buildTab('🚗 Cab', 0),
                    const SizedBox(width: 3),
                    _buildTab('🛺 Auto', 1),
                    const SizedBox(width: 3),
                    _buildTab('🔌 E-Rick', 2),
                    const SizedBox(width: 3),
                    _buildTab('👤 Driver', 3),
                  ],
                ),
              ),
            ),
          ),

          // ══════════ CONTENT ══════════
          SliverPadding(
            padding: const EdgeInsets.all(12),
            sliver: SliverToBoxAdapter(child: _buildSelectedTabContent()),
          ),

          const SliverPadding(padding: EdgeInsets.only(bottom: 16)),
        ],
      ),
    );
  }

  // ═════════════════════════════════════════════════════════════
  // TAB SYSTEM
  // ═════════════════════════════════════════════════════════════
  Widget _buildTab(String label, int index) {
    final isSelected = _selectedTab == index;
    return Expanded(
      child: GestureDetector(
        onTap: () {
          setState(() {
            _selectedTab = index;
          });
        },
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 8),
          decoration: BoxDecoration(
            color: isSelected ? primaryColor : Colors.transparent,
            borderRadius: BorderRadius.circular(10),
            boxShadow: isSelected
                ? [
              BoxShadow(
                color: primaryColor.withOpacity(0.3),
                blurRadius: 8,
                offset: const Offset(0, 3),
              ),
            ]
                : null,
          ),
          child: Center(
            child: Text(
              label,
              style: TextStyle(
                color: isSelected ? Colors.white : Colors.grey.shade600,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                fontSize: 12,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSelectedTabContent() {
    switch (_selectedTab) {
      case 0:
        return _buildCabBooking();
      case 1:
        return _buildAutoBooking();
      case 2:
        return _buildRickshawBooking();
      case 3:
        return _buildDriverBooking();
      default:
        return _buildCabBooking();
    }
  }

  // ═════════════════════════════════════════════════════════════
  // CAB BOOKING
  // ═════════════════════════════════════════════════════════════
  Widget _buildCabBooking() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildLocationPair(
          pickup: _cabPickup,
          drop: _cabDrop,
          onPickupTap: () => _openLocationPicker(
            title: 'Select Pickup Location',
            onSelect: (loc) {
              setState(() {
                _cabPickup = loc;
                _recalcCabDistance();
              });
            },
          ),
          onDropTap: () => _openLocationPicker(
            title: 'Select Drop Location',
            onSelect: (loc) {
              setState(() {
                _cabDrop = loc;
                _recalcCabDistance();
              });
            },
          ),
          onSwap: () {
            setState(() {
              final t = _cabPickup;
              _cabPickup = _cabDrop;
              _cabDrop = t;
              _recalcCabDistance();
            });
          },
        ),
        const SizedBox(height: 14),

        _buildPriceCard(_cabDistance, _cabPrice),
        const SizedBox(height: 14),

        _buildSectionTitle('Select Driver'),
        const SizedBox(height: 8),
        ...cabDrivers.map(
              (driver) => _buildDriverCard(driver, _selectedCabDriver, (name) {
            setState(() => _selectedCabDriver = name);
          }),
        ),
        const SizedBox(height: 14),

        _buildBookButton(
          'Book Cab',
          _cabBooked,
              () => _bookRide('Cab', () {
            setState(() => _cabBooked = true);
          }),
        ),
        if (_cabBooked)
          _buildSuccessMessage('Cab', _getSelectedDriverPhone(cabDrivers)),
        const SizedBox(height: 12),
      ],
    );
  }

  // ═════════════════════════════════════════════════════════════
  // AUTO BOOKING
  // ═════════════════════════════════════════════════════════════
  Widget _buildAutoBooking() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildLocationPair(
          pickup: _autoPickup,
          drop: _autoDrop,
          onPickupTap: () => _openLocationPicker(
            title: 'Select Pickup Location',
            onSelect: (loc) {
              setState(() {
                _autoPickup = loc;
                _recalcAutoDistance();
              });
            },
          ),
          onDropTap: () => _openLocationPicker(
            title: 'Select Drop Location',
            onSelect: (loc) {
              setState(() {
                _autoDrop = loc;
                _recalcAutoDistance();
              });
            },
          ),
          onSwap: () {
            setState(() {
              final t = _autoPickup;
              _autoPickup = _autoDrop;
              _autoDrop = t;
              _recalcAutoDistance();
            });
          },
        ),
        const SizedBox(height: 14),

        _buildPriceCard(_autoDistance, _autoPrice),
        const SizedBox(height: 14),

        _buildSectionTitle('Select Driver'),
        const SizedBox(height: 8),
        ...autoDrivers.map(
              (driver) => _buildDriverCard(driver, _selectedAutoDriver, (name) {
            setState(() => _selectedAutoDriver = name);
          }),
        ),
        const SizedBox(height: 14),

        _buildBookButton(
          'Book Auto',
          _autoBooked,
              () => _bookRide('Auto', () {
            setState(() => _autoBooked = true);
          }),
        ),
        if (_autoBooked)
          _buildSuccessMessage('Auto', _getSelectedDriverPhone(autoDrivers)),
        const SizedBox(height: 12),
      ],
    );
  }

  // ═════════════════════════════════════════════════════════════
  // E-RICKSHAW BOOKING
  // ═════════════════════════════════════════════════════════════
  Widget _buildRickshawBooking() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildLocationPair(
          pickup: _rickshawPickup,
          drop: _rickshawDrop,
          onPickupTap: () => _openLocationPicker(
            title: 'Select Pickup Location',
            onSelect: (loc) {
              setState(() {
                _rickshawPickup = loc;
                _recalcRickshawDistance();
              });
            },
          ),
          onDropTap: () => _openLocationPicker(
            title: 'Select Drop Location',
            onSelect: (loc) {
              setState(() {
                _rickshawDrop = loc;
                _recalcRickshawDistance();
              });
            },
          ),
          onSwap: () {
            setState(() {
              final t = _rickshawPickup;
              _rickshawPickup = _rickshawDrop;
              _rickshawDrop = t;
              _recalcRickshawDistance();
            });
          },
        ),
        const SizedBox(height: 14),

        _buildPriceCard(_rickshawDistance, _rickshawPrice),
        const SizedBox(height: 14),

        _buildSectionTitle('Select Driver'),
        const SizedBox(height: 8),
        ...rickshawDrivers.map(
              (driver) => _buildDriverCard(driver, _selectedRickshawDriver, (name) {
            setState(() => _selectedRickshawDriver = name);
          }),
        ),
        const SizedBox(height: 14),

        _buildBookButton(
          'Book Rickshaw',
          _rickshawBooked,
              () => _bookRide('E-Rickshaw', () {
            setState(() => _rickshawBooked = true);
          }),
        ),
        if (_rickshawBooked)
          _buildSuccessMessage(
            'E-Rickshaw',
            _getSelectedDriverPhone(rickshawDrivers),
          ),
        const SizedBox(height: 12),
      ],
    );
  }

  // ═════════════════════════════════════════════════════════════
  // LOCAL DRIVER BOOKING
  // ═════════════════════════════════════════════════════════════
  Widget _buildDriverBooking() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildLocationPair(
          pickup: _driverPickup,
          drop: _driverDrop,
          onPickupTap: () => _openLocationPicker(
            title: 'Select Pickup Location',
            onSelect: (loc) {
              setState(() {
                _driverPickup = loc;
                _recalcDriverDistance();
              });
            },
          ),
          onDropTap: () => _openLocationPicker(
            title: 'Select Drop Location',
            onSelect: (loc) {
              setState(() {
                _driverDrop = loc;
                _recalcDriverDistance();
              });
            },
          ),
          onSwap: () {
            setState(() {
              final t = _driverPickup;
              _driverPickup = _driverDrop;
              _driverDrop = t;
              _recalcDriverDistance();
            });
          },
        ),
        const SizedBox(height: 14),

        _buildPriceCard(_driverDistance, _driverPrice),
        const SizedBox(height: 14),

        _buildSectionTitle('Select Driver'),
        const SizedBox(height: 8),
        ...driverList.map(
              (driver) => _buildDriverCard(driver, _selectedDriver, (name) {
            setState(() => _selectedDriver = name);
          }),
        ),
        const SizedBox(height: 14),

        _buildBookButton(
          'Hire Driver',
          _driverBooked,
              () => _bookRide('Driver', () {
            setState(() => _driverBooked = true);
          }),
        ),
        if (_driverBooked)
          _buildSuccessMessage('Driver', _getSelectedDriverPhone(driverList)),
        const SizedBox(height: 12),
      ],
    );
  }

  // ═════════════════════════════════════════════════════════════
  // DISTANCE / PRICE RECALCULATION
  // ═════════════════════════════════════════════════════════════
  void _recalcCabDistance() {
    if (_cabPickup != null && _cabDrop != null) {
      _cabDistance = _calcDistance(_cabPickup!.title, _cabDrop!.title);
      _cabPrice = 100 + (_cabDistance * 20);
    }
  }

  void _recalcAutoDistance() {
    if (_autoPickup != null && _autoDrop != null) {
      _autoDistance = _calcDistance(_autoPickup!.title, _autoDrop!.title);
      _autoPrice = 30 + (_autoDistance * 12);
    }
  }

  void _recalcRickshawDistance() {
    if (_rickshawPickup != null && _rickshawDrop != null) {
      _rickshawDistance =
          _calcDistance(_rickshawPickup!.title, _rickshawDrop!.title);
      _rickshawPrice = 20 + (_rickshawDistance * 8);
    }
  }

  void _recalcDriverDistance() {
    if (_driverPickup != null && _driverDrop != null) {
      _driverDistance =
          _calcDistance(_driverPickup!.title, _driverDrop!.title);
      _driverPrice = 200 + (_driverDistance * 18);
    }
  }

  /// Simple hash-based distance — replace with real distance API
  double _calcDistance(String a, String b) {
    if (a == b) return 1.0;
    final hash = (a.hashCode + b.hashCode).abs() % 250;
    return 2.0 + (hash / 10.0); // 2.0 to ~27.0 km
  }

  // ═════════════════════════════════════════════════════════════
  // PICKUP + DROP PAIR
  // ═════════════════════════════════════════════════════════════
  Widget _buildLocationPair({
    required TravelLocation? pickup,
    required TravelLocation? drop,
    required VoidCallback onPickupTap,
    required VoidCallback onDropTap,
    required VoidCallback onSwap,
  }) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade200),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        children: [
          // ── Pickup ──
          _buildLocationRow(
            label: 'Pickup',
            value: pickup,
            placeholder: 'Select pickup location',
            dotColor: Colors.green,
            onTap: onPickupTap,
          ),

          // ── Dashed connector + Swap ──
          Padding(
            padding: const EdgeInsets.only(left: 8),
            child: Row(
              children: [
                SizedBox(
                  width: 24,
                  child: Center(
                    child: Container(
                      width: 2,
                      height: 22,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade300,
                        borderRadius: BorderRadius.circular(1),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Divider(
                    color: Colors.grey.shade200,
                    thickness: 1,
                    height: 22,
                  ),
                ),
                // Swap button
                GestureDetector(
                  onTap: onSwap,
                  child: Container(
                    padding: const EdgeInsets.all(6),
                    decoration: BoxDecoration(
                      color: primaryColor.withOpacity(0.08),
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        color: primaryColor.withOpacity(0.2),
                      ),
                    ),
                    child: Icon(
                      Icons.swap_vert_rounded,
                      color: primaryColor,
                      size: 18,
                    ),
                  ),
                ),
              ],
            ),
          ),

          // ── Drop ──
          _buildLocationRow(
            label: 'Drop',
            value: drop,
            placeholder: 'Select drop location',
            dotColor: Colors.red,
            onTap: onDropTap,
          ),
        ],
      ),
    );
  }

  Widget _buildLocationRow({
    required String label,
    required TravelLocation? value,
    required String placeholder,
    required Color dotColor,
    required VoidCallback onTap,
  }) {
    final hasValue = value != null;
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(10),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 4),
        child: Row(
          children: [
            // Colored dot
            Container(
              width: 12,
              height: 12,
              decoration: BoxDecoration(
                color: hasValue ? dotColor : Colors.grey.shade300,
                shape: BoxShape.circle,
                border: Border.all(
                  color: hasValue
                      ? dotColor.withOpacity(0.3)
                      : Colors.grey.shade300,
                  width: 3,
                ),
              ),
            ),
            const SizedBox(width: 12),

            // Label + value
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    label,
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w600,
                      color: Colors.grey.shade500,
                      letterSpacing: 0.3,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    hasValue ? value.title : placeholder,
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight:
                      hasValue ? FontWeight.w600 : FontWeight.w400,
                      color: hasValue
                          ? const Color(0xFF1E293B)
                          : Colors.grey.shade400,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  if (hasValue)
                    Text(
                      value.subtitle,
                      style: TextStyle(
                        fontSize: 10.5,
                        color: Colors.grey.shade500,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                ],
              ),
            ),

            // Chevron or clear
            if (hasValue)
              GestureDetector(
                onTap: onTap,
                child: Icon(
                  Icons.edit_rounded,
                  size: 16,
                  color: primaryColor.withOpacity(0.7),
                ),
              )
            else
              Icon(
                Icons.chevron_right_rounded,
                size: 20,
                color: Colors.grey.shade400,
              ),
          ],
        ),
      ),
    );
  }

  // ═════════════════════════════════════════════════════════════
  // LOCATION PICKER BOTTOM SHEET
  // ═════════════════════════════════════════════════════════════
  void _openLocationPicker({
    required String title,
    required ValueChanged<TravelLocation> onSelect,
  }) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => _LocationPickerSheet(
        title: title,
        savedAddresses: savedAddresses,
        popularPlaces: popularPlaces,
        onSelect: (loc) {
          Navigator.pop(context);
          onSelect(loc);
        },
      ),
    );
  }

  // ═════════════════════════════════════════════════════════════
  // PRICE CARD
  // ═════════════════════════════════════════════════════════════
  Widget _buildPriceCard(double distance, double price) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade200),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.05),
            blurRadius: 5,
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
                const Text(
                  'Distance',
                  style: TextStyle(fontSize: 11, color: Colors.grey),
                ),
                Row(
                  children: [
                    Icon(Icons.route_rounded, size: 16, color: primaryColor),
                    const SizedBox(width: 4),
                    Text(
                      '${distance.toStringAsFixed(1)} km',
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Container(width: 1, height: 32, color: Colors.grey.shade200),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text(
                  'Est. Price',
                  style: TextStyle(fontSize: 11, color: Colors.grey),
                ),
                Text(
                  '₹${price.toStringAsFixed(0)}',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: successColor,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ═════════════════════════════════════════════════════════════
  // DRIVER CARD
  // ═════════════════════════════════════════════════════════════
  Widget _buildDriverCard(
      Map<String, dynamic> driver,
      String selectedDriver,
      Function(String) onTap,
      ) {
    final isSelected = selectedDriver == driver['name'];
    return GestureDetector(
      onTap: () => onTap(driver['name']),
      child: Container(
        margin: const EdgeInsets.only(bottom: 6),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: isSelected ? primaryColor : Colors.grey.shade200,
            width: isSelected ? 1.4 : 0.6,
          ),
          boxShadow: isSelected
              ? [
            BoxShadow(
              color: primaryColor.withOpacity(0.1),
              blurRadius: 5,
              offset: const Offset(0, 2),
            ),
          ]
              : null,
        ),
        child: Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: isSelected
                    ? primaryColor.withOpacity(0.1)
                    : Colors.grey.shade100,
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Text(
                  driver['name'][0],
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: isSelected ? primaryColor : Colors.grey.shade700,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    driver['name'],
                    style: const TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.star_rounded,
                        size: 12,
                        color: Colors.amber.shade600,
                      ),
                      Text(
                        driver['rating'].toString(),
                        style: const TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        driver['vehicle'],
                        style: TextStyle(
                          fontSize: 10,
                          color: Colors.grey.shade600,
                        ),
                      ),
                    ],
                  ),
                  if (driver['experience'] != null)
                    Text(
                      'Exp: ${driver['experience']}',
                      style: TextStyle(
                        fontSize: 9,
                        color: Colors.grey.shade500,
                      ),
                    ),
                  if (isSelected && driver['phone'] != null)
                    Row(
                      children: [
                        Icon(
                          Icons.phone_rounded,
                          size: 12,
                          color: successColor,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          driver['phone'],
                          style: TextStyle(
                            fontSize: 10,
                            color: successColor,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                ],
              ),
            ),
            if (isSelected)
              Icon(Icons.check_circle, color: primaryColor, size: 24),
            const SizedBox(width: 4),
          ],
        ),
      ),
    );
  }

  // ═════════════════════════════════════════════════════════════
  // BOOK BUTTON
  // ═════════════════════════════════════════════════════════════
  Widget _buildBookButton(String label, bool isBooked, VoidCallback onTap) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: isBooked ? null : onTap,
        style: ElevatedButton.styleFrom(
          backgroundColor: isBooked ? successColor : primaryColor,
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          elevation: isBooked ? 0 : 3,
        ),
        child: Text(
          isBooked ? '✅ Booked' : label,
          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  // ═════════════════════════════════════════════════════════════
  // SUCCESS MESSAGE
  // ═════════════════════════════════════════════════════════════
  Widget _buildSuccessMessage(String type, String phone) {
    return Container(
      margin: const EdgeInsets.only(top: 10),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: successColor.withOpacity(0.08),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: successColor.withOpacity(0.2)),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Icon(Icons.check_circle_rounded, color: successColor, size: 18),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  '$type booked successfully! 🎉',
                  style: TextStyle(
                    color: successColor,
                    fontWeight: FontWeight.w500,
                    fontSize: 12,
                  ),
                ),
              ),
            ],
          ),
          if (phone.isNotEmpty) ...[
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                InkWell(
                  onTap: () => _makePhoneCall(phone),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: successColor,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.call_rounded,
                          color: Colors.white,
                          size: 16,
                        ),
                        SizedBox(width: 6),
                        Text(
                          'Call Driver',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 11,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                InkWell(
                  onTap: () => _sendWhatsAppMessage(phone),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: successColor,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.chat_rounded,
                          color: Colors.white,
                          size: 16,
                        ),
                        SizedBox(width: 6),
                        Text(
                          'WhatsApp',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 11,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }

  // ═════════════════════════════════════════════════════════════
  // HELPERS
  // ═════════════════════════════════════════════════════════════
  String _getSelectedDriverPhone(List<Map<String, dynamic>> drivers) {
    String selectedName;
    if (drivers == cabDrivers) {
      selectedName = _selectedCabDriver;
    } else if (drivers == autoDrivers) {
      selectedName = _selectedAutoDriver;
    } else if (drivers == rickshawDrivers) {
      selectedName = _selectedRickshawDriver;
    } else {
      selectedName = _selectedDriver;
    }
    final driver = drivers.firstWhere((d) => d['name'] == selectedName);
    return driver['phone'] ?? '';
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.bold,
        color: Color(0xFF1E293B),
      ),
    );
  }

  void _bookRide(String type, VoidCallback setBooked) {
    setBooked();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('$type booked successfully! 🎉'),
        backgroundColor: successColor,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  // ═════════════════════════════════════════════════════════════
  // CALL & WHATSAPP
  // ═════════════════════════════════════════════════════════════
  Future<void> _makePhoneCall(String phoneNumber) async {
    final Uri phoneUri = Uri(scheme: 'tel', path: phoneNumber);
    try {
      if (await canLaunchUrl(phoneUri)) {
        await launchUrl(phoneUri);
      } else {
        throw 'Could not launch $phoneNumber';
      }
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Unable to call $phoneNumber'),
          backgroundColor: Colors.red,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      );
    }
  }

  Future<void> _sendWhatsAppMessage(String phoneNumber) async {
    String cleanPhone = phoneNumber.replaceAll('+', '');
    final Uri whatsappUri = Uri(
      scheme: 'https',
      host: 'wa.me',
      path: cleanPhone,
      queryParameters: {
        'text':
        'Hi, I booked your ride through Local Travels app. Please confirm my booking.',
      },
    );
    try {
      if (await canLaunchUrl(whatsappUri)) {
        await launchUrl(whatsappUri);
      } else {
        throw 'Could not launch WhatsApp';
      }
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('WhatsApp is not installed on your device'),
          backgroundColor: Colors.red,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      );
    }
  }
}

// ═════════════════════════════════════════════════════════════
// LOCATION PICKER SHEET
// ═════════════════════════════════════════════════════════════
class _LocationPickerSheet extends StatefulWidget {
  final String title;
  final List<TravelLocation> savedAddresses;
  final List<TravelLocation> popularPlaces;
  final ValueChanged<TravelLocation> onSelect;

  const _LocationPickerSheet({
    required this.title,
    required this.savedAddresses,
    required this.popularPlaces,
    required this.onSelect,
  });

  @override
  State<_LocationPickerSheet> createState() => _LocationPickerSheetState();
}

class _LocationPickerSheetState extends State<_LocationPickerSheet> {
  final TextEditingController _searchController = TextEditingController();
  String _query = '';

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  List<TravelLocation> get _filteredSaved => _query.isEmpty
      ? widget.savedAddresses
      : widget.savedAddresses
      .where((a) =>
  a.title.toLowerCase().contains(_query.toLowerCase()) ||
      a.subtitle.toLowerCase().contains(_query.toLowerCase()))
      .toList();

  List<TravelLocation> get _filteredPopular => _query.isEmpty
      ? widget.popularPlaces
      : widget.popularPlaces
      .where((a) =>
  a.title.toLowerCase().contains(_query.toLowerCase()) ||
      a.subtitle.toLowerCase().contains(_query.toLowerCase()))
      .toList();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.85,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: Column(
        children: [
          // ── Handle ──
          Center(
            child: Container(
              width: 44,
              height: 5,
              margin: const EdgeInsets.only(top: 10, bottom: 8),
              decoration: BoxDecoration(
                color: const Color(0xFFCBD5E1),
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),

          // ── Title ──
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 4, 16, 8),
            child: Row(
              children: [
                Text(
                  widget.title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF1E293B),
                  ),
                ),
                const Spacer(),
                IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(Icons.close_rounded, size: 20),
                ),
              ],
            ),
          ),

          // ── Search bar ──
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Container(
              decoration: BoxDecoration(
                color: const Color(0xFFF8FAFC),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: const Color(0xFFE2E8F0)),
              ),
              child: TextField(
                controller: _searchController,
                onChanged: (v) => setState(() => _query = v),
                decoration: const InputDecoration(
                  hintText: 'Search for area, street, landmark...',
                  hintStyle: TextStyle(fontSize: 13, color: Colors.grey),
                  prefixIcon: Icon(
                    Icons.search_rounded,
                    color: Color(0xFF1A73E8),
                    size: 20,
                  ),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(vertical: 14),
                ),
                style: const TextStyle(fontSize: 13.5),
              ),
            ),
          ),

          const SizedBox(height: 8),

          // ── Current Location tile ──
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: InkWell(
              onTap: () {
                widget.onSelect(const TravelLocation(
                  title: 'Current Location',
                  subtitle: 'Using GPS location',
                  icon: Icons.my_location_rounded,
                ));
              },
              borderRadius: BorderRadius.circular(12),
              child: Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: const Color(0xFF1A73E8).withOpacity(0.06),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: const Color(0xFF1A73E8).withOpacity(0.2),
                  ),
                ),
                child: Row(
                  children: [
                    Container(
                      width: 36,
                      height: 36,
                      decoration: const BoxDecoration(
                        color: Color(0xFF1A73E8),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.my_location_rounded,
                        color: Colors.white,
                        size: 18,
                      ),
                    ),
                    const SizedBox(width: 12),
                    const Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Use Current Location',
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF1A73E8),
                            ),
                          ),
                          Text(
                            'Detect automatically via GPS',
                            style: TextStyle(
                              fontSize: 11,
                              color: Color(0xFF1A73E8),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Icon(
                      Icons.chevron_right_rounded,
                      color: Color(0xFF1A73E8),
                    ),
                  ],
                ),
              ),
            ),
          ),

          const SizedBox(height: 12),

          // ── Scrollable sections ──
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              children: [
                // Saved addresses
                if (_filteredSaved.isNotEmpty) ...[
                  _sectionTitle('Saved Addresses'),
                  const SizedBox(height: 6),
                  ..._filteredSaved.map(
                        (loc) => _locationTile(loc, isSaved: true),
                  ),
                  const SizedBox(height: 12),
                ],

                // Popular places
                if (_filteredPopular.isNotEmpty) ...[
                  _sectionTitle('Popular Places'),
                  const SizedBox(height: 6),
                  ..._filteredPopular.map(
                        (loc) => _locationTile(loc, isSaved: false),
                  ),
                  const SizedBox(height: 12),
                ],

                // Empty state
                if (_filteredSaved.isEmpty && _filteredPopular.isEmpty)
                  Padding(
                    padding: const EdgeInsets.only(top: 40),
                    child: Column(
                      children: [
                        Icon(
                          Icons.search_off_rounded,
                          size: 60,
                          color: Colors.grey.shade300,
                        ),
                        const SizedBox(height: 12),
                        Text(
                          'No results for "$_query"',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey.shade600,
                          ),
                        ),
                      ],
                    ),
                  ),

                const SizedBox(height: 30),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _sectionTitle(String text) {
    return Padding(
      padding: const EdgeInsets.only(left: 4, top: 4),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.w700,
          color: Colors.grey.shade500,
          letterSpacing: 0.5,
        ),
      ),
    );
  }

  Widget _locationTile(TravelLocation loc, {required bool isSaved}) {
    return InkWell(
      onTap: () => widget.onSelect(loc),
      borderRadius: BorderRadius.circular(10),
      child: Container(
        margin: const EdgeInsets.only(bottom: 6),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.grey.shade200),
        ),
        child: Row(
          children: [
            Container(
              width: 34,
              height: 34,
              decoration: BoxDecoration(
                color: isSaved
                    ? const Color(0xFF1A73E8).withOpacity(0.08)
                    : Colors.grey.shade100,
                shape: BoxShape.circle,
              ),
              child: Icon(
                loc.icon,
                size: 17,
                color: isSaved
                    ? const Color(0xFF1A73E8)
                    : Colors.grey.shade700,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    loc.title,
                    style: const TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF1E293B),
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    loc.subtitle,
                    style: TextStyle(
                      fontSize: 11,
                      color: Colors.grey.shade500,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            Icon(
              Icons.chevron_right_rounded,
              color: Colors.grey.shade400,
              size: 18,
            ),
          ],
        ),
      ),
    );
  }
}