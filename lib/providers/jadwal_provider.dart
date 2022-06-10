import 'package:flutter/cupertino.dart';
import 'package:sivat/api/jadwal_api.dart';
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
}
