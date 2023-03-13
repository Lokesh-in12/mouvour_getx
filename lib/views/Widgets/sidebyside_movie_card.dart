import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:mouvour_getx/views/utils/Consts/consts.dart';

class SideBySideCard extends StatelessWidget {
  dynamic e;
  bool? isDark;
  SideBySideCard({super.key, this.e, this.isDark});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        ClipRRect(
          borderRadius: BorderRadius.circular(6),
          // child: Image(
          //   image: NetworkImage(Const.IMG + "${e.posterPath}"),
          //   height: 180,
          // ),
          child: e.posterPath != null ? Image.network(
                "${Consts.IMG}${e.posterPath}",
                height: 180,
              ): Image.network(
                "${Consts.IMG}${"/6M2IeELPSKZZ4iAPz2w0i7wdm6X.jpg"}",
                height: 180,
              ),
        ),
        const SizedBox(
          width: 20.5,
        ),
        Container(
          width: 302,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              //title
              const SizedBox(
                height: 5,
              ),
              SizedBox(
                child: Text(
                  "${e.title.toString()}",
                  maxLines: 4,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      fontSize: 19,
                      color: isDark! ? Colors.white : Colors.black),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              Text(
                "⭐ ${e.voteAverage.toString()}/10 IMDb",
                style: TextStyle(
                    fontSize: 16,
                    color: isDark! ? Colors.white : Colors.black),
              ),
              //genres - of side movie cards
              SizedBox(
                height: 15,
              ),
              LimitedBox(
                maxWidth: 210,
                child: Row(
                  children: <Widget>[
                    SizedBox(
                      width: 5,
                    ),
                    LimitedBox(
                      maxWidth: 200,
                      child: Text(
                        "${e.overview}",
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color:
                              isDark! ? Colors.white : Colors.black)
                      ),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    SizedBox(
                      width: 5,
                    ),
                  ],
                ),
              ),

              //time of a movie
              SizedBox(
                height: 10,
              ),
              Row(
                children: <Widget>[
                  Icon(
                    Icons.volunteer_activism_rounded,
                    size: 20,
                    color: isDark! ? Colors.white : Colors.black,
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  Text("${e.voteCount.toString()}",
                      style: TextStyle(
                          color:
                              isDark! ? Colors.white : Colors.black))
                ],
              )
            ],
          ),
        )
      ],
    );
  }
}
