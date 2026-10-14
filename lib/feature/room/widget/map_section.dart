import 'package:flutter/material.dart';

import '../screen/owner_screen.dart';

class MapSection extends StatelessWidget {
  const MapSection({super.key});
  void _navigateToOwner(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const OwnerScreen()),
    );
  }
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
          child: Image.asset(
            "assets/image/map.jpg",
            fit: BoxFit.cover,
          ),
        ),

        // Spot 1
        Positioned(
          top: 100,
          left: 50,
          child: GestureDetector(
            onTap: () => _navigateToOwner(context),
            child: const Icon(Icons.location_on, color: Colors.red, size: 30),
          ),
        ),

        // Spot 2
         Positioned(
          top: 200,
          left: 150,
          child: GestureDetector(
              onTap: () => _navigateToOwner(context),
              child: Icon(Icons.location_on, color: Colors.blue, size: 30)),
        ),

        // Spot 3
         Positioned(
          top: 150,
          right: 80,
          child: GestureDetector(
              onTap: () => _navigateToOwner(context),
              child: Icon(Icons.location_on, color: Colors.green, size: 30)),
        ),
        // Spot 4
         Positioned(
          bottom: 600,
          left: 20,
          child: GestureDetector(
              onTap: () => _navigateToOwner(context),
              child: Icon(Icons.location_on, color: Colors.orange, size: 30)),
        ),

        // Spot 5
         Positioned(
          bottom: 400,
          left: 50,
           child: GestureDetector(
               onTap: () => _navigateToOwner(context),
              child: Icon(Icons.location_on, color: Colors.purple, size: 30)),
        ),
      ],
    );
  }
}
