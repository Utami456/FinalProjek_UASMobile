import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/movie_provider.dart';
import '../models/movie.dart';

class DetailScreen extends StatelessWidget {
  final String imdbId;

  const DetailScreen({required this.imdbId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Movie Details', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        centerTitle: true,
      ),
      body: FutureBuilder(
        future: context.read<MovieProvider>().getMovieDetails(imdbId),
        builder: (context, AsyncSnapshot<Movie> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData) {
            return const Center(child: Text('Movie not found'));
          } else {
            final movie = snapshot.data!;
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(movie.title, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 8),
                    Center(
                      child: Image.network(
                        movie.poster,
                        fit: BoxFit.cover,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text('Rating: ${movie.imdbRating}'),
                    const SizedBox(height: 8),
                    Text('Duration: ${movie.runtime}'),
                    const SizedBox(height: 8),
                    Text('Genre: ${movie.genre}'),
                    const SizedBox(height: 8),
                    const Text('Plot:', style: TextStyle(fontWeight: FontWeight.bold)),
                    const SizedBox(height: 8),
                    Text(movie.plot),
                    const SizedBox(height: 20), // Adding space before the button
                    Center(
                    child: ElevatedButton(
                      onPressed: () {
                        // You can replace the following with any action like opening a video URL, etc.
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Watch Now button pressed')),
                        );
                      },
                      child: const Text('Watch Now'),
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 16.0), backgroundColor: Colors.red,
                        textStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold), // You can change the color to match your theme
                      ),
                    ),),
                  ],
                ),
              ),
            );
          }
        },
      ),
    );
  }
}
