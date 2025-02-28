import 'package:flutter/material.dart';
import 'package:pilem/models/movie.dart';

class DetailScreen extends StatelessWidget {
  final Movie movie; // Dari Model di Line 2
  const DetailScreen({super.key, required this.movie});
  // This Movie ambil dari model

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(movie.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Image.network(
                "https://image.tmdb.org/t/p/w500${movie.backdropPath}",
                height: 300,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
              const SizedBox(height: 20),
              const Text(
                'Overview:',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              Text(
                movie.overview,
                textAlign: TextAlign.justify,
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  const Icon(Icons.calendar_month, color: Colors.blue),
                  const SizedBox(width: 10),
                  const Text(
                    'Release Date:',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(width: 10),
                  Text(movie.releaseDate),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  const Icon(Icons.star, color: Colors.amber),
                  const SizedBox(width: 10),
                  const Text(
                    'Rating:',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(width: 10),
                  Text(movie.voteAverage.toString()),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
