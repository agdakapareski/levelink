import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:sivat/list_data.dart';
import 'package:sivat/model/tagihan_model.dart';
import 'package:sivat/providers/pembayaran_provider.dart';
import 'package:sivat/widget/custom_button.dart';
import 'package:sivat/widget/padded_widget.dart';

import 'custom_theme.dart';

class DetailPembayaranPage extends StatefulWidget {
  final int? idPembayaran;
  final String? namaGuru;
  final List<Tagihan>? tagihans;
  final double? totalHarga;
  final bool? statusBayar;
  const DetailPembayaranPage({
    Key? key,
    required this.idPembayaran,
    required this.namaGuru,
    required this.tagihans,
    required this.totalHarga,
    required this.statusBayar,
  }) : super(key: key);

  @override
  State<DetailPembayaranPage> createState() => _DetailPembayaranPageState();
}

class _DetailPembayaranPageState extends State<DetailPembayaranPage> {
  @override
  Widget build(BuildContext context) {
    final pembayaranProvider = Provider.of<PembayaranProvider>(context);
    return Scaffold(
      bottomNavigationBar: widget.statusBayar == false
          ? BottomAppBar(
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
                            const Text(
                              'TOTAL BAYAR',
                              style: TextStyle(
                                fontSize: 11.4,
                              ),
                            ),
                            const SizedBox(
                              height: 3,
                            ),
                            Text(
                              NumberFormat.simpleCurrency(
                                      name: 'Rp. ', locale: 'id')
                                  .format(widget.totalHarga),
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
                            pembayaranProvider.updatePembayaran(
                              widget.idPembayaran!,
                              currentid!,
                            );

                            Navigator.pop(context);
                          },
                          child: Container(
                            height: 60,
                            color: Colour.red,
                            child: Center(
                              child: Text(
                                'Bayar',
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
            )
          : const SizedBox(),
      appBar: AppBar(
        title: Text(
          widget.namaGuru!,
          style: const TextStyle(color: Colors.white),
        ),
        elevation: 0,
        backgroundColor: Colour.blue,
        // actions: [
        //   IconButton(
        //     onPressed: () {},
        //     icon: Icon(
        //       Icons.payments,
        //       color: Colors.white,
        //     ),
        //     splashRadius: 20,
        //   )
        // ],
      ),
      body: ListView(
        children: [
          const SizedBox(
            height: 16,
          ),
          const PaddedWidget(
            child: SmallerTitleText('TAGIHAN'),
          ),
          ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: widget.tagihans!.length,
            itemBuilder: (context, index) {
              return ListTile(
                dense: true,
                title: Text(
                  widget.tagihans![index].pertemuan!.materi!,
                  style: const TextStyle(fontSize: 14),
                ),
                subtitle: Text(
                  '${DateFormat('kk:mm').format(
                    widget.tagihans![index].pertemuan!.jamMulai!,
                  )} - ${DateFormat('kk:mm').format(
                    widget.tagihans![index].pertemuan!.jamSelesai!,
                  )}',
                  style: const TextStyle(fontSize: 12),
                ),
                trailing: Text(
                  NumberFormat.simpleCurrency(
                    name: 'Rp. ',
                    locale: 'id',
                  ).format(
                    widget.tagihans![index].hargaKelas,
                  ),
                ),
              );
            },
          ),
          ListTile(
            shape: Border(
              top: BorderSide(color: Colors.grey[300]!),
            ),
            title: const Text(
              'Total : ',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
            ),
            trailing: Text(
              NumberFormat.simpleCurrency(
                name: 'Rp. ',
                locale: 'id',
              ).format(
                widget.totalHarga,
              ),
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
            ),
          ),
          // const SizedBox(
          //   height: 5,
          // ),
          // PaddedWidget(
          //   child: CustomButton(
          //     onTap: () {},
          //     color: Colour.blue,
          //     text: 'Bayar Tagihan',
          //   ),
          // ),
        ],
      ),
    );
  }
}
