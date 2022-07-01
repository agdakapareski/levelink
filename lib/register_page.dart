// import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:sivat/list_data.dart';
import 'package:sivat/login_page.dart';
import 'package:sivat/widget/custom_button.dart';
import 'package:sivat/widget/input_form.dart';
import 'custom_theme.dart';
import 'package:http/http.dart' as http;

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController kelasController = TextEditingController();
  TextEditingController provinsiController = TextEditingController();
  TextEditingController kotaController = TextEditingController();
  TextEditingController detailController = TextEditingController();
  TextEditingController teleponController = TextEditingController();

  register(
    String nama,
    String email,
    String password,
    String role,
    String alamat,
    String kota,
    String provinsi,
    String jenjang,
    String kelas,
    String jenisKelamin,
  ) async {
    var url = Uri.parse('$mainUrl/register');
    var response = await http.post(url, body: {
      "nama_pengguna": nama,
      "email": email,
      "password": password,
      "role_pengguna": role,
      "alamat_pengguna": alamat,
      "kota_pengguna": kota,
      "provinsi_pengguna": provinsi,
      "jenjang": jenjang,
      "kelas": kelas,
      "jenis_kelamin": jenisKelamin,
    });

    // var body = json.decode(response.body);

    if (response.statusCode == 200) {
      Route route = MaterialPageRoute(
        builder: (context) => const LoginPage(),
      );
      Navigator.pushReplacement(context, route);
    }
  }

  List<String> jenjang = [
    'SD',
    'SMP',
    'SMA',
  ];

  List<int> kelasSD = [1, 2, 3, 4, 5, 6];
  List<int> kelasSMPSMA = [1, 2, 3];
  List<String> jenisKelamin = ['laki-laki', 'perempuan'];

  String? selectedJenjang;
  String? selectedKelas;
  String? selectedJenisKelamin;

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;

    var verticalGap = screenHeight * 0.04;
    var titleGap = screenHeight * 0.015;

    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.symmetric(
            horizontal: screenWidth * 0.04,
            vertical: screenWidth * 0.04,
          ),
          children: [
            const TitleText('Register Akun'),
            SizedBox(
              height: screenHeight * 0.025,
            ),
            const Text('Data Diri'),
            SizedBox(
              height: titleGap,
            ),
            InputForm(
              labelText: 'nama lengkap',
              controller: nameController,
            ),
            SizedBox(
              height: titleGap,
            ),
            InputForm(
              labelText: 'email',
              hintText: 'email',
              controller: emailController,
            ),

            SizedBox(
              height: titleGap,
            ),

            // InputForm(
            //   labelText: 'kelas',
            //   controller: kelasController,
            // ),
            InputForm(
              labelText: 'password',
              controller: passwordController,
            ),
            SizedBox(
              height: titleGap,
            ),
            InputForm(
              labelText: 'telepon',
              prefix: const Text('+62'),
              controller: teleponController,
            ),
            SizedBox(
              height: titleGap,
            ),
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
              ),
              padding: EdgeInsets.symmetric(
                vertical: screenHeight * 0.005,
                horizontal: screenHeight * 0.015,
              ),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  isExpanded: true,
                  value: selectedJenjang,
                  items: jenjang
                      .map((e) => DropdownMenuItem<String>(
                            child: Text(e),
                            value: e,
                          ))
                      .toList(),
                  onChanged: (value) {
                    setState(() {
                      selectedJenjang = value;
                    });
                  },
                  hint: selectedJenjang == null
                      ? const Text(
                          'jenjang',
                          style: TextStyle(
                            fontSize: 13,
                            color: Colors.grey,
                          ),
                        )
                      : Text(
                          selectedJenjang!,
                          style: const TextStyle(
                            fontSize: 13,
                            color: Colors.grey,
                          ),
                        ),
                ),
              ),
            ),
            SizedBox(
              height: titleGap,
            ),
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
              ),
              padding: EdgeInsets.symmetric(
                vertical: screenHeight * 0.005,
                horizontal: screenHeight * 0.015,
              ),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  isExpanded: true,
                  value: selectedJenisKelamin,
                  items: jenisKelamin
                      .map((e) => DropdownMenuItem<String>(
                            child: Text(e),
                            value: e,
                          ))
                      .toList(),
                  onChanged: (value) {
                    setState(() {
                      selectedJenisKelamin = value;
                    });
                  },
                  hint: selectedJenisKelamin == null
                      ? const Text(
                          'jenis kelamin',
                          style: TextStyle(
                            fontSize: 13,
                            color: Colors.grey,
                          ),
                        )
                      : Text(
                          selectedJenisKelamin!,
                          style: const TextStyle(
                            fontSize: 13,
                            color: Colors.grey,
                          ),
                        ),
                ),
              ),
            ),
            SizedBox(
              height: titleGap,
            ),
            selectedJenjang != null
                ? Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                    ),
                    padding: EdgeInsets.symmetric(
                      vertical: screenHeight * 0.005,
                      horizontal: screenHeight * 0.015,
                    ),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        isExpanded: true,
                        value: selectedKelas,
                        items: selectedJenjang == 'SD'
                            ? kelasSD
                                .map((e) => DropdownMenuItem<String>(
                                      child: Text(e.toString()),
                                      value: e.toString(),
                                    ))
                                .toList()
                            : kelasSMPSMA
                                .map((e) => DropdownMenuItem<String>(
                                      child: Text(e.toString()),
                                      value: e.toString(),
                                    ))
                                .toList(),
                        onChanged: (value) {
                          setState(() {
                            selectedKelas = value;
                          });
                        },
                        hint: selectedKelas == null
                            ? const Text(
                                'kelas',
                                style: TextStyle(
                                  fontSize: 13,
                                  color: Colors.grey,
                                ),
                              )
                            : Text(
                                selectedKelas!,
                                style: const TextStyle(
                                  fontSize: 13,
                                  color: Colors.grey,
                                ),
                              ),
                      ),
                    ),
                  )
                : const SizedBox.shrink(),

            SizedBox(
              height: verticalGap,
            ),
            const Text('Tempat Tinggal'),
            SizedBox(
              height: titleGap,
            ),
            InputForm(
              labelText: 'provinsi',
              hintText: 'provinsi',
              controller: provinsiController,
            ),
            SizedBox(
              height: titleGap,
            ),
            InputForm(
              labelText: 'kota',
              hintText: 'kota',
              controller: kotaController,
            ),
            SizedBox(
              height: titleGap,
            ),

            SizedBox(
              height: titleGap,
            ),
            InputForm(
              labelText: 'detail',
              hintText: 'detail',
              controller: detailController,
              maxLines: 5,
            ),
            SizedBox(
              height: verticalGap,
            ),
            CustomButton(
              text: 'Daftar',
              color: Colour.blue,
              onTap: () {
                // Route route = MaterialPageRoute(
                //   builder: (context) => const LoginPage(),
                // );
                // Navigator.pushReplacement(context, route);
                register(
                  nameController.text,
                  emailController.text,
                  passwordController.text,
                  'siswa',
                  detailController.text,
                  kotaController.text,
                  provinsiController.text,
                  selectedJenjang!,
                  selectedKelas!,
                  selectedJenisKelamin!,
                );
              },
            ),
            SizedBox(
              height: verticalGap,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('Sudah punya akun?'),
                GestureDetector(
                  onTap: () {
                    Route route = MaterialPageRoute(
                      builder: (context) => const LoginPage(),
                    );
                    Navigator.pushReplacement(context, route);
                  },
                  child: Text(
                    ' Login',
                    style: TextStyle(color: Colour.red),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: verticalGap,
            ),
          ],
        ),
      ),
    );
  }
}
