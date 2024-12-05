// lib/repositories/movie_repository.dart
import '../services/api_service.dart';
import '../models/movie.dart';

class MovieRepository {
  final ApiService _apiService;

  MovieRepository(this._apiService);

  Future<List<Movie>> searchMovies(String query) async {
    final response = await _apiService.searchMovies(query);
    final List movies = response['Search'];
    return movies.map((json) => Movie.fromJson(json)).toList();
  }

  Future<Movie> getMovieDetails(String imdbId) async {
    final response = await _apiService.getMovieDetails(imdbId);
    return Movie.fromJson(response);
  }
}
