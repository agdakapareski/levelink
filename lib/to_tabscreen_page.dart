/// File ini berisi page untuk memproses fungsi login
/// agar user tau bahwa sistem sedang melakukan login

import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sivat/list_data.dart';
import 'package:sivat/tab_screen.dart';

import 'package:http/http.dart' as http;

import 'login_page.dart';

class ToTabScreen extends StatefulWidget {
  final String? email;
  final String? password;
  const ToTabScreen(this.email, this.password, {Key? key}) : super(key: key);

  @override
  State<ToTabScreen> createState() => _ToTabScreenState();
}

class _ToTabScreenState extends State<ToTabScreen> {
  Future<void> addToSp() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    prefs.setInt('currentid', currentid!);
    prefs.setString('currentnama', currentnama!);
    prefs.setString('currentjenjang', currentjenjang!);
    prefs.setInt('currentkelas', currentkelas!);
    prefs.setString('currentalamatProvinsi', currentalamatProvinsi!);
    prefs.setString('currentalamatKota', currentalamatKota!);
    prefs.setString('currentalamatDetail', currentalamatDetail!);
    prefs.setString('currentjenisKelamin', currentjenisKelamin!);
    prefs.setString('currentnoTelepon', currentnoTelepon!);
    prefs.setBool('isLogin', isLogin!);

    setState(() {});
  }

  login(String email, String password) async {
    var url = Uri.parse('$mainUrl/student-login');
    var response = await http.post(url, body: {
      'email': email,
      'password': password,
    });

    var body = json.decode(response.body);
    var user = body['user'];
    var message = body['message'];

    if (response.statusCode == 200) {
      setState(() {
        currentid = user['id'];
        currentgambar = user['picture'];
        currentnama = user['nama_pengguna'];
        currentjenjang = user['jenjang'];
        currentkelas = user['kelas'];
        currentalamatProvinsi = user['provinsi_pengguna'];
        currentalamatKota = user['kota_pengguna'];
        currentalamatDetail = user['alamat_pengguna'];
        currentjenisKelamin = user['jenis_kelamin'];
        currentnoTelepon = user['no_telepon'];
        isLogin = true;

        addToSp();

        Route route = MaterialPageRoute(
          builder: (context) => const TabScreen(),
        );
        Navigator.pushReplacement(context, route);
      });
    } else {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) => const LoginPage(),
        ),
        (route) => false,
      );
      var snackBar = SnackBar(
        content: Text(message),
        // action: SnackBarAction(
        //   textColor: Colors.blue,
        //   label: 'dismiss',
        //   onPressed: () {
        //     ScaffoldMessenger.of(context).hideCurrentSnackBar();
        //   },
        // ),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }

  @override
  void initState() {
    login(widget.email!, widget.password!);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              CircularProgressIndicator(),
              SizedBox(
                height: 10,
              ),
              Text('Sedang Login')
            ],
          ),
        ),
      ),
    );
  }
}
