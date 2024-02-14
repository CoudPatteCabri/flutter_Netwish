import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_exemple/Movie.dart';
import 'package:flutter_exemple/MovieCard.dart';
// import 'package:flutter_exemple/MovieCard.dart';
import 'package:http/http.dart' as http;

fetchMovies(String titredufilm) async {
  var url = Uri.parse(
      'https://api.themoviedb.org/3/search/movie?api_key=26a145d058cf4d1b17cbf084ddebedec&query=$titredufilm&language=fr-FR');

  var res = await http.get(url);
  // To json

  if (res.statusCode >= 200 && res.statusCode < 300) {
    //Requete ok
    List resBody = jsonDecode(res.body)['results'];
    List<Movie> movies = resBody
        .map((e) => Movie(
              title: e['title'],
              posterPath: e['poster_path'] ?? 'https://via.placeholder.com/150',
              overview: e['overview'],
              releaseDate: e['release_date'],
              voteAverage: e['vote_average'],
            ))
        .toList();
    return movies;

    // print(resBody);
    // return resBody;
  } else {
    //Requete pas ok
    print(res.reasonPhrase);
    return [];
  }
}

class ListMovie extends StatefulWidget {
  const ListMovie({super.key});

  @override
  State<ListMovie> createState() => _ListMovieState();
}

class _ListMovieState extends State<ListMovie> {
  List<Movie> movies = [];
  TextEditingController _searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView(children: [
        TextField(
          cursorColor: Colors.white,
          controller: _searchController,
        ),

        Container(
          decoration: BoxDecoration(
              color: Colors.red, borderRadius: BorderRadius.circular(40)),
          child: TextButton(
            onPressed: () {
              fetchMovies(_searchController.text).then(
                (value) => setState(() {
                  movies = value;
                }),
              );
            },
            child: Text(
              "Rechercher",
              style: TextStyle(color: Colors.white),
              
            ),
          ),
        ),
        for (var m in movies) MovieCard(movie: m),
        // movies.map((e) =>
        // MovieCard(movie: e)
        // ).toList(),
      ]),
    );
  }
}
