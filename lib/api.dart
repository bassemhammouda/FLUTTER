import 'dart:convert';
import 'package:http/http.dart' as http;
import 'config.dart';
import 'logger.dart';

class Api {
  static Future<List<dynamic>> getTelemetry() async {
    try {
      final r = await http.get(Uri.parse('${Config.apiUrl}/telemetry'))
          .timeout(const Duration(seconds: 3));
      return jsonDecode(r.body);
    } catch (e) {
      Logger.log('API telemetry error: $e');
      return [];
    }
  }

  static Future<List<String>> getImages() async {
    try {
      final r = await http.get(Uri.parse('${Config.apiUrl}/images'));
      final List d = jsonDecode(r.body);
      return d.cast<String>();
    } catch (e) {
      Logger.log('API images error: $e');
      return [];
    }
  }

  static Future<List<dynamic>> getAlerts() async {
    try {
      final r = await http.get(Uri.parse('${Config.apiUrl}/alerts'));
      return jsonDecode(r.body);
    } catch (e) {
      return [];
    }
  }

  static Future<void> sendCommand(String robot, String cmd) async {
    try {
      await http.post(Uri.parse('${Config.apiUrl}/command/$robot?command=$cmd'));
      Logger.log('CMD: $robot <- $cmd');
    } catch (e) {
      Logger.log('CMD error: $e');
    }
  }
}