import 'package:flutter/material.dart';
import '../../home/screen/book_home_screen.dart';
import '../../home/screen/book_details_screen.dart';

class BookCategoryScreen extends StatefulWidget {
  final String selectedCategory;

  const BookCategoryScreen({
    super.key,
    required this.selectedCategory,
  });

  @override
  State<BookCategoryScreen> createState() => _BookCategoryScreenState();
}

class _BookCategoryScreenState extends State<BookCategoryScreen> {
  bool isGridView = true;
  String searchQuery = '';
  int _selectedCategoryIndex = 0;

  final List<CategoryTab> categoryTabs = [
    CategoryTab(name: 'All', icon: Icons.apps_rounded, color: Colors.blue),
    CategoryTab(name: 'Fiction', icon: Icons.auto_stories, color: Colors.purple),
    CategoryTab(name: 'Non-Fiction', icon: Icons.menu_book, color: Colors.teal),
    CategoryTab(name: 'Academic', icon: Icons.school, color: Colors.orange),
    CategoryTab(name: 'Novels', icon: Icons.book, color: Colors.indigo),
    CategoryTab(name: 'Finance', icon: Icons.attach_money, color: Colors.green),
    CategoryTab(name: 'Comics', icon: Icons.emoji_emotions, color: Colors.pink),
    CategoryTab(name: 'Biography', icon: Icons.person, color: Colors.brown),
    CategoryTab(name: 'Self-Help', icon: Icons.psychology, color: Colors.cyan),
    CategoryTab(name: 'Business', icon: Icons.business_center, color: Colors.deepOrange),
    CategoryTab(name: 'Competitive', icon: Icons.emoji_events, color: Colors.amber),
    CategoryTab(name: 'Government', icon: Icons.account_balance, color: Colors.red),
    CategoryTab(name: 'College', icon: Icons.school_rounded, color: Colors.deepPurple),
    CategoryTab(name: 'School', icon: Icons.baby_changing_station, color: Colors.lightBlue),
  ];

  @override
  void initState() {
    super.initState();
    _applySelectedCategory(widget.selectedCategory);
  }

