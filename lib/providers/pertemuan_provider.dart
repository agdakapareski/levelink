import 'package:flutter/cupertino.dart';
import 'package:sivat/api/pertemuan_api.dart';
import 'package:sivat/model/pertemuan_model.dart';

class PertemuanProvider extends ChangeNotifier {
  ViewPertemuan viewPertemuan = ViewPertemuan();
  bool isLoading = false;

  getPertemuan() async {
    isLoading = true;
    viewPertemuan = await PertemuanApi().getPertemuan();
    isLoading = false;
    notifyListeners();
  }

  storePertemuan(Pertemuan p) async {
    await PertemuanApi().storePertemuan(p);

    viewPertemuan = await PertemuanApi().getPertemuan();
    notifyListeners();
  }

  updatePertemuan(Pertemuan p, int idPertemuan) async {
    await PertemuanApi().updatePertemuan(p, idPertemuan);

    viewPertemuan = await PertemuanApi().getPertemuan();
    notifyListeners();
  }
}
