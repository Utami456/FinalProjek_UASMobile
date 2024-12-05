import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static const String baseUrl = 'http://www.omdbapi.com/';
  static const String apiKey = 'df2fa54a';

  Future<dynamic> searchMovies(String query) async {
    final response = await http.get(
      Uri.parse('$baseUrl?apikey=$apiKey&s=$query'),
    );
    return json.decode(response.body);
  }

  Future<dynamic> getMovieDetails(String imdbId) async {
    final response = await http.get(
      Uri.parse('$baseUrl?apikey=$apiKey&i=$imdbId'),
    );
    return json.decode(response.body);
  }
}
