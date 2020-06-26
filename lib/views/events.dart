import 'package:bdcoe/notifiers/dark.dart';
import 'package:circular_reveal_animation/circular_reveal_animation.dart';
//import 'package:circular_reveal_animation/circular_reveal_animation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
class Events extends StatefulWidget {
  @override
  _EventsState createState() => _EventsState();
}

class _EventsState extends State<Events> with TickerProviderStateMixin {
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
                        animationController.status ==
                            AnimationStatus.completed) {
                      animationController.reset();
                      animationController.forward();
                    } else {
                      animationController.forward();
                    }
   
  }
@override
dispose() {
  animationController.dispose(); // you need this
  super.dispose();
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

  Widget homeBody(DarkThemeProvider themeProvider) {
    return Container(
      color:Theme.of(context).primaryColor,
      child: SafeArea(child: Scaffold(
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
                      flex: 6,
                      child: _description(
                        context,
                      )),
                  
                ],
              ),
            ],
          ),
          backgroundColor: Theme.of(context).backgroundColor,
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
                'OUR EVENTS',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              alignment: Alignment.center,
            )
          : Align(
              child: Text(
                'OUR EVENTS',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              alignment: Alignment.center,
            ),
    ),
  );
}

Widget _description(
  context,
) {
//  var upcomingEventsData = upcomingEvent.data.attributes;
//  print(upcomingEventsData.name);

  
  return Container(
    
  );
}


//   }
