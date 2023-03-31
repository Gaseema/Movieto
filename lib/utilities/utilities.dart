import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:dio/dio.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:transparent_image/transparent_image.dart';

// IP address
String ipAddress = 'https://api.tvmaze.com';
String ipAddressDB = 'http://192.168.27.245:8040';
List favoriteList = [];
bool loadingFav = false;

// Vertical & horizontal percentage size
class SizeConfig {
  static MediaQueryData? _mediaQueryData;
  static double? screenWidth;
  static double? screenHeight;
  static double? blockSizeHorizontal;
  static double? blockSizeVertical;

  void init(BuildContext context) {
    _mediaQueryData = MediaQuery.of(context);
    screenWidth = _mediaQueryData?.size.width ?? 0;
    screenHeight = _mediaQueryData?.size.height ?? 0;
    blockSizeHorizontal = screenWidth! / 100;
    blockSizeVertical = screenHeight! / 100;
  }
}

// Tab controller
PersistentTabController bottomNavigationController =
    PersistentTabController(initialIndex: 0);

Map globalUserData = {};

// Main colors
Color pinkColor = const Color.fromRGBO(254, 1, 120, 1);
Color purpleColor = const Color.fromRGBO(17, 21, 52, 1);

////////////////////////////////////////////////////////////////
/// TEXT STYLES
////////////////////////////////////////////////////////////////

TextStyle smallTextLightBlack() {
  return GoogleFonts.lato(
    fontSize: SizeConfig.blockSizeHorizontal! * 2.7,
    letterSpacing: .8,
    color: Colors.black.withOpacity(0.4),
  );
}

TextStyle smallTextLightWhite() {
  return GoogleFonts.lato(
    fontSize: SizeConfig.blockSizeHorizontal! * 2.7,
    letterSpacing: .8,
    color: Colors.white.withOpacity(0.8),
  );
}

TextStyle smallTextWhite() {
  return GoogleFonts.lato(
    fontSize: SizeConfig.blockSizeHorizontal! * 2.7,
    letterSpacing: .8,
    color: Colors.white,
  );
}

TextStyle normalTextWhite() {
  return GoogleFonts.lato(
    fontSize: SizeConfig.blockSizeHorizontal! * 3.5,
    letterSpacing: .8,
    color: Colors.white,
  );
}

TextStyle normalBoldTextWhite() {
  return GoogleFonts.lato(
    fontSize: SizeConfig.blockSizeHorizontal! * 3.5,
    letterSpacing: .8,
    fontWeight: FontWeight.w600,
    color: Colors.white,
  );
}

TextStyle normalTextBlack() {
  return GoogleFonts.lato(
    fontSize: SizeConfig.blockSizeHorizontal! * 3.5,
    letterSpacing: .8,
    color: Colors.black,
  );
}

TextStyle normalTextGreen() {
  return GoogleFonts.lato(
    fontSize: SizeConfig.blockSizeHorizontal! * 3.5,
    letterSpacing: .8,
    color: Colors.green,
  );
}

TextStyle normalBoldTextGreen() {
  return GoogleFonts.lato(
    fontSize: SizeConfig.blockSizeHorizontal! * 3.5,
    letterSpacing: .8,
    color: Colors.green,
    fontWeight: FontWeight.bold,
  );
}

TextStyle normalTextRed() {
  return GoogleFonts.lato(
    fontSize: SizeConfig.blockSizeHorizontal! * 3.5,
    letterSpacing: .8,
    color: Colors.red,
  );
}

TextStyle normalTextLightBlack() {
  return GoogleFonts.lato(
    fontSize: SizeConfig.blockSizeHorizontal! * 3.5,
    letterSpacing: .8,
    color: Colors.black.withOpacity(0.5),
  );
}

TextStyle normalTextLightWhite() {
  return GoogleFonts.lato(
    fontSize: SizeConfig.blockSizeHorizontal! * 3.5,
    letterSpacing: .8,
    color: Colors.white.withOpacity(0.7),
  );
}

TextStyle smallTextBlack() {
  return GoogleFonts.lato(
    fontSize: SizeConfig.blockSizeHorizontal! * 3,
    letterSpacing: .8,
    color: Colors.black,
  );
}

