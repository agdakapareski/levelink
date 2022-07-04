import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart';
import 'package:sivat/list_data.dart';
import 'package:sivat/model/guru_model.dart';
import 'package:sivat/model/rating_model.dart';

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

  getRating(int idUser) async {
    Uri url = Uri.parse('$mainUrl/get-rating/$idUser');
    Response response = await get(url);

    if (response.statusCode == 200) {
      var body = json.decode(response.body);
      var data = body['data'];
      List<Rating> ratings = [];

      for (var item in data) {
        Rating r = Rating(
          id: item['id'],
          guru: Guru(
            id: item['siswa']['id'],
            nama: item['siswa']['nama_pengguna'],
          ),
          rating: item['rating'].toDouble(),
          evaluasi: item['evaluasi'],
        );

        ratings.add(r);
      }
      double? rataRating = body['rata_rating'].toDouble();

      return SummaryRating(
        rating: ratings,
        rataRating: rataRating,
      );
    }
  }
}
