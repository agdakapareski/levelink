import 'package:flutter/material.dart';
import 'package:sivat/activity_page.dart';

import '../dashboard_page.dart';
import '../find_page.dart';
import '../transaction_page.dart';

class TabProvider extends ChangeNotifier {
  int? currentTab;
  Widget? currentScreen;

  getScreen() {
    currentTab = 0;
    currentScreen = const DashboardPage();
    // notifyListeners();
  }

  changeScreen(int index) {
    currentTab = index;
    if (currentTab == 0) {
      currentScreen = const DashboardPage();
      notifyListeners();
    } else if (currentTab == 1) {
      currentScreen = const ActivityPage();
      notifyListeners();
    } else if (currentTab == 2) {
      currentScreen = const FindPage();
      notifyListeners();
    } else {
      currentScreen = const TransactionPage();
      notifyListeners();
    }
    notifyListeners();
  }
}
