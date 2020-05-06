import 'package:gerenciar_financas_app/data/utils/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalStorage {
  static Future saveUserId(String userId) async {
    try {
      SharedPreferences preferences = await SharedPreferences.getInstance();
      preferences.setString(Preferences.UserId, userId);
    } catch (error) {
      return null;
    }
  }

  static Future<String> getUserId() async {
    try {
      SharedPreferences preferences = await SharedPreferences.getInstance();
      return preferences.getString(Preferences.UserId);
    } catch (error) {
      return null;
    }
  }
}
