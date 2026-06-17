import 'package:flutter/cupertino.dart';

import '../../../../core/utils/auth_manager.dart';

class HeaderProvider extends ChangeNotifier{
  bool showMenu= false;
  bool isLoggedIn= false;

  String userName = "";
  String userEmail = "";

  Future<void> loadUser() async {

    isLoggedIn = await AuthManager.isLoggedIn();

    if (isLoggedIn) {
      userName = await AuthManager.getUserName();
      userEmail = await AuthManager.getUserEmail();
    }

    notifyListeners();
  }

  void toggleMenu() {
    showMenu = !showMenu;
    notifyListeners();
  }

  Future<void> logout() async {

    await AuthManager.logout();

    isLoggedIn = false;
    showMenu = false;
    userName = "";
    userEmail = "";

    notifyListeners();
  }
}