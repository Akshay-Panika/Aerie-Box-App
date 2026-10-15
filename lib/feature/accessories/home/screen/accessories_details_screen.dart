import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

// Import with alias to avoid conflict
import 'package:carousel_slider/carousel_controller.dart' as carousel;

import 'accessories_home_screen.dart';

class AccessoriesDetailsScreen extends StatefulWidget {
  final Product product;

  const AccessoriesDetailsScreen({super.key, required this.product});

  @override
  State<AccessoriesDetailsScreen> createState() =>
      _AccessoriesDetailsScreenState();
}

class _AccessoriesDetailsScreenState extends State<AccessoriesDetailsScreen> {
  bool _isFavorite = false;
  int _selectedImageIndex = 0;

  // ✅ Carousel controller
  final carousel.CarouselSliderController _carouselController =
  carousel.CarouselSliderController();

  // ✅ Product images (product ka image + samples)
  late final List<String> productImages = [
    widget.product.imageUrl,
    'https://picsum.photos/seed/gadget1/800/500',
    'https://picsum.photos/seed/gadget2/800/500',
    'https://picsum.photos/seed/gadget3/800/500',
    'https://picsum.photos/seed/gadget4/800/500',
  ];

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final product = widget.product;
    final isDonate = product.type == 'Donate';

    // ✅ Purple theme colors (dynamic)
    final Color primaryColor =
    isDonate ? Colors.green.shade700 : const Color(0xFF5F259F);

