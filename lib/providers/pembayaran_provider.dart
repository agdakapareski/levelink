import 'package:flutter/cupertino.dart';
import 'package:sivat/api/pembayaran_api.dart';
import 'package:sivat/model/pembayaran_model.dart';

class PembayaranProvider extends ChangeNotifier {
  ApiBayar apiBayar = ApiBayar();
  bool isLoading = false;

  getPembayaran(int idUser) async {
    isLoading = true;
    apiBayar = await PembayaranApi().getPembayaran(idUser);
    isLoading = false;
    notifyListeners();
  }

  postPembayaran(
    int idGuru,
    int idSiswa,
    int idPertemuan,
    double hargaKelas,
    int idUser,
  ) async {
    await PembayaranApi().tambahPembayaran(
      idGuru,
      idSiswa,
      idPertemuan,
      hargaKelas,
    );

    apiBayar = PembayaranApi().getPembayaran(idUser);
    notifyListeners();
  }
}
