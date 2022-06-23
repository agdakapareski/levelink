import 'package:sivat/model/jadwal_model.dart';

class Pertemuan {
  int? id;
  int? idJadwal;
  Jadwal? jadwal;
  String? materi;
  int? isAktif;
  String? evaluasi;
  double? capaian;
  DateTime? jamMulai;
  DateTime? jamSelesai;

  Pertemuan({
    this.id,
    this.idJadwal,
    this.jadwal,
    this.materi,
    this.isAktif,
    this.evaluasi,
    this.capaian,
    this.jamMulai,
    this.jamSelesai,
  });
}

class ViewPertemuan {
  Pertemuan? pertemuanAktif;
  List<Pertemuan>? riwayatPertemuan;

  ViewPertemuan({
    this.pertemuanAktif,
    this.riwayatPertemuan,
  });
}
