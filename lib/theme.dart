import 'package:flutter/material.dart';

class DS {
  static const Color bg = Color(0xFF000000);
  static const Color surface = Color(0xFF0E0E0E);
  static const Color surface2 = Color(0xFF1A1A1A);
  static const Color primary = Color(0xFF4ADE80);
  static const Color viperAccent = Color(0xFF3B82F6);
  static const Color hawkAccent = Color(0xFFF97316);
  static const Color danger = Color(0xFFEF4444);
  static const Color textPrimary = Color(0xFFFFFFFF);
  static const Color textSecondary = Color(0xFF9CA3AF);
  static const Color divider = Color(0xFF1F1F1F);

  static const double rSmall = 12;
  static const double rMedium = 20;
  static const double rLarge = 28;

  static const EdgeInsets pad = EdgeInsets.all(20);
  static const EdgeInsets padH = EdgeInsets.symmetric(horizontal: 20);
}

Widget glassCard({required Widget child, EdgeInsets? padding, Color? accent}) {
  return Container(
    padding: padding ?? DS.pad,
    decoration: BoxDecoration(
      color: DS.surface,
      borderRadius: BorderRadius.circular(DS.rMedium),
      border: Border.all(color: accent?.withOpacity(0.3) ?? DS.divider),
    ),
    child: child,
  );
}

Widget statRow(String label, String value, {Color? color}) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 6),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: const TextStyle(color: DS.textSecondary, fontSize: 13)),
        Text(value, style: TextStyle(color: color ?? DS.textPrimary, fontWeight: FontWeight.w600, fontSize: 14)),
      ],
    ),
  );
}

Widget sectionHeader(String title) {
  return Padding(
    padding: const EdgeInsets.fromLTRB(20, 20, 20, 10),
    child: Text(title, style: const TextStyle(
        fontSize: 13, fontWeight: FontWeight.w700, color: DS.textSecondary, letterSpacing: 1.5)),
  );
}