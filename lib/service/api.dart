//dart:convert → digunakan untuk mengubah (encode/decode) JSON menjadi Map dan sebaliknya.
import 'dart:convert';
//package:http/http.dart → library untuk melakukan permintaan HTTP (seperti GET, POST). as http → membuat alias, jadi kamu bisa menulis http.get() bukan get().
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;


class Article {
  final String judul;
  final String? deskripsi;
  final String? linkgambar;

  //Construct
  Article({required this.judul, this.deskripsi, this.linkgambar});

    //field yang dikirim newsapi
  //   {
  // "title": "...",
  // "description": "...",
  // "urlToImage": "..."
  // }
  // Bentuk <key, value > disebut Generic Type ntuk menentukan tipe data secara fleksibel
  factory Article.fromJson(Map<String, dynamic> json) {
    return Article(
      judul: json['title'] ?? 'Tanpa Judul',
      deskripsi: json['description'],
      linkgambar: json['urlToImage'],
    );
  }
}

class ApiService {
  //static const → berarti nilai konstan dan milik class (bukan objeknya)
  static const _apiKey = 'ISI_DENGAN_API_KEY_ANDA';
  static const _baseUrl = 'https://newsapi.org/v2/top-headlines?country=id&apiKey=$_apiKey';

// Future → artinya fungsi ini asynchronous (hasilnya akan datang nanti, bukan langsung).
// List<Article> → hasil akhirnya adalah daftar (list) objek Article.
// async → agar bisa memakai await di dalam fungsi ini.
  Future<List<Article>> fetchArticles() async {

// try → blok untuk menangkap error jika ada masalah.
// Uri.parse(_baseUrl) → mengubah string URL menjadi objek Uri agar bisa dipakai oleh http.get().
    
    try {
// await → menunggu hasil dari operasi http.get() selesai (karena ini operasi jaringan).
      final response = await http.get(Uri.parse(_baseUrl));

      if (response.statusCode == 200) {

        // response.body → isi dari respons (berupa teks JSON).
        // jsonDecode(...) → mengubah teks JSON menjadi Map (peta data) agar bisa diakses seperti json['articles'].
        final Map<String, dynamic> json = jsonDecode(response.body);

        // Mengambil daftar artikel dari JSON utama.
        // Di NewsAPI, semua berita ada di dalam articles.
        final List<dynamic> articlesJson = json['articles'];

        // articlesJson.map(...) → mengubah setiap elemen dari list JSON menjadi objek Article.
        // (json) => Article.fromJson(json) → memanggil factory constructor fromJson untuk tiap data.
        // .toList() → mengubah hasil map menjadi List<Article>.
        return articlesJson.map((json) => Article.fromJson(json)).toList();

      } else {
        throw Exception('Failed to load articles: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to connect to the server: $e');
    }
  }
}



class NewsApp extends StatelessWidget {
  const NewsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Aplikasi Berita',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const NewsScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class NewsScreen extends StatefulWidget {
  const NewsScreen({super.key});

  @override
  State<NewsScreen> createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> {
//late digunakan untuk Menunda inisialisasi variabel sampai waktu tertentu
  late Future<List<Article>> _articlesFuture;

  @override
  void initState() {
// initState() dijalankan sekali saja saat halaman pertama kali dibuat.
// ApiService().fetchArticles() → memanggil fungsi dari class ApiService yang kamu buat sebelumnya untuk mengambil data berita dari API.
// Hasilnya disimpan dalam _articlesFuture.
    super.initState();
    _articlesFuture = ApiService().fetchArticles();
  }

  @override
  Widget build(BuildContext context) {
    // Kamu bilang: “Aku mau menampilkan widget ini ke layar.”
    return Scaffold(
      appBar: AppBar(
        title: const Text('Berita Terkini (Indonesia)'),
      ),
      body: FutureBuilder<List<Article>>(
        // Future yang sedang ditunggu (hasil fetchArticles()).
        future: _articlesFuture,
        // builder adalah fungsi yang bertugas membangun (menampilkan) tampilan (UI) berdasarkan hasil data yang diterima.
        // snapshot → berisi status dan hasil Future (misal: loading, sukses, error).
        builder: (context, snapshot) {
          // Menampilkan loading spinner selama data belum selesai diambil dari API.
          if (snapshot.connectionState == ConnectionState.waiting) {
            // CircularProgressIndicator() adalah widget Flutter yang digunakan untuk menampilkan animasi loading berbentuk lingkaran yang berputar ⏳
            return const Center(child: CircularProgressIndicator());
          } 
          else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } 
          // snapshot.hasData → memastikan data tersedia. snapshot.data! → mengambil list artikel yang sudah diambil dari API.
          else if (snapshot.hasData && snapshot.data!.isNotEmpty) {

            // snapshot.data! → mengambil list artikel yang sudah diambil dari API.
            final articles = snapshot.data!;
            // ListView.builder → membuat daftar (scrollable list).
            // itemCount → jumlah berita yang akan ditampilkan.
            // itemBuilder → membuat tampilan untuk setiap berita.
            return ListView.builder(
              itemCount: articles.length,
              itemBuilder: (context, index) {
                final article = articles[index];
                return Card(
                  margin: const EdgeInsets.all(10),
                  elevation: 4,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Image.network() → menampilkan gambar dari URL.
                        // errorBuilder → jika gambar gagal dimuat, tampilkan ikon pengganti.
                        if (article.urlToImage != null)
                          Image.network(
                            article.urlToImage!,
                            errorBuilder: (context, error, stackTrace) {
                              return const Icon(Icons.image_not_supported, size: 50);
                            },
                          ),
                        const SizedBox(height: 10),
                        Text(
                          article.title,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 5),
                        Text(article.description ?? 'Tidak ada deskripsi.'),
                      ],
                    ),
                  ),
                );
              },
            );
          } else {
            return const Center(child: Text('Tidak ada berita yang ditemukan.'));
          }
        },
      ),
    );
  }
}
