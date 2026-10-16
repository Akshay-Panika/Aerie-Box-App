import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

import '../../../../core/utils/app_color.dart';

class RoomBannerWidget extends StatefulWidget {
  const RoomBannerWidget({super.key});

  @override
  State<RoomBannerWidget> createState() => _RoomBannerWidgetState();
}

class _RoomBannerWidgetState extends State<RoomBannerWidget> {
  int _currentBannerIndex = 0;
  final List<Map<String, String>> bannerItems = [
    {
      'tag': '🏠 FIND YOUR DREAM ROOM',
      'title':
      'Thousands of Verified Rooms\nAvailable for Students & Professionals',
      'action': 'Explore Now',
    },
    {
      'tag': '💰 BEST DEALS',
      'title': 'Get Amazing Discounts on\nLong Term & Short Term Stays',
      'action': 'View Offers',
    },
    {
      'tag': '🤝 ROOMMATE FINDER',
      'title': 'Find Trusted Roommates\nSave Money & Share Rent',
      'action': 'Find Now',
    },
  ];


  @override
  Widget build(BuildContext context) {
    return  Column(
      children: [
        Container(
          margin: EdgeInsets.only(left: 12,right: 12,top: 10,),
          child: CarouselSlider(
            items: bannerItems.map((item) {
              return Container(
                width: double.infinity,
                decoration: BoxDecoration(
                    color: const Color(0xFFF5F7FA),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: AppColor.primary, width: 0.3)
                ),
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment:
                        CrossAxisAlignment.start,
                        mainAxisAlignment:
                        MainAxisAlignment.center,
                        children: [
                          Text(
                            item['tag']!,
                            style: const TextStyle(
                              color: AppColor.primary,
                              fontSize: 11,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            item['title']!,
                            style: const TextStyle(
                              color: Color(0xFF1E293B),
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              height: 1.3,
                            ),
                            maxLines: 2,
                          ),
                          const SizedBox(height: 8),
                          Container(
                            padding:
                            const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 6,
                            ),
                            decoration: BoxDecoration(
                              color: AppColor.primary,
                              borderRadius:
                              BorderRadius.circular(8),
                            ),
                            child: Text(
                              item['action']!,
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
                    const SizedBox(width: 12),
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: AppColor.primary.withOpacity(0.1),
                        borderRadius:
                        BorderRadius.circular(12),
                      ),
                      child: const Icon(
                        Icons.home_work_rounded,
                        size: 40,
                        color: AppColor.primary,
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
            options: CarouselOptions(
              viewportFraction: 1.0,
              autoPlay: true,
              autoPlayInterval: const Duration(seconds: 4),
              autoPlayCurve: Curves.fastOutSlowIn,
              onPageChanged: (index, reason) {
                setState(() {
                  _currentBannerIndex = index;
                });
              },
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(right: 16.0,top: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: List.generate(bannerItems.length, (
                index,
                ) {
              bool isActive = _currentBannerIndex == index;
              return AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                margin: const EdgeInsets.symmetric(
                  horizontal: 4,
                ),
                width: isActive ? 18 : 6,
                height: 4,
                decoration: BoxDecoration(
                  color: isActive
                      ? AppColor.primary
                      : Colors.grey.withOpacity(0.4),
                  borderRadius: BorderRadius.circular(2),
                ),
              );
            }),
          ),
        ),
      ],
    );
  }
}
