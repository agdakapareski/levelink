import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:sivat/custom_theme.dart';
import 'package:sivat/detail_guru_page.dart';
import 'package:sivat/list_data.dart';

import 'package:http/http.dart' as http;
import 'package:sivat/widget/input_form.dart';
import 'package:sivat/widget/padded_widget.dart';
import 'model/guru_model.dart';
import 'model/mata_pelajaran_model.dart';

class FindPage extends StatefulWidget {
  const FindPage({Key? key}) : super(key: key);

  @override
  State<FindPage> createState() => _FindPageState();
}

class _FindPageState extends State<FindPage> {
  /// API call untuk mengambil data guru
  /// dengan rating diurutkan dari yang paling tinggi
  /// dan jenjang mata pelajaran yang dikuasai sama dengan
  /// jenjang siswa yang sedang login
  getGuru() async {
    var url = Uri.parse('$mainUrl/pengajar/$currentid');
    var response = await http.get(url);

    var body = json.decode(response.body);
    var datas = body['data'];

    /// Data untuk menampung data guru
    /// hasil response dari API
    List<Guru> gurus = [];

    if (response.statusCode == 200) {
      for (var data in datas) {
        Guru u = Guru(
          id: data['id'],
          nama: data['nama_pengguna'],

          /// Algoritma dibawah untuk mengecek tipe data
          /// dari json response 'total_rating'.
          /// Jika tipe datanya int, maka akan diubah ke
          /// dalam tipe data double.
          rating: data['total_rating'].runtimeType == int
              ? double.parse(data['total_rating'].toString())
              : data['total_rating'],
          alamatKota: data['kota_pengguna'],
          alamatProvinsi: data['provinsi_pengguna'],
          alamatDetail: data['alamat_pengguna'],
          jenjang: data['jenjang'],

          /// Algoritma dibawah untuk memasukkan array hasil
          /// json response 'mata_pelajaran_dikuasai'
          /// ke dalam model MataPelajaran.
          mataPelajarans: data['mata_pelajaran_dikuasai']
              .map((mapel) => MataPelajaran(
                    id: mapel['id'],
                    mataPelajaran: mapel['nama_mata_pelajaran'],
                    jenjangMataPelajaran: mapel['jenjang_mata_pelajaran'],
                  ))
              .toList(),
        );

        gurus.add(u);
      }

      return gurus
          .where((element) => element.mataPelajarans!.isNotEmpty)
          .toList();
    }
  }

  TextEditingController searchController = TextEditingController();

  /// data untuk memunculkan Progress Indicator
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    isLoading = false;
    getGuru().then((value) {
      setState(() {
        pengajar = value;
        isLoading = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        elevation: 0,
        toolbarHeight: 80,
        title: InputForm(
          controller: searchController,
          labelText: 'cari guru',
          isDense: true,
        ),
      ),
      body: isLoading == true
          ? ListView(
              children: [
                const GuruBasedKota(),
                const CustomDivider(),
                const GuruBasedMapel(),
                const CustomDivider(),
                const SizedBox(
                  height: 16,
                ),
                const PaddedWidget(
                  child: SmallerTitleText('Guru Dengan Rating Tinggi'),
                ),
                const SizedBox(
                  height: 16,
                ),
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: pengajar.length,
                  itemBuilder: (context, index) {
                    Guru guru = pengajar[index];
                    return listGuruBasedRating(context, guru);
                  },
                )
              ],
            )
          : loading(),
    );
  }
}

listGuruBasedRating(BuildContext context, Guru pengajar) {
  return ListTile(
    // contentPadding: const EdgeInsets.symmetric(
    //   horizontal: 16.0,
    //   vertical: 8,
    // ),
    shape: const Border(
      bottom: BorderSide(
        width: 1,
        color: Color(0xFFEEEEEE),
      ),
    ),
    onTap: () {
      Route route = MaterialPageRoute(
        builder: (context) => DetailGuruPage(
          idGuru: pengajar.id,
          namaGuru: pengajar.nama,
          rating: pengajar.rating,
          alamatGuru: pengajar.alamatDetail,
          kotaGuru: pengajar.alamatKota,
          provinsiGuru: pengajar.alamatProvinsi,
          pendidikanTerakhir: pengajar.jenjang,
        ),
      );

      Navigator.push(context, route);
    },
    tileColor: Colors.white,
    leading: const CircleAvatar(
      child: Icon(Icons.person),
      radius: 25,
    ),
    title: Text(
      pengajar.nama!,
      style: const TextStyle(
        color: Colors.black,
        // fontWeight: FontWeight.bold,
        fontSize: 16,
      ),
    ),
    subtitle: SizedBox(
      height: 14.5,
      child: ListView(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        children: pengajar.mataPelajarans!.map((mapel) {
          var index = pengajar.mataPelajarans!.indexOf(mapel);
          return Text(
            /// algoritma untuk memunculkan koma(,) diantara
            /// tiap item dan menghilangkan koma di item paling terakhir
            index != pengajar.mataPelajarans!.length - 1
                ? mapel.mataPelajaran + ', '
                : mapel.mataPelajaran,
            style: const TextStyle(
              // color: Colors.black,
              fontSize: 13,
            ),
          );
        }).toList(),
      ),
    ),
    trailing: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          pengajar.rating!.toString() + ' / 5.0',
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 13,
          ),
        ),
        const SizedBox(
          width: 2,
        ),
        Icon(
          Icons.star,
          color: Colors.yellow[600],
          size: 20,
        ),
      ],
    ),
  );
}

class GuruBasedMapel extends StatelessWidget {
  const GuruBasedMapel({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: const BoxDecoration(
        color: Colors.white,
      ),
      height: 70,
      child: Center(
        child: Row(
          children: const [
            Text(
              'Pilih Berdasarkan Mata Pelajaran',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            Spacer(),
            Icon(
              Icons.arrow_forward_ios,
              size: 20,
            )
          ],
        ),
      ),
    );
  }
}

class GuruBasedKota extends StatelessWidget {
  const GuruBasedKota({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: const BoxDecoration(
        color: Colors.white,
      ),
      height: 70,
      child: Center(
        child: Row(
          children: const [
            Text(
              'Telusuri Guru di Kotamu',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            Spacer(),
            Icon(
              Icons.arrow_forward_ios,
              size: 20,
            )
          ],
        ),
      ),
    );
  }
}
