import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsController extends GetxController {
  var username = 'Unknown User'.obs;
  var selectedAvatar = RxString('');

  @override
  void onInit() {
    super.onInit();
    loadUserData();
  }

  Future<void> loadUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    username.value = prefs.getString('username') ?? 'Unknown User';
    selectedAvatar.value = prefs.getString('avatar') ?? '';
  }

  Future<void> saveUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('username', username.value);
    await prefs.setString('avatar', selectedAvatar.value);
  }

  void updateUsername(String newUsername) {
    username.value = newUsername;
    saveUserData();
  }

  void updateAvatar(String avatarPath) {
    selectedAvatar.value = avatarPath;
    saveUserData();
  }
}
