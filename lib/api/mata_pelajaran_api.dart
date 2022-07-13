import 'dart:convert';

import 'package:http/http.dart';
import 'package:sivat/list_data.dart';
import 'package:sivat/model/mata_pelajaran_model.dart';

class MataPelajaranApi {
  getMataPelajaran() async {
    Uri url = Uri.parse('$mainUrl/mapel');
    Response response = await get(url);

    var body = json.decode(response.body);
    var data = body['data'];

    List<MataPelajaran> mataPelajarans = [];

    if (response.statusCode == 200) {
      for (var item in data) {
        MataPelajaran mataPelajaran = MataPelajaran(
          id: item['id'],
          mataPelajaran: item['nama_mata_pelajaran'],
          jenjangMataPelajaran: item['jenjang_mata_pelajaran'],
        );
        mataPelajarans.add(mataPelajaran);
      }

      return mataPelajarans;
    }
  }
}
