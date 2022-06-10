/// File: splash_screen.dart
///
/// File ini berisi UI untuk Splash Screen serta
/// fungsi untuk mengambil data dari shared_preferences
/// untuk kebutuhan auto-login

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:sivat/list_data.dart';
import 'package:sivat/login_page.dart';
import 'package:sivat/tab_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    /// mengambil data dari shared preferences
    getSp().then((value) {
      /// Fungsi untuk memberi jeda saat splash screen dimunculkan
      Timer(const Duration(seconds: 3), () {
        /// Jika sudah pernah login, maka langsung diarahkan ke dashboard
        if (isLogin == false || isLogin == null) {
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) => const LoginPage()));
        } else {
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) => const TabScreen()));
        }
      });
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: Image.asset(
            'LEVELINK-logo-small.png',
            height: 40,
          ),
        ),
      ),
    );
  }
}
