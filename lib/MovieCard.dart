import 'package:flutter/material.dart';
import 'package:flutter_exemple/Movie.dart';

class MovieCard extends StatelessWidget {
  // Constructeur : Quand je crée MovieCard je peux lui donner des paramètres
  const MovieCard({super.key, required this.movie});

  final Movie movie;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(children: [
        ListTile(
          leading: Image.network(
              "https://image.tmdb.org/t/p/w500/" + movie.posterPath),
          title: Text(
            movie.title,
            style: TextStyle(fontSize: 20),
          ),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => Affiche(movie: movie),
              ),
            );
          },
        ),
      ]),
    );
  }
}

class Affiche extends StatelessWidget {
  const Affiche({super.key, required this.movie});

  final Movie movie;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text('Retour'),
          ),
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 1),
                child: Column(children: [
                  Image.network(
                    "https://image.tmdb.org/t/p/w500/" + movie.posterPath,
                    width: 45,
                  ),
                  Text(movie.title),
                  Text(movie.overview),
                  Text(movie.releaseDate),
                ]),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
