import 'package:flutter/material.dart';
import '../theme.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return ListView(padding: const EdgeInsets.only(bottom: 100), children: [
      const SizedBox(height: 20),
      Center(child: Container(
        width: 120, height: 120,
        decoration: BoxDecoration(
          gradient: const LinearGradient(colors: [DS.primary, DS.viperAccent]),
          borderRadius: BorderRadius.circular(30)),
        child: const Icon(Icons.agriculture, size: 60, color: Colors.black))),
      const SizedBox(height: 24),
      const Center(child: Text('VIPERHAWK',
        style: TextStyle(fontSize: 32, fontWeight: FontWeight.w800, letterSpacing: 3))),
      const SizedBox(height: 8),
      const Center(child: Text('Precision Agriculture Platform',
        style: TextStyle(color: DS.textSecondary, fontSize: 13))),
      const SizedBox(height: 40),
      Padding(padding: DS.padH,
        child: glassCard(accent: DS.primary, child: Column(children: const [
          ListTile(leading: Icon(Icons.school, color: DS.primary),
            title: Text('Final Year Project (PFE)'),
            subtitle: Text('Academic Project', style: TextStyle(color: DS.textSecondary, fontSize: 11))),
          Divider(color: DS.divider),
          ListTile(leading: Icon(Icons.person, color: DS.primary),
            title: Text('Author'),
            subtitle: Text('[Your Name]', style: TextStyle(color: DS.textSecondary, fontSize: 11))),
          Divider(color: DS.divider),
          ListTile(leading: Icon(Icons.location_city, color: DS.primary),
            title: Text('Location'),
            subtitle: Text('Gabès, Tunisia', style: TextStyle(color: DS.textSecondary, fontSize: 11))),
          Divider(color: DS.divider),
          ListTile(leading: Icon(Icons.code, color: DS.primary),
            title: Text('Version'),
            subtitle: Text('1.0 — 12 Screens', style: TextStyle(color: DS.textSecondary, fontSize: 11))),
        ]))),
    ]);
  }
}