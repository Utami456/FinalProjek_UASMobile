// lib/providers/movie_provider.dart
import 'package:flutter/material.dart';
import '../repositories/movie_repository.dart';
import '../models/movie.dart';

class MovieProvider with ChangeNotifier {
  final MovieRepository _repository;

  MovieProvider(this._repository);

  bool _isLoading = false;
  List<Movie> _movies = [];
  List<Movie> _recommendations = [];
  List<Movie> _newReleases = [];
  Movie? _movieDetails;

  bool get isLoading => _isLoading;
  List<Movie> get movies => _movies;
  List<Movie> get recommendations => _recommendations;
  List<Movie> get newReleases => _newReleases;
  Movie? get movieDetails => _movieDetails;

  Future<void> searchMovies(String query) async {
    _isLoading = true;
    notifyListeners();
    final result = await _repository.searchMovies(query);
    _movies = result;
    _isLoading = false;
    notifyListeners();
  }

  Future<Movie> getMovieDetails(String imdbId) async {
    final result = await _repository.getMovieDetails(imdbId);
    _movieDetails = result;
    return result;
  }

  Future<void> fetchDummyData() async {
    // Fetch dummy data for recommendations and new releases
    _isLoading = true;
    notifyListeners();

    // Dummy IMDb IDs for example purposes

     List<String> recommendationIds = [
      'tt1375666', 'tt0848228', 'tt0111161', 'tt0468569', 'tt1375666',
      'tt0137523', 'tt0110912', 'tt0120737', 'tt0109830', 'tt0068646'
    ];
    List<String> newReleaseIds = [
      'tt0993846', 'tt0167260', 'tt0120338', 'tt0172495', 'tt0133093',
      'tt0110357', 'tt0108052', 'tt0090605', 'tt0088763', 'tt0076759'
    ];

    _recommendations = await Future.wait(recommendationIds.map((id) => getMovieDetails(id)));
    _newReleases = await Future.wait(newReleaseIds.map((id) => getMovieDetails(id)));

    _isLoading = false;
    notifyListeners();
  }
}
