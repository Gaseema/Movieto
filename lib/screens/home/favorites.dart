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
        physics: const NeverScrollableScrollPhysics(),
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
                        style: normalBoldTextBlack(),
                      ),
                      Container(
                        margin: const EdgeInsets.only(bottom: 10),
                        child: Text(
                          '($year)',
                          style: normalBoldTextLightBlack(),
                        ),
                      ),
                      Text(
                        'Summary',
                        style: smallTextLightBlack(),
                      ),
                      Container(
                        child: Text(
                          summaryOutput,
                          style: normalTextBlack(),
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
        child: favoriteList.isEmpty
            ? Center(
                child: Text('No data'),
              )
            : favoriteListCard,
      ),
    );
  }
}
