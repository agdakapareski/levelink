import 'package:sivat/model/guru_model.dart';
import 'package:sivat/model/siswa_model.dart';

class Rating {
  int? id;
  Siswa? siswa;
  Guru? guru;
  double? rating;
  String? evaluasi;

  Rating({
    this.id,
    this.siswa,
    this.guru,
    this.rating,
    this.evaluasi,
  });
}
