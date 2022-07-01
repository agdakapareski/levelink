import 'dart:convert';
import 'dart:developer';

import 'package:sivat/list_data.dart';
import 'package:sivat/model/guru_model.dart';
import 'package:sivat/model/kelas_model.dart';
import 'package:sivat/model/mata_pelajaran_model.dart';
import 'package:sivat/model/pertemuan_model.dart';
import 'package:http/http.dart' as http;

import '../model/jadwal_model.dart';

class PertemuanApi {
  storePertemuan(Pertemuan pertemuan) async {
    var url = Uri.parse('$mainUrl/pertemuan');
    var response = await http.post(
      url,
      headers: {"Content-type": "application/json"},
      body: jsonEncode({
        "id_jadwal": pertemuan.idJadwal,
        "materi": pertemuan.materi,
        "is_aktif": 1,
        "capaian": 0,
        "evaluasi": '-',
      }),
    );

    if (response.statusCode == 200) {
      log('pertemuan berhasil dibuat');
    } else {
      log(response.body);
    }
  }

  updatePertemuan(Pertemuan pertemuan, int idPertemuan) async {
    var url = Uri.parse('$mainUrl/update-pertemuan/$idPertemuan');
    var response = await http.put(
      url,
      headers: {"Content-type": "application/json"},
      body: jsonEncode({
        "is_aktif": pertemuan.isAktif,
        "evaluasi": pertemuan.evaluasi,
        "capaian": pertemuan.capaian,
        "jam_selesai": pertemuan.jamSelesai,
      }),
    );

    if (response.statusCode == 200) {
      log('update pertemuan berhasil');
    } else {
      log(response.body);
    }
  }

  getPertemuan() async {
    var url = Uri.parse('$mainUrl/show-pertemuan/$currentid');
    var response = await http.get(url);

    var body = json.decode(response.body);

    var data = body['aktif'];
    var datas = body['riwayat'];

    List<Pertemuan> riwayatPertemuan = [];

    ViewPertemuan viewPertemuan = ViewPertemuan();
    Pertemuan pertemuan = Pertemuan();

    if (response.statusCode == 200) {
      if (data != null) {
        pertemuan.id = data['id'];
        pertemuan.idJadwal = data['id_jadwal'];
        pertemuan.jadwal = Jadwal(
          guru: Guru(
            id: data['jadwal']['kelas']['user']['id'],
            nama: data['jadwal']['kelas']['user']['nama_pengguna'],
          ),
          kelas: Kelas(
            id: data['jadwal']['id_kelas'],
            mataPelajaran: MataPelajaran(
              mataPelajaran: data['jadwal']['kelas']['mata_pelajaran_kelas']
                  ['nama_mata_pelajaran'],
            ),
          ),
        );
        pertemuan.materi = data['materi'];
        pertemuan.isAktif = data['is_aktif'];
        pertemuan.capaian = data['capaian'].runtimeType == int
            ? double.parse(data['capaian'].toString())
            : data['capaian'];
        pertemuan.evaluasi = data['evaluasi'];
        pertemuan.jamMulai = DateTime.parse(data['created_at']);
        pertemuan.jamSelesai = DateTime.parse(data['jam_selesai']);
        viewPertemuan.pertemuanAktif = pertemuan;
      } else {
        viewPertemuan.pertemuanAktif = null;
      }
      for (var item in datas) {
        Pertemuan p = Pertemuan(
          id: item['id'],
          idJadwal: item['id_jadwal'],
          jadwal: Jadwal(
            guru: Guru(
              id: item['jadwal']['kelas']['user']['id'],
              nama: item['jadwal']['kelas']['user']['nama_pengguna'],
            ),
            kelas: Kelas(
              id: item['jadwal']['id_kelas'],
              mataPelajaran: MataPelajaran(
                mataPelajaran: item['jadwal']['kelas']['mata_pelajaran_kelas']
                    ['nama_mata_pelajaran'],
              ),
            ),
          ),
          materi: item['materi'],
          isAktif: item['is_aktif'],
          capaian: item['capaian'].runtimeType == int
              ? double.parse(item['capaian'].toString())
              : item['capaian'],
          evaluasi: item['evaluasi'],
          jamMulai: DateTime.parse(item['created_at']),
          jamSelesai: DateTime.parse(item['jam_selesai']),
        );
        riwayatPertemuan.add(p);
      }

      viewPertemuan.riwayatPertemuan = riwayatPertemuan;

      return viewPertemuan;
    } else {
      return log(response.body);
    }
  }
}
