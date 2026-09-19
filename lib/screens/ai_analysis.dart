import 'package:flutter/material.dart';
import '../theme.dart';

class AIAnalysisScreen extends StatelessWidget {
  const AIAnalysisScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return ListView(padding: const EdgeInsets.only(bottom: 100), children: [
      sectionHeader('AI ENGINE'),
      Padding(padding: DS.padH,
        child: glassCard(accent: DS.primary, child: Column(children: [
          Container(width: 72, height: 72,
            decoration: BoxDecoration(
              gradient: LinearGradient(colors: [
                DS.primary.withOpacity(0.3),
                DS.viperAccent.withOpacity(0.3),
              ]),
              borderRadius: BorderRadius.circular(20)),
            child: const Icon(Icons.psychology, color: DS.primary, size: 36)),
          const SizedBox(height: 16),
          const Text('YOLOv8 Detection Engine',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700)),
          const SizedBox(height: 6),
          const Text('Powered by RTX 3060',
            style: TextStyle(fontSize: 12, color: DS.textSecondary)),
          const SizedBox(height: 20),
          statRow('Model', 'yolov8n.pt'),
          statRow('Classes', '5'),
          statRow('Inference', '60+ FPS'),
          statRow('Device', 'CUDA GPU'),
        ]))),
      sectionHeader('RECENT DETECTIONS'),
      Padding(padding: DS.padH,
        child: glassCard(child: Column(children: [
          Icon(Icons.eco, size: 40, color: DS.primary.withOpacity(0.5)),
          const SizedBox(height: 12),
          const Text('No detections yet', style: TextStyle(color: DS.textSecondary)),
        ]))),
    ]);
  }
}