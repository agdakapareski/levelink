import 'package:flutter/cupertino.dart';
import 'package:sivat/api/cart_api.dart';
import 'package:sivat/model/transaksi_model.dart';

class CartProvider extends ChangeNotifier {
  List<Transaksi> transaksi = [];
  bool loading = false;

  getTransaksi() async {
    transaksi = [];
    loading = true;
    transaksi = await CartApi().getCart();
    loading = false;

    notifyListeners();
  }
}
