import 'package:flutter/material.dart';
import '../logger.dart';
import '../theme.dart';

class ConsoleScreen extends StatefulWidget {
  const ConsoleScreen({super.key});
  @override
  State<ConsoleScreen> createState() => _ConsoleScreenState();
}

class _ConsoleScreenState extends State<ConsoleScreen> {
  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Padding(padding: const EdgeInsets.fromLTRB(20, 16, 20, 8),
        child: Row(children: [
          Expanded(child: GestureDetector(
            onTap: () => setState(() {}),
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 12),
              decoration: BoxDecoration(
                color: DS.viperAccent.withOpacity(0.15),
                borderRadius: BorderRadius.circular(DS.rSmall),
                border: Border.all(color: DS.viperAccent.withOpacity(0.4)),
              ),
              child: const Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                Icon(Icons.refresh, color: DS.viperAccent, size: 18),
                SizedBox(width: 6),
                Text('Refresh', style: TextStyle(color: DS.viperAccent, fontWeight: FontWeight.w600)),
              ]),
            ))),
          const SizedBox(width: 10),
          Expanded(child: GestureDetector(
            onTap: () { Logger.clear(); setState(() {}); },
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 12),
              decoration: BoxDecoration(
                color: DS.danger.withOpacity(0.15),
                borderRadius: BorderRadius.circular(DS.rSmall),
                border: Border.all(color: DS.danger.withOpacity(0.4)),
              ),
              child: const Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                Icon(Icons.delete_outline, color: DS.danger, size: 18),
                SizedBox(width: 6),
                Text('Clear', style: TextStyle(color: DS.danger, fontWeight: FontWeight.w600)),
              ]),
            ))),
        ])),
      Expanded(child: Container(
        margin: const EdgeInsets.fromLTRB(20, 8, 20, 100),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.circular(DS.rSmall),
          border: Border.all(color: DS.divider),
        ),
        child: StreamBuilder<List<String>>(
          stream: Logger.stream,
          initialData: Logger.logs,
          builder: (_, snap) {
            final logs = snap.data ?? [];
            if (logs.isEmpty) {
              return const Center(child: Text('> _',
                style: TextStyle(color: DS.primary, fontFamily: 'monospace', fontSize: 14)));
            }
            return ListView.builder(
              itemCount: logs.length,
              itemBuilder: (_, i) => Padding(
                padding: const EdgeInsets.symmetric(vertical: 1),
                child: Text(logs[i], style: const TextStyle(
                  color: DS.primary, fontSize: 11, fontFamily: 'monospace')),
              ));
          },
        ),
      )),
    ]);
  }
}