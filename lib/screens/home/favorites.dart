import 'package:flutter/material.dart';
import 'package:movieto/utilities/utilities.dart';
import 'package:html_unescape/html_unescape.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:movieto/screens/showDetails.dart';

class Favorites extends StatefulWidget {
  const Favorites({Key? key}) : super(key: key);

  @override
  FavoritesState createState() => FavoritesState();
}

class FavoritesState extends State<Favorites> with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Widget favoriteListCard = Container(
      child: ListView.builder(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        itemCount: favoriteList.length,
        itemBuilder: (context, index) {
          final show = favoriteList[index];
          String year = '2023-12-33';
          String summaryOutput = show['showDetails']['summary'] == null
              ? ''
              : HtmlUnescape().convert(show['showDetails']['summary']
                  .replaceAll(RegExp('<[^>]*>'), ''));
          return GestureDetector(
            onTap: () {
              PersistentNavBarNavigator.pushNewScreen(
                context,
                screen: ShowDetails(
                  showID: show['showDetails']['id'],
                ),
                withNavBar: false,
                pageTransitionAnimation: PageTransitionAnimation.cupertino,
              );
            },
            child: Row(
              children: [
                TvShowCard(
                  showID: show['showDetails']['id'],
                  cardSize: 'normal',
                  imageLink: show['showDetails']['image'] == null
                      ? 'https://static.tvmaze.com/uploads/images/medium_portrait/1/3773.jpg'
                      : show['showDetails']['image']['medium'],
                  showName: show['showDetails']['name'],
                  premiered: show['showDetails']['premiered'],
                  callback: (value) {
                    PersistentNavBarNavigator.pushNewScreen(
                      context,
                      screen: ShowDetails(
                        showID: show['showDetails']['id'],
                      ),
                      withNavBar: false,
                      pageTransitionAnimation:
                          PageTransitionAnimation.cupertino,
                    );
                  },
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        show['showDetails']['name'],
                        style: normalBoldTextWhite(),
                      ),
                      Container(
                        margin: const EdgeInsets.only(bottom: 10),
                        child: Text(
                          '($year)',
                          style: normalBoldTextLightWhite(),
                        ),
                      ),
                      Text(
                        'Summary',
                        style: smallTextLightWhite(),
                      ),
                      Container(
                        child: Text(
                          summaryOutput,
                          style: normalTextWhite(),
                          maxLines: 8,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.left,
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color.fromRGBO(20, 24, 57, 1),
              Color.fromRGBO(25, 27, 65, 1),
              Color.fromRGBO(25, 27, 65, 1),
              Color.fromRGBO(20, 24, 57, 1),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            stops: [0.15, 0.5, 0.6, 1],
          ),
        ),
        child: loadingFav == true
            ? Center(
                child: SizedBox(
                  height: 40,
                  width: 40,
                  child: CircularProgressIndicator(
                    strokeWidth: 3.5,
                    color: pinkColor,
                  ),
                ),
              )
            : favoriteList.isEmpty
                ? Center(
                    child: Column(
                      children: [
                        Container(
                          margin: const EdgeInsets.only(
                            bottom: 20,
                            top: 20,
                          ),
                          child: Image.asset(
                            'images/nodata.png',
                            width: SizeConfig.blockSizeHorizontal! * 70,
                          ),
                        ),
                        Text(
                          'No data found. Enter something in the search bar',
                          style: normalTextWhite(),
                        )
                      ],
                    ),
                  )
                : favoriteListCard,
      ),
    );
  }
}
