import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mouvour_getx/models/movie_model.dart';
import 'package:mouvour_getx/services/api/api.dart';

class MoviesController extends GetxController {
  @override
  void onInit() {
    fetchMovies();
    super.onInit();
  }

  var isLoading = true.obs;

  var Now_playing_movies = <dynamic>[].obs;
  var Popular_movies = <dynamic>[].obs;
  var Top_rated_movies = <dynamic>[].obs;
  var Trending_movies = <dynamic>[].obs;

  void fetchMovies() async {
    try {
      isLoading(true);
      //nowplaying
      List<MovieModel> nowPlaying = await ApiServices.fetchNowPlaying();
      if (nowPlaying != []) {
        Now_playing_movies.value = nowPlaying;
      } else {
        debugPrint("no data in nowPlaying!!");
      }

      //popularmovies
      List<MovieModel> popularMovies = await ApiServices.fetchPopular();
      if (popularMovies != []) {
        Popular_movies.value = popularMovies;
      } else {
        debugPrint("no data in popularMovies!!");
      }

      //topratedMovies
      List<MovieModel> topRatedMovies = await ApiServices.fetchTopRated();
      if (topRatedMovies != []) {
        Top_rated_movies.value = topRatedMovies;
      } else {
        debugPrint("no data in topratedMovies!!");
      }

      //trendingMovies
      List<MovieModel> trendingMovies = await ApiServices.fetchTrending();
      if (trendingMovies != []) {
        Trending_movies.value = trendingMovies;
      } else {
        debugPrint("no data in trendingMovies!!");
      }
    } catch (err) {
      print("error caused in moviesController is =>> ${err}");
    } finally {
      Future.delayed(Duration(seconds: 5));
      isLoading(false);
      print("done");
    }
  }
}
