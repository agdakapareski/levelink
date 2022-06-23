import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:sivat/providers/pertemuan_provider.dart';
import 'package:sivat/widget/confirm_dialog.dart';
import 'package:sivat/widget/padded_widget.dart';

import 'custom_theme.dart';
import 'model/pertemuan_model.dart';

class ActivityPage extends StatefulWidget {
  const ActivityPage({Key? key}) : super(key: key);

  @override
  State<ActivityPage> createState() => _ActivityPageState();
}

class _ActivityPageState extends State<ActivityPage> {
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
    final pertemuanProvider = Provider.of<PertemuanProvider>(
      context,
    );
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Image.asset(
          'LEVELINK-logo-small.png',
          height: 22,
        ),
        elevation: 0,
        backgroundColor: Colors.white,
        toolbarHeight: 60,
        actions: [
          IconButton(
            onPressed: () {
              final pertemuanProvider = Provider.of<PertemuanProvider>(
                context,
                listen: false,
              );
              pertemuanProvider.getPertemuan();
            },
            icon: Icon(
              Icons.refresh,
              color: Colour.blue,
            ),
            splashRadius: 20,
          )
        ],
      ),
      body: pertemuanProvider.isLoading == true
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
          : ListView(
              children: [
                PaddedWidget(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // const Text('Selamat Datang, '),
                      const SizedBox(
                        height: 10,
                      ),
                      const Text(
                        'Aktifitas',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      KotakAktivitas(pertemuanProvider),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                const CustomDivider(),
                const SizedBox(
                  height: 16,
                ),
                const PaddedWidget(
                  child: Text(
                    'Riwayat Aktifitas',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                ListView.builder(
                  itemCount:
                      pertemuanProvider.viewPertemuan.riwayatPertemuan!.length,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    var riwayat = pertemuanProvider
                        .viewPertemuan.riwayatPertemuan![index];

                    return Slidable(
                      endActionPane: ActionPane(
                        motion: const DrawerMotion(),
                        extentRatio: 0.25,
                        children: [
                          SlidableAction(
                            onPressed: (context) {},
                            backgroundColor: Colour.blue,
                            foregroundColor: Colors.white,
                            icon: Icons.list,
                            label: 'Detail',
                          ),
                        ],
                      ),
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(color: Colors.grey[200]!),
                          ),
                        ),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 10,
                        ),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Text(
                                  riwayat.jadwal!.guru!.nama!,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const Spacer(),
                                Text(
                                  riwayat.jadwal!.kelas!.mataPelajaran!
                                      .mataPelajaran!,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Row(
                              children: [
                                const Text('Materi :'),
                                const Spacer(),
                                Text(riwayat.materi!),
                              ],
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Row(
                              children: [
                                const Text('Durasi :'),
                                const Spacer(),
                                Text(
                                  '${DateFormat('kk:mm').format(
                                    riwayat.jamMulai!,
                                  )} - ${DateFormat('kk:mm').format(
                                    riwayat.jamSelesai!,
                                  )}',
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
    );
  }
}

class KotakAktivitas extends StatelessWidget {
  final PertemuanProvider pertemuanProvider;
  const KotakAktivitas(this.pertemuanProvider, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
      ),
      decoration: BoxDecoration(
        border: pertemuanProvider.viewPertemuan.pertemuanAktif == null
            ? Border.all(
                color: Colour.blue,
                width: 0.5,
              )
            : const Border(),
        color: pertemuanProvider.viewPertemuan.pertemuanAktif == null
            ? Colors.white
            : Colour.blue,
      ),
      height: 83,
      child: pertemuanProvider.viewPertemuan.pertemuanAktif == null
          ? const Center(
              child: Text(
                'belum ada kelas aktif',
              ),
            )
          : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  'PERTEMUAN',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                Row(
                  children: [
                    Text(
                      pertemuanProvider.viewPertemuan.pertemuanAktif!.jadwal!
                          .kelas!.mataPelajaran!.mataPelajaran!,
                      style: const TextStyle(color: Colors.white),
                    ),
                    const Spacer(),
                    Text(
                      pertemuanProvider
                          .viewPertemuan.pertemuanAktif!.jadwal!.guru!.nama!,
                      style: const TextStyle(color: Colors.white),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  'Materi : "${pertemuanProvider.viewPertemuan.pertemuanAktif!.materi!}"',
                  style: const TextStyle(color: Colors.white),
                ),
              ],
            ),
    );
  }
}
