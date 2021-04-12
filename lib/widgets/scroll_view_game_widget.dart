import 'package:flutter/material.dart';
import 'package:game_app/game_details.dart';

class ScrollViewGameWidget extends StatelessWidget {
  final double height;
  final double width;
  final bool showTitle;

  final List<Game> gamesData;

  ScrollViewGameWidget(this.height, this.width, this.showTitle, this.gamesData);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width,
      child: ListView(
        physics: BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        children: gamesData.map((_game) {
          return Container(
            height: height,
            width: width * 0.30,
            padding: EdgeInsets.only(right: width * 0.03),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  height: height * 0.80,
                  width: width * 0.45,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage(_game.coverImage.url),
                    ),
                  ),
                ),
                showTitle
                    ? Text(
                        _game.title,
                        maxLines: 2,
                        style: TextStyle(
                            color: Colors.white, fontSize: height * 0.08),
                      )
                    : Container()
              ],
            ),
          );
        }).toList(),
      ),
    );
  }
}
