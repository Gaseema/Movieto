import 'dart:math';

import 'package:flutter/material.dart';
import 'package:movieto/utilities/utilities.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:html_unescape/html_unescape.dart';

class ShowDetails extends StatefulWidget {
  final int? showID;
  const ShowDetails({Key? key, this.showID}) : super(key: key);

  @override
  ShowDetailsState createState() => ShowDetailsState();
}

class ShowDetailsState extends State<ShowDetails> with WidgetsBindingObserver {
  Map showDetails = {};
  List castList = [];
  List seasonsList = [];

  bool liked = false;
  bool favorited = false;

  convertStory() {
    try {
      return HtmlUnescape().convert(
        showDetails['summary'].replaceAll(RegExp('<[^>]*>'), ''),
      );
    } catch (e) {
      return HtmlUnescape().convert(
        ''.replaceAll(RegExp('<[^>]*>'), ''),
      );
    }
  }

  updateFavorited() {
    dioRequest('post', '/user/show/favorite', {
      'userID': globalUserData['_id'],
      'favorited': favorited,
      'show': widget.showID,
      'showDetails': showDetails
    }).then((val) {
      print(val);
    });
  }

  @override
  void initState() {
    super.initState();
    // Fetch show details
    dioRequest('get', '/shows/${widget.showID}', null).then((val) {
      setState(() {
        showDetails = val;
      });
    });

    // Fetch show cast list
    dioRequest('get', '/shows/${widget.showID}/cast', null).then((val) {
      setState(() {
        castList = val;
      });
    });

    // Show seasons for the show
    dioRequest('get', '/shows/${widget.showID}/episodes', null).then((val) {
      setState(() {
        seasonsList = val;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget storyLine = Container(
      margin: const EdgeInsets.only(left: 20, right: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.only(bottom: 15),
            child: Text(
              'Story Line',
              style: header5BoldTextBlack(),
            ),
          ),
          Text(
            convertStory(),
          ),
        ],
      ),
    );
    Widget casts = Container(
      margin: const EdgeInsets.only(top: 20, left: 20, right: 20),
      child: SizedBox(
        height: SizeConfig.blockSizeVertical! * 8,
        child: castList.isEmpty
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
                itemCount: castList.length,
                itemBuilder: (context, index) {
                  final cast = castList[index];
                  String castName = cast['person']['name'];
                  List<String> nameParts = castName.split(" ");
                  String castFirstName = nameParts[0];
                  return Column(
                    children: [
                      Container(
                        height: SizeConfig.blockSizeHorizontal! * 12,
                        width: SizeConfig.blockSizeHorizontal! * 12,
                        margin: const EdgeInsets.only(right: 10),
                        child: ClipOval(
                          child: FadeInImage.memoryNetwork(
                            placeholder: kTransparentImage,
                            image: cast['person']['image']['medium'],
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Container(
                        child: Text(
                          castFirstName,
                          style: smallTextBlack(),
                        ),
                      ),
                    ],
                  );
                },
              ),
      ),
    );
    Widget seasons = Container(
      margin: const EdgeInsets.only(top: 20, left: 20, right: 20),
      child: SizedBox(
        height: SizeConfig.blockSizeVertical! * 20,
        child: seasonsList.isEmpty
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
                itemCount: seasonsList.length,
                itemBuilder: (context, index) {
                  final seasonsLst = seasonsList[index];
                  return Container(
                    child: TvShowCard(
                      cardSize: 'normal',
                      imageLink: seasonsLst['image']['medium'],
                      showName: seasonsLst['name'],
                      premiered: seasonsLst['airdate'],
                      season: seasonsLst['season'],
                      callback: (value) {
                        print(value);
                      },
                    ),
                  );
                },
              ),
      ),
    );
    return Scaffold(
      body: showDetails.isEmpty
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
          : ListView(
              children: [
                Container(
                  height: SizeConfig.blockSizeVertical! * 50,
                  child: Stack(
                    children: [
                      Positioned.fill(
                        child: Container(
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.blueGrey,
                                blurRadius: 5,
                                offset: Offset(0, 4),
                              ),
                            ],
                          ),
                          child: FadeInImage.memoryNetwork(
                            placeholder: kTransparentImage,
                            image: showDetails['image']['original'],
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Positioned.fill(
                        child: Container(
                          padding: const EdgeInsets.all(10.0),
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                Colors.black.withOpacity(0.5),
                                Colors.transparent,
                                Colors.transparent,
                                Colors.black.withOpacity(0.5),
                              ],
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              stops: const [0.15, 0.5, 0.6, 1],
                            ),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Expanded(
                                child: Container(),
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    showDetails['name'],
                                    style: header6BoldTextWhite(),
                                  ),
                                  Row(
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            liked = !liked;
                                          });
                                        },
                                        child: Container(
                                          padding:
                                              const EdgeInsets.only(right: 10),
                                          child: Image.asset(
                                            liked == false
                                                ? 'images/icons/timer_white.png'
                                                : 'images/icons/timer_red.png',
                                            width: SizeConfig
                                                    .blockSizeHorizontal! *
                                                7,
                                          ),
                                        ),
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            favorited = !favorited;
                                          });
                                          updateFavorited();
                                        },
                                        child: Container(
                                          padding:
                                              const EdgeInsets.only(right: 10),
                                          child: Image.asset(
                                            favorited == false
                                                ? 'images/icons/heart_white.png'
                                                : 'images/icons/heart_red.png',
                                            width: SizeConfig
                                                    .blockSizeHorizontal! *
                                                7,
                                          ),
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                casts,
                seasons,
                Container(
                  margin: const EdgeInsets.only(
                    top: 20,
                  ),
                  child: storyLine,
                ),
              ],
            ),
    );
  }
}
