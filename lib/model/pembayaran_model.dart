import 'package:sivat/model/guru_model.dart';
import 'package:sivat/model/tagihan_model.dart';

class Pembayaran {
  int? id;
  double? totalBayar;
  bool? statusBayar;
  Guru? guru;
  List<Tagihan>? tagihan;

  Pembayaran({
    this.id,
    this.totalBayar,
    this.statusBayar,
    this.guru,
    this.tagihan,
  });
}

class ApiBayar {
  List<Pembayaran>? belumBayar;
  List<Pembayaran>? riwayatBayar;

  ApiBayar({
    this.belumBayar,
    this.riwayatBayar,
  });
}
