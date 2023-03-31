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

  loadImage() {
    try {
      return showDetails['image']['original'];
    } catch (e) {
      return 'https://static.tvmaze.com/uploads/images/original_untouched/81/202627.jpg';
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
      print('seasons =================');
      print(val);
      setState(() {
        seasonsList = val;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget storyLine = Container(
      margin: const EdgeInsets.only(
        left: 20,
        right: 20,
        bottom: 40,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.only(bottom: 15),
            child: Text(
              'Story Line',
              style: header5BoldTextWhite(),
            ),
          ),
          Text(
            convertStory(),
            style: normalTextWhite(),
          ),
        ],
      ),
    );
    Widget casts = Container(
      margin: const EdgeInsets.only(top: 20, left: 20, right: 20),
      child: SizedBox(
        height: SizeConfig.blockSizeVertical! * 8,
        child: castList.isEmpty
            ? Container()
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
                          style: smallTextWhite(),
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
                  var imageLink;
                  var showName;
                  var premiered;
                  var season;
                  try {
                    imageLink = seasonsLst['image']['medium'];
                    showName = seasonsLst['name'];
                    premiered = seasonsLst['airdate'];
                    season = seasonsLst['season'];
                  } catch (e) {
                    imageLink =
                        'https://static.tvmaze.com/uploads/images/original_untouched/81/202627.jpg';
                    showName = 'Show';
                    premiered = '2023-12-34';
                    season = '2';
                  }
                  // print(seasonsLst['image']['medium']);
                  return Container(
                    child: TvShowCard(
                      cardSize: 'normal',
                      imageLink: imageLink,
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
        child: showDetails.isEmpty
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
            : ListView(
                children: [
                  Container(
                    height: SizeConfig.blockSizeVertical! * 50,
                    child: Stack(
                      children: [
                        Container(
                          decoration: const BoxDecoration(
                            color: Colors.white,
                          ),
                          child: FadeInImage.memoryNetwork(
                            placeholder: kTransparentImage,
                            image: loadImage(),
                            fit: BoxFit.cover,
                            width: SizeConfig.blockSizeHorizontal! * 100,
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.all(10.0),
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                purpleColor,
                                Colors.transparent,
                                purpleColor.withOpacity(0.6),
                                purpleColor,
                              ],
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              stops: const [0.01, 0.5, 0.8, 1],
                            ),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Expanded(
                                child: Container(),
                              ),
                              Text(
                                showDetails['name'],
                                style: header6BoldTextWhite(),
                              ),
                            ],
                          ),
                        ),
                        CustomAppBar(
                          title: 'Show Details',
                          textColor: 'white',
                          icon: null,
                          callback: (res) {
                            Navigator.pop(context);
                          },
                        ),
                        Positioned(
                          bottom: 10,
                          right: 20,
                          child: Row(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    liked = !liked;
                                  });
                                },
                                child: Container(
                                  padding: const EdgeInsets.only(right: 10),
                                  child: Image.asset(
                                    liked == false
                                        ? 'images/icons/timer_white.png'
                                        : 'images/icons/timer_pink.png',
                                    width: SizeConfig.blockSizeHorizontal! * 7,
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
                                  padding: const EdgeInsets.only(right: 10),
                                  child: Image.asset(
                                    favorited == false
                                        ? 'images/icons/heart_white.png'
                                        : 'images/icons/heart_pink.png',
                                    width: SizeConfig.blockSizeHorizontal! * 7,
                                  ),
                                ),
                              ),
                            ],
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
      ),
    );
  }
}
