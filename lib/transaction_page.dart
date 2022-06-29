import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:sivat/custom_theme.dart';
import 'package:sivat/detail_pembayaran_page.dart';
import 'package:sivat/list_data.dart';
import 'package:sivat/model/pembayaran_model.dart';
import 'package:sivat/providers/cart_provider.dart';
import 'package:sivat/providers/pembayaran_provider.dart';
import 'package:sivat/widget/padded_widget.dart';

class TransactionPage extends StatefulWidget {
  const TransactionPage({Key? key}) : super(key: key);

  @override
  State<TransactionPage> createState() => _TransactionPageState();
}

class _TransactionPageState extends State<TransactionPage> {
  @override
  void initState() {
    final cartProvider = Provider.of<CartProvider>(
      context,
      listen: false,
    );
    cartProvider.getTransaksi();

    final pembayaranProvider = Provider.of<PembayaranProvider>(
      context,
      listen: false,
    );
    pembayaranProvider.getPembayaran(currentid!);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);
    final pembayaranProvider = Provider.of<PembayaranProvider>(context);
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 1,
          title: Image.asset(
            'LEVELINK-logo-small.png',
            height: 22,
          ),
          actions: [
            IconButton(
              onPressed: () {
                final pembayaranProvider = Provider.of<PembayaranProvider>(
                  context,
                  listen: false,
                );
                pembayaranProvider.getPembayaran(
                  currentid!,
                );
              },
              icon: Icon(
                Icons.refresh,
                color: Colour.blue,
              ),
              splashRadius: 20,
            )
          ],
          bottom: TabBar(
            indicatorColor: Colour.blue,
            tabs: const [
              Tab(
                child: Text(
                  'Request',
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Tab(
                child: Text(
                  'Tagihan',
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            cartProvider.loading == false
                ? ListView(
                    children: [
                      cartProvider
                              .transaksi
                              // .where(
                              //   (element) => element.cart!.status! == 'requested',
                              // )
                              .isNotEmpty
                          ? Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: cartProvider.transaksi
                                  // .where(
                                  //   (element) =>
                                  //       element.cart!.status! == 'requested',
                                  // )
                                  .map(
                                    (transaksi) => Container(
                                      decoration: const BoxDecoration(
                                        border: Border(
                                          bottom: BorderSide(
                                            color: Color(0xFFEEEEEE),
                                          ),
                                        ),
                                      ),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const SizedBox(
                                            height: 16,
                                          ),
                                          PaddedWidget(
                                            child: Row(
                                              children: [
                                                Text(
                                                  transaksi.cart!.guru!.nama!,
                                                  style: const TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                                const Spacer(),
                                                Text(
                                                  transaksi.cart!.status!,
                                                  style: TextStyle(
                                                    color: transaksi.cart!
                                                                .status! ==
                                                            'requested'
                                                        ? Colour.red
                                                        : Colour.blue,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          PaddedWidget(
                                            child: ListView(
                                              physics:
                                                  const NeverScrollableScrollPhysics(),
                                              shrinkWrap: true,
                                              children: transaksi.kelas!
                                                  .map(
                                                    (kelas) => Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                        top: 5,
                                                      ),
                                                      child: Row(
                                                        children: [
                                                          Text(
                                                            kelas.mataPelajaran!
                                                                .mataPelajaran!,
                                                          ),
                                                          const Spacer(),
                                                          Text(
                                                            kelas.hari! +
                                                                ', ' +
                                                                kelas.jam!,
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  )
                                                  .toList(),
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 16,
                                          ),
                                        ],
                                      ),
                                    ),
                                  )
                                  .toList(),
                            )
                          : PaddedWidget(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: const [
                                  SizedBox(
                                    height: 16,
                                  ),
                                  Text('Tidak ada request'),
                                  SizedBox(
                                    height: 16,
                                  ),
                                ],
                              ),
                            ),
                    ],
                  )
                : Center(
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
                  ),
            pembayaranProvider.isLoading == false
                ? ListView(
                    padding: const EdgeInsets.symmetric(
                      vertical: 12,
                    ),
                    children: [
                      const PaddedWidget(
                        child: SmallerTitleText('TAGIHAN'),
                      ),
                      pembayaranProvider.apiBayar.belumBayar!.isNotEmpty
                          ? ListView.builder(
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: pembayaranProvider
                                  .apiBayar.belumBayar!.length,
                              itemBuilder: (context, index) {
                                Pembayaran belumBayar = pembayaranProvider
                                    .apiBayar.belumBayar![index];
                                return ListTile(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      CupertinoPageRoute(
                                        builder: (context) =>
                                            DetailPembayaranPage(
                                          namaGuru: belumBayar.guru!.nama,
                                          tagihans: belumBayar.tagihan,
                                          totalHarga: belumBayar.totalBayar,
                                        ),
                                      ),
                                    );
                                  },
                                  shape: Border(
                                    bottom:
                                        BorderSide(color: Colors.grey[200]!),
                                  ),
                                  title: Text(
                                    belumBayar.guru!.nama!,
                                    style: const TextStyle(
                                      fontSize: 14,
                                    ),
                                  ),
                                  trailing: Text(
                                    NumberFormat.simpleCurrency(
                                      name: 'Rp. ',
                                      locale: 'id',
                                    ).format(
                                      belumBayar.totalBayar,
                                    ),
                                    style: TextStyle(
                                      // fontWeight: FontWeight.bold,
                                      color: Colour.red,
                                      fontSize: 14,
                                    ),
                                  ),
                                );
                              },
                            )
                          : const Padding(
                              padding: EdgeInsets.symmetric(
                                vertical: 16,
                              ),
                              child: PaddedWidget(
                                child: Text('tagihan kosong'),
                              ),
                            ),
                      const CustomDivider(),
                      const SizedBox(
                        height: 12,
                      ),
                      const PaddedWidget(
                        child: SmallerTitleText('RIWAYAT'),
                      ),
                    ],
                  )
                : Center(
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
                  ),
          ],
        ),
      ),
    );
  }
}
