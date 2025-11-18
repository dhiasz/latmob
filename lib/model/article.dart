import 'dart:convert';
import 'package:http/http.dart' as http;

class Article {
  final String title;
  final String? description;
  final String? urlToImage;

  Article({
    required this.title, this.description, this.urlToImage
  });

  factory Article.fromJson(Map<String, dynamic> json){
    return Article(
      title: json['title'],
      description: json['description'],
      urlToImage: json['urlToImage']
      );
  }
}

class ApiService{
  static const _apikey= '7471976f73c64077b8cb6fcc567680b6';
  static const _link = "https://newsapi.org/v2/top-headlines?country=us&category=business&apiKey=${_apikey}";

  Future<List<Article>> fetchArticles() async{

    try {
      
      final response = await http.get(Uri.parse(_link));
      if(response.statusCode == 200){
        final Map<String, dynamic> json = jsonDecode(response.body);
        final List<dynamic> articlesJson = json['articles'];
        return articlesJson.map((json) => Article.fromJson(json)).toList();
      }else {
        throw Exception('Failed to load articles: ${response.statusCode}');
      }

    } catch (e) {
      throw Exception('Failed to connect to the server: $e');
    }

  }

}