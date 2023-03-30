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
  @override
  void initState() {
    super.initState();
    dioRequest('get', '/shows/${widget.showID}', null).then((val) {
      setState(() {
        showDetails = val;
      });
    });
    dioRequest('get', '/shows/${widget.showID}/cast', null).then((val) {
      setState(() {
        castList = val;
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
            showDetails.isEmpty
                ? ''
                : HtmlUnescape().convert(
                    showDetails['summary'].replaceAll(RegExp('<[^>]*>'), ''),
                  ),
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
                              Text(
                                showDetails['name'],
                                style: header6BoldTextWhite(),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                casts,
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
