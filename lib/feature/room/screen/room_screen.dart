import 'package:flutter/material.dart';
import 'package:rent_hub/core/utils/app_color.dart';

import '../../location/screen/location_screen.dart';
import '../widget/map_section.dart';
import '../widget/room_section.dart';

class RoomScreen extends StatefulWidget {
  final String categoryName;
  const RoomScreen({super.key, required this.categoryName});

  @override
  State<RoomScreen> createState() => _RoomScreenState();
}

class _RoomScreenState extends State<RoomScreen> {
  double _currentSheetSize = 0.85;

  @override
  Widget build(BuildContext context) {
    final double dynamicRadius = _currentSheetSize >= 0.98 ? 0.0 : 20.0;

    return Scaffold(
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  AppColor.primary,
                  AppColor.secondary],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
            child: SafeArea(
              bottom: false,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white.withOpacity(0.2),
                        border:
                        Border.all(color: Colors.white, width: 1.5),
                      ),
                      child: const Center(
                        child: Icon(
                          Icons.arrow_back_ios_new_rounded,
                          color: Colors.white,
                          size: 18,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                   InkWell(
                         onTap: () {
                           Navigator.push(context, MaterialPageRoute(builder: (context) => LocationScreen(),));
                         },
                     child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          '${widget.categoryName}',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                          ),
                        ),
                        Row(
                          spacing: 6,
                          children: [
                            Icon(Icons.location_on,size: 12,color: Colors.white70,),
                            Text(
                              'Jabalpur, MP',
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.white70,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ],
                                       ),
                   ),
                  const Spacer(),

                  IconButton(
                    icon: const Icon(
                      Icons.favorite_border,
                      color: Colors.white,
                      size: 26,
                    ),
                    onPressed: () {},
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: NotificationListener<DraggableScrollableNotification>(
              onNotification: (notification) {
                setState(() {
                  _currentSheetSize = notification.extent;
                });
                return true;
              },
              child: Stack(
                children: [
                  // Background Image
                  Positioned.fill(
                    child: MapSection(),
                  ),
                  // Draggable Sheet - Align to bottom
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: DraggableScrollableSheet(
                      initialChildSize: 0.85,
                      minChildSize: 0.5,
                      maxChildSize: 1.0,
                      expand: true,
                      builder: (BuildContext context, ScrollController scrollController) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            if (_currentSheetSize < 0.98)
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: CircleAvatar(
                                  backgroundColor: Colors.white,
                                  child: const Icon(Icons.location_searching, color: Colors.green),
                                ),
                              ),
                            Expanded(
                              child: AnimatedContainer(
                                padding: EdgeInsets.all(10),
                                duration: const Duration(milliseconds: 100),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(dynamicRadius),
                                    topRight: Radius.circular(dynamicRadius),
                                  ),
                                  boxShadow: [
                                    if (_currentSheetSize < 0.98)
                                      const BoxShadow(
                                        color: Color(0x12000000),
                                        blurRadius: 16,
                                        offset: Offset(0, -4),
                                      ),
                                  ],
                                ),
                                child: RoomSection(scrollController: scrollController,),
                              ),
                            ),
                          ],
                        );
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
}