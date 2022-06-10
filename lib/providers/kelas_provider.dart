import 'package:flutter/material.dart';
import 'package:sivat/api/cart_api.dart';
import 'package:sivat/api/kelas_api.dart';
import 'package:sivat/model/kelas_model.dart';

class KelasProvider extends ChangeNotifier {
  List<Kelas> kelas = [];
  bool loading = false;

  getDaftarKelas(int idGuru) async {
    kelas = [];
    loading = true;
    kelas = await KelasApi().getKelas(idGuru);
    loading = false;

    notifyListeners();
  }

  requestKelas(
    String idSiswa,
    String idGuru,
    String totalHarga,
    List<Kelas> detail,
  ) async {
    await CartApi().storeCart(idSiswa, idGuru, totalHarga, detail);

    kelas = await KelasApi().getKelas(int.parse(idGuru));
    notifyListeners();
  }
}
