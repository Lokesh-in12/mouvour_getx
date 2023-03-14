import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:mouvour_getx/controllers/movies_controller/single_movie_controller.dart';
import 'package:mouvour_getx/controllers/theme/theme_controller.dart';
import 'package:mouvour_getx/views/Widgets/movie_card_now.dart';

import 'package:mouvour_getx/views/utils/Consts/consts.dart';

class DetailsPage extends StatefulWidget {
  final String? id;
  final String? isDark;

  DetailsPage({super.key, @required this.id, this.isDark});

  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  SingleMovieController singleMovieController =
      Get.put(SingleMovieController());
  ThemeController themeController = Get.put(ThemeController());

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    Future.delayed(Duration(microseconds:5 ), () {
      singleMovieController.SimilarMovies.clear();
      singleMovieController.SingleMovieCasts.clear();
      singleMovieController.SimilarMovies.clear();
      handleApiCall(widget.id!);
    });
  }

  void handleApiCall(id) async {
    singleMovieController.fetchSingleMovieData(id);
  }

  @override
  Widget build(BuildContext context) {
    print("in dets =>>> ${themeController.isDark.value}");
    return Obx(() {
      if (singleMovieController.isLoading.value) {
        return Center(
          child: CircularProgressIndicator(),
        );
      }
      return Scaffold(
        backgroundColor:
            themeController.isDark.value ? Colors.grey[900] : Colors.grey[200],
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              width: double.infinity,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Stack(
                      children: <Widget>[
                        SizedBox(
                            width: double.infinity,
                            height: 210,
                            child: singleMovieController
                                        .SingleMovieData[0].backdropPath !=
                                    null
                                ? Image.network(
                                    "${Consts.IMG}${singleMovieController.SingleMovieData[0].backdropPath}")
                                : Image.asset(
                                    "assets/images/backdrop_def.jpg")),
                        InkWell(
                          onTap: () => context.pop(),
                          onLongPress: () => context.pushNamed('home'),
                          child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Icon(
                                Icons.arrow_back_ios_new,
                                size: 40,
                                color: Colors.white,
                              )),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 25,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        LimitedBox(
                          maxWidth: 180,
                          child: Text(
                            "${singleMovieController.SingleMovieData[0].title.toString() ?? "Unavailable"}",
                            style: TextStyle(
                                fontSize: 20,
                                color: themeController.isDark.value
                                    ? Colors.white
                                    : Colors.black),
                          ),
                        ),
                        Text(
                          "⭐ ${singleMovieController.SingleMovieData[0].voteAverage ?? "Unavailable"}/10 IMDb ",
                          style: TextStyle(
                              color: themeController.isDark.value
                                  ? Colors.white
                                  : Colors.black),
                        ),
                      ],
                    ),

                    SizedBox(
                      height: 15,
                    ),

                    //genre
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                              children: singleMovieController
                                  .SingleMovieData[0].genres!
                                  .map<Widget>((e) {
                            return Row(
                              children: [
                                Container(
                                  width: 95,
                                  height: 25,
                                  decoration: BoxDecoration(
                                    color: Color.fromARGB(206, 238, 204, 202),
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Center(
                                          child: Text(
                                        maxLines: 1,
                                        "${e.name.toString()}".toUpperCase(),
                                        style: TextStyle(
                                            fontSize: 11, color: Colors.black),
                                      )),
                                      SizedBox(
                                        width: 5,
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  width: 8,
                                )
                              ],
                            );
                          }).toList()) ??
                          Text("Unavailable"),
                    ),
                    Divider(height: 25),
                    SizedBox(
                        child: Text(
                      "${singleMovieController.SingleMovieData[0].overview ?? "Unavailable"}",
                      style: TextStyle(
                          color: themeController.isDark.value
                              ? Colors.white
                              : Colors.black),
                    )),

                    SizedBox(
                      height: 20,
                    ),

                    //first-air-date and popularity

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              "Release Date",
                              style: TextStyle(
                                  fontSize: 18,
                                  color: themeController.isDark.value
                                      ? Colors.white
                                      : Colors.black),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              "${singleMovieController.SingleMovieData[0].releaseDate ?? "Unavailable"}",
                              style: TextStyle(
                                  color: themeController.isDark.value
                                      ? Colors.white
                                      : Colors.black),
                            ),
                          ],
                        ),
                        Column(
                          children: <Widget>[
                            Text(
                              "Popularity",
                              style: TextStyle(
                                  fontSize: 18,
                                  color: themeController.isDark.value
                                      ? Colors.white
                                      : Colors.black),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              "${singleMovieController.SingleMovieData[0].popularity ?? "Unavailable"} %",
                              style: TextStyle(
                                  color: themeController.isDark.value
                                      ? Colors.white
                                      : Colors.black),
                            ),
                          ],
                        )
                      ],
                    ),

                    SizedBox(
                      height: 20,
                    ),

                    //orignal languae
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              "Orignal Language ",
                              style: TextStyle(
                                  fontSize: 18,
                                  color: themeController.isDark.value
                                      ? Colors.white
                                      : Colors.black),
                            ),
                            Text(
                              "${singleMovieController.SingleMovieData[0].originalLanguage ?? "Unavailable"}",
                              style: TextStyle(
                                  color: themeController.isDark.value
                                      ? Colors.white
                                      : Colors.black),
                            )
                          ],
                        ),
                        Column(
                          children: <Widget>[
                            Text(
                              "Budget ",
                              style: TextStyle(
                                  fontSize: 18,
                                  color: themeController.isDark.value
                                      ? Colors.white
                                      : Colors.black),
                            ),
                            Text(
                              "${singleMovieController.SingleMovieData[0].budget ?? " empty"} \$",
                              style: TextStyle(
                                  color: themeController.isDark.value
                                      ? Colors.white
                                      : Colors.black),
                            )
                          ],
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 5,
                    ),

                    SizedBox(
                      height: 20,
                    ),

                    Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: Text(
                        "Casts",
                        style: TextStyle(
                            fontSize: 20,
                            color: themeController.isDark.value
                                ? Colors.white
                                : Colors.black),
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                          children: singleMovieController.SingleMovieCasts.map<
                                  Widget>((e) {
                                return Container(
                                  child: Row(
                                    children: <Widget>[
                                      e.profilePath != null
                                          ? Column(
                                              children: [
                                                CircleAvatar(
                                                  maxRadius: 45,
                                                  backgroundImage: NetworkImage(
                                                      "${Consts.IMG}${e.profilePath}"),
                                                ),
                                                Text(
                                                  "${e.name.toString()}",
                                                  style: TextStyle(
                                                      color: themeController
                                                              .isDark.value
                                                          ? Colors.white
                                                          : Colors.black),
                                                )
                                              ],
                                            )
                                          : Column(
                                              children: [
                                                CircleAvatar(
                                                  maxRadius: 45,
                                                  backgroundImage: AssetImage(
                                                      "assets/images/cast_def.jpg"),
                                                ),
                                                Text("${e.name.toString()}"),
                                              ],
                                            ),
                                      SizedBox(
                                        width: 10,
                                      )
                                    ],
                                  ),
                                );
                              }).toList() ??
                              <Widget>[
                                Text(
                                  "Unavailable",
                                  style: TextStyle(
                                      color: themeController.isDark.value
                                          ? Colors.white
                                          : Colors.black),
                                )
                              ]),
                    ),

                    SizedBox(
                      height: 30,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          "Similar Movies",
                          style: TextStyle(
                              fontSize: 20,
                              color: themeController.isDark.value
                                  ? Colors.white
                                  : Colors.black),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 30,
                    ),

                    //similar Movies
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                          children: singleMovieController.SimilarMovies.map<
                                  Widget>((e) {
                                return InkWell(
                                  onTap: () async {
                                    context.pop();
                                    context.pushNamed('details', params: {
                                      'id': "${e.id}",
                                    }, queryParams: {
                                      "isDark": "${widget.isDark.toString()}"
                                    });
                                  },
                                  child: Container(
                                    child: Row(
                                      children: <Widget>[
                                        Movie_card_now(
                                            e: e,
                                            isDark:
                                                themeController.isDark.value),
                                        SizedBox(
                                          width: 10,
                                        )
                                      ],
                                    ),
                                  ),
                                );
                              }).toList() ??
                              <Widget>[
                                Text(
                                  "Similar movies Not Available",
                                  style: TextStyle(
                                      color: themeController.isDark.value
                                          ? Colors.white
                                          : Colors.black),
                                )
                              ]),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      );
    });
  }
}
