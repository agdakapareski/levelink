import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sivat/custom_theme.dart';
import 'package:sivat/register_page.dart';
import 'package:sivat/tab_screen.dart';
import 'package:sivat/to_tabscreen_page.dart';
import 'package:sivat/widget/custom_button.dart';
import 'package:sivat/widget/input_form.dart';
import 'package:http/http.dart' as http;

import 'list_data.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  bool isVisible = false;

  Future<void> addToSp() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    prefs.setInt('currentid', currentid!);
    prefs.setString('currentnama', currentnama!);
    prefs.setString('currentjenjang', currentjenjang!);
    prefs.setInt('currentkelas', currentkelas!);
    prefs.setString('currentalamatProvinsi', currentalamatProvinsi!);
    prefs.setString('currentalamatKota', currentalamatKota!);
    prefs.setString('currentalamatDetail', currentalamatDetail!);
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
        isLogin = true;

        addToSp();

        Route route = MaterialPageRoute(
          builder: (context) => const TabScreen(),
        );
        Navigator.pushReplacement(context, route);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;

    var verticalGap = screenHeight * 0.035;
    var titleGap = screenHeight * 0.015;

    return Scaffold(
      body: SafeArea(
        child: Center(
          child: ListView(
            shrinkWrap: true,
            padding: EdgeInsets.symmetric(
              horizontal: screenWidth * 0.04,
            ),
            physics: const NeverScrollableScrollPhysics(),
            children: [
              Image.asset(
                'LEVELINK-logo-small.png',
                height: 40,
              ),
              SizedBox(
                height: verticalGap,
              ),
              InputForm(
                labelText: 'email',
                hintText: 'email',
                controller: emailController,
              ),
              SizedBox(
                height: titleGap,
              ),
              TextFormField(
                style: const TextStyle(fontSize: 13),
                obscureText: isVisible ? false : true,
                controller: passwordController,
                decoration: InputDecoration(
                  labelText: 'password',
                  labelStyle: const TextStyle(color: Colors.grey),
                  suffixIcon: GestureDetector(
                    child: isVisible
                        ? const Icon(Icons.visibility)
                        : const Icon(Icons.visibility_off),
                    onTap: () {
                      setState(() {
                        isVisible = !isVisible;
                      });
                    },
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(0),
                  ),
                ),
              ),
              // InputForm(
              //   labelText: 'password',
              //   hintText: 'password',
              //   controller: passwordController,
              //   obscureText: isVisible ? false : true,
              //   suffix: GestureDetector(
              //     child: isVisible
              //         ? const Icon(Icons.visibility)
              //         : const Icon(Icons.visibility_off),
              //     onTap: () {
              //       setState(() {
              //         isVisible = !isVisible;
              //       });
              //     },
              //   ),
              // ),
              SizedBox(
                height: verticalGap,
              ),
              CustomButton(
                text: 'Login',
                color: Colour.blue,
                onTap: () {
                  if (emailController.text != '' ||
                      passwordController.text != '') {
                    Route route = MaterialPageRoute(
                      builder: (context) => ToTabScreen(
                          emailController.text, passwordController.text),
                    );
                    Navigator.pushReplacement(context, route);
                  } else {
                    var snackBar = const SnackBar(
                      content: Text('Semua field harus diisi!'),
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
                },
                // () {
                //   Route route = MaterialPageRoute(
                //     builder: (context) => const TabScreen(),
                //   );
                //   Navigator.pushReplacement(context, route);
                // },
              ),
              SizedBox(
                height: verticalGap,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Belum punya akun?'),
                  GestureDetector(
                    onTap: () {
                      Route route = MaterialPageRoute(
                        builder: (context) => const RegisterPage(),
                      );
                      Navigator.pushReplacement(context, route);
                    },
                    child: Text(
                      ' Register',
                      style: TextStyle(color: Colour.red),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
