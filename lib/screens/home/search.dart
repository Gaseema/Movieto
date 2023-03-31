import 'package:flutter/material.dart';
import 'package:movieto/utilities/utilities.dart';
import 'package:html_unescape/html_unescape.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:movieto/screens/showDetails.dart';
import 'package:flutter/services.dart';

class Search extends StatefulWidget {
  const Search({Key? key}) : super(key: key);

  @override
  SearchState createState() => SearchState();
}

class SearchState extends State<Search> with WidgetsBindingObserver {
  TextEditingController searchInput = TextEditingController();
  String searchVal = '';
  List searchList = [];

  updateSearchResults() {
    dioRequest('get', '/search/shows?q=$searchVal', null).then((val) {
      setState(() {
        searchList = val;
      });
    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarColor: Colors.red));
    Widget displaySearchList = Container(
      child: ListView.builder(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        itemCount: searchList.length,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          final show = searchList[index];
          print(show['show']['image']);
          String year = '2023-12-33';
          String summaryOutput = show['show']['summary'] == null
              ? ''
              : HtmlUnescape().convert(
                  show['show']['summary'].replaceAll(RegExp('<[^>]*>'), ''));
          return GestureDetector(
            onTap: () {
              PersistentNavBarNavigator.pushNewScreen(
                context,
                screen: ShowDetails(
                  showID: show['show']['id'],
                ),
                withNavBar: false,
                pageTransitionAnimation: PageTransitionAnimation.cupertino,
              );
            },
            child: Container(
              child: Row(
                children: [
                  TvShowCard(
                    showID: show['show']['id'],
                    cardSize: 'normal',
                    imageLink: show['show']['image'] == null
                        ? 'https://static.tvmaze.com/uploads/images/medium_portrait/1/3773.jpg'
                        : show['show']['image']['medium'],
                    showName: show['show']['name'],
                    premiered: show['show']['premiered'],
                    callback: (value) {
                      PersistentNavBarNavigator.pushNewScreen(
                        context,
                        screen: ShowDetails(
                          showID: show['show']['id'],
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
                          show['show']['name'],
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
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(
                top: SizeConfig.blockSizeVertical! * 10,
                left: 20,
                right: 20,
              ),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        contentPadding:
                            const EdgeInsets.fromLTRB(20, 10, 10, 10),
                        hintText: 'Search...',
                        hintStyle: normalTextBlack(),
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide(
                            color: pinkColor.withOpacity(0.2),
                            width: 2.3,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide(
                            color: pinkColor,
                            width: 2.3,
                          ),
                        ),
                      ),
                      onChanged: ((value) {
                        setState(() {
                          searchVal = value;
                        });
                        updateSearchResults();
                      }),
                      controller: searchInput,
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(10),
                    margin: const EdgeInsets.only(left: 20),
                    decoration: BoxDecoration(
                      color: pinkColor,
                      shape: BoxShape.circle,
                    ),
                    child: Image.asset(
                      'images/icons/sort.png',
                      width: SizeConfig.blockSizeHorizontal! * 5,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView(
                children: [
                  searchList.isEmpty
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
                      : displaySearchList
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
