import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:sivat/providers/cart_provider.dart';
import 'package:sivat/providers/jadwal_provider.dart';
import 'package:sivat/providers/kelas_provider.dart';
import 'package:sivat/providers/tab_provider.dart';
import 'package:sivat/splash_screen.dart';

void main() {
  runApp(
    MultiProvider(
      providers: providers,
      child: const MyApp(),
    ),
  );
}

List<SingleChildWidget> providers = [
  ChangeNotifierProvider<KelasProvider>(create: (_) => KelasProvider()),
  ChangeNotifierProvider<TabProvider>(create: (_) => TabProvider()),
  ChangeNotifierProvider<CartProvider>(create: (_) => CartProvider()),
  ChangeNotifierProvider<JadwalProvider>(create: (_) => JadwalProvider()),
];

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Levelink(alpha)',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'SF',
        primarySwatch: Colors.indigo,
      ),
      home: const SplashScreen(),
      // initialRoute: '/splash',
      // routes: {
      //   '/': (context) => const TabScreen(),
      //   '/login': (context) => const LoginPage(),
      //   '/splash': (context) => const SplashScreen(),
      //   '/dashboard': (context) => const DashboardPage(),
      //   '/find': (context) => const FindPage(),
      //   '/transaction': (context) => const TransactionPage(),
      // },
    );
  }
}
