// lib/screens/dashboard/it_service_home_screen.dart
import 'package:carousel_slider_plus/carousel_slider_plus.dart';
import 'package:flutter/material.dart';
import '../../../core/utils/app_color.dart';
import '../../../core/utils/app_media_query.dart';

final List<Map<String, dynamic>> serviceProviders = [
  {
    'id': 'provider_1',
    'name': 'CodeCraft Studios',
    'category': 'App Development',
    'image':
    'https://images.unsplash.com/photo-1526374965328-7f61d4dc18c5?q=80&w=400',
    'logo':
    'https://images.unsplash.com/photo-1526374965328-7f61d4dc18c5?q=80&w=200',
    'rating': 4.9,
    'reviews': 234,
    'distance': '0.5 km',
    'deliveryTime': '2-3 weeks',
    'minOrder': '₹50,000',
    'deliveryFee': '₹0',
    'isOpen': true,
    'tags': ['Flutter', 'React Native', 'iOS', 'Android'],
    'featuredProducts': [
      {'name': 'E-Commerce App', 'price': '₹1,50,000', 'unit': 'project'},
      {'name': 'Social Media App', 'price': '₹2,00,000', 'unit': 'project'},
      {'name': 'Custom App', 'price': '₹1,00,000', 'unit': 'project'},
    ],
    'address': '123 Tech Park, Mumbai',
    'phone': '+91 98765 43210',
  },
  {
    'id': 'provider_2',
    'name': 'WebWizards Inc',
    'category': 'Web Development',
    'image':
    'https://images.unsplash.com/photo-1547658719-da2b51169166?q=80&w=400',
    'logo':
    'https://images.unsplash.com/photo-1547658719-da2b51169166?q=80&w=200',
    'rating': 4.8,
    'reviews': 567,
    'distance': '1.2 km',
    'deliveryTime': '3-4 weeks',
    'minOrder': '₹40,000',
    'deliveryFee': '₹0',
    'isOpen': true,
    'tags': ['HTML', 'CSS', 'JavaScript', 'WordPress'],
    'featuredProducts': [
      {'name': 'Business Website', 'price': '₹80,000', 'unit': 'project'},
      {'name': 'E-Commerce Site', 'price': '₹1,50,000', 'unit': 'project'},
      {'name': 'Portfolio Website', 'price': '₹50,000', 'unit': 'project'},
    ],
    'address': '456 Web Avenue, Mumbai',
    'phone': '+91 98765 43211',
  },
  {
    'id': 'provider_3',
    'name': 'AppForge Solutions',
    'category': 'App Development',
    'image':
    'https://images.unsplash.com/photo-1551650975-87deedd944c3?q=80&w=400',
    'logo':
    'https://images.unsplash.com/photo-1551650975-87deedd944c3?q=80&w=200',
    'rating': 4.7,
    'reviews': 189,
    'distance': '2.0 km',
    'deliveryTime': '4-5 weeks',
    'minOrder': '₹60,000',
    'deliveryFee': '₹0',
    'isOpen': true,
    'tags': ['Kotlin', 'Swift', 'Flutter', 'Firebase'],
    'featuredProducts': [
      {'name': 'Gaming App', 'price': '₹2,50,000', 'unit': 'project'},
      {'name': 'Utility App', 'price': '₹1,20,000', 'unit': 'project'},
      {'name': 'Health App', 'price': '₹1,80,000', 'unit': 'project'},
    ],
    'address': '789 App Street, Mumbai',
    'phone': '+91 98765 43212',
  },
  {
    'id': 'provider_4',
    'name': 'RoboTech Innovations',
    'category': 'IoT & Robotics',
    'image':
    'https://images.unsplash.com/photo-1485827404703-89b55fcc595e?q=80&w=400',
    'logo':
    'https://images.unsplash.com/photo-1485827404703-89b55fcc595e?q=80&w=200',
    'rating': 4.9,
    'reviews': 345,
    'distance': '0.8 km',
    'deliveryTime': '6-8 weeks',
    'minOrder': '₹1,00,000',
    'deliveryFee': '₹0',
    'isOpen': true,
    'tags': ['Arduino', 'Raspberry Pi', 'Sensors', 'AI'],
    'featuredProducts': [
      {'name': 'Smart Home System', 'price': '₹2,00,000', 'unit': 'project'},
      {'name': 'Industrial Automation', 'price': '₹3,50,000', 'unit': 'project'},
      {'name': 'Robotics Kit', 'price': '₹1,50,000', 'unit': 'project'},
    ],
    'address': '321 Robotics Hub, Mumbai',
    'phone': '+91 98765 43213',
  },
  {
    'id': 'provider_5',
    'name': 'GameForge Studios',
    'category': 'Game Development',
    'image':
    'https://images.unsplash.com/photo-1552820728-8b83bb6b773f?q=80&w=400',
    'logo':
    'https://images.unsplash.com/photo-1552820728-8b83bb6b773f?q=80&w=200',
    'rating': 4.8,
    'reviews': 156,
    'distance': '3.5 km',
    'deliveryTime': '8-12 weeks',
    'minOrder': '₹1,50,000',
    'deliveryFee': '₹0',
    'isOpen': true,
    'tags': ['Unity', 'Unreal', '3D', '2D'],
    'featuredProducts': [
      {'name': 'Mobile Game', 'price': '₹2,50,000', 'unit': 'project'},
      {'name': 'PC Game', 'price': '₹4,00,000', 'unit': 'project'},
      {'name': 'AR/VR Game', 'price': '₹5,00,000', 'unit': 'project'},
    ],
    'address': '654 Game City, Mumbai',
    'phone': '+91 98765 43214',
  },
  {
    'id': 'provider_6',
    'name': 'WebApp Masters',
    'category': 'Web Application Development',
    'image':
    'https://images.unsplash.com/photo-1460925895917-afdab827c52f?q=80&w=400',
    'logo':
    'https://images.unsplash.com/photo-1460925895917-afdab827c52f?q=80&w=200',
    'rating': 4.6,
    'reviews': 98,
    'distance': '4.0 km',
    'deliveryTime': '4-6 weeks',
    'minOrder': '₹70,000',
    'deliveryFee': '₹0',
    'isOpen': true,
    'tags': ['React', 'Angular', 'Vue', 'Node.js'],
    'featuredProducts': [
      {'name': 'SaaS Platform', 'price': '₹2,00,000', 'unit': 'project'},
      {'name': 'Dashboard App', 'price': '₹1,20,000', 'unit': 'project'},
      {'name': 'API Development', 'price': '₹80,000', 'unit': 'project'},
    ],
    'address': '987 Web Park, Mumbai',
    'phone': '+91 98765 43215',
  },
];

class TechServicesScreen extends StatefulWidget {
  final VoidCallback? onNavigateToCategory;
  final Function(String)? onNavigateToCategoryWithName;

  const TechServicesScreen({
    super.key,
    this.onNavigateToCategory,
    this.onNavigateToCategoryWithName,
  });

  @override
  State<TechServicesScreen> createState() => TechServicesScreenState();
}

class TechServicesScreenState extends State<TechServicesScreen> {
  final CarouselSliderController _carouselController =
  CarouselSliderController();
  int _currentBannerIndex = 0;
  String _selectedCategory = 'All';

  List<String> get categoriesList {
    Set<String> categories = {'All'};
    for (var provider in serviceProviders) {
      categories.add(provider['category'] as String);
    }
    return categories.toList();
  }

  List<Map<String, dynamic>> get filteredProviders {
    if (_selectedCategory == 'All') {
      return serviceProviders;
    }
    return serviceProviders
        .where((provider) => provider['category'] == _selectedCategory)
        .toList();
  }

