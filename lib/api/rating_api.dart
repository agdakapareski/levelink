import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart';
import 'package:sivat/list_data.dart';

class RatingApi {
  storeRating(
    int idSiswa,
    int idGuru,
    double rating,
    String evaluasi,
    int idJadwal,
    int idKelas,
  ) async {
    Uri url = Uri.parse('$mainUrl/rating');
    Response response = await post(
      url,
      headers: {"Content-type": "application/json"},
      body: jsonEncode(
        {
          "id_guru": idGuru,
          "id_siswa": idSiswa,
          "id_jadwal": idJadwal,
          "id_kelas": idKelas,
          "rating": rating,
          "evaluasi": evaluasi
        },
      ),
    );

    if (response.statusCode == 200) {
      log('pemberian rating berhasil');
    } else {
      log(response.body);
    }
  }
}
