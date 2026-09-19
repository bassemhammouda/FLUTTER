import 'package:flutter/material.dart';
import '../theme.dart';
import '../api.dart';

class AlertsScreen extends StatefulWidget {
  const AlertsScreen({super.key});
  @override
  State<AlertsScreen> createState() => _AlertsScreenState();
}

class _AlertsScreenState extends State<AlertsScreen> {
  List<dynamic> alerts = [];

  @override
  void initState() { super.initState(); fetch(); }

  Future<void> fetch() async {
    final d = await Api.getAlerts();
    if (!mounted) return;
    setState(() => alerts = d.reversed.toList());
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: fetch,
      color: DS.primary,
      backgroundColor: DS.surface,
      child: alerts.isEmpty
        ? ListView(children: [
            const SizedBox(height: 150),
            Center(child: Column(children: [
              Container(width: 100, height: 100,
                decoration: BoxDecoration(color: DS.primary.withOpacity(0.1), shape: BoxShape.circle),
                child: const Icon(Icons.check_circle, size: 50, color: DS.primary)),
              const SizedBox(height: 20),
              const Text('All systems normal', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700)),
              const SizedBox(height: 6),
              const Text('No alerts', style: TextStyle(color: DS.textSecondary)),
            ])),
          ])
        : ListView.builder(
            padding: const EdgeInsets.only(bottom: 100),
            itemCount: alerts.length,
            itemBuilder: (_, i) {
              final a = alerts[i];
              return Padding(padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
                child: glassCard(accent: DS.warning,
                  padding: const EdgeInsets.all(14),
                  child: Row(children: [
                    const Icon(Icons.warning_amber_rounded, color: DS.warning, size: 28),
                    const SizedBox(width: 12),
                    Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                      Text(a['type'] ?? 'Alert', style: const TextStyle(fontWeight: FontWeight.w700)),
                      Text(a['message'] ?? '', style: const TextStyle(fontSize: 12, color: DS.textSecondary)),
                    ])),
                  ])));
            }),
    );
  }
}