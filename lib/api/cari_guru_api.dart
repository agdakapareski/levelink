import 'dart:convert';

import 'package:http/http.dart';
import 'package:sivat/model/guru_model.dart';
import 'package:sivat/model/mata_pelajaran_model.dart';

import '../list_data.dart';

class CariGuruApi {
  getGuruByMataPelajaran(int idMataPelajaran, int idSiswa) async {
    Uri url = Uri.parse('$mainUrl/pengajar-mapel/$idSiswa/$idMataPelajaran');
    Response response = await get(url);

    var body = json.decode(response.body);
    var data = body['data'];

    List<Guru> gurus = [];

    if (data != null) {
      for (var item in data) {
        Guru guru = Guru(
          id: item['id'],
          nama: item['nama_pengguna'],
          rating: item['total_rating'].runtimeType == int
              ? double.parse(item['total_rating'].toString())
              : item['total_rating'],
          alamatProvinsi: item['provinsi_pengguna'],
          alamatKota: item['kota_pengguna'],
          alamatDetail: item['alamat_pengguna'],
          jenjang: item['jenjang'],
          jenisKelamin: item['jenis_kelamin'],
          noTelepon: item['no_telepon'],
          mataPelajarans: item['mata_pelajaran_dikuasai']
              .map((mapel) => MataPelajaran(
                    id: mapel['id'],
                    mataPelajaran: mapel['nama_mata_pelajaran'],
                    jenjangMataPelajaran: mapel['jenjang_mata_pelajaran'],
                  ))
              .toList(),
        );

        gurus.add(guru);
      }

      return gurus;
    } else {
      return gurus;
    }
  }

  getGuruByKota(int idSiswa) async {
    Uri url = Uri.parse('$mainUrl/pengajar-kota/$idSiswa');
    Response response = await get(url);

    var body = json.decode(response.body);
    var data = body['data'];

    List<Guru> gurus = [];

    if (data != null) {
      for (var item in data) {
        Guru guru = Guru(
          id: item['id'],
          nama: item['nama_pengguna'],
          rating: item['total_rating'].runtimeType == int
              ? double.parse(item['total_rating'].toString())
              : item['total_rating'],
          alamatProvinsi: item['provinsi_pengguna'],
          alamatKota: item['kota_pengguna'],
          alamatDetail: item['alamat_pengguna'],
          jenjang: item['jenjang'],
          jenisKelamin: item['jenis_kelamin'],
          noTelepon: item['no_telepon'],
          mataPelajarans: item['mata_pelajaran_dikuasai']
              .map((mapel) => MataPelajaran(
                    id: mapel['id'],
                    mataPelajaran: mapel['nama_mata_pelajaran'],
                    jenjangMataPelajaran: mapel['jenjang_mata_pelajaran'],
                  ))
              .toList(),
        );

        gurus.add(guru);
      }

      return gurus;
    } else {
      return gurus;
    }
  }
}
