


















import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

import 'config.dart';
import 'logger.dart';
import 'theme.dart';

import 'screens/dashboard.dart';
import 'screens/robots.dart';
import 'screens/manual_control.dart';
import 'screens/camera.dart';
import 'screens/ai_analysis.dart';
import 'screens/map.dart';
import 'screens/missions.dart';
import 'screens/history.dart';
import 'screens/alerts.dart';
import 'screens/console.dart';
import 'screens/settings.dart';
import 'screens/about.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    statusBarIconBrightness: Brightness.light,
  ));
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(const ViperHawkApp());
}

class ViperHawkApp extends StatelessWidget {
  const ViperHawkApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ViperHawk',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: DS.bg,
        colorScheme: const ColorScheme.dark(primary: DS.primary, surface: DS.surface),
        textTheme: GoogleFonts.interTextTheme(ThemeData.dark().textTheme),
        useMaterial3: true,
      ),
      home: const MainShell(),
    );
  }
}

class MainShell extends StatefulWidget {
  const MainShell({super.key});
  @override
  State<MainShell> createState() => _MainShellState();
}

class _MainShellState extends State<MainShell> {
  int index = 0;

  final screens = const [
    DashboardScreen(),
    RobotsViewScreen(),
    ManualControlScreen(),
    CameraScreen(),
    AIAnalysisScreen(),
    MapScreen(),
    MissionsScreen(),
    HistoryScreen(),
    AlertsScreen(),
    ConsoleScreen(),
    SettingsScreen(),
    AboutScreen(),
  ];

  final titles = ['Dashboard', 'Robots', 'Control', 'Camera', 'AI Vision',
    'Map', 'Missions', 'History', 'Alerts', 'Console', 'Settings', 'About'];

  final icons = [
    Icons.grid_view_rounded, Icons.devices_rounded, Icons.gamepad_rounded,
    Icons.camera_alt_rounded, Icons.psychology_rounded, Icons.map_rounded,
    Icons.flag_rounded, Icons.history_rounded, Icons.warning_rounded,
    Icons.terminal_rounded, Icons.settings_rounded, Icons.info_rounded,
  ];

  final labels = ['Home', 'Robots', 'Control', 'Cam', 'AI',
    'Map', 'Task', 'History', 'Alerts', 'Log', 'Settings', 'Info'];

  @override
  void initState() {
    super.initState();
    Config.load().then((_) {
      Logger.log('APP started');
      if (mounted) setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFF0A0F1A), Color(0xFF000000)],
          ),
        ),
        child: SafeArea(
          bottom: false,
          child: Column(children: [
            _buildTopBar(titles[index]),
            Expanded(child: screens[index]),
          ]),
        ),
      ),
      bottomNavigationBar: _buildBottomNav(),
    );
  }

  Widget _buildTopBar(String title) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 8),
      child: Row(children: [
        Container(width: 40, height: 40,
          decoration: BoxDecoration(
            gradient: const LinearGradient(colors: [DS.primary, DS.viperAccent]),
            borderRadius: BorderRadius.circular(12)),
          child: const Icon(Icons.agriculture, color: Colors.black, size: 22)),
        const SizedBox(width: 14),
        Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(title, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w700, letterSpacing: -0.5)),
          const Text('ViperHawk Platform',
            style: TextStyle(fontSize: 12, color: DS.textSecondary)),
        ])),
        _statusChip('V', DS.viperAccent, Config.showViper),
        const SizedBox(width: 6),
        _statusChip('H', DS.hawkAccent, Config.showHawk),
      ]),
    );
  }

  Widget _statusChip(String label, Color color, bool active) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      width: 32, height: 32,
      decoration: BoxDecoration(
        color: active ? color.withOpacity(0.15) : DS.surface2,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: active ? color : DS.divider, width: 1.5)),
      child: Center(child: Text(label,
        style: TextStyle(color: active ? color : DS.textSecondary,
          fontWeight: FontWeight.w700, fontSize: 12))),
    );
  }

  Widget _buildBottomNav() {
    return Container(
      margin: const EdgeInsets.fromLTRB(16, 0, 16, 16),
      decoration: BoxDecoration(
        color: DS.surface.withOpacity(0.95),
        borderRadius: BorderRadius.circular(DS.rLarge),
        border: Border.all(color: DS.divider),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.5),
          blurRadius: 20, offset: const Offset(0, 8))]),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(DS.rLarge),
        child: SizedBox(height: 68,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
            itemCount: 12,
            itemBuilder: (_, i) {
              final selected = index == i;
              return GestureDetector(
                onTap: () => setState(() => index = i),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 250),
                  width: 60,
                  margin: const EdgeInsets.symmetric(horizontal: 2),
                  decoration: BoxDecoration(
                    color: selected ? DS.primary.withOpacity(0.15) : Colors.transparent,
                    borderRadius: BorderRadius.circular(14)),
                  child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                    Icon(icons[i], size: 20,
                      color: selected ? DS.primary : DS.textSecondary),
                    const SizedBox(height: 2),
                    Text(labels[i], style: TextStyle(
                      fontSize: 9,
                      color: selected ? DS.primary : DS.textSecondary,
                      fontWeight: selected ? FontWeight.w600 : FontWeight.w400)),
                  ]),
                ),
              );
            },
          )),
      ),
    );
  }
}