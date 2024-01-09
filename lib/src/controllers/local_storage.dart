import 'package:shared_preferences/shared_preferences.dart';

class LocalStoragePrefernces {
  final SharedPreferences sharedPreferences;
  LocalStoragePrefernces(this.sharedPreferences);

  Future<void> setSettings(bool sound, int level, int score) async {
    await sharedPreferences.setBool('sound', sound);
    await sharedPreferences.setInt('level', level);
    await sharedPreferences.setInt('score', score);
  }

  Future<void> setScore(int score) async {
    await sharedPreferences.setInt('score', score);
  }

  Map<String, dynamic> getSettings() {
    final sound = sharedPreferences.getBool('sound');
    final level = sharedPreferences.getInt('level');
    final score = sharedPreferences.getInt('score');
    return {
      'sound': sound,
      'level': level,
      'score': score,
    };
  }
}
