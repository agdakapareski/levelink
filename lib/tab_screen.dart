/// File: tab_screen.dart
///
/// File ini berisi UI untuk tampilan Tab yang ada pada bawah layar.
/// Halaman akan berubah sesuai tab yang ditekan.

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sivat/providers/tab_provider.dart';

import 'custom_theme.dart';

class TabScreen extends StatefulWidget {
  const TabScreen({Key? key}) : super(key: key);

  @override
  State<TabScreen> createState() => _TabScreenState();
}

class _TabScreenState extends State<TabScreen> {
  // int currentTab = 0;
  final PageStorageBucket bucket = PageStorageBucket();
  // Widget currentScreen = const DashboardPage();

  // changeScreen(int index) {
  //   setState(() {
  //     currentTab = index;
  //   });
  //   if (currentTab == 0) {
  //     setState(() {
  //       currentScreen = const DashboardPage();
  //     });
  //   } else if (currentTab == 1) {
  //     setState(() {
  //       currentScreen = const FindPage();
  //     });
  //   } else {
  //     setState(() {
  //       currentScreen = const TransactionPage();
  //     });
  //   }
  // }

  @override
  void initState() {
    final tabProvider = Provider.of<TabProvider>(context, listen: false);
    tabProvider.getScreen();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final tabProvider = Provider.of<TabProvider>(context);
    // var width = MediaQuery.of(context).size.width;
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        selectedItemColor: Colour.blue,
        unselectedItemColor: Colors.grey,
        currentIndex: tabProvider.currentTab!,
        showUnselectedLabels: true,
        onTap: tabProvider.changeScreen,
        items: const [
          BottomNavigationBarItem(
            backgroundColor: Colors.white,
            icon: Icon(Icons.dashboard_rounded),
            label: 'Dashboard',
          ),
          BottomNavigationBarItem(
            backgroundColor: Colors.white,
            icon: Icon(Icons.menu_book),
            label: 'Aktifitas',
          ),
          BottomNavigationBarItem(
            backgroundColor: Colors.white,
            icon: Icon(Icons.search_rounded),
            label: 'Cari Guru',
          ),
          BottomNavigationBarItem(
            backgroundColor: Colors.white,
            icon: Icon(Icons.receipt_rounded),
            label: 'Transaksi',
          ),
        ],
      ),
      body: SafeArea(
        child: PageStorage(
          bucket: bucket,
          child: tabProvider.currentScreen!,
        ),
      ),
    );
  }
}
