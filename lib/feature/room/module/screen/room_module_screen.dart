import 'package:flutter/material.dart';
import '../../../../core/utils/app_color.dart';
import '../../../location/screen/location_screen.dart';
import '../../category/widget/room_category_widget.dart';
import '../../category/widget/special_category_widget.dart';
import '../../home/widget/room_banner_widget.dart';


class RoomModuleScreen extends StatefulWidget {
  final VoidCallback? onAccountTap;

  const RoomModuleScreen({super.key, this.onAccountTap});

  @override
  State<RoomModuleScreen> createState() => _RoomModuleScreenState();
}

class _RoomModuleScreenState extends State<RoomModuleScreen> {
  double _currentSheetSize = 0.66;

  @override
  Widget build(BuildContext context) {
    final double dynamicRadius = _currentSheetSize >= 0.98 ? 0.0 : 32.0;


    return Container(
      color: Colors.white,
      child: Column(
        children: [
          // ── HEADER ──
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
                children: [
                  GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    onTap: () {
                      // Switch to Account tab in DashboardScreen
                      widget.onAccountTap?.call();
                    },
                    child: Stack(
                      children: [
                        Container(
                          width: 60,
                          height: 60,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: AppColor.white,
                            border: Border.all(color: AppColor.secondary, width: 1.5),
                          ),
                          child: const Center(
                            child: Icon(
                              Icons.image,
                              color: AppColor.background,
                              size: 22,
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: 0,
                          right: 0,
                          child: Container(
                            padding: const EdgeInsets.all(2),
                            decoration: const BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              Icons.verified,
                              size: 8,
                              color: Colors.green,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 12),
                  InkWell(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => LocationScreen(),));
                    },
                    child: const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'AB User',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          'Jabalpur, MP',
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Spacer(),

                  IconButton(
                    icon: const Icon(
                      Icons.notifications_active,
                      color: Colors.white,
                      size: 26,
                    ),
                    onPressed: () {},
                  ),
                ],
              ),
            ),
          ),

          // ── BODY ──
          Expanded(
            child: NotificationListener<DraggableScrollableNotification>(
              onNotification: (DraggableScrollableNotification notification) {
                setState(() {
                  _currentSheetSize = notification.extent;
                });
                return true;
              },
              child: LayoutBuilder(
                builder: (context, constraints) {
                  return Stack(
                    children: [
                      // Background + Banner
                      Positioned(
                        top: 0,
                        left: 0,
                        right: 0,
                        child: Stack(
                          children: [
                            Container(
                              height: 100,
                              decoration: BoxDecoration(
                                color: AppColor.secondary,
                                borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(20),
                                  bottomRight: Radius.circular(20),
                                )
                              ),
                            ),
                            RoomBannerWidget(),
                          ],
                        ),
                      ),

                      // Draggable Sheet
                      DraggableScrollableSheet(
                        initialChildSize: 0.66,
                        minChildSize: 0.66,
                        maxChildSize: 1.0,
                        builder:
                            (BuildContext context, ScrollController scrollController) {
                          return AnimatedContainer(
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
                            child: ListView(
                              controller: scrollController,
                              physics: const ClampingScrollPhysics(),
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 12,
                              ),
                              children: [
                                if (_currentSheetSize < 0.98)
                                  Center(
                                    child: Container(
                                      width: 44,
                                      height: 5,
                                      margin: const EdgeInsets.all(20),
                                      decoration: BoxDecoration(
                                        color: const Color(0xFFCBD5E1),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                    ),
                                  ),
                                 RoomCategoryWidget(),


                                Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 14.0),
                                  child:  Divider(
                                    color: AppColor.border.withOpacity(0.3),
                                    thickness: 2,
                                  ),
                                ),


                                SpecialCategoryWidget(),

                                Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 14.0),
                                  child:  Divider(
                                    color: AppColor.border.withOpacity(0.3),
                                    thickness: 2,
                                  ),
                                ),

                                Container(
                                  height: 300,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(14),
                                    border: Border.all(color: Colors.grey.shade200, width: 1.2),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withOpacity(0.04),
                                        blurRadius: 6,
                                        offset: const Offset(0, 3),
                                      ),
                                    ],
                                    image: const DecorationImage(
                                      image: AssetImage('assets/image/aerie-banner.png'),
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 150),
                              ],
                            ),
                          );
                        },
                      ),
                    ],
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

}