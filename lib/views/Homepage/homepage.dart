import 'dart:math';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:mouvour_getx/controllers/movies_controller/movie_controller.dart';
import 'package:mouvour_getx/controllers/theme/theme_controller.dart';
import 'package:mouvour_getx/views/Widgets/movie_card_now.dart';
import 'package:mouvour_getx/views/Widgets/sidebyside_movie_card.dart';
import 'package:mouvour_getx/views/utils/Consts/consts.dart';

class HomePage extends StatelessWidget {
  MoviesController moviesController = Get.put(MoviesController());
  ThemeController themeController = Get.put(ThemeController());

  @override
  Widget build(BuildContext context) {
    print(themeController.isDark.value);
    return Obx(() {
      if (moviesController.isLoading.value) {
        return Scaffold(
          backgroundColor: Colors.white,
          body: Center(child: CircularProgressIndicator()),
        );
      } else {
        return Scaffold(
          backgroundColor: themeController.isDark.value
              ? Color.fromARGB(115, 54, 54, 54)
              : Colors.white,
          appBar: AppBar(
            backgroundColor: themeController.isDark.value
                ? Color.fromARGB(115, 2, 2, 2)
                : Colors.lightBlue,
            title: Text("Mouvour"),
          ),
          drawer: Drawer(
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Row(
                      children: <Widget>[
                        GestureDetector(
                          onTap: () => themeController.isDark.toggle(),
                          child: Row(
                            children: <Widget>[
                              Icon(themeController.isDark.value
                                  ? Icons.sunny
                                  : Icons.dark_mode),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                  "Switch to ${themeController.isDark.value ? "light" : "dark"} mode")
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ]),
              ),
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
            child: Container(
              width: double.infinity,
              // color: Colors.grey[400],
              child: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    const SizedBox(
                      height: 5,
                    ),
                    Container(
                        child: CarouselSlider(
                      items: moviesController.Now_playing_movies.sublist(5, 9)
                          .map((e) {
                        return InkWell(
                          onTap: () => GoRouter.of(context)
                              .pushNamed('details', params: {
                            'id': '${e.id}',
                          }),
                          child: Stack(children: <Widget>[
                            Container(
                                width: double.infinity,
                                height: 210,
                                child: FittedBox(
                                  fit: BoxFit.cover,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: Image(
                                      image: NetworkImage(
                                          "${Consts.IMG}${e.backdropPath}"),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                )),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Align(
                                alignment: Alignment.bottomLeft,
                                child: Text("${e.title.toString()}",
                                    style: TextStyle(
                                        fontSize: 20, color: Colors.white)),
                              ),
                            )
                          ]),
                        );
                      }).toList(),
                      options: CarouselOptions(
                          pageViewKey: PageStorageKey(3),
                          viewportFraction: 1,
                          scrollPhysics: BouncingScrollPhysics(),
                          // autoPlay: true,
                          // enableInfiniteScroll: true,
                          autoPlayInterval: Duration(seconds: 5)),
                    )),

                    SizedBox(
                      height: 30,
                    ),
                    //now showing
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          "Now showing",
                          style: TextStyle(
                              fontSize: 20,
                              color: themeController.isDark.value
                                  ? Colors.white
                                  : Colors.black),
                        ),
                        Text("See more",
                            style: TextStyle(
                                color: themeController.isDark.value
                                    ? Colors.white
                                    : Colors.black))
                      ],
                    ),

                    //movie_cards
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      // color: Colors.red,
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children:
                              moviesController.Now_playing_movies.map((e) {
                                    return InkWell(
                                        onTap: () async {
                                          context.pushNamed('details', params: {
                                            'id': "${e.id}",
                                          });
                                        },
                                        child: Container(
                                            child: Row(
                                          children: <Widget>[
                                            // movie_card_now(e),
                                            Movie_card_now(
                                              e: e,
                                              isDark:
                                                  themeController.isDark.value,
                                            ),
                                            SizedBox(
                                              width: 10,
                                            ),
                                          ],
                                        )));
                                  })
                                      // .take(2)
                                      .toList() ??
                                  <Widget>[Text("no data")],
                        ),
                      ),
                    ),
                    //now showing movie cards ends here

                    //popular title
                    //scroll_perfect_layout
                    Container(
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(
                                "Popular",
                                style: TextStyle(
                                    fontSize: 20,
                                    color: themeController.isDark.value
                                        ? Colors.white
                                        : Colors.black),
                              ),
                              Text("See more",
                                  style: TextStyle(
                                      color: themeController.isDark.value
                                          ? Colors.white
                                          : Colors.black))
                            ],
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            physics: BouncingScrollPhysics(),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children:
                                  moviesController.Popular_movies.sublist(10)
                                          .map((e) {
                                        return Row(
                                          children: [
                                            InkWell(
                                                onTap: () async {
                                                  context.pushNamed(
                                                    'details',
                                                    params: {
                                                      'id': "${e.id}",
                                                    },
                                                  );
                                                },
                                                child: SideBySideCard(
                                                  e: e,
                                                  isDark: themeController
                                                      .isDark.value,
                                                )),
                                            SizedBox(
                                              width: 20,
                                            ),
                                          ],
                                        );
                                      }).toList() ??
                                      <Widget>[Text("no data")],
                            ),
                          )
                        ],
                      ),
                    ),

                    // title for top-rated
                    SizedBox(
                      height: 25,
                    ),
                    Container(
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(
                                "Top Rated",
                                style: TextStyle(
                                    fontSize: 20,
                                    color: themeController.isDark.value
                                        ? Colors.white
                                        : Colors.black),
                              ),
                              Text("See more",
                                  style: TextStyle(
                                      color: themeController.isDark.value
                                          ? Colors.white
                                          : Colors.black))
                            ],
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            physics: PageScrollPhysics(),
                            child: Row(
                              children:
                                  moviesController.Top_rated_movies.map((e) {
                                        return InkWell(
                                            onTap: () async {
                                              context.pushNamed(
                                                'details',
                                                params: {
                                                  'id': "${e.id}",
                                                },
                                              );
                                            },
                                            child: SideBySideCard(
                                              e: e,
                                              isDark:
                                                  themeController.isDark.value,
                                            ));
                                      }).toList() ??
                                      <Widget>[Text("no data")],
                            ),
                          )
                        ],
                      ),
                    ),
                    //trending now
                    // title for top-rated
                    SizedBox(
                      height: 25,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          "Trending Now",
                          style: TextStyle(
                              fontSize: 20,
                              color: themeController.isDark.value
                                  ? Colors.white
                                  : Colors.black),
                        ),
                        Text("See more",
                            style: TextStyle(
                                color: themeController.isDark.value
                                    ? Colors.white
                                    : Colors.black))
                      ],
                    ),
                    SizedBox(
                      height: 5,
                    ),

                    Container(
                      child: CarouselSlider(
                          carouselController: CarouselController(),
                          items: moviesController.Trending_movies.map((e) {
                                return InkWell(
                                  onTap: () async {
                                    context.pushNamed('details', params: {
                                      'id': "${e.id}",
                                    }, queryParams: {
                                      "isDark": "${"false"}"
                                    });
                                  },
                                  child: Container(
                                    // child: Image(
                                    //   image: NetworkImage(
                                    //       Const.IMG + "${e.posterPath}"),
                                    //   height: 180,
                                    // ),
                                    child: Image.network(
                                        "${Consts.IMG}${e.posterPath}"),
                                  ),
                                );
                              }).toList() ??
                              <Widget>[Text("no data")],
                          options: CarouselOptions(
                              autoPlay: true,
                              enlargeCenterPage: true,
                              aspectRatio: sqrt1_2)),
                    )
                  ],
                ),
              ),
            ),
          ),
          //body ends here
        );
      }
    });
  }

  Container movie_card_now(e) {
    return Container(
      width: 140,
      height: 280,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          ClipRRect(
              borderRadius: BorderRadius.circular(6),
              child: Image(
                image: NetworkImage("${Consts.IMG}${e.posterPath}"),
              )),
          SizedBox(
            height: 10,
          ),
          Text(
            e.title.toString(),
            style: TextStyle(
              color: Colors.white,
              fontSize: 15,
            ),
          ),
          SizedBox(
            height: 8,
          ),
          Text(
            "⭐ 0/10 IMDb",
            style: TextStyle(color: Colors.white),
          )
        ],
      ),
    );
  }
}
