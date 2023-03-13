import 'package:flutter/material.dart';
import 'package:mouvour_getx/views/utils/Consts/consts.dart';

class Movie_card_now extends StatelessWidget {
  dynamic e;
  bool? isDark;
  Movie_card_now({this.e, this.isDark});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 140,
      height: 280,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          ClipRRect(
              borderRadius: BorderRadius.circular(6),
              // child: Image(
              //   image: NetworkImage("${Const.IMG}${e.posterPath}"),
              // ))
              child: e.posterPath != null
                  ? Image.network(
                      "${Consts.IMG}${e.posterPath}",
                      height: 180,
                    )
                  : Image.asset(
                      "assets/images/backdrop_def.jpg",
                      height: 180,
                    )),
          SizedBox(
            height: 10,
          ),
          LimitedBox(
            maxWidth: 30,
            child: Text(
              maxLines: 1,
              "${e.title.toString()}",
              style: TextStyle(
                  fontSize: 15, color: isDark! ? Colors.white : Colors.black),
            ),
          ),
          SizedBox(
            height: 8,
          ),
          Text("⭐${e.voteAverage.toString()}/10 IMDb",
              style: TextStyle(color: isDark! ? Colors.white : Colors.black))
        ],
      ),
    );
  }
}
