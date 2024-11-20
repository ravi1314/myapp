import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:myapp/feature/data/new_model.dart';

class HomeRepo {
  static const String _apiKey = 'd9ae167f2ada423e8d47d63964ab9c8a';
  static const String _baseUrl = 'https://newsapi.org/v2/top-headlines';

  // Fetch news data from API
  Future<NewsModel?> getNews(
      {String country = 'us', String category = 'business'}) async {
    try {
      final Uri url = Uri.parse(
          '$_baseUrl?country=$country&category=$category&apiKey=$_apiKey');

      final  response = await http.get(url);


      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);

        // Parse the response into NewsModel
        return NewsModel.fromJson(jsonData);
      } else {
        print("Failed to load news. Status code: ${response.statusCode}");
        return null; // Return null if the request fails
      }
    } catch (e) {
      print("Error fetching news data: $e");
      return null; // Return null if there's an error
    }
  }
}
