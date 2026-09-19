import 'package:flutter/material.dart';
import '../config.dart';
import '../theme.dart';
import '../api.dart';

class ManualControlScreen extends StatelessWidget {
  const ManualControlScreen({super.key});

  Widget _ctrlBtn(IconData icon, String cmd, Color color, {double size = 70}) {
    return GestureDetector(
      onTap: () => Api.sendCommand(Config.robotId, cmd),
      child: Container(
        width: size, height: size,
        decoration: BoxDecoration(
          color: color.withOpacity(0.15),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: color.withOpacity(0.4), width: 1.5),
        ),
        child: Icon(icon, color: color, size: 30),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListView(padding: const EdgeInsets.only(bottom: 100), children: [
      sectionHeader('TARGET: ${Config.robotId.toUpperCase()}'),
      const SizedBox(height: 20),
      Center(child: Column(children: [
        _ctrlBtn(Icons.keyboard_arrow_up, 'M,0.5,0.0', DS.viperAccent),
        const SizedBox(height: 12),
        Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          _ctrlBtn(Icons.keyboard_arrow_left, 'M,0.0,-0.5', DS.viperAccent),
          const SizedBox(width: 60),
          _ctrlBtn(Icons.keyboard_arrow_right, 'M,0.0,0.5', DS.viperAccent),
        ]),
        const SizedBox(height: 12),
        _ctrlBtn(Icons.keyboard_arrow_down, 'M,-0.5,0.0', DS.viperAccent),
      ])),
      const SizedBox(height: 40),
      Padding(padding: DS.padH, child: Row(children: [
        Expanded(child: GestureDetector(
          onTap: () => Api.sendCommand(Config.robotId, 'STOP'),
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 18),
            decoration: BoxDecoration(
              color: DS.danger.withOpacity(0.15),
              borderRadius: BorderRadius.circular(DS.rMedium),
              border: Border.all(color: DS.danger.withOpacity(0.5), width: 1.5),
            ),
            child: const Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              Icon(Icons.stop_circle, color: DS.danger),
              SizedBox(width: 8),
              Text('STOP', style: TextStyle(color: DS.danger, fontWeight: FontWeight.w700, letterSpacing: 1)),
            ]),
          ))),
        const SizedBox(width: 12),
        Expanded(child: GestureDetector(
          onTap: () => Api.sendCommand(Config.robotId, 'RESUME'),
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 18),
            decoration: BoxDecoration(
              color: DS.primary.withOpacity(0.15),
              borderRadius: BorderRadius.circular(DS.rMedium),
              border: Border.all(color: DS.primary.withOpacity(0.5), width: 1.5),
            ),
            child: const Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              Icon(Icons.play_circle, color: DS.primary),
              SizedBox(width: 8),
              Text('RESUME', style: TextStyle(color: DS.primary, fontWeight: FontWeight.w700, letterSpacing: 1)),
            ]),
          ))),
      ])),
    ]);
  }
}