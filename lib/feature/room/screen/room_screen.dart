import 'package:flutter/material.dart';

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
    const Color primaryColor = Color(0xFF5F259F);
    final double dynamicRadius = _currentSheetSize >= 0.98 ? 0.0 : 20.0;

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 75,
        backgroundColor: primaryColor,
        title: InkWell(
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => LocationScreen(),));
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(widget.categoryName,
                style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18,),
              ),
              Row(
                children: [
                  Icon(Icons.location_on,color: Colors.white,size: 16,),
                  Text("Jabalpur, MP",
                    style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w500, fontSize: 12,),
                  )
                ],
              )
            ],
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () => Navigator.pop(context),
          padding: EdgeInsets.zero,
        ),
        actions: [
          const Icon(Icons.favorite, color: Colors.white),
          const SizedBox(width: 10),
        ],
      ),
      body: NotificationListener<DraggableScrollableNotification>(
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
    );
  }
}