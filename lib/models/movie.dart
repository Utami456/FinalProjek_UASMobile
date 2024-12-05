// lib/models/movie.dart
class Movie {
  final String title;
  final String year;
  final String imdbId;
  final String type;
  final String poster;
  final String imdbRating;
  final String runtime;
  final String genre;
  final String plot;

  Movie({
    required this.title,
    required this.year,
    required this.imdbId,
    required this.type,
    required this.poster,
    required this.imdbRating,
    required this.runtime,
    required this.genre,
    required this.plot,
  });

  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie(
      title: json['Title'],
      year: json['Year'],
      imdbId: json['imdbID'],
      type: json['Type'],
      poster: json['Poster'],
      imdbRating: json['imdbRating'] ?? 'N/A',
      runtime: json['Runtime'] ?? 'N/A',
      genre: json['Genre'] ?? 'N/A',
      plot: json['Plot'] ?? 'N/A',
    );
  }
}
