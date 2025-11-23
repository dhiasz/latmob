import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeMode _themeMode = ThemeMode.light;
  ThemeMode get themeMode => _themeMode;
  bool get isDarkMode => _themeMode == ThemeMode.dark;

  static const String _themeKey = 'theme_key';

  ThemeProvider() {
    _loadTheme();
  }

  void _loadTheme() async {
    //getintance mengkoneksikan ke penyimpanan agar bisa membaca dan menulis data 
    final prefs = await SharedPreferences.getInstance();
    final isDark = prefs.getBool(_themeKey) ?? false;
    // jika true gunakan dark jika false gunakan light
    _themeMode = isDark ? ThemeMode.dark : ThemeMode.light;
    notifyListeners();
  }

  void toggleTheme(bool isOn) async {
    _themeMode = isOn ? ThemeMode.dark : ThemeMode.light;
    notifyListeners();

    final prefs = await SharedPreferences.getInstance();
    prefs.setBool(_themeKey, isOn);
  }
}

// shared_preferences di Flutter digunakan untuk menyimpan data kecil secara lokal (permanen) di perangkat, mirip seperti Local Storage di web.

// Kegunaan shared_preferences
// Paket ini digunakan untuk menyimpan data sederhana berupa key-value, misalnya:
// Tema aplikasi (dark/light mode)
// Status login (sudah login atau belum)
// Nama pengguna / user ID
// Bahasa aplikasi
// Nilai boolean, integer, string, double, atau list minimal


// SharedPreferences memang disimpan di perangkat, tetapi tidak berada di folder proyek Flutter kamu.
// Penyimpanannya diatur oleh sistem operasi (Android/iOS), dan lokasinya tidak untuk diakses langsung oleh pengguna—lebih seperti database internal aplikasi.
// Namun lokasi teknisnya tetap ada, berikut penjelasannya: