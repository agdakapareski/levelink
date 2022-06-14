import 'package:sivat/model/mata_pelajaran_model.dart';

class Kelas {
  int? id;
  String? hari;
  String? jam;
  double? harga;
  int? isPenuh;
  int? isTidakAktif;
  MataPelajaran? mataPelajaran;
  bool? isTambah;

  Kelas({
    this.id,
    this.hari,
    this.jam,
    this.harga,
    this.isPenuh,
    this.isTidakAktif,
    this.mataPelajaran,
    this.isTambah,
  });

  factory Kelas.fromJson(Map<String, dynamic> json) {
    return Kelas(
      id: json['id'],
      hari: json['hari'],
      jam: json['jam'],
      harga: json['harga'].runtimeType == double
          ? json['harga']
          : double.parse(json['harga'].toString()),
      isPenuh: json['is_penuh'],
      isTidakAktif: json['is_tidak_aktif'],
      mataPelajaran: MataPelajaran(
        id: json['mata_pelajaran_kelas']['id'],
        mataPelajaran: json['mata_pelajaran_kelas']['nama_mata_pelajaran'],
      ),
      isTambah: true,
    );
  }
}
