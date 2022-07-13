import 'package:flutter/material.dart';
import 'package:sivat/api/cari_guru_api.dart';
import 'package:sivat/api/mata_pelajaran_api.dart';
import 'package:sivat/custom_theme.dart';
import 'package:sivat/detail_guru_page.dart';
import 'package:sivat/list_data.dart';
import 'package:sivat/model/guru_model.dart';
import 'package:sivat/model/mata_pelajaran_model.dart';

class CariGuruByMapelPage extends StatefulWidget {
  const CariGuruByMapelPage({Key? key}) : super(key: key);

  @override
  State<CariGuruByMapelPage> createState() => _CariGuruByMapelPageState();
}

class _CariGuruByMapelPageState extends State<CariGuruByMapelPage> {
  List<MataPelajaran> mataPelajarans = [];
  bool isLoading = true;

  @override
  void initState() {
    MataPelajaranApi().getMataPelajaran().then(
      (value) {
        setState(() {
          mataPelajarans = value;
          isLoading = false;
        });
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          'Mata Pelajaran',
        ),
        backgroundColor: Colour.blue,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: isLoading
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  CircularProgressIndicator(),
                  SizedBox(
                    height: 10,
                  ),
                  Text('memuat')
                ],
              ),
            )
          : ListView.builder(
              itemCount: mataPelajarans
                  .where(
                    (element) => element.jenjangMataPelajaran == currentjenjang,
                  )
                  .toList()
                  .length,
              itemBuilder: (context, index) {
                var mapel = mataPelajarans
                    .where(
                      (element) =>
                          element.jenjangMataPelajaran == currentjenjang,
                    )
                    .toList();
                return ListTile(
                  onTap: () {
                    Route route = MaterialPageRoute(
                      builder: (context) =>
                          CariGuruMapel(idMapel: mapel[index].id),
                    );

                    Navigator.push(context, route);
                  },
                  title: Text(
                    mapel[index].mataPelajaran!,
                  ),
                  trailing: Text(mapel[index].jenjangMataPelajaran!),
                );
              }),
    );
  }
}

class CariGuruMapel extends StatefulWidget {
  final int? idMapel;
  const CariGuruMapel({
    Key? key,
    required this.idMapel,
  }) : super(key: key);

  @override
  State<CariGuruMapel> createState() => _CariGuruMapelState();
}

class _CariGuruMapelState extends State<CariGuruMapel> {
  List<Guru> gurus = [];
  bool isLoading = true;

  @override
  void initState() {
    CariGuruApi()
        .getGuruByMataPelajaran(
      widget.idMapel!,
      currentid!,
    )
        .then(
      (value) {
        setState(() {
          gurus = value;
          isLoading = false;
        });
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          'Cari Guru',
        ),
        backgroundColor: Colour.blue,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: isLoading
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  CircularProgressIndicator(),
                  SizedBox(
                    height: 10,
                  ),
                  Text('memuat')
                ],
              ),
            )
          : (gurus.isNotEmpty
              ? ListView.builder(
                  itemCount: gurus.length,
                  itemBuilder: (context, index) {
                    var pengajars = gurus[index];
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
                            idGuru: pengajars.id,
                            namaGuru: pengajars.nama,
                            rating: pengajars.rating,
                            alamatGuru: pengajars.alamatDetail,
                            kotaGuru: pengajars.alamatKota,
                            provinsiGuru: pengajars.alamatProvinsi,
                            pendidikanTerakhir: pengajars.jenjang,
                            jenisKelamin: pengajars.jenisKelamin,
                            noTelepon: pengajars.noTelepon,
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
                        pengajars.nama!,
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
                          children: pengajars.mataPelajarans!.map((mapel) {
                            var index =
                                pengajars.mataPelajarans!.indexOf(mapel);
                            return Text(
                              /// algoritma untuk memunculkan koma(,) diantara
                              /// tiap item dan menghilangkan koma di item paling terakhir
                              index != pengajars.mataPelajarans!.length - 1
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
                            pengajars.rating!.toString() + ' / 5.0',
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
                  })
              : const ListTile(
                  title: Text('belum ada guru'),
                )),
    );
  }
}
