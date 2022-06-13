import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:sivat/list_data.dart';
import 'package:sivat/model/kelas_model.dart';

class KelasApi {
  /// Fungsi untuk mengambil list kelas dari database
  getKelas(int idGuru) async {
    var url = Uri.parse('$mainUrl/detail-pengajar/$idGuru/$currentid');
    var response = await http.get(url);

    if (response.statusCode == 200) {
      var body = json.decode(response.body);
      var datas = body['data']['kelas'];

      List<Kelas> kelass = [];

      for (var data in datas) {
        kelass.add(Kelas.fromJson(data));
      }

      return kelass;
    }
  }
}
