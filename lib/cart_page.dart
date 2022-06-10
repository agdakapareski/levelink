import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:sivat/custom_theme.dart';
import 'package:sivat/list_data.dart';
import 'package:sivat/model/kelas_model.dart';
import 'package:sivat/providers/kelas_provider.dart';
import 'package:sivat/widget/custom_button.dart';

class CartPage extends StatefulWidget {
  final int? idGuru;
  final List<Kelas>? cart;
  final double? total;
  const CartPage({Key? key, this.idGuru, this.cart, this.total})
      : super(key: key);

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  // storeCart(
  //   String idSiswa,
  //   String idGuru,
  //   String totalHarga,
  //   List<Kelas> detail,
  // ) async {
  //   List<Map<String, String>> detailBody = [];
  //   for (var data in detail) {
  //     detailBody.add(
  //       {"id_kelas": data.id.toString()},
  //     );
  //   }
  //   Cart cart = Cart(
  //     idSiswa: idSiswa,
  //     idGuru: idGuru,
  //     totalHarga: totalHarga,
  //     status: "requested",
  //     detail: detailBody,
  //   );

  //   var url = Uri.parse('$mainUrl/store-cart');
  //   var response = await http.post(
  //     url,
  //     headers: {"Content-type": "application/json"},
  //     body: json.encode(cart.toJson()),
  //   );

  //   var body = json.decode(response.body);
  //   var data = body['data'];

  //   log(data.toString());
  // }

  @override
  Widget build(BuildContext context) {
    final kelasProvider = Provider.of<KelasProvider>(context);

    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: BottomAppBar(
        child: SizedBox(
          height: 60,
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 8,
            ),
            child: CustomButton(
              text: 'request',
              color: Colour.red,
              onTap: () {
                if (widget.cart!.isNotEmpty) {
                  kelasProvider.requestKelas(
                    currentid.toString(),
                    widget.idGuru.toString(),
                    widget.total.toString(),
                    widget.cart!,
                  );
                  carts = [];
                  totalHarga = 0;
                  Navigator.pop(context);
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
            ),
          ),
        ),
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(
            vertical: 20,
          ),
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
              ),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Image.asset(
                  'LEVELINK-logo-small.png',
                  height: 22,
                ),
              ),
            ),
            const SizedBox(
              height: 25,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
              ),
              child: Row(
                children: const [
                  Text('kelas yang diambil'),
                  Spacer(),
                  Text('harga / kelas'),
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: widget.cart!
                    .map((e) => Container(
                          padding: const EdgeInsets.symmetric(
                            vertical: 10,
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    e.mataPelajaran!.mataPelajaran!,
                                    style: TextStyle(
                                      color: Colour.blue,
                                    ),
                                  ),
                                  Text(e.hari! + ', ' + e.jam!),
                                ],
                              ),
                              const Spacer(),
                              Text(
                                NumberFormat.simpleCurrency(
                                  name: 'Rp. ',
                                  locale: 'id',
                                ).format(
                                  e.harga,
                                ),
                              ),
                            ],
                          ),
                        ))
                    .toList(),
              ),
            ),
            const Divider(
              color: Colors.black,
              indent: 16,
              endIndent: 16,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 16,
              ),
              child: Row(
                children: [
                  const Text(
                    'Total',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Spacer(),
                  Text(
                    NumberFormat.simpleCurrency(
                      name: 'Rp. ',
                      locale: 'id',
                    ).format(widget.total),
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            const Divider(
              color: Colors.black,
              indent: 16,
              endIndent: 16,
            ),
          ],
        ),
      ),
    );
  }
}
