import 'package:flutter/material.dart';
import '../../home/screen/room_screen.dart';

class ModuleModel {
  final String id;
  final String title;
  final String subtitle;
  final IconData icon;
  final Color color;
  final String category; // "room" | "special"
  final Widget Function() builder;

  const ModuleModel({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.color,
    required this.category,
    required this.builder,
  });
}

class ModuleDataStore {
  static const List<ModuleModel> allModules = [
    // ── 8 ROOM MODULES ──
    ModuleModel(
      id: 'room_students',
      title: 'Students',
      subtitle: 'Student Rooms',
      icon: Icons.school_rounded,
      color: Color(0xFF6366F1),
      category: 'room',
      builder: _buildStudentsScreen,
    ),
    ModuleModel(
      id: 'room_professionals',
      title: 'Professionals',
      subtitle: 'Work & Stay',
      icon: Icons.business_center_rounded,
      color: Color(0xFF0EA5E9),
      category: 'room',
      builder: _buildProfessionalsScreen,
    ),
    ModuleModel(
      id: 'room_temporary',
      title: 'Temporary Stay',
      subtitle: 'Short-term',
      icon: Icons.hourglass_top_rounded,
      color: Color(0xFF10B981),
      category: 'room',
      builder: _buildTemporaryScreen,
    ),
    ModuleModel(
      id: 'room_freelancers',
      title: 'Freelancers',
      subtitle: 'Artist & Creators',
      icon: Icons.brush_rounded,
      color: Color(0xFFF43F5E),
      category: 'room',
      builder: _buildFreelancersScreen,
    ),
    ModuleModel(
      id: 'room_family',
      title: 'Family',
      subtitle: 'Family Stays',
      icon: Icons.family_restroom_rounded,
      color: Color(0xFF7986CB),
      category: 'room',
      builder: _buildFamilyScreen,
    ),
    ModuleModel(
      id: 'room_bachelor',
      title: 'Bachelor',
      subtitle: 'Bachelor Rooms',
      icon: Icons.person_outline_rounded,
      color: Color(0xFF8B5CF6),
      category: 'room',
      builder: _buildBachelorScreen,
    ),
    ModuleModel(
      id: 'room_pg_hostel',
      title: 'PG & Hostel',
      subtitle: 'PG / Hostel',
      icon: Icons.person_2_outlined,
      color: Color(0xFF8B5CF6),
      category: 'room',
      builder: _buildPgHostelScreen,
    ),
    ModuleModel(
      id: 'room_all',
      title: 'All Rooms',
      subtitle: 'Browse all',
      icon: Icons.dashboard_outlined,
      color: Color(0xFF5F259F),
      category: 'room',
      builder: _buildAllRoomsScreen,
    ),
  ];

  // Helper getters (split by category)
  static List<ModuleModel> get roomModules =>
      allModules.where((m) => m.category == 'room').toList();

  static List<ModuleModel> get specialModules =>
      allModules.where((m) => m.category == 'special').toList();
}

// Static builder functions (needed because const list can't use closures)
Widget _buildStudentsScreen() =>
    const RoomScreen(categoryName: "Students");
Widget _buildProfessionalsScreen() =>
    const RoomScreen(categoryName: "Professionals");
Widget _buildTemporaryScreen() =>
    const RoomScreen(categoryName: "Temporary Stay");
Widget _buildFreelancersScreen() =>
    const RoomScreen(categoryName: "Freelancers");
Widget _buildFamilyScreen() =>
    const RoomScreen(categoryName: "Family");
Widget _buildBachelorScreen() =>
    const RoomScreen(categoryName: "Bachelor");
Widget _buildPgHostelScreen() =>
    const RoomScreen(categoryName: "PG & Hostel");
Widget _buildAllRoomsScreen() =>
    const RoomScreen(categoryName: "All");



class RoomCategoryWidget extends StatefulWidget {
  const RoomCategoryWidget({super.key});

  @override
  State<RoomCategoryWidget> createState() => _RoomCategoryWidgetState();
}

class _RoomCategoryWidgetState extends State<RoomCategoryWidget> {

  final List<ModuleModel> categories = ModuleDataStore.roomModules;


  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          '🏠 Find Your Perfect Stay',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w700,
            color: Color(0xFF1E293B),
          ),
        ),
        const Text(
          'Choose from a variety of room categories for your needs',
          style: TextStyle(
            fontSize: 13,
            color: Color(0xFF64748B),
          ),
        ),
        const SizedBox(height: 16),

        // Room categories grid (now 8 items, 4x2)
        _buildModuleGrid(categories),
      ],
    );
  }

  Widget _buildModuleGrid(List<ModuleModel> modules) {
    return GridView.builder(
      shrinkWrap: true,
      padding: EdgeInsets.zero,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4,
        childAspectRatio: 1,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
      ),
      itemCount: modules.length,
      itemBuilder: (context, index) {
        return _buildModuleCard(modules[index]);
      },
    );
  }
  Widget _buildModuleCard(ModuleModel module) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => module.builder()),
        );
      },
      child: Container(
        padding: const EdgeInsets.all(4),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: Colors.grey.shade200, width: 1.2),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.04),
              blurRadius: 6,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(module.icon, color: module.color, size: 26),
            const SizedBox(height: 10),
            Flexible(
              child: Text(
                module.title,
                style: const TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 9,
                  color: Color(0xFF1E293B),
                ),
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }
}




