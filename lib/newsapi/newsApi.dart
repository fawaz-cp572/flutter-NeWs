import 'dart:convert';
import 'package:http/http.dart' as http;

class NewsApi {
  final String apiKey = "4873b1f0f83342d68d450105c7fd9f70";
  final String baseUrl = 'https://newsapi.org/v2';
  final String catogory;
  final String country;
  NewsApi(this.catogory, this.country);

//var old = '$baseUrl/everything?country=us&apiKey=$apiKey';
  Stream<List<NewsArticle>> fetchNews() async* {
    final response = await Future.delayed(
      const Duration(seconds: 1),
      () {
        return http.get(Uri.parse(
            "https://newsapi.org/v2/everything?q=$catogory&apiKey=$apiKey"));
      },
    );
    if (response.statusCode == 200) {
      final jsonBody = json.decode(response.body);
      final List<dynamic> articlesJson = jsonBody['articles'];
      yield articlesJson
          .map((articleJson) => NewsArticle.fromJson(articleJson))
          .toList();
    } else {
      throw Exception('Failed to load news');
    }
  }
}

class NewsArticle {
  final String title;
  final String description;
  final String imageUrl;
  final String Nurl;

  NewsArticle(
      {required this.title, required this.description, required this.imageUrl, required this.Nurl});

  factory NewsArticle.fromJson(Map<String, dynamic> json) {
    return NewsArticle(
      title: json['title'] ?? 'No Title',
      description: json['description'] ?? 'No Description',
      imageUrl: json['urlToImage'] ?? '',
      Nurl:json['url']??'',

    );
  }
}
