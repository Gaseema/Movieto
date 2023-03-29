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
                : 'images/icons/home_black.png'
            : page == 'Search'
                ? activePage == 1
                    ? 'images/icons/search_white.png'
                    : 'images/icons/search_black.png'
                : page == 'Favorites'
                    ? activePage == 2
                        ? 'images/icons/heart_white.png'
                        : 'images/icons/heart_black.png'
                    : activePage == 3
                        ? 'images/icons/profile_white.png'
                        : 'images/icons/profile_black.png',
        width: SizeConfig.blockSizeHorizontal! * 5,
      ),
      title: page,
      activeColorPrimary: Colors.red,
      inactiveColorPrimary: CupertinoColors.systemGrey,
      activeColorSecondary: Colors.blue,
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
      body: PersistentTabView(
        context,
        controller: bottomNavigationController,
        screens: _buildScreens(),
        items: _navBarsItems(),
        confineInSafeArea: true,
        backgroundColor: Colors.white,
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
          setState(() {
            activePage = value;
          });
        },
      ),
    );
  }
}
