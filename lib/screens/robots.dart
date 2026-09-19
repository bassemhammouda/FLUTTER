import 'package:flutter/material.dart';
import 'dart:async';
import '../config.dart';
import '../theme.dart';
import '../api.dart';

class RobotsViewScreen extends StatefulWidget {
  const RobotsViewScreen({super.key});
  @override
  State<RobotsViewScreen> createState() => _RobotsViewScreenState();
}

class _RobotsViewScreenState extends State<RobotsViewScreen> {
  List<String> images = [];
  Timer? timer;

  @override
  void initState() {
    super.initState();
    fetchImages();
    timer = Timer.periodic(const Duration(seconds: 5), (_) => fetchImages());
  }

  @override
  void dispose() { timer?.cancel(); super.dispose(); }

  Future<void> fetchImages() async {
    final d = await Api.getImages();
    if (!mounted) return;
    setState(() => images = d);
  }

  Widget _robotCard(String name, String type, IconData icon, Color color) {
    return glassCard(accent: color, child: Column(children: [
      Container(width: 56, height: 56,
        decoration: BoxDecoration(color: color.withOpacity(0.15),
          borderRadius: BorderRadius.circular(16)),
        child: Icon(icon, color: color, size: 28)),
      const SizedBox(height: 12),
      Text(name, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w700)),
      Text(type, style: const TextStyle(fontSize: 11, color: DS.textSecondary)),
    ]));
  }

  @override
  Widget build(BuildContext context) {
    return ListView(padding: const EdgeInsets.only(bottom: 100), children: [
      sectionHeader('ACTIVE ROBOTS'),
      Padding(padding: DS.padH,
        child: Row(children: [
          if (Config.showViper) Expanded(child: _robotCard('Viper', 'Rover', Icons.directions_car, DS.viperAccent)),
          if (Config.showViper && Config.showHawk) const SizedBox(width: 12),
          if (Config.showHawk) Expanded(child: _robotCard('Hawk', 'Drone', Icons.flight, DS.hawkAccent)),
        ])),
      if (Config.showViper && Config.showHawk) ...[
        sectionHeader('COMBINED MISSION'),
        Padding(padding: DS.padH,
          child: glassCard(accent: DS.primary, child: Row(children: [
            const Icon(Icons.hub, color: DS.primary, size: 40),
            const SizedBox(width: 16),
            const Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text('Viper + Hawk', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700)),
              SizedBox(height: 4),
              Text('Coordinated precision agriculture',
                style: TextStyle(fontSize: 12, color: DS.textSecondary)),
            ])),
          ]))),
      ],
      if (images.isNotEmpty) ...[
        sectionHeader('LATEST CAPTURE'),
        Padding(padding: DS.padH,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(DS.rMedium),
            child: AspectRatio(aspectRatio: 16 / 9,
              child: Image.network('${Config.apiUrl}/images/${images.last}',
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => Container(color: DS.surface2,
                  child: const Icon(Icons.broken_image, color: DS.textSecondary)))),
          )),
      ],
    ]);
  }
}