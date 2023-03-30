import 'package:flutter/material.dart';
import 'package:movieto/utilities/utilities.dart';
import 'package:html_unescape/html_unescape.dart';

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
      print('val');
      print(val);
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
          return Row(
            children: [
              TvShowCard(
                showID: show['show']['id'],
                cardSize: 'normal',
                imageLink: show['show']['image'] == null
                    ? ''
                    : show['show']['image']['medium'],
                showName: show['show']['name'],
                premiered: show['show']['premiered'],
                callback: (value) {},
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      show['show']['name'],
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
    );
    return SafeArea(
      child: Scaffold(
        body: Container(
          margin: const EdgeInsets.only(left: 20, right: 20),
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.only(top: 10),
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
                          fillColor: Colors.white.withOpacity(0.6),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: BorderSide(
                              color: Colors.blue.withOpacity(0.2),
                              width: 2.3,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: const BorderSide(
                              color: Colors.blue,
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
                      decoration: const BoxDecoration(
                        color: Colors.green,
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
                            child: Text('sdfasdf'),
                          )
                        : displaySearchList
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
