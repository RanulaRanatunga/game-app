import 'package:flutter/material.dart';
import '../game_details.dart';
import '../widgets/scroll_view_game_widget.dart';

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomePageState();
  }
}

class _HomePageState extends State<HomePage> {
  var deviceHeight;
  var deviceWidth;
  var selectedGame;

  @override
  void initState() {
    // life cycle function
    super.initState();
    selectedGame = 0;
  }

  @override
  Widget build(BuildContext context) {
    deviceHeight = MediaQuery.of(context).size.height;
    deviceWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Stack(
        children: <Widget>[
          _featuresInGameWidget(),
          gradientBoxWidget(),
          topLayerWidget(),
        ],
      ),
    );
  }

  Widget _featuresInGameWidget() {
    return SizedBox(
        height: deviceHeight * 0.50,
        width: deviceWidth,
        child: PageView(
          onPageChanged: (_index) {
            setState(() {
              selectedGame = _index;
            });
          },
          scrollDirection: Axis.horizontal,
          children: featuredGames.map((_game) {
            return Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage(_game.coverImage.url),
                ),
              ),
            );
          }).toList(),
        ));
  }

  Widget gradientBoxWidget() {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        height: deviceHeight * 0.80,
        width: deviceWidth,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color.fromRGBO(35, 45, 59, 1.0),
              Colors.transparent,
            ],
            stops: [0.65, 1.0],
            begin: Alignment.bottomCenter,
            end: Alignment.topCenter,
          ),
        ),
      ),
    );
  }

  Widget topLayerWidget() {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: deviceWidth * 0.05, vertical: deviceHeight * 0.005),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          topBarWidget(),
          SizedBox(height: deviceHeight * 0.13),
          featuredGamesInfoWidget(),
          Padding(
            padding: EdgeInsets.symmetric(vertical: deviceHeight * 0.01),
            child: ScrollViewGameWidget(
                deviceHeight * 0.24, deviceWidth, true, games),
          ),
          featuredGameBannerWidget(),
          ScrollViewGameWidget(deviceHeight * 0.22, deviceWidth, false, games2),
        ],
      ),
    );
  }

  Widget topBarWidget() {
    return SizedBox(
      height: deviceHeight * 0.13,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Icon(
            Icons.menu,
            color: Colors.white,
            size: 30,
          ),
          Row(
            children: <Widget>[
              Icon(
                Icons.search,
                color: Colors.white,
                size: 30,
              ),
              SizedBox(
                width: deviceWidth * 0.03,
              ),
              Icon(
                Icons.notifications_none,
                color: Colors.white,
                size: 30,
              )
            ],
          )
        ],
      ),
    );
  }

  Widget featuredGamesInfoWidget() {
    return SizedBox(
      height: deviceHeight * 0.12,
      width: deviceWidth,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            featuredGames[selectedGame].title,
            maxLines: 2,
            style:
                TextStyle(color: Colors.white, fontSize: deviceHeight * 0.040),
          ),
          SizedBox(height: deviceHeight * 0.13),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: featuredGames.map((_game) {
              bool isActive = _game.title == featuredGames[selectedGame].title;
              double _circleRadius = deviceHeight * 0.004;
              return Container(
                margin: EdgeInsets.only(right: deviceWidth * 0.015),
                height: _circleRadius * 2,
                width: _circleRadius * 2,
                decoration: BoxDecoration(
                    color: isActive ? Colors.green : Colors.grey,
                    borderRadius: BorderRadius.circular(100)),
              );
            }).toList(),
          )
        ],
      ),
    );
  }

  Widget featuredGameBannerWidget() {
    return Container(
      height: deviceHeight * 0.13,
      width: deviceWidth,
      decoration: BoxDecoration(
        image: DecorationImage(
          fit: BoxFit.cover,
          image: NetworkImage(featuredGames[3].coverImage.url),
        ),
      ),
    );
  }
}