TextStyle smallBoldTextBlack() {
  return GoogleFonts.lato(
    fontSize: SizeConfig.blockSizeHorizontal! * 3,
    letterSpacing: .8,
    color: Colors.black,
    fontWeight: FontWeight.w600,
  );
}

TextStyle normalBoldTextBlack() {
  return GoogleFonts.lato(
    fontSize: SizeConfig.blockSizeHorizontal! * 3.5,
    letterSpacing: .8,
    fontWeight: FontWeight.w600,
    color: Colors.black,
  );
}

TextStyle normalBoldTextLightBlack() {
  return GoogleFonts.lato(
    fontSize: SizeConfig.blockSizeHorizontal! * 3.5,
    letterSpacing: .8,
    fontWeight: FontWeight.w600,
    color: Colors.black.withOpacity(0.4),
  );
}

TextStyle normalBoldTextLightWhite() {
  return GoogleFonts.lato(
    fontSize: SizeConfig.blockSizeHorizontal! * 3.5,
    letterSpacing: .8,
    fontWeight: FontWeight.w600,
    color: Colors.white.withOpacity(0.4),
  );
}

TextStyle headerBoldTextBlack() {
  return GoogleFonts.lato(
    fontSize: SizeConfig.blockSizeHorizontal! * 5,
    letterSpacing: .8,
    fontWeight: FontWeight.w600,
    color: Colors.black,
  );
}

TextStyle header1BoldTextBlack() {
  return GoogleFonts.lato(
    fontSize: SizeConfig.blockSizeHorizontal! * 5,
    letterSpacing: .8,
    fontWeight: FontWeight.w600,
    color: Colors.black,
  );
}

TextStyle header2BoldTextBlack() {
  return GoogleFonts.lato(
    fontSize: SizeConfig.blockSizeHorizontal! * 5,
    letterSpacing: .8,
    fontWeight: FontWeight.w600,
    color: Colors.black,
  );
}

TextStyle header2BoldTextWhite() {
  return GoogleFonts.lato(
    fontSize: SizeConfig.blockSizeHorizontal! * 5,
    letterSpacing: .8,
    fontWeight: FontWeight.w600,
    color: Colors.white,
  );
}

TextStyle header5BoldTextBlack() {
  return GoogleFonts.lato(
    fontSize: SizeConfig.blockSizeHorizontal! * 4,
    letterSpacing: .8,
    fontWeight: FontWeight.w600,
    color: Colors.black,
  );
}

TextStyle header5BoldTextWhite() {
  return GoogleFonts.lato(
    fontSize: SizeConfig.blockSizeHorizontal! * 4,
    letterSpacing: .8,
    fontWeight: FontWeight.w600,
    color: Colors.white,
  );
}

TextStyle header4BoldTextBlack() {
  return GoogleFonts.lato(
    fontSize: SizeConfig.blockSizeHorizontal! * 6,
    letterSpacing: .8,
    fontWeight: FontWeight.w600,
    color: Colors.black,
  );
}

TextStyle header6BoldTextBlack() {
  return GoogleFonts.lato(
    fontSize: SizeConfig.blockSizeHorizontal! * 5,
    letterSpacing: .8,
    fontWeight: FontWeight.w600,
    color: Colors.black,
  );
}

TextStyle header6BoldTextWhite() {
  return GoogleFonts.lato(
    fontSize: SizeConfig.blockSizeHorizontal! * 5,
    letterSpacing: .8,
    fontWeight: FontWeight.w600,
    color: Colors.white,
  );
}

