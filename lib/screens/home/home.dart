import 'package:flutter/material.dart';
import 'package:movieto/utilities/utilities.dart';

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
    dioRequest('get', '/shows', null).then((val) {
      setState(() {
        popularList = val;
      });
    });
    dioRequest('get', '/shows', null).then((val) {
      setState(() {
        recommendedList = val;
      });
    });
    dioRequest('get', '/shows', null).then((val) {
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
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              shrinkWrap: true,
              itemCount: popularList.length,
              itemBuilder: (context, index) {
                final show = popularList[index];
                return TvShowCard(
                  cardSize: 'normal',
                  imageLink: show['image']['medium'],
                  showName: show['name'],
                  premiered: show['premiered'],
                  callback: (value) {
                    print(value);
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
            height: SizeConfig.blockSizeVertical! * 20,
            child: ListView.builder(
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
                    Text(show['name']),
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
          SizedBox(
            height: SizeConfig.blockSizeVertical! * 15,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              shrinkWrap: true,
              itemCount: popularList.length,
              itemBuilder: (context, index) {
                final show = popularList[index];
                return TvShowCard(
                  cardSize: 'wide',
                  imageLink: show['image']['medium'],
                  showName: show['name'],
                  premiered: show['premiered'],
                  callback: (value) {
                    print(value);
                  },
                );
              },
            ),
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
