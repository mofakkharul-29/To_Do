import 'package:shared_preferences/shared_preferences.dart';

class OnboardingLocalDataSource {
  static const _key = 'isFirstLaunch';

  Future<bool> isFirstLaunch() async {
    final SharedPreferences pref =
        await SharedPreferences.getInstance();
    return pref.getBool(_key) ?? true;
  }

  Future<void> setFirstLaunch(bool value) async {
    final SharedPreferences pref =
        await SharedPreferences.getInstance();
    await pref.setBool(_key, value);
  }
}
