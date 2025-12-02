import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';


class TemaProvider extends ChangeNotifier{
  ThemeMode _ModeTema = ThemeMode.light;
  ThemeMode get ModeTema => _ModeTema;
  bool get ModeGelap => _ModeTema == ThemeMode.dark;

  static String _kunci = 'KunciTema';

  TemaProvider(){
    
    }
    void loadtema() async {
    final koneksi = await SharedPreferences.getInstance();
    final Gelap = koneksi.getBool(_kunci) ?? false;

    _ModeTema = Gelap ? ThemeMode.dark : ThemeMode.light;
  }

  void GantiTema(bool aktif) async{
    _ModeTema = aktif ? ThemeMode.dark : ThemeMode.light;
    notifyListeners();

    final koneksi = await SharedPreferences.getInstance();
    koneksi.setBool(_kunci, aktif);
  }

}




