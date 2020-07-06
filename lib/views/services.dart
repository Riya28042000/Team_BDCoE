import 'package:bdcoe/navigation/navigation.dart';
import 'package:bdcoe/notifiers/dark.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:circular_reveal_animation/circular_reveal_animation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:slimy_card/slimy_card.dart';



class Services extends StatefulWidget {
  @override
  _ServicesState createState() => _ServicesState();
}

class _ServicesState extends State<Services> with TickerProviderStateMixin {
  AnimationController animationController;

  Animation<double> animation;
  bool cirAn = false;
  @override
  void initState() {
    super.initState();
//    upcomingEventBloc.loadScreenScreen();

    animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 500),
    );
    animation = CurvedAnimation(
      parent: animationController,
      curve: Curves.easeIn,
      // reverseCurve: Curves.easeInOut
    );
    animationController.forward();
    setState(() {
      cirAn = true;
    });
    // themeProvider.darkTheme = !themeProvider.darkTheme;

    if (animationController.status == AnimationStatus.forward ||
        animationController.status == AnimationStatus.completed) {
      animationController.reset();
      animationController.forward();
    } else {
      animationController.forward();
    }
  }

 

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<DarkThemeProvider>(context);

    var size = MediaQuery.of(context).size;
    return cirAn
        ? CircularRevealAnimation(
            center: Offset(size.height / 15, size.width / 3.5),
            animation: animation,
            child: homeBody(
              themeProvider,
            ),
          )
        : homeBody(themeProvider);
  }

  Future<bool> MoveToLastScreen() {
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => BottomNavBar()),
        (Route<dynamic> route) => false);
  }

  Widget homeBody(DarkThemeProvider themeProvider) {
    return WillPopScope(
      onWillPop: MoveToLastScreen,
      child: Container(
        color: Theme.of(context).primaryColor,
        child: SafeArea(
          child: Scaffold(
            body: Stack(
              children: <Widget>[
                new Positioned(
                  left: MediaQuery.of(context).size.width / 1.15, //230.0,
                  bottom: MediaQuery.of(context).size.width / 1,

                  child: new Container(
                    height: MediaQuery.of(context).size.height / 8,
                    width: MediaQuery.of(context).size.height / 5,
                    decoration: new BoxDecoration(
                      shape: BoxShape.circle,
                      color: Theme.of(context).indicatorColor,
                    ),
                  ),
                ),
                new Positioned(
                  right: MediaQuery.of(context).size.width / 1.2, //230.0,
                  bottom: MediaQuery.of(context).size.width / 0.69, //40
                  child: new Container(
                    height: MediaQuery.of(context).size.height / 8,
                    width: MediaQuery.of(context).size.height / 5,
                    decoration: new BoxDecoration(
                      shape: BoxShape.circle,
                      color: Theme.of(context).hintColor,
                    ),
                  ),
                ),
                new Positioned(
                  left: MediaQuery.of(context).size.width / 1.1, //230.0,
                  top: MediaQuery.of(context).size.width / 0.8, //40.0,
                  child: new Container(
                    height: MediaQuery.of(context).size.height / 4,
                    width: MediaQuery.of(context).size.height / 4,
                    decoration: new BoxDecoration(
                      shape: BoxShape.circle,
                      color: Theme.of(context).highlightColor,
                    ),
                  ),
                ),
                new Positioned(
                  right: MediaQuery.of(context).size.width / 1.05, //230.0,
                  bottom: MediaQuery.of(context).size.width / 1.3, //40.0,
                  child: new Container(
                    height: MediaQuery.of(context).size.height / 8,
                    width: MediaQuery.of(context).size.height / 8,
                    decoration: new BoxDecoration(
                      shape: BoxShape.circle,
                      color: Theme.of(context).focusColor,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: Container(
                        decoration: new BoxDecoration(
                          shape: BoxShape.circle,
                          color: Theme.of(context).backgroundColor,
                        ),
                      ),
                    ),
                  ),
                ),
                new Positioned(
                  left: MediaQuery.of(context).size.width / 1.1, //230.0,
                  bottom: MediaQuery.of(context).size.width / 0.7, //40.0,
                  child: new Container(
                    height: MediaQuery.of(context).size.height / 8,
                    width: MediaQuery.of(context).size.height / 8,
                    decoration: new BoxDecoration(
                      shape: BoxShape.circle,
                      color: Theme.of(context).hintColor,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: Container(
                        decoration: new BoxDecoration(
                          shape: BoxShape.circle,
                          color: Theme.of(context).backgroundColor,
                        ),
                      ),
                    ),
                  ),
                ),
                new Positioned(
                  right: MediaQuery.of(context).size.width / 1.2, //230.0,
                  top: MediaQuery.of(context).size.width / 2.5, //40.0,
                  child: new Container(
                    height: MediaQuery.of(context).size.height / 12,
                    width: MediaQuery.of(context).size.height / 12,
                    decoration: new BoxDecoration(
                      shape: BoxShape.circle,
                      color: Theme.of(context).indicatorColor,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: Container(
                        decoration: new BoxDecoration(
                          shape: BoxShape.circle,
                          color: Theme.of(context).backgroundColor,
                        ),
                      ),
                    ),
                  ),
                ),
                new Positioned(
                  right: MediaQuery.of(context).size.width / 1.2, //230.0,
                  top: MediaQuery.of(context).size.width / 0.69, //40
                  child: new Container(
                    height: MediaQuery.of(context).size.height / 8,
                    width: MediaQuery.of(context).size.height / 5,
                    decoration: new BoxDecoration(
                      shape: BoxShape.circle,
                      color: Theme.of(context).indicatorColor,
                    ),
                  ),
                ),
                new Column(
                  children: <Widget>[
                    Flexible(
                      child: new Container(
                        margin: EdgeInsets.only(bottom: 25.0),
                        child: Stack(
                          children: <Widget>[
                            _logo(themeProvider, context),
                          ],
                        ),
                      ),
                      flex: 3,
                    ),
                    Flexible(
                        flex: 11,
                        child: _description(
                          themeProvider,
                          context,
                        )),
                  ],
                ),
              ],
            ),
            backgroundColor: Theme.of(context).backgroundColor,
          ),
        ),
      ),
    );
  }
}