  // ✅ NEW: Parent se category change hone par update
  @override
  void didUpdateWidget(covariant BookCategoryScreen oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.selectedCategory != widget.selectedCategory) {
      _applySelectedCategory(widget.selectedCategory);
    }
  }

  void _applySelectedCategory(String category) {
    if (category.isEmpty) {
      _selectedCategoryIndex = 0;
      return;
    }
    // "More" → "All"
    if (category == 'All' || category == 'More') {
      _selectedCategoryIndex = 0;
      return;
    }
    final index = categoryTabs.indexWhere((tab) => tab.name == category);
    if (index != -1) {
      _selectedCategoryIndex = index;
    }
  }

  List<Book> _getFilteredBooks(String category, String query) {
    final allBooks = Book.getSampleBooks();

    // 👇 "All" aur "More" dono me saare books
    var books = (category == 'All' || category == 'More')
        ? allBooks
        : allBooks.where((book) => book.category == category).toList();

    if (query.isNotEmpty) {
      books = books.where((book) =>
      book.title.toLowerCase().contains(query.toLowerCase()) ||
          book.author.toLowerCase().contains(query.toLowerCase())
      ).toList();
    }

    return books;
  }

  void _navigateToBookDetails(Book book) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => BookDetailsScreen(book: book),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final currentCategory = categoryTabs[_selectedCategoryIndex].name;
    final books = _getFilteredBooks(currentCategory, searchQuery);

    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: Column(
        children: [
          _buildHeader(),
          _buildSearchBar(),
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // ── LEFT: Vertical Category Sidebar ──
                _buildCategorySidebar(),

                // ── RIGHT: Books Grid/List ──
                Expanded(child: _buildBookContent(books, currentCategory)),
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
                    icon: const Icon(Icons.school, color: Colors.black),
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
                      'Categories',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                    Text(
                      'Browse by category',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey[600],
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
                        '${Book.getSampleBooks().length}',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue[700],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 8),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.grey[100],
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: IconButton(
                    icon: Icon(
                      isGridView ? Icons.list_rounded : Icons.grid_view_rounded,
                      color: Colors.black87,
                      size: 22,
                    ),
                    onPressed: () {
                      setState(() {
                        isGridView = !isGridView;
                      });
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // ══════════ SEARCH BAR ══════════
  Widget _buildSearchBar() {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.fromLTRB(12, 0, 12, 12),
      child: TextField(
        onChanged: (value) => setState(() => searchQuery = value),
        decoration: InputDecoration(
          hintText: 'Search by title or author...',
          hintStyle: TextStyle(color: Colors.grey[500], fontSize: 14),
          prefixIcon: const Icon(Icons.search, color: Colors.grey, size: 22),
          suffixIcon: searchQuery.isNotEmpty
              ? IconButton(
            icon: const Icon(Icons.clear, size: 20, color: Colors.grey),
            onPressed: () => setState(() => searchQuery = ''),
          )
              : null,
          filled: true,
          fillColor: Colors.grey.shade100,
          contentPadding: const EdgeInsets.symmetric(vertical: 12),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }

  // ══════════ LEFT SIDEBAR ══════════
  Widget _buildCategorySidebar() {
    return Container(
      width: 100,
      color: Colors.grey[100],
      child: ListView.builder(
        padding: const EdgeInsets.symmetric(vertical: 8),
        itemCount: categoryTabs.length,
        itemBuilder: (context, index) {
          final tab = categoryTabs[index];
          final isSelected = _selectedCategoryIndex == index;
          final count = tab.name == 'All'
              ? Book.getSampleBooks().length
              : _getFilteredBooks(tab.name, '').length;

          return GestureDetector(
            onTap: () {
              setState(() => _selectedCategoryIndex = index);
            },
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 180),
              margin: const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 6),
              decoration: BoxDecoration(
                color: isSelected ? Colors.white : Colors.transparent,
                borderRadius: BorderRadius.circular(12),
                border: isSelected
                    ? Border(
                  left: BorderSide(color: tab.color, width: 4),
                )
                    : null,
                boxShadow: isSelected
                    ? [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ]
                    : null,
              ),
              child: Column(
                children: [
                  Icon(
                    tab.icon,
                    size: 22,
                    color: isSelected ? tab.color : Colors.grey[600],
                  ),
                  const SizedBox(height: 6),
                  Text(
                    tab.name,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 10.5,
                      fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                      color: isSelected ? Colors.black87 : Colors.grey[700],
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  if (tab.name != 'All') ...[
                    const SizedBox(height: 4),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 6,
                        vertical: 1,
                      ),
                      decoration: BoxDecoration(
                        color: isSelected
                            ? tab.color.withOpacity(0.15)
                            : Colors.grey[200],
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        '$count',
                        style: TextStyle(
                          fontSize: 9,
                          color: isSelected ? tab.color : Colors.grey[600],
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ],
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  // ══════════ RIGHT: BOOK CONTENT ══════════
  Widget _buildBookContent(List<Book> books, String categoryName) {
    if (books.isEmpty) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.book_outlined,
                size: 64,
                color: Colors.grey[300],
              ),
              const SizedBox(height: 14),
              Text(
                searchQuery.isNotEmpty
                    ? 'No matching books'
                    : 'No books in $categoryName',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Colors.grey[600],
                ),
              ),
              const SizedBox(height: 6),
              Text(
                searchQuery.isNotEmpty
                    ? 'Try adjusting your search'
                    : 'Check other categories',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 12, color: Colors.grey[500]),
              ),
              if (searchQuery.isNotEmpty) ...[
                const SizedBox(height: 16),
                ElevatedButton.icon(
                  onPressed: () => setState(() => searchQuery = ''),
                  icon: const Icon(Icons.clear_rounded, size: 16),
                  label: const Text('Clear'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ],
            ],
          ),
        ),
      );
    }

    return Column(
      children: [
        // ── Result header ──
        Padding(
          padding: const EdgeInsets.fromLTRB(12, 12, 12, 4),
          child: Row(
            children: [
              Text(
                categoryName,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(width: 6),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 8,
                  vertical: 2,
                ),
                decoration: BoxDecoration(
                  color: Colors.blue[50],
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  '${books.length}',
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue[700],
                  ),
                ),
              ),
            ],
          ),
        ),

        // ── Grid / List ──
        Expanded(
          child: isGridView
              ? _buildGrid(books)
              : _buildList(books),
        ),
      ],
    );
  }

  // ══════════ GRID VIEW ══════════
  Widget _buildGrid(List<Book> books) {
    return GridView.builder(
      padding: const EdgeInsets.fromLTRB(10, 8, 10, 20),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.65,
        crossAxisSpacing: 8,
        mainAxisSpacing: 8,
      ),
      itemCount: books.length,
      itemBuilder: (context, index) {
        return _buildCompactBookCard(books[index]);
      },
    );
  }

  // ══════════ LIST VIEW ══════════
  Widget _buildList(List<Book> books) {
    return ListView.builder(
      padding: const EdgeInsets.fromLTRB(10, 8, 10, 20),
      itemCount: books.length,
      itemBuilder: (context, index) {
        return _buildCompactBookListItem(books[index]);
      },
    );
  }

  // ══════════ COMPACT GRID CARD ══════════
  Widget _buildCompactBookCard(Book book) {
    return GestureDetector(
      onTap: () => _navigateToBookDetails(book),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.08),
              blurRadius: 6,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image
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
                      height: 120,
                      width: double.infinity,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          height: 120,
                          width: double.infinity,
                          color: Colors.grey[200],
                          child: const Icon(Icons.book,
                              size: 32, color: Colors.grey),
                        );
                      },
                    ),
                  ),
                ),
                if (book.type == 'Donate')
                  Positioned(
                    top: 6,
                    left: 6,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 6,
                        vertical: 2,
                      ),
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [Colors.green, Colors.greenAccent],
                        ),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Text(
                        'FREE',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 8,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                if (book.isVerified)
                  Positioned(
                    top: 6,
                    right: 6,
                    child: Container(
                      padding: const EdgeInsets.all(2),
                      decoration: const BoxDecoration(
                        color: Colors.blue,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.verified_rounded,
                        color: Colors.white,
                        size: 11,
                      ),
                    ),
                  ),
              ],
            ),

            // Info
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      book.title,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 11.5,
                        fontWeight: FontWeight.w700,
                        color: Colors.black87,
                        height: 1.25,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      book.author,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 9.5,
                        color: Colors.grey,
                      ),
                    ),
                    const Spacer(),
                    Row(
                      children: [
                        const Icon(
                          Icons.directions_walk_rounded,
                          size: 10,
                          color: Colors.grey,
                        ),
                        const SizedBox(width: 2),
                        Text(
                          '${book.distance} km',
                          style: const TextStyle(
                            fontSize: 9,
                            color: Colors.grey,
                          ),
                        ),
                        const Spacer(),
                        Text(
                          book.price,
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: book.type == 'Donate'
                                ? Colors.green
                                : Colors.blue,
                          ),
                        ),
                      ],
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

  // ══════════ COMPACT LIST ITEM ══════════
  Widget _buildCompactBookListItem(Book book) {
    return GestureDetector(
      onTap: () => _navigateToBookDetails(book),
      child: Container(
        margin: const EdgeInsets.only(bottom: 8),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.06),
              blurRadius: 6,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            Hero(
              tag: 'book_${book.id}',
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.network(
                  book.imageUrl,
                  width: 65,
                  height: 80,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      width: 65,
                      height: 80,
                      color: Colors.grey[200],
                      child: const Icon(Icons.book,
                          size: 30, color: Colors.grey),
                    );
                  },
                ),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          book.title,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w700,
                            color: Colors.black87,
                          ),
                        ),
                      ),
                      if (book.isVerified)
                        const Icon(
                          Icons.verified_rounded,
                          color: Colors.blue,
                          size: 14,
                        ),
                    ],
                  ),
                  const SizedBox(height: 2),
                  Text(
                    book.author,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(fontSize: 11, color: Colors.grey),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      const Icon(
                        Icons.directions_walk_rounded,
                        size: 12,
                        color: Colors.grey,
                      ),
                      const SizedBox(width: 2),
                      Text(
                        '${book.distance} km',
                        style: const TextStyle(fontSize: 10.5, color: Colors.grey),
                      ),
                      const SizedBox(width: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 6,
                          vertical: 1,
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
                      const Spacer(),
                      Text(
                        book.price,
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                          color: book.type == 'Donate'
                              ? Colors.green
                              : Colors.blue,
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

// ══════════ CATEGORY MODEL ══════════
class CategoryTab {
  final String name;
  final IconData icon;
  final Color color;

  CategoryTab({
    required this.name,
    required this.icon,
    required this.color,
  });
}