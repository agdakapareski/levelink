import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:sivat/list_data.dart';
import 'package:sivat/model/guru_model.dart';
import 'package:sivat/model/jadwal_model.dart';
import 'package:sivat/model/kelas_model.dart';
import 'package:sivat/model/mata_pelajaran_model.dart';

class JadwalApi {
  getJadwal(int id) async {
    var url = Uri.parse('$mainUrl/jadwal/$id');
    var response = await http.get(url);

    var body = json.decode(response.body);
    var data = body['data'];

    List<Jadwal> jadwals = [];

    if (response.statusCode == 200) {
      for (var jadwal in data) {
        Jadwal j = Jadwal(
          guru: Guru(
            nama: jadwal['kelas']['user']['nama_pengguna'],
            jenisKelamin: jadwal['kelas']['user']['jenis_kelamin'],
          ),
          kelas: Kelas(
            mataPelajaran: MataPelajaran(
              mataPelajaran: jadwal['kelas']['mata_pelajaran_kelas']
                  ['nama_mata_pelajaran'],
            ),
            hari: jadwal['kelas']['hari'],
            jam: jadwal['kelas']['jam'],
          ),
          isAktif: jadwal['is_aktif'],
        );

        jadwals.add(j);
      }
      return jadwals;
    }
  }
}
