import 'package:afynder/constants/strings.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefManager {
  Future<String> getAuthKey() async {
    return SharedPreferences.getInstance()
        .then((value) => value.getString(authorizationKey) ?? guestAuth);
  }

  Future<String> getShopeeId() async {
    return SharedPreferences.getInstance()
        .then((value) => value.getString(shopeeId) ?? "");
  }

  Future<String> getProfileImageUrl() async {
    return SharedPreferences.getInstance()
        .then((value) => value.getString(profileImage) ?? "");
  }

  signOutUser() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.clear();
  }

  Future<bool> iSignedIn() async {
    return SharedPreferences.getInstance()
        .then((value) => value.getBool(isSignnedIn) ?? false);
  }
}