////////////////////////////////////////////////////////////////
/// WIDGETS
////////////////////////////////////////////////////////////////
alertExitModal(context) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Exit GenAfrica'),
        content: SingleChildScrollView(
          child: ListBody(
            children: const <Widget>[
              Text('Are you sure you want to exit the application?'),
            ],
          ),
        ),
        actions: <Widget>[
          TextButton(
            child: Text(
              'YES',
              style: normalBoldTextBlack(),
            ),
            onPressed: () {
              SystemNavigator.pop();
            },
          ),
          TextButton(
            child: Text(
              'NO',
              style: normalBoldTextBlack(),
            ),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}

class AnimatedButton extends StatefulWidget {
  final String? text;
  final String? link;
  final Object? obj;
  final dynamic req;
  final bool? disabled;
  final String? error;
  final ValueSetter<dynamic>? callback;
  final String? buttonColor;
  const AnimatedButton({
    super.key,
    this.text,
    this.link,
    this.obj,
    this.req,
    this.disabled,
    this.error,
    this.callback,
    this.buttonColor,
  });

  @override
  State<AnimatedButton> createState() => _AnimatedButtonState();
}

class _AnimatedButtonState extends State<AnimatedButton>
    with TickerProviderStateMixin {
  bool loading = false;
  double width = SizeConfig.blockSizeHorizontal! * 100;
  double height = SizeConfig.blockSizeHorizontal! * 12;
  BorderRadiusGeometry borderRadius = BorderRadius.circular(8);

  final spinkit = SpinKitRotatingCircle(
    color: Colors.white,
    size: SizeConfig.blockSizeHorizontal! * 9,
  );

  @override
  void dispose() {
    super.dispose();
    spinkit;
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: GestureDetector(
        onTap: () async {
          if (widget.disabled == true) {
            widget.callback!({"isSuccessful": false, "error": "form"});
            return showToast(
              context,
              'Error!!!',
              '${widget.error}',
              Colors.red,
            );
          }
          if (widget.link == null) {
            return widget.callback!({
              'isSuccessful': true,
            });
          }
          setState(() {
            loading = true;
            width = SizeConfig.blockSizeHorizontal! * 12;
            borderRadius = BorderRadius.circular(50);
          });
          dioRequest(widget.req, widget.link, widget.obj).then((val) {
            setState(() {
              loading = false;
              width = SizeConfig.blockSizeHorizontal! * 100;
              borderRadius = BorderRadius.circular(8);
            });
            widget.callback!(val);
          });
        },
        child: AnimatedContainer(
          width: width,
          height: height,
          decoration: BoxDecoration(
            color: widget.disabled == null || widget.disabled == false
                ? widget.buttonColor == 'white'
                    ? Colors.white
                    : pinkColor
                : Colors.grey,
            borderRadius: borderRadius,
          ),
          duration: const Duration(milliseconds: 500),
          curve: Curves.fastOutSlowIn,
          child: Center(
            child: loading == false
                ? Text(
                    '${widget.text}',
                    style: widget.buttonColor == null
                        ? normalBoldTextWhite()
                        : normalBoldTextBlack(),
                  )
                : spinkit,
          ),
        ),
      ),
    );
  }
}

class CustomAppBar extends StatelessWidget {
  final Color? backgroundColor;
  final String? title;
  final String? textColor;
  final String? page;
  final String? icon;
  final ValueSetter<dynamic>? callback;

  CustomAppBar({
    @required this.title,
    this.page,
    this.backgroundColor,
    this.textColor,
    this.icon,
    this.callback,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: backgroundColor ?? Colors.transparent,
      elevation: 0,
      title: Text(
        title == null ? '' : '$title',
        style: textColor == 'white'
            ? header6BoldTextWhite()
            : header6BoldTextBlack(),
      ),
      leading: GestureDetector(
        onTap: () {
          callback!({
            "page": page,
          });
        },
        child: Container(
          color: Colors.transparent,
          child: Center(
            child: Image.asset(
              icon == 'cancel'
                  ? 'images/icons/cancel.png'
                  : textColor == 'white'
                      ? 'images/icons/backButtonWhite.png'
                      : 'images/icons/backButton.png',
              width: 17,
            ),
          ),
        ),
      ),
      automaticallyImplyLeading: false,
    );
  }
}

class MessageNotification extends StatelessWidget {
  final VoidCallback onReply;

  final String message;
  final String? title;
  Color? color;

  MessageNotification({
    Key? key,
    required this.onReply,
    required this.message,
    required this.color,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(
        horizontal: 2,
        vertical: 1,
      ),
      color: color ?? Colors.green,
      child: SafeArea(
        child: ListTile(
          title: title == null
              ? null
              : Text(
                  '$title',
                  style: normalBoldTextWhite(),
                ),
          subtitle: Text(
            message,
            style: normalTextWhite(),
          ),
        ),
      ),
    );
  }
}

