import 'package:flutter/material.dart';
import 'package:movieto/utilities/utilities.dart';
import 'package:movieto/screens/home/favorites.dart';
import 'package:movieto/screens/home/profile.dart';
import 'package:movieto/screens/home/search.dart';
import 'package:movieto/screens/home/home.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:flutter/cupertino.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  DashboardState createState() => DashboardState();
}

class DashboardState extends State<Dashboard> with WidgetsBindingObserver {
  num activePage = 0;

  // Navigation Screens
  List<Widget> _buildScreens() {
    return [
      Home(),
      Search(),
      Favorites(),
      Profile(),
    ];
  }

  // Navigation Items
  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
      iconBarStyle('Home'),
      iconBarStyle('Search'),
      iconBarStyle('Favorites'),
      iconBarStyle('Profile'),
    ];
  }

  // Icon Bar Style
  iconBarStyle(String page) {
    return PersistentBottomNavBarItem(
      icon: Image.asset(
        page == 'Home'
            ? activePage == 0
                ? 'images/icons/home_white.png'
                : 'images/icons/home_white.png'
            : page == 'Search'
                ? activePage == 1
                    ? 'images/icons/search_white.png'
                    : 'images/icons/search_white.png'
                : page == 'Favorites'
                    ? activePage == 2
                        ? 'images/icons/heart_white.png'
                        : 'images/icons/heart_white.png'
                    : activePage == 3
                        ? 'images/icons/profile_white.png'
                        : 'images/icons/profile_white.png',
        width: SizeConfig.blockSizeHorizontal! * 5,
      ),
      title: page,
      activeColorPrimary: Colors.white,
      inactiveColorPrimary: Colors.white,
      activeColorSecondary: Colors.white,
      textStyle: normalTextBlack(),
    );
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: const Color.fromRGBO(17, 21, 52, 1),
        child: Column(
          children: [
            Expanded(
              child: PersistentTabView(
                context,
                controller: bottomNavigationController,
                screens: _buildScreens(),
                items: _navBarsItems(),
                confineInSafeArea: true,
                backgroundColor: const Color.fromRGBO(37, 44, 87, 1),
                handleAndroidBackButtonPress: true,
                resizeToAvoidBottomInset: true,
                stateManagement: true,
                hideNavigationBarWhenKeyboardShows: true,
                decoration: NavBarDecoration(
                  borderRadius: BorderRadius.circular(0.0),
                  colorBehindNavBar: Colors.white,
                ),
                popAllScreensOnTapOfSelectedTab: true,
                popActionScreens: PopActionScreensType.all,
                itemAnimationProperties: const ItemAnimationProperties(
                  duration: Duration(milliseconds: 200),
                  curve: Curves.ease,
                ),
                screenTransitionAnimation: const ScreenTransitionAnimation(
                  animateTabTransition: true,
                  curve: Curves.ease,
                  duration: Duration(milliseconds: 200),
                ),
                navBarStyle: NavBarStyle.style1,
                onItemSelected: (value) {
                  print(globalUserData);
                  if (value == 2) {
                    setState(() {
                      loadingFav = true;
                    });
                    dioRequest(
                      'post',
                      '/user/fetch/favorites',
                      {'userID': globalUserData['_id']},
                    ).then((val) {
                      setState(() {
                        favoriteList = val['favorites'];
                        loadingFav = false;
                      });
                    });
                  }
                  setState(() {
                    activePage = value;
                  });
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
