import 'package:flutter/material.dart';
import '../config.dart';
import '../theme.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});
  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  final urlCtrl = TextEditingController();
  final idCtrl = TextEditingController();
  bool showViper = true;
  bool showHawk = true;
  bool saved = false;

  @override
  void initState() {
    super.initState();
    urlCtrl.text = Config.apiUrl;
    idCtrl.text = Config.robotId;
    showViper = Config.showViper;
    showHawk = Config.showHawk;
  }

  Future<void> save() async {
    await Config.save(urlCtrl.text, idCtrl.text, showViper, showHawk);
    setState(() => saved = true);
    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) setState(() => saved = false);
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListView(padding: const EdgeInsets.only(bottom: 100), children: [
      sectionHeader('CONNECTION'),
      Padding(padding: DS.padH,
        child: glassCard(child: Column(children: [
          TextField(controller: urlCtrl,
            style: const TextStyle(color: DS.textPrimary),
            decoration: const InputDecoration(
              labelText: 'Backend URL',
              labelStyle: TextStyle(color: DS.textSecondary),
              helperText: 'Example: http://192.168.100.4:8000',
              helperStyle: TextStyle(color: DS.textSecondary, fontSize: 11),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: DS.divider),
                borderRadius: BorderRadius.all(Radius.circular(12))),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: DS.primary),
                borderRadius: BorderRadius.all(Radius.circular(12))),
            )),
          const SizedBox(height: 16),
          TextField(controller: idCtrl,
            style: const TextStyle(color: DS.textPrimary),
            decoration: const InputDecoration(
              labelText: 'Default Robot ID',
              labelStyle: TextStyle(color: DS.textSecondary),
              helperText: 'viper or hawk',
              helperStyle: TextStyle(color: DS.textSecondary, fontSize: 11),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: DS.divider),
                borderRadius: BorderRadius.all(Radius.circular(12))),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: DS.primary),
                borderRadius: BorderRadius.all(Radius.circular(12))),
            )),
        ]))),
      sectionHeader('ROBOT SELECTION'),
      Padding(padding: DS.padH,
        child: glassCard(child: Column(children: [
          CheckboxListTile(
            title: const Text('🐆 Viper (Rover)'),
            value: showViper,
            activeColor: DS.viperAccent,
            onChanged: (v) => setState(() => showViper = v ?? false),
          ),
          const Divider(color: DS.divider),
          CheckboxListTile(
            title: const Text('🦅 Hawk (Drone)'),
            value: showHawk,
            activeColor: DS.hawkAccent,
            onChanged: (v) => setState(() => showHawk = v ?? false),
          ),
        ]))),
      const SizedBox(height: 20),
      Padding(padding: DS.padH,
        child: GestureDetector(
          onTap: save,
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 18),
            decoration: BoxDecoration(
              gradient: const LinearGradient(colors: [DS.primary, Color(0xFF22C55E)]),
              borderRadius: BorderRadius.circular(DS.rMedium),
            ),
            child: const Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              Icon(Icons.save, color: Colors.black),
              SizedBox(width: 10),
              Text('Save Settings',
                style: TextStyle(color: Colors.black, fontWeight: FontWeight.w700, fontSize: 15)),
            ]),
          ))),
      if (saved) const Padding(padding: EdgeInsets.only(top: 15),
        child: Center(child: Text('✓ Saved!',
          style: TextStyle(color: DS.primary, fontWeight: FontWeight.w700)))),
    ]);
  }
}