  final List<Map<String, dynamic>> banners = [
    {
      'image':
      'https://images.unsplash.com/photo-1526374965328-7f61d4dc18c5?q=80&w=600',
      'title': 'App Development',
      'subtitle': 'Build stunning mobile apps',
      'color': AppColors.itServices,
      'tag': '📱 Mobile Apps',
    },
    {
      'image':
      'https://images.unsplash.com/photo-1547658719-da2b51169166?q=80&w=600',
      'title': 'Web Development',
      'subtitle': 'Create amazing websites',
      'color': AppColors.primary,
      'tag': '🌐 Web Solutions',
    },
    {
      'image':
      'https://images.unsplash.com/photo-1485827404703-89b55fcc595e?q=80&w=600',
      'title': 'IoT & Robotics',
      'subtitle': 'Innovate with smart tech',
      'color': AppColors.accent,
      'tag': '🤖 Smart Technology',
    },
    {
      'image':
      'https://images.unsplash.com/photo-1552820728-8b83bb6b773f?q=80&w=600',
      'title': 'Game Development',
      'subtitle': 'Create immersive games',
      'color': AppColors.school,
      'tag': '🎮 Gaming',
    },
  ];

  final List<Map<String, dynamic>> serviceCategories = [
    {
      'name': 'App Development',
      'icon': Icons.mobile_friendly_rounded,
      'color': AppColors.ecommerce
    },
    {
      'name': 'Web Development',
      'icon': Icons.web_rounded,
      'color': AppColors.primary
    },
    {
      'name': 'Web Application',
      'icon': Icons.web_asset_rounded,
      'color': AppColors.itServices
    },
    {
      'name': 'IoT & Robotics',
      'icon': Icons.smart_toy_rounded,
      'color': AppColors.ngo
    },
    {
      'name': 'Game Development',
      'icon': Icons.sports_esports_rounded,
      'color': AppColors.school
    },
    {
      'name': 'AI & ML',
      'icon': Icons.psychology_rounded,
      'color': AppColors.itServicesTint
    },
    {
      'name': 'Cloud Computing',
      'icon': Icons.cloud_rounded,
      'color': AppColors.primary
    },
    {
      'name': 'DevOps',
      'icon': Icons.settings_rounded,
      'color': AppColors.ecommerce
    },
    {
      'name': 'AR/VR',
      'icon': Icons.view_in_ar_rounded,
      'color': AppColors.ott
    },
    {
      'name': 'Blockchain',
      'icon': Icons.link_rounded,
      'color': AppColors.school
    },
    {
      'name': 'Cybersecurity',
      'icon': Icons.security_rounded,
      'color': AppColors.ngo
    },
    {
      'name': 'Data Science',
      'icon': Icons.data_usage_rounded,
      'color': AppColors.primary
    },
    {
      'name': 'All',
      'icon': Icons.dashboard_rounded,
      'color': AppColors.itServices
    },
  ];

  final List<Map<String, dynamic>> featuredProjects = [
    {
      'title': 'E-Commerce Mobile App',
      'imageUrl':
      'https://images.unsplash.com/photo-1551650975-87deedd944c3?q=80&w=400',
      'provider': 'CodeCraft Studios',
      'price': '₹1,50,000',
      'oldPrice': '₹2,00,000',
      'rating': 4.9,
      'badge': 'Trending',
      'color': AppColors.ecommerce,
      'category': 'App Development',
    },
    {
      'title': 'Smart Home Automation',
      'imageUrl':
      'https://images.unsplash.com/photo-1485827404703-89b55fcc595e?q=80&w=400',
      'provider': 'RoboTech Innovations',
      'price': '₹2,00,000',
      'oldPrice': '₹2,80,000',
      'rating': 4.8,
      'badge': 'IoT',
      'color': AppColors.ngo,
      'category': 'IoT & Robotics',
    },
    {
      'title': '3D Adventure Game',
      'imageUrl':
      'https://images.unsplash.com/photo-1552820728-8b83bb6b773f?q=80&w=400',
      'provider': 'GameForge Studios',
      'price': '₹4,00,000',
      'oldPrice': '₹5,50,000',
      'rating': 4.7,
      'badge': 'Trending',
      'color': AppColors.school,
      'category': 'Game Development',
    },
    {
      'title': 'Corporate Website',
      'imageUrl':
      'https://images.unsplash.com/photo-1547658719-da2b51169166?q=80&w=400',
      'provider': 'WebWizards Inc',
      'price': '₹80,000',
      'oldPrice': '₹1,20,000',
      'rating': 4.6,
      'badge': 'Popular',
      'color': AppColors.primary,
      'category': 'Web Development',
    },
    {
      'title': 'SaaS Dashboard',
      'imageUrl':
      'https://images.unsplash.com/photo-1460925895917-afdab827c52f?q=80&w=400',
      'provider': 'WebApp Masters',
      'price': '₹2,00,000',
      'oldPrice': '₹2,50,000',
      'rating': 4.8,
      'badge': 'New',
      'color': AppColors.itServices,
      'category': 'Web Application Development',
    },
    {
      'title': 'AR Shopping App',
      'imageUrl':
      'https://images.unsplash.com/photo-1551650975-87deedd944c3?q=80&w=400',
      'provider': 'AppForge Solutions',
      'price': '₹2,50,000',
      'oldPrice': '₹3,20,000',
      'rating': 4.9,
      'badge': 'AR/VR',
      'color': AppColors.ott,
      'category': 'App Development',
    },
  ];

