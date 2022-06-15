import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sivat/cart_page.dart';
import 'package:sivat/custom_theme.dart';
import 'package:sivat/list_data.dart';
import 'package:intl/intl.dart';
import 'package:sivat/providers/kelas_provider.dart';
import 'package:sivat/widget/padded_widget.dart';

class DetailGuruPage extends StatefulWidget {
  final int? idGuru;
  final String? namaGuru;
  final double? rating;
  final String? alamatGuru;
  final String? kotaGuru;
  final String? provinsiGuru;
  final String? pendidikanTerakhir;
  const DetailGuruPage({
    Key? key,
    required this.idGuru,
    required this.namaGuru,
    required this.rating,
    required this.alamatGuru,
    required this.kotaGuru,
    required this.provinsiGuru,
    required this.pendidikanTerakhir,
  }) : super(key: key);

  @override
  State<DetailGuruPage> createState() => _DetailGuruPageState();
}

class _DetailGuruPageState extends State<DetailGuruPage> {
  @override
  void initState() {
    final kelasProvider = Provider.of<KelasProvider>(context, listen: false);
    kelasProvider.getDaftarKelas(widget.idGuru!);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final kelasProvider = Provider.of<KelasProvider>(context);
    return Scaffold(
      backgroundColor: Colors.white,

      /// Tempat untuk melihat total cart
      bottomNavigationBar: kelasProvider.loading == true
          ? const SizedBox()
          : BarTotalCart(widget.idGuru),

      /// Body disini
      body: SafeArea(
        child: kelasProvider.loading == true
            ? loading()
            : ListView(
                padding: const EdgeInsets.symmetric(
                  vertical: 20,
                ),
                children: [
                  const AppBarLogo(),
                  const SizedBox(
                    height: 20,
                  ),
                  InfoGuru(widget.namaGuru, widget.rating),
                  const SizedBox(
                    height: 20,
                  ),
                  InfoGuruDetail(
                    widget.alamatGuru,
                    widget.kotaGuru,
                    widget.provinsiGuru,
                    widget.pendidikanTerakhir,
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  const CustomDivider(),
                  const SizedBox(
                    height: 16,
                  ),
                  PaddedWidget(
                    child: Row(
                      children: [
                        const SmallerTitleText('Daftar Kelas Tersedia'),
                        const Spacer(),
                        GestureDetector(
                          onTap: () {
                            kelasProvider.getDaftarKelas(widget.idGuru!);
                          },
                          child: const Icon(Icons.refresh),
                        ),
                      ],
                    ),
                  ),
                  // const SizedBox(
                  //   height: 16,
                  // ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: kelasProvider.kelas.isNotEmpty
                        ? kelasProvider.kelas
                            .map(
                              (kelas) => ListTile(
                                // contentPadding: const EdgeInsets.symmetric(
                                //   horizontal: 16,
                                //   vertical: 10,
                                // ),
                                shape: const Border(
                                  bottom: BorderSide(
                                    color: Color(0xFFEEEEEE),
                                  ),
                                ),
                                isThreeLine: true,
                                title: Text(
                                  kelas.mataPelajaran!.mataPelajaran!
                                      .toUpperCase(),
                                  style: TextStyle(color: Colour.blue),
                                ),
                                subtitle: Text(
                                  '${kelas.hari}, ${kelas.jam}',
                                  style: const TextStyle(color: Colors.black),
                                ),
                                trailing: Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Text(
                                      NumberFormat.simpleCurrency(
                                        name: 'Rp. ',
                                        locale: 'id',
                                      ).format(kelas.harga),
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const Spacer(),
                                    GestureDetector(
                                      onTap: () {
                                        if (kelas.isPenuh == 0) {
                                          if (kelas.isTambah!) {
                                            carts.add(kelas);
                                            // print(cart);
                                            setState(() {
                                              totalHarga =
                                                  totalHarga + kelas.harga!;
                                              kelas.isTambah = false;
                                            });
                                          } else {
                                            carts.removeWhere((element) =>
                                                element.id == kelas.id);
                                            // print(cart);
                                            setState(() {
                                              totalHarga =
                                                  totalHarga - kelas.harga!;
                                              if (totalHarga < 0) {
                                                totalHarga = 0;
                                              }
                                              kelas.isTambah = true;
                                            });
                                          }
                                        } else {
                                          log('kelas penuh');
                                        }
                                      },
                                      child: Container(
                                        height: 30,
                                        width: 90,
                                        color: kelas.isPenuh == 0
                                            ? (kelas.isTambah!
                                                ? Colour.blue
                                                : Colour.red)
                                            : Colors.grey,
                                        child: Center(
                                          child: kelas.isPenuh == 0
                                              ? (kelas.isTambah!
                                                  ? const Text(
                                                      'pilih',
                                                      style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 12,
                                                      ),
                                                    )
                                                  : const Text(
                                                      'batal',
                                                      style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 12,
                                                      ),
                                                    ))
                                              : const Text(
                                                  'penuh',
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 12,
                                                  ),
                                                ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            )
                            .toList()
                        : [
                            const Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 16,
                              ),
                              child: Text('belum ada kelas'),
                            ),
                          ],
                  )
                ],
              ),
      ),
    );
  }
}

class InfoGuru extends StatelessWidget {
  final String? namaGuru;
  final double? rating;
  const InfoGuru(this.namaGuru, this.rating, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PaddedWidget(
      child: Row(
        children: [
          const CircleAvatar(
            child: Icon(Icons.person),
            radius: 28,
          ),
          const SizedBox(
            width: 16,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                namaGuru!,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              Row(
                children: [
                  Text(
                    '$rating / 5.0',
                  ),
                  Icon(
                    Icons.star,
                    color: Colors.yellow[600],
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class InfoGuruDetail extends StatelessWidget {
  final String? alamatGuru;
  final String? kotaGuru;
  final String? provinsiGuru;
  final String? pendidikanTerakhir;
  const InfoGuruDetail(this.alamatGuru, this.kotaGuru, this.provinsiGuru,
      this.pendidikanTerakhir,
      {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PaddedWidget(
      child: Column(
        children: [
          GuruDetailRow(
            title: 'Alamat :',
            value: alamatGuru,
          ),
          const SizedBox(
            height: 16,
          ),
          GuruDetailRow(
            title: 'Kota :',
            value: kotaGuru,
          ),
          const SizedBox(
            height: 16,
          ),
          GuruDetailRow(
            title: 'Provinsi :',
            value: provinsiGuru,
          ),
          const SizedBox(
            height: 16,
          ),
          GuruDetailRow(
            title: 'Pendidikan Terakhir :',
            value: pendidikanTerakhir,
          ),
        ],
      ),
    );
  }
}

class BarTotalCart extends StatelessWidget {
  final int? idGuru;
  const BarTotalCart(this.idGuru, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      child: SizedBox(
        height: 60,
        child: Padding(
          padding: const EdgeInsets.only(left: 16),
          child: Row(
            children: [
              Expanded(
                flex: 2,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Total'),
                    Text(
                      NumberFormat.simpleCurrency(name: 'Rp. ', locale: 'id')
                          .format(totalHarga),
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 1,
                child: GestureDetector(
                  onTap: () {
                    if (carts.isNotEmpty) {
                      Route route = MaterialPageRoute(
                        builder: (context) => CartPage(
                          idGuru: idGuru,
                          cart: carts,
                          total: totalHarga,
                        ),
                      );

                      Navigator.push(context, route);
                    } else {
                      var snackBar = SnackBar(
                        content: const Text('Cart Kosong!'),
                        action: SnackBarAction(
                          textColor: Colors.blue,
                          label: 'dismiss',
                          onPressed: () {
                            ScaffoldMessenger.of(context).hideCurrentSnackBar();
                          },
                        ),
                      );
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    }
                  },
                  child: Container(
                    height: 60,
                    color: Colour.red,
                    child: Center(
                      child: Text(
                        'Konfirmasi',
                        style: TextStyle(
                          color: Colors.grey[50],
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