Widget _logo(DarkThemeProvider themeChangeProvider, context) {
  var size = MediaQuery.of(context).size;
  return Container(
    child: Container(
      margin: EdgeInsets.only(top: 25, bottom: 0.0, left: 25.0, right: 25.0),
      height: size.height / 8,
      width: size.width / 2,
      child: themeChangeProvider.darkTheme
          ? Align(
              child: Text(
                'WHAT WE DO?',
                style: GoogleFonts.zillaSlab(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              alignment: Alignment.center,
            )
          : Align(
              child: Text(
                'WHAT WE DO?',
                style: GoogleFonts.zillaSlab(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              alignment: Alignment.center,
            ),
    ),
  );
}

Future what() async {
  var firestore = Firestore.instance;
  QuerySnapshot qn = await firestore.collection("whatwedo").getDocuments();
  return qn.documents;
}

Widget _description(
  DarkThemeProvider themeProvider,
  context,
) {
  var size = MediaQuery.of(context).size;

  return Container(
    child: Padding(
      padding: const EdgeInsets.only(left: 15, right: 15),
      child: Container(
          height: size.height / 1,
          width: size.width / 1.1,
          child: FutureBuilder(
              future: what(),
              builder: (_, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: SpinKitChasingDots(
                      itemBuilder: (BuildContext context, int index) {
                        return DecoratedBox(
                          decoration: BoxDecoration(
                            color: themeProvider.darkTheme
                                ? Colors.white
                                : Colors.black,
                          ),
                        );
                      },
                    ),
                  );
                } else {
                  return Column(
                    //  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Flexible(
                        child: Padding(
                          padding: const EdgeInsets.only(top: 10),
                          child: new Swiper(
                            itemBuilder: (BuildContext context, int index) {
                              return Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: SlimyCard(
                                  color: themeProvider.darkTheme?Color(0xFF151515):Color(0xff3671a4),
                                  topCardHeight: 200,
                                  bottomCardHeight: 200,
                                  slimeEnabled: true,
                                  
                                  topCardWidget: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Container(
                                        height: 70,
                                        width: 70,
                                        decoration: BoxDecoration(
                                        
                                          borderRadius:
                                      BorderRadius.circular(15),

                                          boxShadow: [
                                            BoxShadow(
                                              color:
                                                  Colors.black.withOpacity(0.1),
                                              blurRadius: 20,
                                              spreadRadius: 1,
                                            ),
                                          ],
                                        ),
                                        child: CachedNetworkImage(
                                          imageUrl: snapshot
                                              .data[index].data['image'],
                                          progressIndicatorBuilder: (context,
                                                  url, downloadProgress) =>
                                              CircularProgressIndicator(
                                                  value: downloadProgress
                                                      .progress),
                                          errorWidget: (context, url, error) =>
                                              Icon(Icons.error),
                                          fit: BoxFit.fill,
                                        ),
                                      ),
                                      SizedBox(height: 15),
                                      Text(
                                        snapshot.data[index].data['title'],
                                        style: GoogleFonts.zillaSlab(
                                          color: Colors.white,
                                            fontSize: 15,fontWeight: FontWeight.bold),
                                      ),
                                      SizedBox(height: 15),
                                    ],
                                  ),
                                  
                                  bottomCardWidget: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      snapshot.data[index].data['desc'],
                                      style: GoogleFonts.zillaSlab(
                                        color: Colors.white,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ),
                              );
                            },
                            autoplay: true,
                            itemCount: snapshot.data.length,
                            scrollDirection: Axis.horizontal,
                            //  pagination: new SwiperPagination(alignment: Alignment.centerRight),
                            // control: new SwiperControl(),
                          ),
                        ),
                      ),
                    ],
                  );
                }
              })),
    ),
  );
}
