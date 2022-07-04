import 'package:flutter/material.dart';
import 'package:sivat/custom_theme.dart';
import 'package:sivat/list_data.dart';
import 'package:sivat/login_page.dart';
import 'package:sivat/widget/padded_widget.dart';

class AccountPage extends StatefulWidget {
  const AccountPage({Key? key}) : super(key: key);

  @override
  State<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          'Halaman Akun',
        ),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: Column(
        children: [
          const SizedBox(height: 16),
          PaddedWidget(
            child: Row(
              children: [
                const CircleAvatar(
                  radius: 28,
                  child: Icon(Icons.person),
                ),
                const SizedBox(
                  width: 10,
                ),
                Column(
                  children: [
                    Text(
                      currentnama!,
                      style: const TextStyle(
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          PaddedWidget(
            child: Row(
              children: [
                const Text('Jenjang : '),
                const Spacer(),
                Text(currentjenjang!),
              ],
            ),
          ),
          const SizedBox(height: 16),
          PaddedWidget(
            child: Row(
              children: [
                const Text('Kelas : '),
                const Spacer(),
                Text(currentkelas.toString()),
              ],
            ),
          ),
          const SizedBox(height: 16),
          // PaddedWidget(
          //   child: Row(
          //     children: [
          //       const Text('Nomor Telepon : '),
          //       const Spacer(),
          //       Text('0$currentnoTelepon'),
          //     ],
          //   ),
          // ),
          // const SizedBox(height: 16),
          // PaddedWidget(
          //   child: Row(
          //     children: [
          //       const Text('Jenis Kelamin : '),
          //       const Spacer(),
          //       Text(currentjenisKelamin!),
          //     ],
          //   ),
          // ),
          // const SizedBox(height: 16),
          const CustomDivider(),
          ListTile(
            onTap: () {
              deleteCurrentUser();
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder: (context) => const LoginPage(),
                ),
                (route) => false,
              );
            },
            leading: Icon(
              Icons.logout,
              color: Colour.red,
            ),
            title: const Text('Log Out'),
            shape: const Border(
              bottom: BorderSide(
                color: Color(0xFFEEEEEE),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
