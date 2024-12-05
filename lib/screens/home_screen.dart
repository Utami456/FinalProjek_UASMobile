import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/movie_provider.dart';
import '../widgets/movie_card.dart';
import '../screens/detail_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String _searchQuery = ''; // To store the search query

  @override
  void initState() {
    super.initState();
    context.read<MovieProvider>().fetchDummyData(); // Fetch dummy data when the screen loads
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Movie Explorer',style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        centerTitle: true,
      ),
      body: CustomScrollView(
        slivers: [
          SliverList(
            delegate: SliverChildListDelegate([
              _buildSearchBar(), // Adding the search bar
              _buildSearchResults(context), // Display search results above recommendations
              _buildRecommendationsAndNewReleases(context),
            ]),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: TextField(
        onChanged: (query) {
          setState(() {
            _searchQuery = query;
          });
          if (_searchQuery.isNotEmpty) {
            // Trigger search when query is not empty
            context.read<MovieProvider>().searchMovies(_searchQuery);
          }
        },
        decoration: InputDecoration(
          hintText: 'Search movies...',
          prefixIcon: const Icon(Icons.search),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
    );
  }

  Widget _buildSearchResults(BuildContext context) {
    return Consumer<MovieProvider>(
      builder: (context, provider, child) {
        if (provider.isLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (_searchQuery.isEmpty || provider.movies.isEmpty) {
          return const SizedBox.shrink(); // Don't show anything if there's no query or results
        }

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text('Search Results', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            ),
            SizedBox(
              height: 300,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: provider.movies.length,
                itemBuilder: (context, index) {
                  final movie = provider.movies[index];
                  return GestureDetector(
                    onTap: () {
                      // Navigate to the DetailScreen when a card is tapped
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DetailScreen(imdbId: movie.imdbId),
                        ),
                      );
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: MovieCard(movie: movie), // Movie card widget
                    ),
                  );
                },
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildRecommendationsAndNewReleases(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.all(8.0),
          child: Text('Recommendations', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        ),
        Consumer<MovieProvider>(
          builder: (context, provider, child) {
            if (provider.isLoading) {
              return const Center(child: CircularProgressIndicator());
            }
            return SizedBox(
              height: 300,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: provider.recommendations.length,
                itemBuilder: (context, index) {
                  final movie = provider.recommendations[index];
                  return GestureDetector(
                    onTap: () {
                      // Navigate to the DetailScreen when a card is tapped
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DetailScreen(imdbId: movie.imdbId),
                        ),
                      );
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: MovieCard(movie: movie), // Movie card widget
                    ),
                  );
                },
              ),
            );
          },
        ),
        const Padding(
          padding: EdgeInsets.all(8.0),
          child: Text('New Releases', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        ),
        Consumer<MovieProvider>(
          builder: (context, provider, child) {
            if (provider.isLoading) {
              return const Center(child: CircularProgressIndicator());
            }
            return SizedBox(
              height: 300,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: provider.newReleases.length,
                itemBuilder: (context, index) {
                  final movie = provider.newReleases[index];
                  return GestureDetector(
                    onTap: () {
                      // Navigate to the DetailScreen when a card is tapped
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DetailScreen(imdbId: movie.imdbId),
                        ),
                      );
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: MovieCard(movie: movie), // Movie card widget
                    ),
                  );
                },
              ),
            );
          },
        ),
      ],
    );
  }
}
