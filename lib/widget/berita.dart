import 'package:flutter/material.dart';
import 'package:lat1/model/article.dart';

class AppBerita extends StatelessWidget {
  const AppBerita({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: TampilanBeritaApp(),
    );
  }
}


class TampilanBeritaApp extends StatefulWidget {
  const TampilanBeritaApp({super.key});

  @override
  State<TampilanBeritaApp> createState() => _TampilanBeritaAppState();
}

class _TampilanBeritaAppState extends State<TampilanBeritaApp> {

  late Future<List<Article>> _ArticlesFuture;

  @override
  void initState() {
   
    super.initState();
    _ArticlesFuture = ApiService().fetchArticles();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Berita Terkini (Indonesia)"),
      ),

      body: FutureBuilder<List<Article>>(

        future: _ArticlesFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }else if(snapshot.hasError){
            return Center(child: Text("Error Connection ${snapshot.error}"),);
          }else if(snapshot.hasData && snapshot.data!.isNotEmpty){
            final articles = snapshot.data!;
             return ListView.builder(
            itemCount: articles.length,
            itemBuilder: (context, index) {
              final article = articles[index];
              return Card(
                margin: const EdgeInsets.all(10),
                elevation: 4,
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: Column(
                    children: <Widget>[
                      if (article.urlToImage != null)
                      Image.network(
                        article.urlToImage!,
                        errorBuilder: (context, error, stackTrace){
                          return const Icon(Icons.image_not_supported, size: 40,);
                        },
                      ),
                      SizedBox(height: 10,),
                      Text(
                        article.title,
                        style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                      ),
                      SizedBox(height: 5,),
                      Text(article.description ?? 'Tidak ada deskripsi')
                    ],
                  ),
                  ),
                  
              );
            },
          );
          }else {
            return const Center (child: Text("Tidak ada berita yang akan di tunjukan"),);
          }        
        },





      ),






    );
  }
}