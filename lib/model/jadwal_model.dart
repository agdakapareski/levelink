import 'package:sivat/model/guru_model.dart';
import 'package:sivat/model/kelas_model.dart';

class Jadwal {
  int? id;
  Guru? guru;
  Kelas? kelas;
  int? isAktif;

  Jadwal({
    this.id,
    this.guru,
    this.kelas,
    this.isAktif,
  });
}