class TvShowCard extends StatelessWidget {
  final int? showID;
  final int? season;
  final String? cardSize;
  final String? imageLink;
  final String? showName;
  final String? premiered;
  final ValueSetter<dynamic>? callback;
  TvShowCard({
    this.showID,
    this.season,
    this.cardSize,
    this.imageLink,
    this.showName,
    this.premiered,
    this.callback,
  });
  @override
  Widget build(BuildContext context) {
    String year = premiered?.substring(0, 4) ?? '2012-12-09';
    Widget card = Container(
      margin: const EdgeInsets.only(top: 20),
      padding: const EdgeInsets.only(left: 10),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: IntrinsicHeight(
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.fromLTRB(0, 0, 10, 10),
                width: cardSize == 'tall'
                    ? SizeConfig.blockSizeHorizontal! * 30
                    : cardSize == 'wide'
                        ? SizeConfig.blockSizeHorizontal! * 40
                        : SizeConfig.blockSizeHorizontal! * 50,
                height: cardSize == 'tall'
                    ? SizeConfig.blockSizeVertical! * 20
                    : cardSize == 'wide'
                        ? SizeConfig.blockSizeVertical! * 30
                        : SizeConfig.blockSizeVertical! * 30,
                child: Stack(
                  children: [
                    Positioned.fill(
                      child: Container(
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                          // boxShadow: [
                          //   BoxShadow(
                          //     color: Colors.blueGrey,
                          //     blurRadius: 5,
                          //     offset: Offset(0, 4),
                          //   ),
                          // ],
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: FadeInImage.memoryNetwork(
                            placeholder: kTransparentImage,
                            image: imageLink ?? '',
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                    Positioned.fill(
                      child: Container(
                        padding: const EdgeInsets.all(10.0),
                        decoration: BoxDecoration(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(20)),
                          gradient: LinearGradient(
                            colors: season != null
                                ? [
                                    Colors.transparent,
                                    Colors.transparent,
                                    Colors.transparent,
                                    Colors.black.withOpacity(0.5),
                                  ]
                                : [
                                    Colors.black.withOpacity(0.5),
                                    Colors.transparent,
                                    Colors.transparent,
                                    Colors.transparent,
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
                            season != null
                                ? Text(
                                    'Season $season',
                                    style: normalBoldTextWhite(),
                                  )
                                : Container(),
                            cardSize == 'tall'
                                ? Container()
                                : cardSize == 'wide'
                                    ? Container()
                                    : Text(
                                        showName ?? '',
                                        style: normalBoldTextWhite(),
                                      ),
                            cardSize == 'wide'
                                ? Container()
                                : Text(
                                    year,
                                    style: normalTextLightWhite(),
                                  ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );

    return GestureDetector(
      onTap: () {
        callback!(showID);
      },
      child: card,
    );
  }
}

// Global Toast
showToast(context, String title, String message, Color color) {
  return showOverlayNotification((context) {
    return MessageNotification(
      title: title,
      message: message,
      color: color,
      onReply: () {
        OverlaySupportEntry.of(context)!.dismiss();
      },
    );
  });
}

////////////////////////////////////////////////////////////////
/// FUNCTIONS START
////////////////////////////////////////////////////////////////
freshInstall() async {
  try {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isFreshInstall = (prefs.getBool('freshInstall') ?? true);
    if (isFreshInstall) {
      prefs.setBool('freshInstall', false);
      return true;
    } else {
      return false;
    }
  } catch (err) {
    return true;
  }
}

dioRequest(String? method, String? url, Object? data) async {
  if (method == 'get') {
    var response = await getHttp(url, data);
    return response;
  } else {
    var response = await postHttp(url, data);
    return response;
  }
}

getHttp(link, data) async {
  try {
    var response = await Dio().get(ipAddress + link, queryParameters: data);
    return response.data;
  } on DioError catch (e) {
    print('Error with get request');
    print(e.response);
    return (e.response?.data ?? {"message": 'Error processing request'});
  }
}

postHttp(link, data) async {
  try {
    Dio dio = Dio();
    var response = await dio.post(ipAddressDB + link, data: data);
    return response.data;
  } on DioError catch (e) {
    print('Error with post request');
    print(e.response);
    return (e.response?.data ?? {"message": 'Error processing request'});
  }
}


////////////////////////////////////////////////////////////////
/// FUNCTIONS STOP
////////////////////////////////////////////////////////////////

