import 'package:flutter/material.dart';
import '../config.dart';
import '../theme.dart';
import '../api.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});
  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  List<dynamic> data = [];

  @override
  void initState() { super.initState(); fetch(); }

  Future<void> fetch() async {
    final d = await Api.getTelemetry();
    if (!mounted) return;
    setState(() => data = d.reversed.toList());
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: fetch,
      color: DS.primary,
      backgroundColor: DS.surface,
      child: data.isEmpty
        ? ListView(children: [
            const SizedBox(height: 200),
            Center(child: Column(children: [
              Icon(Icons.history, size: 60, color: DS.textSecondary.withOpacity(0.3)),
              const SizedBox(height: 16),
              const Text('No history yet', style: TextStyle(color: DS.textSecondary)),
            ])),
          ])
        : ListView.builder(
            padding: const EdgeInsets.only(bottom: 100),
            itemCount: data.length,
            itemBuilder: (_, i) {
              final d = data[i];
              final isViper = d['robot'] == 'viper';
              if (isViper && !Config.showViper) return const SizedBox.shrink();
              if (!isViper && !Config.showHawk) return const SizedBox.shrink();
              return Padding(padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
                child: glassCard(padding: const EdgeInsets.all(14),
                  child: Row(children: [
                    Container(width: 36, height: 36,
                      decoration: BoxDecoration(
                        color: (isViper ? DS.viperAccent : DS.hawkAccent).withOpacity(0.15),
                        borderRadius: BorderRadius.circular(10)),
                      child: Icon(isViper ? Icons.directions_car : Icons.flight,
                        color: isViper ? DS.viperAccent : DS.hawkAccent, size: 18)),
                    const SizedBox(width: 12),
                    Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                      Text((d['robot'] ?? 'unknown').toString().toUpperCase(),
                        style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 14)),
                      Text(d['timestamp']?.toString().substring(0, 19) ?? '',
                        style: const TextStyle(fontSize: 11, color: DS.textSecondary)),
                    ])),
                  ])));
            }),
    );
  }
}