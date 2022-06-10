import 'package:shared_preferences/shared_preferences.dart';

import 'model/guru_model.dart';
import 'model/kelas_model.dart';

/// url untuk request ke API
/// sudah public gaess...
var mainUrl = 'https://levelink-api.agdakapareski.xyz/api';

/// data untuk menyimpan list guru(pengajar)
/// untuk halaman cari guru
List<Guru> pengajar = [];

/// data untuk menyimpan list cart
/// untuk halaman cart
List<Kelas> carts = [];

/// data untuk menyimpan total harga kelas yang akan dibeli
double totalHarga = 0;

/// Kumpulan data untuk menampung data user yang sedang login di aplikasi
int? currentid;
String? currentgambar;
String? currentnama;
String? currentjenjang;
int? currentkelas;
String? currentalamatProvinsi;
String? currentalamatKota;
String? currentalamatDetail;
bool? isLogin;

/// fungsi untuk mengambil data dari shared preferences
getSp() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();

  currentid = prefs.getInt('currentid');
  currentnama = prefs.getString('currentnama');
  currentjenjang = prefs.getString('currentjenjang');
  currentkelas = prefs.getInt('currentkelas');
  currentalamatProvinsi = prefs.getString('currentalamatProvinsi');
  currentalamatKota = prefs.getString('currentalamatKota');
  currentalamatDetail = prefs.getString('currentalamatDetail');
  isLogin = prefs.getBool('isLogin');
}

/// fungsi untuk menghapus shared preferences
void deleteCurrentUser() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.remove('currentid');
  prefs.remove('currentnama');
  prefs.remove('currentjenjang');
  prefs.remove('currentkelas');
  prefs.remove('currentalamatProvinsi');
  prefs.remove('currentalamatKota');
  prefs.remove('currentalamatDetail');
  prefs.remove('isLogin');
}
