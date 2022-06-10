import 'dart:developer';

import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:sivat/list_data.dart';
import 'package:sivat/model/cart_model.dart';
import 'package:sivat/model/guru_model.dart';
import 'package:sivat/model/kelas_model.dart';
import 'package:sivat/model/mata_pelajaran_model.dart';
import 'package:sivat/model/transaksi_model.dart';

class CartApi {
  /// Fungsi untuk menyimpan cart yang sudah diinput ke database
  storeCart(
    String idSiswa,
    String idGuru,
    String totalHarga,
    List<Kelas> detail,
  ) async {
    /// Data untuk menyimpan detail berupa id kelas yang akan di-request ke API
    List<Map<String, String>> detailBody = [];

    /// memasukkan id kelas ke dalam detailBody
    for (var data in detail) {
      detailBody.add(
        {"id_kelas": data.id.toString()},
      );
    }

    /// Inisialisasi data cart yang akan disimpan ke database.
    Cart cart = Cart(
      idSiswa: idSiswa,
      idGuru: idGuru,
      totalHarga: totalHarga,
      status: "requested",
      detail: detailBody,
    );

    var url = Uri.parse('$mainUrl/store-cart');
    var response = await http.post(
      url,

      /// headers kali ini ditulis, karena ada list id kelas
      /// yang hanya bisa ditulis via JSON
      headers: {"Content-type": "application/json"},
      body: json.encode(cart.toJson()),
    );

    var body = json.decode(response.body);
    var message = body['message'];
    if (response.statusCode == 200) {
      log(message.toString());
    } else {
      log(message.toString());
    }
  }

  /// Fungsi untuk mengambil data cart berdasarkan id pengguna yang login(murid)
  getCart() async {
    var url = Uri.parse('$mainUrl/cart/$currentid');
    var response = await http.get(url);

    List<Transaksi> transaksi = [];

    if (response.statusCode == 200) {
      var body = json.decode(response.body);
      var data = body['data'];

      for (var item in data) {
        Cart c = Cart(
          id: item['id'],
          guru: Guru(nama: item['guru_cart']['nama_pengguna']),
          status: item['status'],
        );

        List<Kelas> kelas = [];

        for (var item in item['detail_cart']) {
          Kelas k = Kelas(
            id: item['kelas']['id'],
            kapasitas: item['kelas']['kapasitas'],
            hari: item['kelas']['hari'],
            jam: item['kelas']['jam'],
            harga: double.parse(item['kelas']['harga'].toString()),
            mataPelajaran: MataPelajaran(
              id: item['kelas']['mata_pelajaran_kelas']['id'],
              mataPelajaran: item['kelas']['mata_pelajaran_kelas']
                  ['nama_mata_pelajaran'],
            ),
          );

          kelas.add(k);
        }
        transaksi.add(
          Transaksi(cart: c, kelas: kelas),
        );
      }
    }

    return transaksi;
  }
}
