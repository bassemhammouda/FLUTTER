import 'package:flutter/material.dart';
import 'dart:async';
import '../config.dart';
import '../theme.dart';
import '../api.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});
  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  Map<String, dynamic> viper = {};
  Map<String, dynamic> hawk = {};
  int count = 0;
  String lastUpdate = '--';
  Timer? timer;

  @override
  void initState() {
    super.initState();
    fetch();
    timer = Timer.periodic(const Duration(seconds: 2), (_) => fetch());
  }

  @override
  void dispose() { timer?.cancel(); super.dispose(); }

  Future<void> fetch() async {
    final d = await Api.getTelemetry();
    final v = d.where((x) => x['robot'] == 'viper').toList();
    final h = d.where((x) => x['robot'] == 'hawk').toList();
    if (!mounted) return;
    setState(() {
      viper = v.isNotEmpty ? v.last : {};
      hawk = h.isNotEmpty ? h.last : {};
      count = d.length;
      lastUpdate = DateTime.now().toString().substring(11, 19);
    });
  }

  Widget _onlineDot(bool online) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: (online ? DS.primary : DS.danger).withOpacity(0.15),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(mainAxisSize: MainAxisSize.min, children: [
        Container(width: 6, height: 6,
          decoration: BoxDecoration(color: online ? DS.primary : DS.danger, shape: BoxShape.circle)),
        const SizedBox(width: 6),
        Text(online ? 'ONLINE' : 'OFFLINE',
          style: TextStyle(fontSize: 10, fontWeight: FontWeight.w700,
            color: online ? DS.primary : DS.danger, letterSpacing: 1)),
      ]),
    );
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: fetch,
      color: DS.primary,
      backgroundColor: DS.surface,
      child: ListView(padding: const EdgeInsets.only(bottom: 100), children: [
        sectionHeader('LIVE STATUS'),
        if (Config.showViper) Padding(padding: DS.padH,
          child: glassCard(accent: DS.viperAccent, child: Column(
            crossAxisAlignment: CrossAxisAlignment.start, children: [
            Row(children: [
              Container(width: 40, height: 40,
                decoration: BoxDecoration(color: DS.viperAccent.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(12)),
                child: const Icon(Icons.directions_car, color: DS.viperAccent, size: 22)),
              const SizedBox(width: 12),
              const Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text('Viper', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700)),
                Text('Ground Rover', style: TextStyle(fontSize: 12, color: DS.textSecondary)),
              ])),
              _onlineDot(viper.isNotEmpty),
            ]),
            const SizedBox(height: 16),
            statRow('Speed', '${viper['linear'] ?? 0} m/s'),
            statRow('Distance', '${viper['distance'] ?? '--'} cm'),
            statRow('Battery', '${viper['battery'] ?? '--'} V'),
            statRow('E-Stop', viper['estop'] == true ? 'ACTIVE' : 'OFF',
              color: viper['estop'] == true ? DS.danger : DS.primary),
          ]))),
        if (Config.showHawk) Padding(padding: const EdgeInsets.only(top: 12),
          child: Padding(padding: DS.padH,
            child: glassCard(accent: DS.hawkAccent, child: Column(
              crossAxisAlignment: CrossAxisAlignment.start, children: [
              Row(children: [
                Container(width: 40, height: 40,
                  decoration: BoxDecoration(color: DS.hawkAccent.withOpacity(0.15),
                    borderRadius: BorderRadius.circular(12)),
                  child: const Icon(Icons.flight, color: DS.hawkAccent, size: 22)),
                const SizedBox(width: 12),
                const Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Text('Hawk', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700)),
                  Text('Aerial Drone', style: TextStyle(fontSize: 12, color: DS.textSecondary)),
                ])),
                _onlineDot(hawk.isNotEmpty),
              ]),
              const SizedBox(height: 16),
              statRow('RSSI', '${hawk['rssi'] ?? '--'} dBm'),
              statRow('Uptime', '${hawk['uptime'] ?? '--'} s'),
              statRow('Images', '${hawk['images'] ?? 0}'),
            ])))),
        sectionHeader('SYSTEM'),
        Padding(padding: DS.padH,
          child: glassCard(child: Column(children: [
            statRow('Backend', 'Connected', color: DS.primary),
            statRow('Packets', '$count'),
            statRow('Last Sync', lastUpdate),
          ]))),
      ]),
    );
  }
}