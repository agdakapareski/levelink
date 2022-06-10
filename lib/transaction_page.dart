import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sivat/custom_theme.dart';
import 'package:sivat/providers/cart_provider.dart';
import 'package:sivat/widget/padded_widget.dart';

class TransactionPage extends StatefulWidget {
  const TransactionPage({Key? key}) : super(key: key);

  @override
  State<TransactionPage> createState() => _TransactionPageState();
}

class _TransactionPageState extends State<TransactionPage> {
  @override
  void initState() {
    final cartProvider = Provider.of<CartProvider>(context, listen: false);
    cartProvider.getTransaksi();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);
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
                      // const CustomDivider(),
                      // const SizedBox(
                      //   height: 16,
                      // ),
                      // const PaddedWidget(
                      //   child: SmallerTitleText('Tagihan'),
                      // ),
                      // const SizedBox(
                      //   height: 16,
                      // ),
                      // Container(
                      //   decoration: const BoxDecoration(
                      //     border: Border(
                      //       bottom: BorderSide(
                      //         color: Color(0xFFEEEEEE),
                      //       ),
                      //     ),
                      //   ),
                      //   child: PaddedWidget(
                      //     child: Column(
                      //       crossAxisAlignment: CrossAxisAlignment.start,
                      //       children: const [
                      //         Text(
                      //           'Belum ada tagihan',
                      //         ),
                      //         SizedBox(
                      //           height: 16,
                      //         ),
                      //       ],
                      //     ),
                      //   ),
                      // ),
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
            const Center(
              child: Text('Tagihan'),
            ),
          ],
        ),
      ),
    );
  }
}
