import 'package:flutter/material.dart';
import '../theme.dart';

class MapScreen extends StatelessWidget {
  const MapScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Center(child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      Container(width: 100, height: 100,
        decoration: BoxDecoration(color: DS.viperAccent.withOpacity(0.1), shape: BoxShape.circle),
        child: const Icon(Icons.map, size: 50, color: DS.viperAccent)),
      const SizedBox(height: 24),
      const Text('Field Map', style: TextStyle(fontSize: 24, fontWeight: FontWeight.w700)),
      const SizedBox(height: 8),
      const Padding(padding: EdgeInsets.symmetric(horizontal: 60),
        child: Text('GPS waypoints and robot positions will appear here',
          textAlign: TextAlign.center, style: TextStyle(color: DS.textSecondary))),
    ]));
  }
}