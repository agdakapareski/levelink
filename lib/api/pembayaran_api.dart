import 'dart:developer';

import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:sivat/list_data.dart';
import 'package:sivat/model/guru_model.dart';
import 'package:sivat/model/pembayaran_model.dart';
import 'package:sivat/model/pertemuan_model.dart';
import 'package:sivat/model/tagihan_model.dart';

class PembayaranApi {
  tambahPembayaran(
    int idGuru,
    int idSiswa,
    int idPertemuan,
    double hargaKelas,
  ) async {
    var url = Uri.parse('$mainUrl/pembayaran');
    var response = await http.post(
      url,
      headers: {"Content-type": "application/json"},
      body: jsonEncode({
        "id_guru": idGuru,
        "id_siswa": idSiswa,
        "id_pertemuan": idPertemuan,
        "harga_kelas": hargaKelas,
        "status_bayar": false
      }),
    );

    if (response.statusCode == 200) {
      log('berhasil membuat tagihan');
    } else {
      log(response.body);
    }
  }

  getPembayaran(int idUser) async {
    var url = Uri.parse('$mainUrl/pembayaran/$idUser');
    var response = await http.get(url);

    var body = json.decode(response.body);
    var listDataBelumBayar = body['belum_bayar'];
    var listDataRiwayatBayar = body['riwayat_bayar'];

    List<Pembayaran> belumBayar = [];
    List<Pembayaran> riwayatBayar = [];

    if (response.statusCode == 200) {
      if (listDataBelumBayar != []) {
        for (var data in listDataBelumBayar) {
          Pembayaran bayar = Pembayaran(
            id: data['id'],
            totalBayar: data['total_bayar'].runtimeType == int
                ? double.parse(data['total_bayar'].toString())
                : data['total_bayar'],
            statusBayar: data['status_bayar'] == 1 ? true : false,
            guru: Guru(
              id: data['guru']['id'],
              nama: data['guru']['nama_pengguna'],
            ),
            tagihan: Tagihan(
              id: data['tagihan']['id'],
              hargaKelas: data['tagihan']['harga_kelas'].runtimeType == int
                  ? double.parse(data['tagihan']['harga_kelas'].toString())
                  : data['tagihan']['harga_kelas'],
              pertemuan: Pertemuan(
                materi: data['tagihan']['pertemuan']['materi'],
              ),
            ),
          );

          belumBayar.add(bayar);
        }
      } else {
        belumBayar = [];
      }

      if (listDataRiwayatBayar != []) {
        for (var data in listDataRiwayatBayar) {
          Pembayaran bayar = Pembayaran(
            id: data['id'],
            totalBayar: data['total_bayar'].runtimeType == int
                ? double.parse(data['total_bayar'].toString())
                : data['total_bayar'],
            statusBayar: data['status_bayar'] == 1 ? true : false,
            guru: Guru(
              id: data['guru']['id'],
              nama: data['guru']['nama_pengguna'],
            ),
            tagihan: Tagihan(
              id: data['tagihan']['id'],
              hargaKelas: data['tagihan']['harga_kelas'].runtimeType == int
                  ? double.parse(data['tagihan']['harga_kelas'].toString())
                  : data['tagihan']['harga_kelas'],
              pertemuan: Pertemuan(
                materi: data['tagihan']['pertemuan']['materi'],
              ),
            ),
          );

          riwayatBayar.add(bayar);
        }
      } else {
        riwayatBayar = [];
      }

      return ApiBayar(
        belumBayar: belumBayar,
        riwayatBayar: riwayatBayar,
      );
    }
  }
}
