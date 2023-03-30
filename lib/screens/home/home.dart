import 'package:flutter/material.dart';
import 'package:movieto/utilities/utilities.dart';
import 'package:movieto/screens/showDetails.dart';
import 'package:html_unescape/html_unescape.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  HomeState createState() => HomeState();
}

class HomeState extends State<Home> with WidgetsBindingObserver {
  List popularList = [];
  List recommendedList = [];
  List topRatedList = [];

  @override
  void initState() {
    super.initState();
    dioRequest('get', '/shows?page=1', null).then((val) {
      setState(() {
        popularList = val;
      });
    });
    dioRequest('get', '/shows?page=4', null).then((val) {
      setState(() {
        recommendedList = val;
      });
    });
    dioRequest('get', '/shows?page=9', null).then((val) {
      setState(() {
        topRatedList = val;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget popular = Container(
      margin: const EdgeInsets.only(top: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Popular',
                style: header5BoldTextBlack(),
              ),
              Text(
                'View all',
                style: header5BoldTextBlack(),
              ),
            ],
          ),
          SizedBox(
            height: SizeConfig.blockSizeVertical! * 30,
            child: popularList.isEmpty
                ? const Center(
                    child: SizedBox(
                      height: 40,
                      width: 40,
                      child: CircularProgressIndicator(
                        strokeWidth: 3.5,
                        color: Colors.blue,
                      ),
                    ),
                  )
                : ListView.builder(
                    scrollDirection: Axis.horizontal,
                    shrinkWrap: true,
                    itemCount: popularList.length,
                    itemBuilder: (context, index) {
                      final show = popularList[index];
                      return TvShowCard(
                        showID: show['id'],
                        cardSize: 'normal',
                        imageLink: show['image']['medium'],
                        showName: show['name'],
                        premiered: show['premiered'],
                        callback: (value) {
                          PersistentNavBarNavigator.pushNewScreen(
                            context,
                            screen: ShowDetails(
                              showID: value,
                            ),
                            withNavBar: false,
                            pageTransitionAnimation:
                                PageTransitionAnimation.cupertino,
                          );
                        },
                      );
                    },
                  ),
          ),
        ],
      ),
    );
    Widget recommended = Container(
      margin: const EdgeInsets.only(top: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Recommendation',
                style: header5BoldTextBlack(),
              ),
              Text(
                'View all',
                style: header5BoldTextBlack(),
              ),
            ],
          ),
          SizedBox(
            height: SizeConfig.blockSizeVertical! * 27,
            child: recommendedList.isEmpty
                ? const Center(
                    child: SizedBox(
                      height: 40,
                      width: 40,
                      child: CircularProgressIndicator(
                        strokeWidth: 3.5,
                        color: Colors.blue,
                      ),
                    ),
                  )
                : ListView.builder(
                    scrollDirection: Axis.horizontal,
                    shrinkWrap: true,
                    itemCount: popularList.length,
                    itemBuilder: (context, index) {
                      final show = popularList[index];
                      return Column(
                        children: [
                          TvShowCard(
                            cardSize: 'tall',
                            imageLink: show['image']['medium'],
                            showName: show['name'],
                            premiered: show['premiered'],
                            callback: (value) {
                              print(value);
                            },
                          ),
                          Container(
                            width: SizeConfig.blockSizeHorizontal! * 30,
                            child: Text(
                              show['name'],
                              style: normalTextBlack(),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ],
                      );
                    },
                  ),
          ),
        ],
      ),
    );
    Widget topRated = Container(
      margin: const EdgeInsets.only(top: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Top Rated',
                style: header5BoldTextBlack(),
              ),
              Text(
                'View all',
                style: header5BoldTextBlack(),
              ),
            ],
          ),
          topRatedList.isEmpty
              ? const Center(
                  child: SizedBox(
                    height: 40,
                    width: 40,
                    child: CircularProgressIndicator(
                      strokeWidth: 3.5,
                      color: Colors.blue,
                    ),
                  ),
                )
              : ListView.builder(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: popularList.length,
                  itemBuilder: (context, index) {
                    final show = popularList[index];
                    String year = show['premiered'].substring(0, 4) ?? '';
                    String summaryOutput = HtmlUnescape().convert(
                        show['summary'].replaceAll(RegExp('<[^>]*>'), ''));

                    return Row(
                      children: [
                        TvShowCard(
                          cardSize: 'wide',
                          imageLink: show['image']['medium'],
                          showName: show['name'],
                          premiered: show['premiered'],
                          callback: (value) {
                            print(value);
                          },
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                show['name'],
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
                    );
                  },
                ),
        ],
      ),
    );
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: Container(
              padding: const EdgeInsets.only(top: 20),
              margin: const EdgeInsets.only(left: 20, right: 20),
              child: MediaQuery.removePadding(
                context: context,
                removeTop: true,
                child: ListView(
                  shrinkWrap: true,
                  children: [popular, recommended, topRated],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
