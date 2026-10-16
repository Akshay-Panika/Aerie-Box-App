import 'package:flutter/material.dart';
import 'package:rent_hub/feature/dashboard/screen/dashboard_screen.dart';
import '../../../core/utils/app_color.dart';
import 'auth_screen.dart'; // adjust path if needed

class IntroScreen extends StatefulWidget {
  const IntroScreen({super.key});

  @override
  State<IntroScreen> createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  final PageController _controller = PageController();
  int _currentPage = 0;

  final List<Map<String, dynamic>> _slides = [
    {
      'image':
      'https://images.unsplash.com/photo-1488646953014-85cb44e25828?w=900',
      'title': 'Explore the World',
      'subtitle':
      'Discover amazing destinations and plan your perfect trip with ease.',
    },
    {
      'image':
      'https://images.unsplash.com/photo-1469854523086-cc02fe5d8800?w=900',
      'title': 'Book with Confidence',
      'subtitle':
      'Find the best hotels and flights at the lowest prices, anytime, anywhere.',
    },
    {
      'image':
      'https://images.unsplash.com/photo-1539635278303-d4002c07eae3?w=900',
      'title': 'Travel Made Simple',
      'subtitle':
      'Manage your bookings, track flights, and enjoy a seamless travel experience.',
    },
  ];

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  // Navigate to Auth screen
  void _goToAuth() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) =>  DashboardScreen()),
    );
  }

  void _nextPage() {
    if (_currentPage == _slides.length - 1) {
      _goToAuth();
    } else {
      _controller.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  void _skip() {
    _goToAuth();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              Expanded(
                child: Stack(
                  children: [
                    PageView.builder(
                      controller: _controller,
                      itemCount: _slides.length,
                      onPageChanged: (index) {
                        setState(() => _currentPage = index);
                      },
                      itemBuilder: (context, index) {
                        final slide = _slides[index];
                        return ClipRRect(
                          borderRadius: BorderRadius.circular(24),
                          child: Image.network(
                            slide['image'],
                            fit: BoxFit.cover,
                            width: double.infinity,
                            loadingBuilder: (context, child, progress) {
                              if (progress == null) return child;
                              return Container(
                                color: Colors.grey.shade200,
                                child: const Center(
                                  child: CircularProgressIndicator(),
                                ),
                              );
                            },
                            errorBuilder: (_, __, ___) => Container(
                              color: Colors.grey.shade300,
                              child: const Icon(
                                Icons.image_not_supported,
                                size: 60,
                                color: Colors.grey,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: AnimatedOpacity(
                        duration: const Duration(milliseconds: 200),
                        opacity:
                        _currentPage == _slides.length - 1 ? 0.0 : 1.0,
                        child: TextButton(
                          onPressed: _skip,
                          style: TextButton.styleFrom(
                            backgroundColor: AppColor.subtitleBlack.withOpacity(0.3),
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 8,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                          child: const Text(
                            'Skip',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            _slides[_currentPage]['title'],
                            style: TextStyle(
                              fontSize: 26,
                              fontWeight: FontWeight.bold,
                              color: AppColor.primary,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            _slides[_currentPage]['subtitle'],
                            style: TextStyle(
                              fontSize: 14,
                              height: 1.5,
                              color: AppColor.subtitleBlack,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // Dots
                        Row(
                          children: List.generate(
                            _slides.length,
                                (i) => AnimatedContainer(
                              duration: const Duration(milliseconds: 300),
                              margin: const EdgeInsets.only(right: 6),
                              height: 6,
                              width: _currentPage == i ? 22 : 6,
                              decoration: BoxDecoration(
                                color: _currentPage == i
                                    ? AppColor.primary
                                    : AppColor.subtitleBlack.withOpacity(0.3),
                                borderRadius: BorderRadius.circular(3),
                              ),
                            ),
                          ),
                        ),

                        // Circular button
                        GestureDetector(
                          onTap: _nextPage,
                          child: Container(
                            height: 56,
                            width: 56,
                            decoration: BoxDecoration(
                              color: AppColor.primary,
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              _currentPage == _slides.length - 1
                                  ? Icons.check
                                  : Icons.arrow_forward,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}