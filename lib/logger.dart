import 'dart:async';

class Logger {
  static final List<String> _logs = [];
  static final StreamController<List<String>> _ctrl = StreamController.broadcast();

  static Stream<List<String>> get stream => _ctrl.stream;
  static List<String> get logs => List.unmodifiable(_logs);

  static void log(String msg) {
    final t = DateTime.now().toString().substring(11, 19);
    _logs.insert(0, '[$t] $msg');
    if (_logs.length > 200) _logs.removeLast();
    _ctrl.add(_logs);
  }

  static void clear() {
    _logs.clear();
    _ctrl.add(_logs);
  }
}