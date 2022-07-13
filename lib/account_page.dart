import 'package:d_chart/d_chart.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sivat/custom_theme.dart';
import 'package:sivat/list_data.dart';
import 'package:sivat/login_page.dart';
import 'package:sivat/model/pertemuan_model.dart';
import 'package:sivat/providers/pertemuan_provider.dart';
import 'package:sivat/update_page.dart';
import 'package:sivat/widget/padded_widget.dart';

class AccountPage extends StatefulWidget {
  const AccountPage({Key? key}) : super(key: key);

  @override
  State<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  @override
  void initState() {
    final pertemuanProvider = Provider.of<PertemuanProvider>(
      context,
      listen: false,
    );
    pertemuanProvider.getPertemuan();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final pertemuanProvider = Provider.of<PertemuanProvider>(context);
    if (pertemuanProvider.viewPertemuan.riwayatPertemuan!.isNotEmpty) {
      pertemuanProvider.viewPertemuan.riwayatPertemuan!
          .sort((a, b) => a.id!.compareTo(b.id!));
    }
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          'Halaman Akun',
        ),
        backgroundColor: Colour.blue,
        foregroundColor: Colors.white,
        elevation: 0,
        actions: [
          IconButton(
            onPressed: () {
              Route route = MaterialPageRoute(
                builder: (context) {
                  return const UpdatePage();
                },
              );

              Navigator.push(context, route);
            },
            icon: const Icon(Icons.edit),
            splashRadius: 20,
          ),
        ],
      ),
      body: pertemuanProvider.isLoading
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  CircularProgressIndicator(),
                  SizedBox(
                    height: 10,
                  ),
                  Text('memuat')
                ],
              ),
            )
          : Column(
              children: [
                const SizedBox(height: 16),
                PaddedWidget(
                  child: Row(
                    children: [
                      CircleAvatar(
                        backgroundColor: Colour.blue,
                        foregroundColor: Colors.white,
                        radius: 25,
                        child: const Icon(Icons.person),
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
                const SizedBox(
                  height: 16,
                ),
                const PaddedWidget(child: SmallerTitleText('Performa Belajar')),
                pertemuanProvider.viewPertemuan.riwayatPertemuan!.isNotEmpty
                    ? SizedBox(
                        height: 200,
                        child: PaddedWidget(
                          child: DChartBar(
                            data: [
                              {
                                'id': 'Bar',
                                'data': pertemuanProvider
                                    .viewPertemuan.riwayatPertemuan!
                                    .map((e) {
                                  var index = pertemuanProvider
                                      .viewPertemuan.riwayatPertemuan!
                                      .indexOf(e);
                                  return {
                                    'domain': (index + 1).toString(),
                                    'measure': e.capaian,
                                  };
                                }).toList()
                              },
                            ],
                            yAxisTitle: 'capaian',
                            xAxisTitle: 'pertemuan ke',
                            domainLabelPaddingToAxisLine: 16,
                            axisLineTick: 2,
                            axisLinePointTick: 2,
                            axisLinePointWidth: 5,
                            axisLineColor: Colour.blue,
                            measureLabelPaddingToAxisLine: 16,
                            barColor: (barData, index, id) => Colour.blue,
                            showBarValue: true,
                          ),
                        ),
                      )
                    : const SizedBox(
                        height: 200,
                        child: Center(
                          child: Text('belum ada pertemuan'),
                        ),
                      ),
                const SizedBox(
                  height: 16,
                ),
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
