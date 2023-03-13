import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mouvour_getx/models/cast_model.dart';
import 'package:mouvour_getx/models/movie_model.dart';
import 'package:mouvour_getx/models/single_movie_model/single_movie_model.dart';
import 'package:mouvour_getx/services/api/api.dart';

class SingleMovieController extends GetxController {
  var SingleMovieData = <SingleMovieModel>[].obs;
  var SingleMovieCasts = <CastModel>[].obs;
  var SimilarMovies = <MovieModel>[].obs;
  var isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
  }

  void fetchSingleMovieData(String id) async {
    print("in here fetchSingleMovieData and id is $id");
    try {
      isLoading(true);
      //whole dets about movie
      List<SingleMovieModel> movieData =
          await ApiServices.fetchSingleMovieData(id);
      SingleMovieData.value = movieData;
      //casts dets
      List<CastModel> casts = await ApiServices.fetchSingleMovieCasts(id);
      SingleMovieCasts.value = casts;

      //similar movies
      List<MovieModel> similarMov = await ApiServices.fetchSimilarMovies(id);
      SimilarMovies.value = similarMov;
    } catch (err) {
      print("the error occured in singleMovieData is =>> $err");
    } finally {
      isLoading(false);
    }
  }
}
