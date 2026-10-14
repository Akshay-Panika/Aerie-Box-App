import 'package:flutter/material.dart';
import 'book_category_screen.dart';
import 'book_details_screen.dart'; // Add this import

class BookScreen extends StatefulWidget {
  const BookScreen({super.key});

  @override
  State<BookScreen> createState() => _BookScreenState();
}

class _BookScreenState extends State<BookScreen>
    with SingleTickerProviderStateMixin {
  bool isGridView = true;
  List<Book> books = [];
  List<Book> filteredBooks = [];
  String sortBy = 'nearby';
  bool isSearching = false;
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;

  final TextEditingController searchController = TextEditingController();

  // Categories for the top section
  final List<CategoryItem> categories = [
    CategoryItem(title: 'New Arrivals', subtitle: 'Latest books', icon: Icons.fiber_new, iconColor: Colors.red),
    CategoryItem(title: 'Best Sellers', subtitle: 'Top rated', icon: Icons.star, iconColor: Colors.orange),
  ];

  final List<SmallCategoryItem> smallCategories = [
    SmallCategoryItem(title: 'Fiction', icon: Icons.auto_stories, iconColor: Colors.purple),
    SmallCategoryItem(title: 'Non-Fiction', icon: Icons.menu_book, iconColor: Colors.teal),
    SmallCategoryItem(title: 'Academic', icon: Icons.school, iconColor: Colors.blue),
    SmallCategoryItem(title: 'Comics', icon: Icons.emoji_emotions, iconColor: Colors.pink),
    SmallCategoryItem(title: 'Novels', icon: Icons.book, iconColor: Colors.indigo),
    SmallCategoryItem(title: 'Biography', icon: Icons.person, iconColor: Colors.brown),
    SmallCategoryItem(title: 'Self-Help', icon: Icons.psychology, iconColor: Colors.green),
    SmallCategoryItem(title: 'More', icon: Icons.apps, iconColor: Colors.deepPurple),
  ];

  @override
  void initState() {
    super.initState();
    books = Book.getSampleBooks();
    filteredBooks = books;

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

  void _sortBooks() {
    switch (sortBy) {
      case 'nearby':
        filteredBooks.sort((a, b) => a.distance.compareTo(b.distance));
        break;
      case 'free':
        filteredBooks.sort((a, b) {
          bool aIsFree = a.price.toLowerCase() == 'free';
          bool bIsFree = b.price.toLowerCase() == 'free';
          if (aIsFree && !bIsFree) return -1;
          if (!aIsFree && bIsFree) return 1;
          return _getPriceValue(a.price).compareTo(_getPriceValue(b.price));
        });
        break;
      case 'paid':
        filteredBooks.sort((a, b) {
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
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12.0),
                    child: Container(
                      height: 180,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [Colors.blue.shade700, Colors.blue.shade400],
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
                            child: Icon(Icons.book, size: 150, color: Colors.white.withOpacity(0.2)),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(24.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text(
                                  "Discover New Books",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                const Text(
                                  "Explore our collection of top-rated\nbooks and start learning today.",
                                  style: TextStyle(
                                    color: Colors.white70,
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
                ),
                // Categories Section
                SliverToBoxAdapter(
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                    child: Column(
                      children: [
                        // Row 1: Big Cards
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
                        // Row 2: 4 small icons
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
                        // Row 3: 4 small icons
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
                  ),
                ),
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
                          _sortBooks();
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
                      child: _buildBookList(),
                    )
                ),
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    child: Center(
                      child: Text(
                        '${filteredBooks.length} books available for exchange',
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

  void _navigateToCategory(String category) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => BookCategoryScreen(selectedCategory: category),
      ),
    );
  }

  // Updated navigation method to use BookDetailsScreen
  void _navigateToBookDetails(Book book) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => BookDetailsScreen(book: book),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.only(top: 40, left: 0, right: 0),
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
                    icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    padding: const EdgeInsets.all(8),
                    iconSize: 22,
                  ),
                ),
                const SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Book Store',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                    Text(
                      'Find your next read',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey.shade700,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.blue[50],
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.book_rounded,
                        size: 16,
                        color: Colors.blue,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        '${books.length}',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue[700],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSearch() {
    return Container(
      height: 80,
      padding: EdgeInsets.all(12),
      child: Card(
        elevation: 0.2,
        color: Colors.grey.shade100,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: InkWell(
          onTap: () {
            print("Search tapped!");
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              children: [
                Icon(Icons.search, color: Colors.grey),
                const SizedBox(width: 10),
                Text(
                  "Search...",
                  style: TextStyle(color: Colors.grey, fontSize: 16),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildBookList() {
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
          itemCount: filteredBooks.length,
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
              child: BookCard(
                book: filteredBooks[index],
                onTap: () {
                  _navigateToBookDetails(filteredBooks[index]); // Updated
                },
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
          itemCount: filteredBooks.length,
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
              child: BookListItem(
                book: filteredBooks[index],
                onTap: () {
                  _navigateToBookDetails(filteredBooks[index]); // Updated
                },
              ),
            );
          },
        ),
      );
    }
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
          color: isSelected ? Colors.blue : Colors.grey[100],
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: isSelected ? Colors.blue : Colors.transparent,
            width: 1.5,
          ),
          boxShadow: isSelected
              ? [
            BoxShadow(
              color: Colors.blue.withOpacity(0.2),
              spreadRadius: 1,
              blurRadius: 4,
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

// ============== CATEGORY WIDGETS ==============
class _BigCategoryCard extends StatelessWidget {
  final String title;
  final String subtitle;
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
                  Text(
                    title,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    subtitle,
                    style: TextStyle(fontSize: 11, color: Colors.grey.shade600),
                  ),
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
              style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
            ),
          ],
        ),
      ),
    );
  }
}

// ============== BOOK LIST ITEM ==============
class BookListItem extends StatelessWidget {
  final Book book;
  final VoidCallback onTap;

  const BookListItem({super.key, required this.book, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 0, vertical: 6),
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
              tag: 'book_${book.id}',
              child: Container(
                width: 80,
                height: 100,
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Image.network(
                  book.imageUrl,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return const Icon(Icons.book, size: 40, color: Colors.grey);
                  },
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
                          book.title,
                          style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                            color: Colors.black87,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      if (book.isVerified)
                        const Icon(
                          Icons.verified_rounded,
                          color: Colors.blue,
                          size: 16,
                        ),
                    ],
                  ),
                  const SizedBox(height: 2),
                  Text(
                    book.author,
                    style: const TextStyle(fontSize: 13, color: Colors.grey),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Icon(
                        Icons.location_on_outlined,
                        size: 14,
                        color: Colors.grey[600],
                      ),
                      const SizedBox(width: 2),
                      Text(
                        book.location,
                        style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                      ),
                      const SizedBox(width: 8),
                      Icon(
                        Icons.directions_walk_rounded,
                        size: 14,
                        color: Colors.grey[600],
                      ),
                      const SizedBox(width: 2),
                      Text(
                        '${book.distance} km',
                        style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                      ),
                      const Spacer(),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 6,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          color: book.condition == 'Excellent'
                              ? Colors.green[50]
                              : book.condition == 'Like New'
                              ? Colors.blue[50]
                              : Colors.orange[50],
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Text(
                          book.condition,
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w600,
                            color: book.condition == 'Excellent'
                                ? Colors.green[700]
                                : book.condition == 'Like New'
                                ? Colors.blue[700]
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
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.blue[50],
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Text(
                          book.category,
                          style: TextStyle(
                            fontSize: 11,
                            color: Colors.blue[700],
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      Text(
                        book.price,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: book.type == 'Donate'
                              ? Colors.green
                              : Colors.blue,
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
                          const Icon(
                            Icons.person_outline_rounded,
                            size: 12,
                            color: Colors.grey,
                          ),
                          const SizedBox(width: 2),
                          Text(
                            book.donor,
                            style: const TextStyle(
                              fontSize: 11,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 14,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: book.type == 'Donate'
                                ? [Colors.green, Colors.green[700]!]
                                : [Colors.blue, Colors.blue[700]!],
                          ),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Text(
                          book.type == 'Donate' ? 'Request' : 'Buy',
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

// ============== BOOK CARD ==============
class BookCard extends StatelessWidget {
  final Book book;
  final VoidCallback onTap;

  const BookCard({super.key, required this.book, required this.onTap});

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
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(12),
                  ),
                  child: Hero(
                    tag: 'book_${book.id}',
                    child: Image.network(
                      book.imageUrl,
                      width: double.infinity,
                      height: 180,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          height: 180,
                          width: double.infinity,
                          color: Colors.grey[200],
                          child: const Center(
                            child: Icon(
                              Icons.book,
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
                              color: Colors.blue,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
                if (book.type == 'Donate')
                  Positioned(
                    top: 8,
                    left: 8,
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
                            color: Colors.green.withOpacity(0.3),
                            spreadRadius: 1,
                            blurRadius: 4,
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
                  bottom: 8,
                  right: 8,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 3,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.7),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      book.condition,
                      style: const TextStyle(color: Colors.white, fontSize: 10),
                    ),
                  ),
                ),
                if (book.isVerified)
                  Positioned(
                    top: 8,
                    right: 8,
                    child: Container(
                      padding: const EdgeInsets.all(4),
                      decoration: const BoxDecoration(
                        color: Colors.blue,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.verified_rounded,
                        color: Colors.white,
                        size: 14,
                      ),
                    ),
                  ),
                Positioned(
                  bottom: 8,
                  left: 8,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 3,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.7),
                      borderRadius: BorderRadius.circular(8),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 4,
                        ),
                      ],
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
                          '${book.distance} km',
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
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    book.title,
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
                    book.author,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(fontSize: 11, color: Colors.grey),
                  ),
                  const SizedBox(height: 6),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.blue[50],
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Text(
                          book.category,
                          style: TextStyle(
                            fontSize: 9,
                            color: Colors.blue[700],
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
                          color: book.condition == 'Excellent'
                              ? Colors.green[50]
                              : book.condition == 'Like New'
                              ? Colors.blue[50]
                              : Colors.orange[50],
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Text(
                          book.condition,
                          style: TextStyle(
                            fontSize: 9,
                            fontWeight: FontWeight.w600,
                            color: book.condition == 'Excellent'
                                ? Colors.green[700]
                                : book.condition == 'Like New'
                                ? Colors.blue[700]
                                : Colors.orange[700],
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      const Icon(
                        Icons.person_outline_rounded,
                        size: 10,
                        color: Colors.grey,
                      ),
                      const SizedBox(width: 2),
                      Expanded(
                        child: Text(
                          book.donor,
                          style: const TextStyle(
                            fontSize: 10,
                            color: Colors.grey,
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
                        book.price,
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: book.type == 'Donate'
                              ? Colors.green
                              : Colors.blue,
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 5,
                        ),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: book.type == 'Donate'
                                ? [Colors.green, Colors.green[700]!]
                                : [Colors.blue, Colors.blue[700]!],
                          ),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Text(
                          book.type == 'Donate' ? 'Request' : 'Buy',
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

// ============== CATEGORY DATA MODELS ==============
class CategoryItem {
  final String title;
  final String subtitle;
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

// ============== BOOK MODEL ==============
class Book {
  final String id;
  final String title;
  final String author;
  final String category;
  final String price;
  final String type;
  final String imageUrl;
  final String condition;
  final String donor;
  final String location;
  final bool isVerified;
  final double distance;

  Book({
    required this.id,
    required this.title,
    required this.author,
    required this.category,
    required this.price,
    required this.type,
    required this.imageUrl,
    required this.condition,
    required this.donor,
    required this.location,
    required this.isVerified,
    required this.distance,
  });

  static List<Book> getSampleBooks() {
    return [
      Book(
        id: '1',
        title: 'UPSC Civil Services Preliminary Exam',
        author: 'Arihant Publication',
        category: 'Government',
        price: '₹250',
        type: 'Sell',
        imageUrl:
        'https://images.unsplash.com/photo-1589829085413-56de8ae18c73?w=400&h=500&fit=crop',
        condition: 'Good',
        donor: 'Rahul Sharma',
        location: 'Delhi',
        isVerified: true,
        distance: 1.2,
      ),
      Book(
        id: '2',
        title: 'Concepts of Physics - JEE Advanced',
        author: 'HC Verma',
        category: 'College',
        price: 'Free',
        type: 'Donate',
        imageUrl:
        'https://images.unsplash.com/photo-1532012197267-da84d127e765?w=400&h=500&fit=crop',
        condition: 'Excellent',
        donor: 'Priya Singh',
        location: 'Mumbai',
        isVerified: true,
        distance: 2.5,
      ),
      Book(
        id: '3',
        title: 'Financial Accounting for Business',
        author: 'TS Grewal',
        category: 'Business',
        price: '₹350',
        type: 'Sell',
        imageUrl:
        'https://images.unsplash.com/photo-1589998059171-988d887df646?w=400&h=500&fit=crop',
        condition: 'Like New',
        donor: 'Amit Kumar',
        location: 'Bangalore',
        isVerified: false,
        distance: 3.8,
      ),
      Book(
        id: '4',
        title: 'Financial Management Principles',
        author: 'IM Pandey',
        category: 'Finance',
        price: 'Free',
        type: 'Donate',
        imageUrl:
        'https://images.unsplash.com/photo-1524995997946-a1c2e315a42f?w=400&h=500&fit=crop',
        condition: 'Good',
        donor: 'Sneha Patel',
        location: 'Chennai',
        isVerified: true,
        distance: 0.8,
      ),
      Book(
        id: '5',
        title: 'Science Textbook Class 10',
        author: 'NCERT',
        category: 'School',
        price: '₹120',
        type: 'Sell',
        imageUrl:
        'https://images.unsplash.com/photo-1544716278-ca5e3f4abd8c?w=400&h=500&fit=crop',
        condition: 'Used',
        donor: 'Mohan Das',
        location: 'Kolkata',
        isVerified: false,
        distance: 4.2,
      ),
      Book(
        id: '6',
        title: 'Quantitative Aptitude for Exams',
        author: 'RS Aggarwal',
        category: 'Competitive',
        price: 'Free',
        type: 'Donate',
        imageUrl:
        'https://images.unsplash.com/photo-1519681393784-d120267933ba?w=400&h=500&fit=crop',
        condition: 'Good',
        donor: 'Deepak Verma',
        location: 'Hyderabad',
        isVerified: true,
        distance: 1.9,
      ),
      Book(
        id: '7',
        title: 'The Psychology of Money',
        author: 'Morgan Housel',
        category: 'Finance',
        price: '₹450',
        type: 'Sell',
        imageUrl:
        'https://images.unsplash.com/photo-1544716278-ca5e3f4abd8c?w=400&h=500&fit=crop',
        condition: 'Excellent',
        donor: 'Vikram Patel',
        location: 'Delhi',
        isVerified: true,
        distance: 0.5,
      ),
      Book(
        id: '8',
        title: 'Data Structures & Algorithms',
        author: 'Thomas H. Cormen',
        category: 'College',
        price: 'Free',
        type: 'Donate',
        imageUrl:
        'https://images.unsplash.com/photo-1532012197267-da84d127e765?w=400&h=500&fit=crop',
        condition: 'Good',
        donor: 'Ananya Reddy',
        location: 'Bangalore',
        isVerified: true,
        distance: 3.2,
      ),
    ];
  }
}