  // ====== NAVIGATION METHOD ======
  void _navigateToCategory(String categoryName) {
    // Use the callback if provided, otherwise navigate directly
    if (widget.onNavigateToCategoryWithName != null) {
      widget.onNavigateToCategoryWithName!.call(categoryName);
    } else {
      // Direct navigation
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ItServiceCategoryScreen(
            initialCategory: categoryName,
          ),
        ),
      );
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: CustomScrollView(
        slivers: [
          // ====== APP BAR ======
          SliverAppBar(
            pinned: true,
            elevation: 0,
            backgroundColor: AppColors.white,
            surfaceTintColor: AppColors.white,
            toolbarHeight: 70,
            title: Row(
              children: [
                Container(
                  padding:
                  const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        AppColors.itServices.withOpacity(0.1),
                        AppColors.itServices.withOpacity(0.05),
                      ],
                    ),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: AppColors.itServices.withOpacity(0.2),
                      width: 0.5,
                    ),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.location_on_rounded,
                          color: AppColors.itServices, size: 18),
                      const SizedBox(width: 6),
                      const Text(
                        'Jabalpur, MP',
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          color: AppColors.itServices,
                        ),
                      ),
                      Icon(Icons.arrow_drop_down_rounded,
                          color: AppColors.itServices, size: 22),
                    ],
                  ),
                ),
                const Spacer(),
                Container(
                  decoration: BoxDecoration(
                      color: AppColors.background,
                      borderRadius: BorderRadius.circular(10)),
                  child: IconButton(
                    icon: const Icon(Icons.notifications_outlined,
                        color: AppColors.textSecondary, size: 22),
                    onPressed: () {},
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                  ),
                ),
              ],
            ),
            leading: InkWell(
              onTap: () => Navigator.pop(context),
              child: Icon(Icons.dashboard, color: AppColors.itServices),
            ),
            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(70),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 20),
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          color: AppColors.background,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const Row(
                          children: [
                            Padding(
                              padding: EdgeInsets.only(left: 16),
                              child: Icon(Icons.search_rounded,
                                  color: AppColors.textSecondary, size: 22),
                            ),
                            SizedBox(width: 12),
                            Expanded(
                              child: TextField(
                                readOnly: true,
                                decoration: InputDecoration(
                                  hintText: 'Search IT services...',
                                  hintStyle: TextStyle(
                                      color: AppColors.textSecondary,
                                      fontSize: 14),
                                  border: InputBorder.none,
                                  contentPadding:
                                  EdgeInsets.symmetric(vertical: 14),
                                ),
                                style: TextStyle(
                                    fontSize: 14, color: AppColors.textMain),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(right: 8),
                              child: Icon(Icons.mic_rounded,
                                  color: AppColors.itServices, size: 22),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Container(
                      decoration: BoxDecoration(
                          color: AppColors.background,
                          borderRadius: BorderRadius.circular(10)),
                      child: IconButton(
                        icon: const Icon(Icons.favorite_border_rounded,
                            color: AppColors.textSecondary, size: 22),
                        onPressed: () {},
                        padding: EdgeInsets.zero,
                        constraints: const BoxConstraints(),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          // ====== BANNER CAROUSEL ======
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: CarouselSlider(
                      controller: _carouselController,
                      options: CarouselOptions(
                        height: 200,
                        viewportFraction: 1.0,
                        enableInfiniteScroll: true,
                        autoPlay: true,
                        autoPlayInterval: const Duration(seconds: 4),
                        autoPlayAnimationDuration:
                        const Duration(milliseconds: 800),
                        pauseAutoPlayOnTouch: true,
                        onPageChanged: (index, reason) {
                          setState(() {
                            _currentBannerIndex = index;
                          });
                        },
                      ),
                      items: banners.map((banner) {
                        return GestureDetector(
                          onTap: () {
                            final category = banner['title'];
                            _navigateToCategory(category);
                          },
                          child: Container(
                            width: double.infinity,
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [
                                  banner['color'],
                                  banner['color'].withOpacity(0.7),
                                ],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                              ),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Stack(
                              children: [
                                Positioned.fill(
                                  child: Opacity(
                                    opacity: 0.15,
                                    child: Image.network(
                                      banner['image'],
                                      fit: BoxFit.cover,
                                      errorBuilder: (context, error,
                                          stackTrace) =>
                                          Container(),
                                    ),
                                  ),
                                ),
                                Positioned(
                                  right: -20,
                                  top: -20,
                                  child: Container(
                                    width: 120,
                                    height: 120,
                                    decoration: BoxDecoration(
                                      color: AppColors.white.withOpacity(0.1),
                                      shape: BoxShape.circle,
                                    ),
                                  ),
                                ),
                                Positioned(
                                  bottom: -30,
                                  right: -10,
                                  child: Container(
                                    width: 80,
                                    height: 80,
                                    decoration: BoxDecoration(
                                      color: AppColors.white.withOpacity(0.08),
                                      shape: BoxShape.circle,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(24),
                                  child: Column(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Container(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 12, vertical: 5),
                                        decoration: BoxDecoration(
                                          color: AppColors.white
                                              .withOpacity(0.25),
                                          borderRadius:
                                          BorderRadius.circular(20),
                                        ),
                                        child: Text(
                                          banner['tag'],
                                          style: const TextStyle(
                                            color: AppColors.white,
                                            fontSize: 11,
                                            fontWeight: FontWeight.w600,
                                            letterSpacing: 0.5,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(height: 10),
                                      Text(
                                        banner['title'],
                                        style: const TextStyle(
                                          color: AppColors.white,
                                          fontSize: 26,
                                          fontWeight: FontWeight.bold,
                                          letterSpacing: -0.5,
                                        ),
                                      ),
                                      Text(
                                        banner['subtitle'],
                                        style: const TextStyle(
                                          color: AppColors.white,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                      const SizedBox(height: 12),
                                      Container(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 18, vertical: 8),
                                        decoration: BoxDecoration(
                                          color: AppColors.white,
                                          borderRadius:
                                          BorderRadius.circular(25),
                                          boxShadow: [
                                            BoxShadow(
                                              color: AppColors.shadow,
                                              blurRadius: 10,
                                              offset: const Offset(0, 4),
                                            ),
                                          ],
                                        ),
                                        child: const Text(
                                          'Explore →',
                                          style: TextStyle(
                                            color: AppColors.textMain,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 13,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                  Positioned(
                    bottom: 14,
                    left: 0,
                    right: 0,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: banners.asMap().entries.map((entry) {
                        return AnimatedContainer(
                          duration: const Duration(milliseconds: 300),
                          width: _currentBannerIndex == entry.key ? 28 : 8,
                          height: 6,
                          margin: const EdgeInsets.symmetric(horizontal: 3),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(3),
                            color: _currentBannerIndex == entry.key
                                ? AppColors.white
                                : AppColors.white.withOpacity(0.4),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ],
              ),
            ),
          ),

          const SliverToBoxAdapter(
            child: SizedBox(height: 16),
          ),

          // ====== SERVICE CATEGORIES GRID ======
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.grid_view_rounded,
                              color: AppColors.itServices, size: 20),
                          SizedBox(width: 8),
                          Text(
                            'Services',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: AppColors.textMain,
                              letterSpacing: -0.5,
                            ),
                          ),
                        ],
                      ),
                      Text(
                        'See All',
                        style: TextStyle(
                          fontSize: 14,
                          color: AppColors.itServices,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    padding: EdgeInsets.zero,
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 5,
                      childAspectRatio: 0.8,
                      mainAxisSpacing: 8,
                      crossAxisSpacing: 8,
                    ),
                    itemCount: serviceCategories.length,
                    itemBuilder: (context, index) {
                      final cat = serviceCategories[index];
                      final isAll = cat['name'] == 'All';
                      return InkWell(
                        onTap: () {
                          _navigateToCategory(cat['name']);
                        },
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Expanded(
                              child: Container(
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  color: AppColors.white,
                                  borderRadius: BorderRadius.circular(10),
                                  boxShadow: [
                                    BoxShadow(
                                      color: AppColors.shadow,
                                      blurRadius: 8,
                                      offset: const Offset(0, 2),
                                    ),
                                  ],
                                ),
                                child: Icon(
                                  cat['icon'],
                                  color: isAll
                                      ? AppColors.itServices
                                      : cat['color'],
                                  size: 26,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                cat['name'],
                                style: TextStyle(
                                  fontSize: 10,
                                  fontWeight:
                                  isAll ? FontWeight.w700 : FontWeight.w500,
                                  color: isAll
                                      ? AppColors.itServices
                                      : AppColors.textSecondary,
                                ),
                                textAlign: TextAlign.center,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),

          const SliverToBoxAdapter(
            child: SizedBox(height: 16),
          ),

          // ====== FEATURED PROJECTS ======
          SliverToBoxAdapter(
            child: Container(
              color: AppColors.white,
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          const Text(
                            '🔥',
                            style: TextStyle(fontSize: 20),
                          ),
                          const SizedBox(width: 8),
                          const Text(
                            'Featured Projects',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: AppColors.textMain,
                              letterSpacing: -0.5,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8, vertical: 2),
                            decoration: BoxDecoration(
                              color: AppColors.itServices.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: const Text(
                              '6',
                              style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                                color: AppColors.itServices,
                              ),
                            ),
                          ),
                        ],
                      ),
                      InkWell(
                        onTap: () {
                          _navigateToCategory('All');
                        },
                        child: const Text(
                          'View All',
                          style: TextStyle(
                            fontSize: 14,
                            color: AppColors.itServices,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 14),
                  SizedBox(
                    height: 200,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: featuredProjects.length,
                      itemBuilder: (context, index) {
                        final project = featuredProjects[index];
                        return _buildEnhancedProjectCard(project);
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),

          // ====== TOP RATED PROVIDERS ======
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.verified_rounded,
                              color: AppColors.itServices, size: 22),
                          SizedBox(width: 8),
                          Text(
                            'Top Rated Providers',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: AppColors.textMain,
                              letterSpacing: -0.5,
                            ),
                          ),
                        ],
                      ),
                      Text(
                        'View All',
                        style: TextStyle(
                          fontSize: 14,
                          color: AppColors.itServices,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 14),
                  SizedBox(
                    height: 180,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: serviceProviders.length,
                      itemBuilder: (context, index) {
                        final provider = serviceProviders[index];
                        return _buildProviderCard(provider);
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),

          const SliverToBoxAdapter(
            child: SizedBox(height: 20),
          ),
        ],
      ),
    );
  }

  Widget _buildEnhancedProjectCard(Map<String, dynamic> project) {
    return Container(
      width: 220,
      margin: const EdgeInsets.only(right: 14),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: AppColors.shadow,
            blurRadius: 15,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: InkWell(
        onTap: () {
          // Navigate to category screen with project's category
          _navigateToCategory(project['category']);
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: ClipRRect(
                borderRadius:
                const BorderRadius.vertical(top: Radius.circular(20)),
                child: Stack(
                  children: [
                    Image.network(
                      project['imageUrl'],
                      width: double.infinity,
                      height: double.infinity,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) => Container(
                        color: AppColors.background,
                        child: const Center(
                          child: Icon(Icons.image_not_supported_rounded,
                              size: 40, color: AppColors.textSecondary),
                        ),
                      ),
                    ),
                    Positioned(
                      top: 10,
                      left: 10,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 4),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              project['color'],
                              project['color'].withOpacity(0.8)
                            ],
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          project['badge'],
                          style: const TextStyle(
                            color: AppColors.white,
                            fontSize: 9,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      top: 10,
                      right: 10,
                      child: Container(
                        padding: const EdgeInsets.all(6),
                        decoration: const BoxDecoration(
                          color: AppColors.white,
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.favorite_border_rounded,
                          size: 16,
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 10,
                      left: 10,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 3),
                        decoration: BoxDecoration(
                          color: AppColors.textMain.withOpacity(0.6),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Text(
                          project['category'],
                          style: const TextStyle(
                            color: AppColors.white,
                            fontSize: 8,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 10,
                      right: 10,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 6, vertical: 3),
                        decoration: BoxDecoration(
                          color: AppColors.textMain.withOpacity(0.6),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(Icons.star_rounded,
                                color: AppColors.school, size: 12),
                            const SizedBox(width: 2),
                            Text(
                              project['rating'].toString(),
                              style: const TextStyle(
                                color: AppColors.white,
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    project['title'],
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: AppColors.textMain,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 2),
                  Text(
                    project['provider'],
                    style: const TextStyle(
                      fontSize: 11,
                      color: AppColors.textSecondary,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        project['price'],
                        style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: AppColors.itServices,
                        ),
                      ),
                      Text(
                        project['oldPrice'],
                        style: const TextStyle(
                          fontSize: 11,
                          color: AppColors.textSecondary,
                          decoration: TextDecoration.lineThrough,
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

  Widget _buildProviderCard(Map<String, dynamic> provider) {
    return Container(
      width: 180,
      margin: const EdgeInsets.only(right: 14),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: AppColors.shadow,
            blurRadius: 12,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: InkWell(
        onTap: () {
          // Navigate to category screen with provider's category
          _navigateToCategory(provider['category']);
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.network(
                      provider['logo'],
                      width: double.infinity,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) => Container(
                        color: AppColors.background,
                        child: const Icon(Icons.business_rounded,
                            size: 40, color: AppColors.textSecondary),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 6,
                    right: 6,
                    child: Container(
                      padding:
                      const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                      decoration: BoxDecoration(
                        color: provider['isOpen'] ? AppColors.success : AppColors.error,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        provider['isOpen'] ? 'Open' : 'Closed',
                        style: const TextStyle(
                          color: AppColors.white,
                          fontSize: 8,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 8),
            Text(
              provider['name'],
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: AppColors.textMain,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 2),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const Icon(Icons.star_rounded,
                    color: AppColors.school, size: 14),
                const SizedBox(width: 2),
                Text(
                  provider['rating'].toString(),
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textMain,
                  ),
                ),
                const SizedBox(width: 4),
                Text(
                  '(${provider['reviews']})',
                  style: const TextStyle(
                    fontSize: 10,
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 4),
            Wrap(
              spacing: 4,
              runSpacing: 4,
              alignment: WrapAlignment.start,
              children: (provider['tags'] as List).take(3).map((tag) {
                return Container(
                  padding:
                  const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                  decoration: BoxDecoration(
                    color: AppColors.background,
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    tag,
                    style: const TextStyle(
                      fontSize: 8,
                      color: AppColors.textSecondary,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}

// ========== IT SERVICE CATEGORY SCREEN ==========
class ItServiceCategoryScreen extends StatefulWidget {
  final String? initialCategory;

  const ItServiceCategoryScreen({super.key, this.initialCategory});

  @override
  State<ItServiceCategoryScreen> createState() =>
      _ItServiceCategoryScreenState();
}

class _ItServiceCategoryScreenState extends State<ItServiceCategoryScreen> {
  late String _selectedCategory;

  final List<Map<String, dynamic>> categories = [
    {'name': 'All', 'icon': Icons.dashboard, 'color': AppColors.itServices},
    {
      'name': 'App Development',
      'icon': Icons.mobile_friendly_rounded,
      'color': AppColors.ecommerce
    },
    {
      'name': 'Web Development',
      'icon': Icons.web_rounded,
      'color': AppColors.primary
    },
    {
      'name': 'Web Application',
      'icon': Icons.web_asset_rounded,
      'color': AppColors.itServices
    },
    {
      'name': 'IoT & Robotics',
      'icon': Icons.smart_toy_rounded,
      'color': AppColors.ngo
    },
    {
      'name': 'Game Development',
      'icon': Icons.sports_esports_rounded,
      'color': AppColors.school
    },
  ];

  final List<Map<String, dynamic>> allProjects = [
    // App Development Projects
    {
      'title': 'E-Commerce Mobile App',
      'price': '₹1,50,000',
      'oldPrice': '₹2,00,000',
      'imageUrl':
      'https://images.unsplash.com/photo-1551650975-87deedd944c3?q=80&w=200',
      'category': 'App Development',
      'rating': 4.9,
      'reviews': 89,
      'badge': 'Trending',
      'color': AppColors.ecommerce,
      'provider': 'CodeCraft Studios',
      'description':
      'Full-featured e-commerce mobile app with payment integration, user authentication, and real-time inventory management.',
    },
    {
      'title': 'Social Media App',
      'price': '₹2,00,000',
      'oldPrice': '₹2,80,000',
      'imageUrl':
      'https://images.unsplash.com/photo-1611162616475-46b635cb6868?q=80&w=200',
      'category': 'App Development',
      'rating': 4.8,
      'reviews': 67,
      'badge': 'Popular',
      'color': AppColors.ecommerce,
      'provider': 'AppForge Solutions',
      'description':
      'Social media platform with real-time chat, post sharing, and user profile management.',
    },
    {
      'title': 'Health & Fitness App',
      'price': '₹1,80,000',
      'oldPrice': '₹2,50,000',
      'imageUrl':
      'https://images.unsplash.com/photo-1571019613454-1cb2f99b2d8b?q=80&w=200',
      'category': 'App Development',
      'rating': 4.7,
      'reviews': 45,
      'badge': 'New',
      'color': AppColors.ecommerce,
      'provider': 'CodeCraft Studios',
      'description':
      'Health tracking app with workout plans, nutrition tracking, and progress monitoring.',
    },
    // Web Development Projects
    {
      'title': 'Corporate Website',
      'price': '₹80,000',
      'oldPrice': '₹1,20,000',
      'imageUrl':
      'https://images.unsplash.com/photo-1547658719-da2b51169166?q=80&w=200',
      'category': 'Web Development',
      'rating': 4.6,
      'reviews': 56,
      'badge': 'Popular',
      'color': AppColors.primary,
      'provider': 'WebWizards Inc',
      'description':
      'Professional corporate website with custom design, SEO optimization, and responsive layout.',
    },
    {
      'title': 'Portfolio Website',
      'price': '₹50,000',
      'oldPrice': '₹75,000',
      'imageUrl':
      'https://images.unsplash.com/photo-1460925895917-afdab827c52f?q=80&w=200',
      'category': 'Web Development',
      'rating': 4.5,
      'reviews': 34,
      'badge': 'Trending',
      'color': AppColors.primary,
      'provider': 'WebWizards Inc',
      'description':
      'Creative portfolio website for showcasing work, with animated elements and contact forms.',
    },
    {
      'title': 'Blog Platform',
      'price': '₹60,000',
      'oldPrice': '₹90,000',
      'imageUrl':
      'https://images.unsplash.com/photo-1504711434969-e33886168f5c?q=80&w=200',
      'category': 'Web Development',
      'rating': 4.4,
      'reviews': 28,
      'badge': 'Best',
      'color': AppColors.primary,
      'provider': 'WebWizards Inc',
      'description':
      'Full-featured blog platform with content management, user comments, and social sharing.',
    },
    // Web Application Development
    {
      'title': 'SaaS Dashboard',
      'price': '₹2,00,000',
      'oldPrice': '₹2,50,000',
      'imageUrl':
      'https://images.unsplash.com/photo-1460925895917-afdab827c52f?q=80&w=200',
      'category': 'Web Application',
      'rating': 4.8,
      'reviews': 78,
      'badge': 'New',
      'color': AppColors.itServices,
      'provider': 'WebApp Masters',
      'description':
      'Comprehensive SaaS dashboard with analytics, user management, and real-time data visualization.',
    },
    {
      'title': 'API Development',
      'price': '₹80,000',
      'oldPrice': '₹1,20,000',
      'imageUrl':
      'https://images.unsplash.com/photo-1558494949-ef010cbdcc31?q=80&w=200',
      'category': 'Web Application',
      'rating': 4.7,
      'reviews': 56,
      'badge': 'Popular',
      'color': AppColors.itServices,
      'provider': 'WebApp Masters',
      'description':
      'Custom REST API development with authentication, rate limiting, and comprehensive documentation.',
    },
    {
      'title': 'E-Learning Platform',
      'price': '₹2,50,000',
      'oldPrice': '₹3,50,000',
      'imageUrl':
      'https://images.unsplash.com/photo-1503676260728-1c00da094a0b?q=80&w=200',
      'category': 'Web Application',
      'rating': 4.9,
      'reviews': 89,
      'badge': 'Trending',
      'color': AppColors.itServices,
      'provider': 'WebApp Masters',
      'description':
      'Complete e-learning platform with video streaming, quizzes, and student progress tracking.',
    },
    // IoT & Robotics
    {
      'title': 'Smart Home System',
      'price': '₹2,00,000',
      'oldPrice': '₹2,80,000',
      'imageUrl':
      'https://images.unsplash.com/photo-1485827404703-89b55fcc595e?q=80&w=200',
      'category': 'IoT & Robotics',
      'rating': 4.9,
      'reviews': 45,
      'badge': 'IoT',
      'color': AppColors.ngo,
      'provider': 'RoboTech Innovations',
      'description':
      'Complete smart home automation system with voice control, sensors, and mobile app integration.',
    },
    {
      'title': 'Industrial Automation',
      'price': '₹3,50,000',
      'oldPrice': '₹4,50,000',
      'imageUrl':
      'https://images.unsplash.com/photo-1581091226825-a6a2a5aee158?q=80&w=200',
      'category': 'IoT & Robotics',
      'rating': 4.8,
      'reviews': 34,
      'badge': 'Industrial',
      'color': AppColors.ngo,
      'provider': 'RoboTech Innovations',
      'description':
      'Industrial automation system with PLC integration, remote monitoring, and predictive maintenance.',
    },
    {
      'title': 'Robotics Kit',
      'price': '₹1,50,000',
      'oldPrice': '₹2,00,000',
      'imageUrl':
      'https://images.unsplash.com/photo-1535378917042-10a22c95931a?q=80&w=200',
      'category': 'IoT & Robotics',
      'rating': 4.7,
      'reviews': 28,
      'badge': 'New',
      'color': AppColors.ngo,
      'provider': 'RoboTech Innovations',
      'description':
      'Educational robotics kit with sensors, actuators, and programming interface.',
    },
    // Game Development
    {
      'title': '3D Adventure Game',
      'price': '₹4,00,000',
      'oldPrice': '₹5,50,000',
      'imageUrl':
      'https://images.unsplash.com/photo-1552820728-8b83bb6b773f?q=80&w=200',
      'category': 'Game Development',
      'rating': 4.8,
      'reviews': 67,
      'badge': 'Trending',
      'color': AppColors.school,
      'provider': 'GameForge Studios',
      'description':
      'Immersive 3D adventure game with realistic graphics, story-driven gameplay, and multiplayer support.',
    },
    {
      'title': 'Mobile Game',
      'price': '₹2,50,000',
      'oldPrice': '₹3,50,000',
      'imageUrl':
      'https://images.unsplash.com/photo-1534422298391-e4f8c172dddb?q=80&w=200',
      'category': 'Game Development',
      'rating': 4.6,
      'reviews': 45,
      'badge': 'Popular',
      'color': AppColors.school,
      'provider': 'GameForge Studios',
      'description':
      'Casual mobile game with addictive gameplay, leaderboards, and in-app purchases.',
    },
    {
      'title': 'AR/VR Game',
      'price': '₹5,00,000',
      'oldPrice': '₹7,00,000',
      'imageUrl':
      'https://images.unsplash.com/photo-1622979135225-d2ba269cf1ac?q=80&w=200',
      'category': 'Game Development',
      'rating': 4.9,
      'reviews': 34,
      'badge': 'AR/VR',
      'color': AppColors.ott,
      'provider': 'GameForge Studios',
      'description':
      'Cutting-edge AR/VR game with immersive experiences, gesture controls, and 3D environments.',
    },
  ];

  List<Map<String, dynamic>> get filteredProjects {
    if (_selectedCategory == 'All') {
      return allProjects;
    }
    return allProjects
        .where((project) => project['category'] == _selectedCategory)
        .toList();
  }

  @override
  void initState() {
    super.initState();
    _selectedCategory = widget.initialCategory ?? 'All';

    bool categoryExists = categories.any((cat) => cat['name'] == _selectedCategory);
    if (!categoryExists && _selectedCategory != 'All') {
      _selectedCategory = 'All';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        surfaceTintColor: Colors.white,
        title: const Text(
          'IT Services',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: AppColors.textMain,
            letterSpacing: -0.5,
          ),
        ),
        backgroundColor: AppColors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_rounded,
              color: AppColors.textMain, size: 20),
          onPressed: () => Navigator.pop(context),
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1),
          child: Container(
            height: 1,
            color: AppColors.border,
          ),
        ),
      ),
      body: Row(
        children: [
          Container(
            width: 100,
            color: AppColors.white,
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(vertical: 8),
              itemCount: categories.length,
              itemBuilder: (context, index) {
                final category = categories[index];
                final isSelected = _selectedCategory == category['name'];
                return InkWell(
                  onTap: () {
                    setState(() {
                      _selectedCategory = category['name'];
                    });
                  },
                  child: Container(
                    padding:
                    const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
                    decoration: BoxDecoration(
                      color: isSelected
                          ? AppColors.itServices.withOpacity(0.08)
                          : Colors.transparent,
                      border: Border(
                        left: BorderSide(
                          color: isSelected
                              ? AppColors.itServices
                              : Colors.transparent,
                          width: 3,
                        ),
                      ),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            gradient: isSelected
                                ? LinearGradient(
                              colors: [
                                AppColors.itServices,
                                AppColors.itServices.withOpacity(0.6)
                              ],
                            )
                                : null,
                            color: isSelected
                                ? null
                                : category['color'].withOpacity(0.12),
                            shape: BoxShape.circle,
                            boxShadow: isSelected
                                ? [
                              BoxShadow(
                                color: AppColors.itServices
                                    .withOpacity(0.3),
                                blurRadius: 12,
                                offset: const Offset(0, 4),
                              ),
                            ]
                                : null,
                          ),
                          child: Icon(
                            category['icon'],
                            color: isSelected
                                ? AppColors.white
                                : category['color'],
                            size: 24,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          category['name'],
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight:
                            isSelected ? FontWeight.w700 : FontWeight.w500,
                            color: isSelected
                                ? AppColors.itServices
                                : AppColors.textSecondary,
                          ),
                          textAlign: TextAlign.center,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding:
                    const EdgeInsets.symmetric(horizontal: 4, vertical: 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          _selectedCategory == 'All'
                              ? 'All Projects'
                              : _selectedCategory,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: AppColors.textMain,
                            letterSpacing: -0.5,
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 4),
                          decoration: BoxDecoration(
                            color: AppColors.background,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            '${filteredProjects.length} projects',
                            style: const TextStyle(
                              fontSize: 12,
                              color: AppColors.textSecondary,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: filteredProjects.isEmpty
                        ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.inbox_rounded,
                            size: 64,
                            color: AppColors.textSecondary,
                          ),
                          const SizedBox(height: 12),
                          Text(
                            'No projects in this category',
                            style: TextStyle(
                              color: AppColors.textSecondary,
                              fontSize: 14,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Try selecting a different category',
                            style: TextStyle(
                              color: AppColors.textSecondary,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    )
                        : GridView.builder(
                      padding: const EdgeInsets.all(4),
                      gridDelegate:
                      const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 1,
                        childAspectRatio: 1.3,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10,
                      ),
                      itemCount: filteredProjects.length,
                      itemBuilder: (context, index) {
                        final project = filteredProjects[index];
                        return _buildProjectCard(project);
                      },
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

  Widget _buildProjectCard(Map<String, dynamic> project) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ItServiceDetailsScreen(
              project: project,
            ),
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: AppColors.shadow,
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: ClipRRect(
                borderRadius:
                const BorderRadius.vertical(top: Radius.circular(16)),
                child: Stack(
                  children: [
                    Image.network(
                      project['imageUrl'] ?? '',
                      width: double.infinity,
                      height: double.infinity,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) => Container(
                        color: AppColors.background,
                        child: const Icon(
                          Icons.image_not_supported_rounded,
                          size: 40,
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ),
                    Positioned(
                      top: 8,
                      left: 8,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 3),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              project['color'] ?? AppColors.itServices,
                              (project['color'] ?? AppColors.itServices)
                                  .withOpacity(0.8)
                            ],
                          ),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Text(
                          project['category'] ?? '',
                          style: const TextStyle(
                            color: AppColors.white,
                            fontSize: 8,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    if (project['badge'] != null)
                      Positioned(
                        top: 8,
                        right: 8,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 3),
                          decoration: BoxDecoration(
                            color: AppColors.textMain,
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Text(
                            project['badge'],
                            style: const TextStyle(
                              color: AppColors.white,
                              fontSize: 8,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    Positioned(
                      bottom: 8,
                      right: 8,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 6, vertical: 3),
                        decoration: BoxDecoration(
                          color: AppColors.textMain.withOpacity(0.7),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(
                              Icons.star_rounded,
                              color: AppColors.school,
                              size: 12,
                            ),
                            const SizedBox(width: 2),
                            Text(
                              (project['rating'] ?? 4.5).toString(),
                              style: const TextStyle(
                                color: AppColors.white,
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 8,
                      left: 8,
                      child: Container(
                        padding: const EdgeInsets.all(4),
                        decoration: const BoxDecoration(
                          color: AppColors.white,
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.favorite_border_rounded,
                          size: 14,
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    project['title'] ?? '',
                    style: const TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: AppColors.textMain,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 2),
                  Text(
                    project['provider'] ?? '',
                    style: const TextStyle(
                      fontSize: 10,
                      color: AppColors.textSecondary,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        project['price'] ?? '',
                        style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: AppColors.itServices,
                        ),
                      ),
                      if (project['oldPrice'] != null &&
                          project['oldPrice'] != '')
                        Text(
                          project['oldPrice'],
                          style: const TextStyle(
                            fontSize: 10,
                            color: AppColors.textSecondary,
                            decoration: TextDecoration.lineThrough,
                          ),
                        ),
                    ],
                  ),
                  if (project['reviews'] != null)
                    Text(
                      '${project['reviews']} reviews',
                      style: const TextStyle(
                        fontSize: 9,
                        color: AppColors.textSecondary,
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
}

// ========== IT SERVICE DETAILS SCREEN ==========
class ItServiceDetailsScreen extends StatefulWidget {
  final Map<String, dynamic> project;

  const ItServiceDetailsScreen({
    super.key,
    required this.project,
  });

  @override
  State<ItServiceDetailsScreen> createState() =>
      _ItServiceDetailsScreenState();
}

class _ItServiceDetailsScreenState extends State<ItServiceDetailsScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _messageController = TextEditingController();
  String _selectedBudget = '₹50,000 - ₹1,00,000';
  String _selectedTimeline = '1-2 weeks';
  bool _isLoading = false;

  final List<String> _budgetOptions = [
    '₹50,000 - ₹1,00,000',
    '₹1,00,000 - ₹2,50,000',
    '₹2,50,000 - ₹5,00,000',
    '₹5,00,000 - ₹10,00,000',
    '₹10,00,000+',
  ];

  final List<String> _timelineOptions = [
    '1-2 weeks',
    '2-4 weeks',
    '1-2 months',
    '2-3 months',
    '3-6 months',
  ];

  final List<Map<String, dynamic>> _projectFeatures = [
    {
      'icon': Icons.code_rounded,
      'label': 'Custom Development',
      'color': AppColors.itServices
    },
    {
      'icon': Icons.verified_rounded,
      'label': 'Quality Assurance',
      'color': AppColors.success
    },
    {
      'icon': Icons.timeline_rounded,
      'label': 'Timely Delivery',
      'color': AppColors.primary
    },
    {
      'icon': Icons.support_agent_rounded,
      'label': '24/7 Support',
      'color': AppColors.school
    },
    {
      'icon': Icons.source_rounded,
      'label': 'Source Code Included',
      'color': AppColors.ott
    },
    {
      'icon': Icons.security_rounded,
      'label': 'Data Security',
      'color': AppColors.ngo
    },
    {
      'icon': Icons.sync_rounded,
      'label': 'Regular Updates',
      'color': AppColors.accent
    },
    {
      'icon': Icons.people_rounded,
      'label': 'Dedicated Team',
      'color': AppColors.ecommerce
    },
  ];

  final List<Map<String, dynamic>> _techStack = [
    {'name': 'Flutter', 'color': AppColors.primary},
    {'name': 'Firebase', 'color': AppColors.school},
    {'name': 'Node.js', 'color': AppColors.success},
    {'name': 'MongoDB', 'color': AppColors.ngo},
    {'name': 'React', 'color': AppColors.itServices},
    {'name': 'AWS', 'color': AppColors.school},
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _messageController.dispose();
    super.dispose();
  }

  void _submitEnquiry() {
    if (_formKey.currentState!.validate()) {
      setState(() => _isLoading = true);

      Future.delayed(const Duration(seconds: 2), () {
        setState(() => _isLoading = false);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('✅ Enquiry sent successfully! We\'ll contact you soon.'),
            backgroundColor: AppColors.success,
            duration: Duration(seconds: 3),
          ),
        );
        _nameController.clear();
        _emailController.clear();
        _phoneController.clear();
        _messageController.clear();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final project = widget.project;

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        automaticallyImplyLeading: false,
        title: Text(
          project['title'] ?? 'Project Details',
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: AppColors.textMain,
          ),
        ),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            color: AppColors.white,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_rounded,
              color: AppColors.textMain, size: 20),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.favorite_border_rounded,
                color: AppColors.textMain, size: 22),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.share_rounded,
                color: AppColors.textMain, size: 22),
            onPressed: () {},
          ),
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(50),
          child: Container(
            color: AppColors.white,
            child: TabBar(
              controller: _tabController,
              indicatorColor: AppColors.itServices,
              indicatorWeight: 3,
              labelColor: AppColors.itServices,
              unselectedLabelColor: AppColors.textSecondary,
              labelStyle: const TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 13,
              ),
              unselectedLabelStyle: const TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 13,
              ),
              tabs: const [
                Tab(text: '📋 Overview'),
                Tab(text: '✨ Features'),
                Tab(text: '📩 Enquire'),
              ],
            ),
          ),
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildOverviewTab(project),
          _buildFeaturesTab(),
          _buildEnquireTab(),
        ],
      ),
    );
  }

  Widget _buildOverviewTab(Map<String, dynamic> project) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: Stack(
              children: [
                Image.network(
                  project['imageUrl'] ?? '',
                  height: 200,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) => Container(
                    height: 200,
                    color: AppColors.background,
                    child: const Icon(
                      Icons.image_not_supported_rounded,
                      size: 60,
                      color: AppColors.textSecondary,
                    ),
                  ),
                ),
                Positioned(
                  top: 12,
                  left: 12,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          project['color'] ?? AppColors.itServices,
                          (project['color'] ?? AppColors.itServices)
                              .withOpacity(0.8)
                        ],
                      ),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      project['badge'] ?? 'Featured',
                      style: const TextStyle(
                        color: AppColors.white,
                        fontSize: 11,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  bottom: 12,
                  right: 12,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 5),
                    decoration: BoxDecoration(
                      color: AppColors.textMain.withOpacity(0.7),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(Icons.star_rounded,
                            color: AppColors.school, size: 16),
                        const SizedBox(width: 4),
                        Text(
                          project['rating']?.toString() ?? '4.5',
                          style: const TextStyle(
                            color: AppColors.white,
                            fontSize: 13,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(width: 4),
                        Text(
                          '(${project['reviews'] ?? 0})',
                          style: const TextStyle(
                            color: AppColors.white,
                            fontSize: 11,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          Text(
            project['title'] ?? '',
            style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: AppColors.textMain,
            ),
          ),
          const SizedBox(height: 4),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
            decoration: BoxDecoration(
              color: AppColors.itServices.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              project['category'] ?? '',
              style: TextStyle(
                fontSize: 12,
                color: AppColors.itServices,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: AppColors.shadow,
                  blurRadius: 10,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Project Price',
                      style: TextStyle(
                        fontSize: 12,
                        color: AppColors.textSecondary,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      project['price'] ?? '₹0',
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: AppColors.itServices,
                      ),
                    ),
                    if (project['oldPrice'] != null)
                      Text(
                        project['oldPrice'],
                        style: const TextStyle(
                          fontSize: 12,
                          color: AppColors.textSecondary,
                          decoration: TextDecoration.lineThrough,
                        ),
                      ),
                  ],
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16, vertical: 8),
                  decoration: BoxDecoration(
                    color: AppColors.background,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    children: [
                      const Text(
                        'Reviews',
                        style: TextStyle(
                          fontSize: 11,
                          color: AppColors.textSecondary,
                        ),
                      ),
                      Text(
                        '${project['reviews'] ?? 0}',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: AppColors.textMain,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: AppColors.shadow,
                  blurRadius: 10,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Row(
              children: [
                Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    color: AppColors.background,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Icon(
                    Icons.business_rounded,
                    size: 28,
                    color: AppColors.textSecondary,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        project['provider'] ?? 'Unknown Provider',
                        style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          color: AppColors.textMain,
                        ),
                      ),
                      const Row(
                        children: [
                          Icon(Icons.verified_rounded,
                              color: AppColors.success, size: 14),
                          SizedBox(width: 4),
                          Text(
                            'Verified Partner',
                            style: TextStyle(
                              fontSize: 11,
                              color: AppColors.success,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                OutlinedButton(
                  onPressed: () {},
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: AppColors.itServices),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 8),
                  ),
                  child: const Text(
                    'Contact',
                    style: TextStyle(
                      color: AppColors.itServices,
                      fontWeight: FontWeight.w600,
                      fontSize: 12,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: AppColors.shadow,
                  blurRadius: 10,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Description',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textMain,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  project['description'] ?? 'No description available.',
                  style: const TextStyle(
                    fontSize: 14,
                    color: AppColors.textSecondary,
                    height: 1.6,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: AppColors.shadow,
                  blurRadius: 10,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Technology Stack',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textMain,
                  ),
                ),
                const SizedBox(height: 10),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: _techStack.map((tech) {
                    return Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        color: tech['color'].withOpacity(0.1),
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          color: tech['color'].withOpacity(0.3),
                          width: 1,
                        ),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.circle_rounded,
                            size: 6,
                            color: tech['color'],
                          ),
                          const SizedBox(width: 6),
                          Text(
                            tech['name'],
                            style: TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.w500,
                              color: tech['color'],
                            ),
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                ),
              ],
            ),
          ),
          const SizedBox(height: 40),
        ],
      ),
    );
  }

  Widget _buildFeaturesTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: AppColors.shadow,
                  blurRadius: 10,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  '✨ Key Features',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textMain,
                  ),
                ),
                const SizedBox(height: 4),
                const Text(
                  'Everything included in this project',
                  style: TextStyle(
                    fontSize: 13,
                    color: AppColors.textSecondary,
                  ),
                ),
                const SizedBox(height: 16),
                GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  padding: EdgeInsets.zero,
                  gridDelegate:
                  const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    childAspectRatio: 1,
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12,
                  ),
                  itemCount: _projectFeatures.length,
                  itemBuilder: (context, index) {
                    final feature = _projectFeatures[index];
                    return Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: feature['color'].withOpacity(0.08),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: feature['color'].withOpacity(0.2),
                          width: 1,
                        ),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Icon(
                            feature['icon'],
                            size: 28,
                            color: feature['color'],
                          ),
                          const SizedBox(height: 6),
                          Text(
                            feature['label'],
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              color: feature['color'],
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: AppColors.shadow,
                  blurRadius: 10,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  '📊 Delivery Process',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textMain,
                  ),
                ),
                const SizedBox(height: 4),
                const Text(
                  'How we bring your project to life',
                  style: TextStyle(
                    fontSize: 13,
                    color: AppColors.textSecondary,
                  ),
                ),
                const SizedBox(height: 16),
                ..._deliveryProcess.map((step) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: 28,
                          height: 28,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                AppColors.itServices,
                                AppColors.itServices.withOpacity(0.6)
                              ],
                            ),
                            shape: BoxShape.circle,
                          ),
                          child: Center(
                            child: Text(
                              step['step'],
                              style: const TextStyle(
                                color: AppColors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 11,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                step['title'],
                                style: const TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.textMain,
                                ),
                              ),
                              Text(
                                step['desc'],
                                style: const TextStyle(
                                  fontSize: 11,
                                  color: AppColors.textSecondary,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ],
            ),
          ),
          const SizedBox(height: 40),
        ],
      ),
    );
  }

  Widget _buildEnquireTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: AppColors.shadow,
              blurRadius: 10,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Row(
                children: [
                  Icon(Icons.send_rounded, color: AppColors.itServices),
                  SizedBox(width: 10),
                  Text(
                    'Get a Quote',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textMain,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 4),
              const Text(
                'Fill in the details and we\'ll get back to you within 24 hours',
                style: TextStyle(
                  fontSize: 13,
                  color: AppColors.textSecondary,
                ),
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(
                  labelText: 'Full Name *',
                  hintText: 'Enter your full name',
                  prefixIcon: const Icon(Icons.person_outline_rounded,
                      color: AppColors.itServices),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                  filled: true,
                  fillColor: AppColors.background,
                  contentPadding:
                  const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your name';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 14),
              TextFormField(
                controller: _emailController,
                decoration: InputDecoration(
                  labelText: 'Email Address *',
                  hintText: 'Enter your email address',
                  prefixIcon: const Icon(Icons.email_outlined,
                      color: AppColors.itServices),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                  filled: true,
                  fillColor: AppColors.background,
                  contentPadding:
                  const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your email';
                  }
                  if (!value.contains('@')) {
                    return 'Please enter a valid email';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 14),
              TextFormField(
                controller: _phoneController,
                decoration: InputDecoration(
                  labelText: 'Phone Number *',
                  hintText: 'Enter your phone number',
                  prefixIcon: const Icon(Icons.phone_outlined,
                      color: AppColors.itServices),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                  filled: true,
                  fillColor: AppColors.background,
                  contentPadding:
                  const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                ),
                keyboardType: TextInputType.phone,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your phone number';
                  }
                  if (value.length < 10) {
                    return 'Please enter a valid phone number';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 14),
              DropdownButtonFormField<String>(
                value: _selectedBudget,
                decoration: InputDecoration(
                  labelText: 'Budget Range',
                  prefixIcon: const Icon(Icons.currency_rupee_rounded,
                      color: AppColors.itServices),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                  filled: true,
                  fillColor: AppColors.background,
                  contentPadding:
                  const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                ),
                items: _budgetOptions.map((budget) {
                  return DropdownMenuItem(
                    value: budget,
                    child: Text(budget),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedBudget = value!;
                  });
                },
              ),
              const SizedBox(height: 14),
              DropdownButtonFormField<String>(
                value: _selectedTimeline,
                decoration: InputDecoration(
                  labelText: 'Project Timeline',
                  prefixIcon: const Icon(Icons.timer_outlined,
                      color: AppColors.itServices),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                  filled: true,
                  fillColor: AppColors.background,
                  contentPadding:
                  const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                ),
                items: _timelineOptions.map((timeline) {
                  return DropdownMenuItem(
                    value: timeline,
                    child: Text(timeline),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedTimeline = value!;
                  });
                },
              ),
              const SizedBox(height: 14),
              TextFormField(
                controller: _messageController,
                decoration: InputDecoration(
                  labelText: 'Message *',
                  hintText: 'Tell us about your project requirements...',
                  prefixIcon: const Icon(Icons.message_outlined,
                      color: AppColors.itServices),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                  filled: true,
                  fillColor: AppColors.background,
                  contentPadding:
                  const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                ),
                maxLines: 3,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your message';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _isLoading ? null : _submitEnquiry,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.itServices,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                  child: _isLoading
                      ? const SizedBox(
                    height: 20,
                    width: 20,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      color: AppColors.white,
                    ),
                  )
                      : const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.send_rounded,
                          color: AppColors.white),
                      SizedBox(width: 8),
                      Text(
                        'Send Enquiry',
                        style: TextStyle(
                          color: AppColors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 8),
              Center(
                child: Text(
                  'We respect your privacy. Your information is safe with us.',
                  style: TextStyle(
                    fontSize: 11,
                    color: AppColors.textSecondary,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  final List<Map<String, dynamic>> _deliveryProcess = [
    {
      'step': '1',
      'title': 'Requirement Analysis',
      'desc': 'Understanding your business needs'
    },
    {
      'step': '2',
      'title': 'Design & Prototype',
      'desc': 'Creating wireframes and designs'
    },
    {'step': '3', 'title': 'Development', 'desc': 'Building the actual solution'},
    {
      'step': '4',
      'title': 'Testing & QA',
      'desc': 'Rigorous quality assurance'
    },
    {'step': '5', 'title': 'Deployment', 'desc': 'Launching your project'},
    {

      'step': '6',
      'title': 'Maintenance',
      'desc': 'Ongoing support & updates'
    },
  ];
}

// ========== PROJECT DETAIL SCREEN ==========
class ProjectDetailScreen extends StatefulWidget {
  final Map<String, dynamic> order;

  const ProjectDetailScreen({super.key, required this.order});

  @override
  State<ProjectDetailScreen> createState() => _ProjectDetailScreenState();
}

class _ProjectDetailScreenState extends State<ProjectDetailScreen> {
  @override
  Widget build(BuildContext context) {
    final order = widget.order;

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Text(
          'Project ${order['id']}',
          style: const TextStyle(fontWeight: FontWeight.bold, color: AppColors.textMain),
        ),
        backgroundColor: AppColors.white,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_rounded,
              size: 20, color: AppColors.textMain),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.share_rounded, color: AppColors.textMain),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.shadow,
                    blurRadius: 10,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Project Status',
                            style: TextStyle(
                              fontSize: 14,
                              color: AppColors.textSecondary,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Row(
                            children: [
                              Icon(
                                order['icon'],
                                color: order['statusColor'],
                                size: 20,
                              ),
                              const SizedBox(width: 8),
                              Text(
                                order['status'],
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: order['statusColor'],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      Text(
                        order['date'],
                        style: TextStyle(
                          fontSize: 13,
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    'Progress Tracking',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: AppColors.textMain,
                    ),
                  ),
                  const SizedBox(height: 12),
                  ...(order['tracking'] as List<Map<String, dynamic>>)
                      .asMap()
                      .entries
                      .map((entry) {
                    final index = entry.key;
                    final track = entry.value;
                    final isCompleted = track['completed'];
                    final isLast = index == (order['tracking'] as List).length - 1;

                    return Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          children: [
                            Container(
                              width: 20,
                              height: 20,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: isCompleted ? order['statusColor'] : AppColors.border,
                                border: Border.all(
                                  color: isCompleted ? order['statusColor'] : AppColors.border,
                                  width: 2,
                                ),
                              ),
                              child: isCompleted
                                  ? const Icon(
                                Icons.check_rounded,
                                color: AppColors.white,
                                size: 12,
                              )
                                  : null,
                            ),
                            if (!isLast)
                              Container(
                                width: 2,
                                height: 30,
                                color: isCompleted ? order['statusColor'] : AppColors.border,
                              ),
                          ],
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.only(bottom: isLast ? 0 : 12),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  track['label'],
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: isCompleted ? FontWeight.w600 : FontWeight.w400,
                                    color: isCompleted ? AppColors.textMain : AppColors.textSecondary,
                                  ),
                                ),
                                Text(
                                  track['time'],
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: isCompleted ? AppColors.textSecondary : AppColors.textSecondary,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    );
                  }),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.shadow,
                    blurRadius: 10,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Project Details',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textMain,
                    ),
                  ),
                  const SizedBox(height: 12),
                  ...(order['items'] as List<Map<String, dynamic>>).map((item) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              '${item['quantity']}x ${item['name']}',
                              style: const TextStyle(
                                fontSize: 14,
                                color: AppColors.textMain,
                              ),
                            ),
                          ),
                          Text(
                            item['price'],
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: AppColors.textMain,
                            ),
                          ),
                        ],
                      ),
                    );
                  }),
                  const Divider(height: 16, color: AppColors.border),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Total Amount',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: AppColors.textMain,
                        ),
                      ),
                      Text(
                        order['total'],
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: AppColors.itServices,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.shadow,
                    blurRadius: 10,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Project Information',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textMain,
                    ),
                  ),
                  const SizedBox(height: 12),
                  _buildInfoRow(Icons.business_rounded, 'Provider', order['provider']),
                  _buildInfoRow(Icons.location_on_rounded, 'Address', order['deliveryAddress']),
                  _buildInfoRow(Icons.payment_rounded, 'Payment Method', order['paymentMethod']),
                  _buildInfoRow(Icons.calendar_today_rounded, 'Start Date', order['date']),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(color: AppColors.itServices),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 14),
                    ),
                    child: const Text(
                      'Back to Projects',
                      style: TextStyle(
                        color: AppColors.itServices,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                if (order['status'] == 'In Progress' || order['status'] == 'On Hold')
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        _showCancelDialog(context, order);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.itServices,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 14),
                      ),
                      child: const Text(
                        'Cancel Project',
                        style: TextStyle(
                          color: AppColors.white,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 80),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        children: [
          Icon(icon, size: 18, color: AppColors.textSecondary),
          const SizedBox(width: 12),
          Text(
            '$label: ',
            style: const TextStyle(
              fontWeight: FontWeight.w600,
              color: AppColors.textMain,
              fontSize: 14,
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(
                color: AppColors.textSecondary,
                fontSize: 14,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showCancelDialog(BuildContext context, Map<String, dynamic> order) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Cancel Project', style: TextStyle(color: AppColors.textMain)),
        content: Text('Are you sure you want to cancel ${order['id']}?',
            style: const TextStyle(color: AppColors.textSecondary)),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('No', style: TextStyle(color: AppColors.textSecondary)),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Project cancelled successfully!'),
                  backgroundColor: AppColors.itServices,
                ),
              );
            },
            child: const Text(
              'Yes, Cancel',
              style: TextStyle(color: AppColors.itServices),
            ),
          ),
        ],
      ),
    );
  }
}