import 'package:flutter/material.dart';
import 'package:movieto/utilities/utilities.dart';
import 'package:html_unescape/html_unescape.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:movieto/screens/showDetails.dart';
import 'package:intl/intl.dart';

class Search extends StatefulWidget {
  const Search({Key? key}) : super(key: key);

  @override
  SearchState createState() => SearchState();
}

class SearchState extends State<Search> with WidgetsBindingObserver {
  TextEditingController searchInput = TextEditingController();
  String searchVal = '';
  List searchList = [];
  int active = 1;
  String? startDate;

  pickDate() async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1800),
      lastDate: DateTime(2101),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: purpleColor,
              onPrimary: Colors.white,
              onSurface: purpleColor,
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                foregroundColor: pinkColor,
              ),
            ),
          ),
          child: child!,
        );
      },
    );

    if (pickedDate != null) {
      String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);
      return formattedDate;
    } else {
      print("Date is not selected");
    }
  }

  updateSearchResults() {
    dioRequest(
            'get',
            active == 1
                ? '/search/shows?q=$searchVal'
                : '/schedule?date=$startDate',
            null)
        .then((val) {
      setState(() {
        searchList = val;
      });
    });
  }

  updateActive(int currentActive) {
    setState(() {
      active = currentActive;
      if (currentActive == 1) {
        searchInput.text == '';
      }
    });
  }

  void _showDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (
            BuildContext context,
            StateSetter setState,
          ) {
            return AlertDialog(
              title: Text(
                "Search settings",
                style: normalBoldTextBlack(),
              ),
              content: Wrap(
                children: [
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        active = 1;
                      });
                      updateActive(1);
                    },
                    child: Container(
                      margin: const EdgeInsets.only(bottom: 20),
                      width: SizeConfig.blockSizeHorizontal! * 70,
                      padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: active == 1
                              ? pinkColor.withOpacity(0.5)
                              : Colors.blueAccent.withOpacity(0.2),
                          width: 2,
                        ),
                        borderRadius: BorderRadius.circular(7),
                      ),
                      child: Text(
                        'Name of the show',
                        style: normalBoldTextBlack(),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        active = 2;
                      });
                      pickDate().then((date) {
                        setState(() {
                          startDate = date;
                          searchInput.text = date;
                        });
                      });
                      updateSearchResults();
                    },
                    child: Container(
                      width: SizeConfig.blockSizeHorizontal! * 70,
                      padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: active == 2
                              ? pinkColor.withOpacity(0.5)
                              : Colors.blueAccent.withOpacity(0.2),
                          width: 2,
                        ),
                        borderRadius: BorderRadius.circular(7),
                      ),
                      child: Text(
                        'Date of premiere',
                        style: normalBoldTextBlack(),
                      ),
                    ),
                  ),
                ],
              ),
              actions: [
                MaterialButton(
                  child: Text("OK"),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          },
        );
      },
    );
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
          String year = show['show']['premiered'] ?? '2023-12-33';
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
            Text(
              'active: $active',
              style: normalBoldTextWhite(),
            ),
            Container(
              margin: EdgeInsets.only(
                top: SizeConfig.blockSizeVertical! * 10,
                left: 20,
                right: 20,
              ),
              child: Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        if (active != 1) {
                          pickDate().then((date) {
                            setState(() {
                              startDate = date;
                              searchInput.text = date;
                            });
                          });
                          updateSearchResults();
                        }
                      },
                      child: TextField(
                        decoration: InputDecoration(
                          enabled: active == 1 ? true : false,
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
                  ),
                  GestureDetector(
                    onTap: () {
                      _showDialog(context);
                    },
                    child: Container(
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
