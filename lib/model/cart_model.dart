import 'package:sivat/model/guru_model.dart';

class Cart {
  int? id;
  String? idSiswa;
  String? idGuru;
  String? totalHarga;
  String? status;
  Guru? guru;
  List<Map<String, String>>? detail;

  Cart({
    this.id,
    this.idSiswa,
    this.idGuru,
    this.totalHarga,
    this.status,
    this.guru,
    this.detail,
  });

  Map<String, dynamic> toJson() => {
        'id_siswa': idSiswa,
        'id_guru': idGuru,
        'total_harga': totalHarga,
        'status': status,
        'detail': detail,
      };
}
