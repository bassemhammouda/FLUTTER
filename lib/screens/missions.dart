import 'package:flutter/material.dart';
import '../theme.dart';

class MissionsScreen extends StatelessWidget {
  const MissionsScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return ListView(padding: const EdgeInsets.only(bottom: 100), children: [
      Padding(padding: DS.padH,
        child: GestureDetector(
          onTap: () {},
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 18),
            decoration: BoxDecoration(
              gradient: const LinearGradient(colors: [DS.primary, Color(0xFF22C55E)]),
              borderRadius: BorderRadius.circular(DS.rMedium),
            ),
            child: const Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              Icon(Icons.add_circle, color: Colors.black),
              SizedBox(width: 10),
              Text('New Mission',
                style: TextStyle(color: Colors.black, fontWeight: FontWeight.w700, fontSize: 15)),
            ]),
          ))),
      sectionHeader('ACTIVE MISSIONS'),
      Padding(padding: DS.padH,
        child: glassCard(child: Column(children: [
          Icon(Icons.flag_outlined, size: 40, color: DS.textSecondary.withOpacity(0.5)),
          const SizedBox(height: 12),
          const Text('No active missions', style: TextStyle(color: DS.textSecondary)),
        ]))),
    ]);
  }
}