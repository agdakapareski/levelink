import 'package:sivat/model/mata_pelajaran_model.dart';

class Kelas {
  int? id;
  int? kapasitas;
  String? hari;
  String? jam;
  int? durasi;
  double? harga;
  int? isPenuh;
  int? isTidakAktif;
  MataPelajaran? mataPelajaran;
  bool? isTambah;

  Kelas({
    this.id,
    this.kapasitas,
    this.hari,
    this.jam,
    this.durasi,
    this.harga,
    this.isPenuh,
    this.isTidakAktif,
    this.mataPelajaran,
    this.isTambah,
  });

  factory Kelas.fromJson(Map<String, dynamic> json) {
    return Kelas(
      id: json['id'],
      kapasitas: json['kapasitas'],
      hari: json['hari'],
      jam: json['jam'],
      durasi: json['durasi'],
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
