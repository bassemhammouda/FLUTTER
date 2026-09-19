import 'package:shared_preferences/shared_preferences.dart';
import 'logger.dart';

class Config {
  static String apiUrl = 'http://192.168.100.4:8000';
  static String robotId = 'viper';
  static bool showViper = true;
  static bool showHawk = true;

  static Future<void> load() async {
    final p = await SharedPreferences.getInstance();
    apiUrl = p.getString('apiUrl') ?? apiUrl;
    robotId = p.getString('robotId') ?? robotId;
    showViper = p.getBool('showViper') ?? true;
    showHawk = p.getBool('showHawk') ?? true;
    Logger.log('CONFIG loaded');
  }

  static Future<void> save(String url, String id, bool v, bool h) async {
    final p = await SharedPreferences.getInstance();
    await p.setString('apiUrl', url);
    await p.setString('robotId', id);
    await p.setBool('showViper', v);
    await p.setBool('showHawk', h);
    apiUrl = url;
    robotId = id;
    showViper = v;
    showHawk = h;
    Logger.log('CONFIG saved');
  }
}