    return Scaffold(
      backgroundColor: isDark ? Colors.grey[900] : Colors.grey[50],
      // ══════════ TOP APP BAR (same style as RoomDetailsScreen) ══════════
      appBar: AppBar(
        backgroundColor: primaryColor,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () => Navigator.pop(context),
          padding: EdgeInsets.zero,
        ),
        title: Text(
          'Product Details',
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(
              _isFavorite ? Icons.favorite : Icons.favorite_border,
              color: _isFavorite ? Colors.red : Colors.white,
            ),
            onPressed: () => setState(() => _isFavorite = !_isFavorite),
          ),
          IconButton(
            icon: const Icon(Icons.share, color: Colors.white),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Share coming soon!'),
                  behavior: SnackBarBehavior.floating,
                ),
              );
            },
          ),
        ],
      ),
      body: CustomScrollView(
        slivers: [
          // ══════════ CAROUSEL SLIVER ══════════
          SliverAppBar(
            expandedHeight: 380,
            pinned: false,
            elevation: 0,
            automaticallyImplyLeading: false,
            backgroundColor: primaryColor,
            flexibleSpace: FlexibleSpaceBar(
              background: Stack(
                fit: StackFit.expand,
                children: [
                  // Carousel Slider
                  CarouselSlider.builder(
                    carouselController: _carouselController,
                    itemCount: productImages.length,
                    options: CarouselOptions(
                      height: 380,
                      viewportFraction: 1.0,
                      enableInfiniteScroll: true,
                      autoPlay: true,
                      autoPlayInterval: const Duration(seconds: 4),
                      autoPlayAnimationDuration:
                      const Duration(milliseconds: 800),
                      autoPlayCurve: Curves.fastOutSlowIn,
                      enlargeCenterPage: false,
                      onPageChanged: (index, reason) {
                        setState(() => _selectedImageIndex = index);
                      },
                    ),
                    itemBuilder: (context, index, realIndex) {
                      return Hero(
                        tag: index == 0
                            ? 'product_${product.id}'
                            : 'product_${product.id}_$index',
                        child: Image.network(
                          productImages[index],
                          fit: BoxFit.cover,
                          errorBuilder: (_, __, ___) => Container(
                            color: Colors.grey.shade200,
                            child: const Icon(
                              Icons.image_not_supported,
                              size: 60,
                              color: Colors.grey,
                            ),
                          ),
                          loadingBuilder: (context, child, loadingProgress) {
                            if (loadingProgress == null) return child;
                            return Container(
                              color: Colors.grey.shade100,
                              child: Center(
                                child: CircularProgressIndicator(
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                      primaryColor),
                                ),
                              ),
                            );
                          },
                        ),
                      );
                    },
                  ),

                  // Gradient Overlay
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.transparent,
                          Colors.transparent,
                          Colors.black.withOpacity(0.4),
                        ],
                      ),
                    ),
                  ),

                  // ✅ Image Indicator (Dots)
                  Positioned(
                    bottom: 20,
                    left: 0,
                    right: 0,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(
                        productImages.length,
                            (index) => AnimatedContainer(
                          duration: const Duration(milliseconds: 300),
                          margin: const EdgeInsets.symmetric(horizontal: 4),
                          width: _selectedImageIndex == index ? 24 : 8,
                          height: 8,
                          decoration: BoxDecoration(
                            color: _selectedImageIndex == index
                                ? primaryColor
                                : Colors.white.withOpacity(0.5),
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                      ),
                    ),
                  ),

                  // ✅ Price Tag
                  Positioned(
                    bottom: 60,
                    right: 16,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 10),
                      decoration: BoxDecoration(
                        color: primaryColor,
                        borderRadius: BorderRadius.circular(14),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.3),
                            blurRadius: 12,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            product.price,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            isDonate ? '🟢 Available Free' : '🟢 Available Now',
                            style: TextStyle(
                              color: Colors.lightGreen.shade200,
                              fontSize: 10,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  // ✅ Left Navigation Arrow
                  Positioned(
                    top: 0,
                    bottom: 0,
                    left: 8,
                    child: Center(
                      child: GestureDetector(
                        onTap: () {
                          _carouselController.previousPage(
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.easeInOut,
                          );
                        },
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: Colors.black.withOpacity(0.4),
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.chevron_left,
                            color: Colors.white,
                            size: 28,
                          ),
                        ),
                      ),
                    ),
                  ),

                  // ✅ Right Navigation Arrow
                  Positioned(
                    top: 0,
                    bottom: 0,
                    right: 8,
                    child: Center(
                      child: GestureDetector(
                        onTap: () {
                          _carouselController.nextPage(
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.easeInOut,
                          );
                        },
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: Colors.black.withOpacity(0.4),
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.chevron_right,
                            color: Colors.white,
                            size: 28,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // ══════════ CONTENT SLIVER ══════════
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Title + Verified badge
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          product.title,
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: isDark
                                ? Colors.white
                                : const Color(0xFF1E293B),
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      if (product.isVerified)
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 4),
                          decoration: BoxDecoration(
                            color: primaryColor.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                                color: primaryColor.withOpacity(0.3)),
                          ),
                          child: Row(
                            children: [
                              Icon(Icons.verified_rounded,
                                  size: 14, color: primaryColor),
                              const SizedBox(width: 4),
                              Text(
                                'Verified',
                                style: TextStyle(
                                  fontSize: 11,
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                    ],
                  ),
                  const SizedBox(height: 6),

                  // Brand
                  Text(
                    'by ${product.brand}',
                    style: TextStyle(
                      fontSize: 14,
                      color: isDark ? Colors.grey[400] : Colors.grey[600],
                    ),
                  ),
                  const SizedBox(height: 10),

                  // Location + Distance
                  Row(
                    children: [
                      Icon(Icons.location_on_rounded,
                          size: 18, color: Colors.grey.shade600),
                      const SizedBox(width: 6),
                      Expanded(
                        child: Text(
                          product.location,
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey.shade600,
                          ),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 2),
                        decoration: BoxDecoration(
                          color: Colors.green.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Row(
                          children: [
                            Icon(Icons.location_on_rounded,
                                size: 12, color: Colors.green.shade700),
                            const SizedBox(width: 2),
                            Text(
                              '${product.distance} km',
                              style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.w600,
                                color: Colors.green.shade700,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),

                  // Stats Row (Category / Condition / Type)
                  Row(
                    children: [
                      _buildStatItem(
                        Icons.category_rounded,
                        product.category,
                        'Category',
                        primaryColor,
                        isDark,
                      ),
                      const SizedBox(width: 8),
                      _buildStatItem(
                        Icons.bookmark_outline,
                        product.condition,
                        'Condition',
                        product.condition == 'New'
                            ? Colors.green
                            : product.condition == 'Like New'
                            ? Colors.purple
                            : Colors.orange,
                        isDark,
                      ),
                      const SizedBox(width: 8),
                      _buildStatItem(
                        Icons.sell_outlined,
                        product.type,
                        'Type',
                        isDonate ? Colors.green : primaryColor,
                        isDark,
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),

                  // Details Grid
                  _buildDetailsGrid(isDark, primaryColor),
                  const SizedBox(height: 20),

                  // Contact Card
                  _buildContactCard(context, isDark, primaryColor, isDonate),
                  const SizedBox(height: 20),

                  // About
                  _buildAboutCard(isDark),
                  const SizedBox(height: 20),

                  // Gallery thumbnails
                  _buildGalleryThumbnails(context, isDark),
                  const SizedBox(height: 20),

                  // Action Buttons
                  _buildActionButtons(context, isDark, isDonate),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ══════════ STAT ITEM ══════════
  Widget _buildStatItem(
      IconData icon,
      String value,
      String label,
      Color color,
      bool isDark,
      ) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
          color: isDark ? Colors.grey[850] : Colors.grey.shade50,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: isDark ? Colors.grey[700]! : Colors.grey.shade200,
          ),
        ),
        child: Column(
          children: [
            Icon(icon, size: 20, color: color),
            const SizedBox(height: 4),
            Text(
              value,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: isDark ? Colors.white : const Color(0xFF1E293B),
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            Text(
              label,
              style: TextStyle(
                fontSize: 10,
                color: isDark ? Colors.grey[500] : Colors.grey.shade500,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ══════════ DETAILS GRID ══════════
  Widget _buildDetailsGrid(bool isDark, Color primaryColor) {
    final product = widget.product;
    final isDonate = product.type == 'Donate';

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isDark ? Colors.grey[850] : Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Product Details',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: isDark ? Colors.white : const Color(0xFF1E293B),
            ),
          ),
          const SizedBox(height: 12),
          GridView.count(
            shrinkWrap: true,
            padding: EdgeInsets.zero,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisCount: 2,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            childAspectRatio: 2.6,
            children: [
              _buildDetailCard(
                icon: Icons.category_outlined,
                label: 'Category',
                value: product.category,
                isDark: isDark,
              ),
              _buildDetailCard(
                icon: Icons.bookmark_outline,
                label: 'Condition',
                value: product.condition,
                color: product.condition == 'New'
                    ? Colors.green
                    : product.condition == 'Like New'
                    ? Colors.purple
                    : Colors.orange,
                isDark: isDark,
              ),
              _buildDetailCard(
                icon: Icons.info_outline,
                label: 'Availability',
                value: isDonate ? 'Free' : 'In Stock',
                color: isDonate ? Colors.green : primaryColor,
                isDark: isDark,
              ),
              _buildDetailCard(
                icon: Icons.verified_outlined,
                label: 'Status',
                value: product.isVerified ? 'Verified' : 'Unverified',
                color: product.isVerified ? Colors.green : Colors.orange,
                isDark: isDark,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDetailCard({
    required IconData icon,
    required String label,
    required String value,
    Color? color,
    required bool isDark,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: isDark ? Colors.grey[800] : Colors.grey[50],
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: isDark ? Colors.grey[700]! : Colors.grey[200]!,
        ),
      ),
      child: Row(
        children: [
          Icon(icon,
              size: 20,
              color: color ?? (isDark ? Colors.grey[400] : Colors.grey[600])),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  label,
                  style: TextStyle(
                    fontSize: 10,
                    color: isDark ? Colors.grey[500] : Colors.grey[500],
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  value,
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: color ?? (isDark ? Colors.white : Colors.black87),
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ══════════ CONTACT CARD ══════════
  Widget _buildContactCard(
      BuildContext context,
      bool isDark,
      Color primaryColor,
      bool isDonate,
      ) {
    final product = widget.product;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: isDonate
              ? [Colors.green.shade50, Colors.green.shade100]
              : [const Color(0xFFF3E5FF), const Color(0xFFE8D5FF)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isDonate ? Colors.green.shade200 : primaryColor.withOpacity(0.2),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  isDonate ? Icons.volunteer_activism : Icons.storefront,
                  color: isDonate ? Colors.green : primaryColor,
                  size: 26,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      isDonate ? 'Donor Information' : 'Seller Information',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: isDark ? Colors.white : Colors.black87,
                      ),
                    ),
                    Text(
                      isDonate
                          ? 'Contact the donor to get this item'
                          : 'Contact the seller for purchase details',
                      style: TextStyle(
                        fontSize: 12,
                        color: isDark ? Colors.grey[400] : Colors.grey[600],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Divider(
              color: isDark ? Colors.grey[700] : Colors.grey[300], height: 1),
          const SizedBox(height: 16),

          Row(
            children: [
              Expanded(
                child: _buildContactInfo(
                  icon: Icons.person_outline,
                  label: 'Name',
                  value: product.seller,
                  isDark: isDark,
                ),
              ),
              Expanded(
                child: _buildContactInfo(
                  icon: Icons.location_on_outlined,
                  label: 'Location',
                  value: product.location,
                  isDark: isDark,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: _buildContactInfo(
                  icon: Icons.phone_outlined,
                  label: 'Phone',
                  value: '+91 ${_generatePhoneNumber(product.seller)}',
                  isDark: isDark,
                ),
              ),
              Expanded(
                child: _buildContactInfo(
                  icon: Icons.email_outlined,
                  label: 'Email',
                  value:
                  '${product.seller.toLowerCase().replaceAll(' ', '.')}@email.com',
                  isDark: isDark,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),

          Row(
            children: [
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: () =>
                      _showContactOptions(context, isDark, primaryColor),
                  icon: const Icon(Icons.contact_phone,
                      color: Colors.white, size: 18),
                  label: const Text(
                    'Contact Now',
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primaryColor,
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Message sent to ${product.seller}!'),
                        backgroundColor: primaryColor,
                        behavior: SnackBarBehavior.floating,
                      ),
                    );
                  },
                  icon: Icon(Icons.message_outlined,
                      size: 18, color: primaryColor),
                  label: Text(
                    'Message',
                    style: TextStyle(
                        color: primaryColor, fontWeight: FontWeight.bold),
                  ),
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    side: BorderSide(color: primaryColor, width: 1.5),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  String _generatePhoneNumber(String seller) {
    String hash = seller.hashCode.abs().toString();
    while (hash.length < 10) {
      hash = '0$hash';
    }
    return hash.substring(0, 10);
  }

  Widget _buildContactInfo({
    required IconData icon,
    required String label,
    required String value,
    required bool isDark,
  }) {
    return Row(
      children: [
        Icon(icon,
            size: 16, color: isDark ? Colors.grey[400] : Colors.grey[600]),
        const SizedBox(width: 8),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(label,
                  style: TextStyle(
                    fontSize: 10,
                    color: isDark ? Colors.grey[500] : Colors.grey[500],
                  )),
              Text(
                value,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: isDark ? Colors.white : Colors.black87,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ],
    );
  }

  // ══════════ ABOUT CARD ══════════
  Widget _buildAboutCard(bool isDark) {
    final product = widget.product;
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isDark ? Colors.grey[850] : Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'About this Product',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: isDark ? Colors.white : const Color(0xFF1E293B),
            ),
          ),
          const SizedBox(height: 12),
          Text(
            'A premium ${product.category} product from ${product.brand}. '
                'This item is in ${product.condition.toLowerCase()} condition and '
                'is available for ${product.type.toLowerCase()} at ${product.price}. '
                'Located in ${product.location}, ${product.distance} km away.',
            style: TextStyle(
              fontSize: 14,
              height: 1.6,
              color: isDark ? Colors.grey[300] : Colors.grey[700],
            ),
          ),
        ],
      ),
    );
  }

  // ══════════ GALLERY THUMBNAILS ══════════
  Widget _buildGalleryThumbnails(BuildContext context, bool isDark) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'More Images',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: isDark ? Colors.white : const Color(0xFF1E293B),
          ),
        ),
        const SizedBox(height: 10),
        SizedBox(
          height: 90,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: productImages.length,
            itemBuilder: (context, index) {
              final isSelected = _selectedImageIndex == index;
              return GestureDetector(
                onTap: () {
                  setState(() => _selectedImageIndex = index);
                  _carouselController.animateToPage(index);
                },
                child: Container(
                  width: 90,
                  margin: const EdgeInsets.only(right: 10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: isSelected
                          ? const Color(0xFF5F259F)
                          : Colors.transparent,
                      width: 2,
                    ),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.network(
                      productImages[index],
                      fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) => Container(
                        color: isDark ? Colors.grey[800] : Colors.grey[200],
                        child: const Icon(Icons.broken_image,
                            size: 30, color: Colors.grey),
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  // ══════════ ACTION BUTTONS ══════════
  Widget _buildActionButtons(
      BuildContext context, bool isDark, bool isDonate) {
    final product = widget.product;
    final primaryColor =
    isDonate ? Colors.green.shade700 : const Color(0xFF5F259F);

    return Row(
      children: [
        Expanded(
          child: OutlinedButton.icon(
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Added to wishlist!'),
                  backgroundColor: Color(0xFF5F259F),
                ),
              );
            },
            icon: const Icon(Icons.favorite_border, size: 20),
            label: const Text('Wishlist'),
            style: OutlinedButton.styleFrom(
              foregroundColor: primaryColor,
              padding: const EdgeInsets.symmetric(vertical: 14),
              side: BorderSide(color: primaryColor),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
            ),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          flex: 2,
          child: ElevatedButton.icon(
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    isDonate
                        ? 'Request sent for ${product.title} 📦'
                        : 'Added ${product.title} to cart 🛒',
                  ),
                  backgroundColor: primaryColor,
                  behavior: SnackBarBehavior.floating,
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: primaryColor,
              padding: const EdgeInsets.symmetric(vertical: 14),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
              elevation: 2,
            ),
            icon: Icon(
              isDonate ? Icons.favorite : Icons.shopping_bag,
              color: Colors.white,
              size: 20,
            ),
            label: Text(
              isDonate ? 'Request Item' : 'Buy Now',
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ),
        ),
      ],
    );
  }

  // ══════════ CONTACT OPTIONS BOTTOM SHEET ══════════
  void _showContactOptions(
      BuildContext context, bool isDark, Color primaryColor) {
    final product = widget.product;
    showModalBottomSheet(
      context: context,
      backgroundColor: isDark ? Colors.grey[900] : Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: isDark ? Colors.grey[600] : Colors.grey[300],
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Text(
                'Contact ${product.seller}',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: isDark ? Colors.white : Colors.black87,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Choose how you want to connect',
                style: TextStyle(
                  fontSize: 14,
                  color: isDark ? Colors.grey[400] : Colors.grey[600],
                ),
              ),
              const SizedBox(height: 20),
              _buildContactOption(
                context,
                icon: Icons.phone,
                title: 'Call',
                subtitle: 'Direct call',
                color: Colors.green,
                isDark: isDark,
                onTap: () {
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                        content: Text('Calling... 📞'),
                        backgroundColor: Colors.green),
                  );
                },
              ),
              const SizedBox(height: 12),
              _buildContactOption(
                context,
                icon: Icons.chat,
                title: 'Chat',
                subtitle: 'Send a message',
                color: primaryColor,
                isDark: isDark,
                onTap: () {
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                        content: const Text('Opening chat... 💬'),
                        backgroundColor: primaryColor),
                  );
                },
              ),
              const SizedBox(height: 12),
              _buildContactOption(
                context,
                icon: Icons.email,
                title: 'Email',
                subtitle: 'Send an email',
                color: Colors.orange,
                isDark: isDark,
                onTap: () {
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                        content: Text('Opening email... ✉️'),
                        backgroundColor: Colors.orange),
                  );
                },
              ),
              const SizedBox(height: 12),
            ],
          ),
        );
      },
    );
  }

  Widget _buildContactOption(
      BuildContext context, {
        required IconData icon,
        required String title,
        required String subtitle,
        required Color color,
        required bool isDark,
        required VoidCallback onTap,
      }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isDark ? Colors.grey[800] : Colors.grey[50],
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isDark ? Colors.grey[700]! : Colors.grey[200]!,
          ),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: color, size: 24),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: isDark ? Colors.white : Colors.black87,
                    ),
                  ),
                  Text(
                    subtitle,
                    style: TextStyle(
                      fontSize: 13,
                      color: isDark ? Colors.grey[400] : Colors.grey[600],
                    ),
                  ),
                ],
              ),
            ),
            Icon(
              Icons.arrow_forward_ios,
              size: 16,
              color: isDark ? Colors.grey[500] : Colors.grey[400],
            ),
          ],
        ),
      ),
    );
  }
}