import 'package:flutter/material.dart';
import 'dart:async';
import '../config.dart';
import '../theme.dart';
import '../api.dart';

class CameraScreen extends StatefulWidget {
  const CameraScreen({super.key});
  @override
  State<CameraScreen> createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  List<String> images = [];
  Timer? timer;

  @override
  void initState() {
    super.initState();
    fetch();
    timer = Timer.periodic(const Duration(seconds: 5), (_) => fetch());
  }

  @override
  void dispose() { timer?.cancel(); super.dispose(); }

  Future<void> fetch() async {
    final d = await Api.getImages();
    if (!mounted) return;
    setState(() => images = d);
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Padding(padding: const EdgeInsets.fromLTRB(20, 16, 20, 10),
        child: GestureDetector(
          onTap: () => Api.sendCommand('hawk', 'CAPTURE'),
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 16),
            decoration: BoxDecoration(
              gradient: const LinearGradient(colors: [DS.primary, Color(0xFF22C55E)]),
              borderRadius: BorderRadius.circular(DS.rMedium),
            ),
            child: const Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              Icon(Icons.camera_alt, color: Colors.black),
              SizedBox(width: 10),
              Text('Capture from Hawk',
                style: TextStyle(color: Colors.black, fontWeight: FontWeight.w700, fontSize: 15)),
            ]),
          ))),
      Expanded(child: images.isEmpty
        ? Center(child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            Icon(Icons.photo_library_outlined, size: 60, color: DS.textSecondary.withOpacity(0.3)),
            const SizedBox(height: 16),
            const Text('No captures yet', style: TextStyle(color: DS.textSecondary)),
          ]))
        : GridView.builder(
            padding: const EdgeInsets.all(20),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, crossAxisSpacing: 12, mainAxisSpacing: 12),
            itemCount: images.length,
            itemBuilder: (_, i) {
              final name = images[images.length - 1 - i];
              return ClipRRect(
                borderRadius: BorderRadius.circular(DS.rSmall),
                child: Image.network('${Config.apiUrl}/images/$name',
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) => Container(color: DS.surface2,
                    child: const Icon(Icons.broken_image, color: DS.textSecondary))),
              );
            })),
    ]);
  }
}