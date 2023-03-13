import 'package:dio/dio.dart';
import 'package:mouvour_getx/models/cast_model.dart';
import 'package:mouvour_getx/models/movie_model.dart';
import 'package:mouvour_getx/models/single_movie_model/single_movie_model.dart';

class ApiServices {
  static final API_KEY = "e458813ff8f9fd6ae8597fa989d111ef";
  static final BASE_URL = "https://api.themoviedb.org/3";

  static var client = Dio();

  //nowplaying
  static Future<List<MovieModel>> fetchNowPlaying() async {
    var response = await client.get(
        "${BASE_URL}/movie/now_playing?api_key=${API_KEY}&language=en-US&page=1");

    if (response.statusCode == 200) {
      List<dynamic> jsonData = await response.data['results'];
      return jsonData.map((e) => MovieModel.fromJson(e)).toList();
    } else {
      return [];
    }
  }

  // popular
  static Future<List<MovieModel>> fetchPopular() async {
    var response = await client.get(
        "${BASE_URL}/movie/popular?api_key=${API_KEY}&language=en-US&page=1");

    if (response.statusCode == 200) {
      List<dynamic> jsonData = await response.data['results'];
      return jsonData.map((e) => MovieModel.fromJson(e)).toList();
    } else {
      return [];
    }
  }

  //top_rated
  static Future<List<MovieModel>> fetchTopRated() async {
    var response = await client.get(
        "${BASE_URL}/movie/top_rated?api_key=${API_KEY}&language=en-US&page=1");

    if (response.statusCode == 200) {
      List<dynamic> jsonData = await response.data['results'];
      return jsonData.map((e) => MovieModel.fromJson(e)).toList();
    } else {
      return [];
    }
  }

  //fetchTrending
  static Future<List<MovieModel>> fetchTrending() async {
    var response =
        await client.get("${BASE_URL}/trending/all/day?api_key=${API_KEY}");

    if (response.statusCode == 200) {
      List<dynamic> jsonData = await response.data['results'];
      return jsonData.map((e) => MovieModel.fromJson(e)).toList();
    } else {
      return [];
    }
  }

  //singleMovieData
  static Future<List<SingleMovieModel>> fetchSingleMovieData(String id) async {
    print("inside singlemov api func =>> $id");
    var response = await client.get("${BASE_URL}/movie/$id?api_key=${API_KEY}");

    if (response.statusCode == 200) {
      List<dynamic> jsonData = await [response.data];
      return jsonData.map((e) => SingleMovieModel.fromJson(e)).toList();
    } else {
      return [];
    }
  }

  //casts
  static Future<List<CastModel>> fetchSingleMovieCasts(String id) async {
    var response = await client
        .get("${BASE_URL}/movie/$id/credits?api_key=${API_KEY}&language=en-US");

    if (response.statusCode == 200) {
      List<dynamic> jsonData = await response.data['cast'];
      return jsonData.map((e) => CastModel.fromJson(e)).toList();
    } else {
      return [];
    }
  }

  //similarMovies
  static Future<List<MovieModel>> fetchSimilarMovies(String id) async {
    var response = await client.get(
        "${BASE_URL}/movie/$id/similar?api_key=${API_KEY}&language=en-US&page=1");

    if (response.statusCode == 200) {
      List<dynamic> jsonData = await response.data['results'];
      return jsonData.map((e) => MovieModel.fromJson(e)).toList();
    } else {
      return [];
    }
  }
}
