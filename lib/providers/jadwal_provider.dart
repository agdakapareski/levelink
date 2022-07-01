import 'package:flutter/cupertino.dart';
import 'package:sivat/api/jadwal_api.dart';
import 'package:sivat/api/rating_api.dart';
import 'package:sivat/model/jadwal_model.dart';

class JadwalProvider extends ChangeNotifier {
  List<Jadwal> jadwals = [];
  bool isLoading = false;

  getJadwal(int id) async {
    jadwals = [];
    isLoading = true;
    JadwalApi().getJadwal(id).then((value) {
      if (value == null) {
        isLoading = false;
        notifyListeners();
      } else {
        jadwals = value;
        isLoading = false;
        notifyListeners();
      }
    });
  }

  storeRating(
    int idSiswa,
    int idGuru,
    double rating,
    String evaluasi,
    int idJadwal,
    int idKelas,
  ) async {
    await RatingApi().storeRating(
      idSiswa,
      idGuru,
      rating,
      evaluasi,
      idJadwal,
      idKelas,
    );

    jadwals = [];
    isLoading = true;
    JadwalApi().getJadwal(idSiswa).then((value) {
      if (value == null) {
        isLoading = false;
        notifyListeners();
      } else {
        jadwals = value;
        isLoading = false;
        notifyListeners();
      }
    });
  }
}
