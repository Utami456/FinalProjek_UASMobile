import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'screens/home_screen.dart';
import 'screens/loginpage.dart'; // Import LoginPage
import 'providers/movie_provider.dart';
import 'repositories/movie_repository.dart';
import 'services/api_service.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider(create: (_) => ApiService()),
        ProxyProvider<ApiService, MovieRepository>(
          update: (_, apiService, __) => MovieRepository(apiService),
        ),
        ChangeNotifierProxyProvider<MovieRepository, MovieProvider>(
          create: (context) => MovieProvider(context.read<MovieRepository>()),
          update: (_, repository, __) => MovieProvider(repository),
        ),
      ],
      child: MaterialApp(
        title: 'Movie Explorer',
        theme: ThemeData(
          brightness: Brightness.dark, // Set brightness to dark mode
          primarySwatch: Colors.blue, // Primary color for AppBar and buttons
          scaffoldBackgroundColor: Colors.black, // Set the background color to black
          appBarTheme: const AppBarTheme(
            backgroundColor: Colors.black, // Set AppBar color to black
            titleTextStyle: TextStyle(color: Colors.white), // Set title text color to white
          ),
          textTheme: const TextTheme(
            bodyLarge: TextStyle(color: Colors.white), // Set body text color to white
            bodyMedium: TextStyle(color: Colors.white), // Set other text color to white
            titleLarge: TextStyle(color: Colors.white), // Set AppBar title text color
          ),
          iconTheme: const IconThemeData(color: Colors.white), // Set icon color to white
        ),
        initialRoute: '/',  // Set the initial route to '/login'
        routes: {
          '/': (context) => LoginPage(),  // Show LoginPage first
          '/home': (context) => const HomeScreen(),  // Define route to go to HomeScreen after login
        },
      ),
    );
  }
}
