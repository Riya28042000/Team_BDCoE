import 'package:bdcoe/notifiers/dark.dart';
import 'package:circular_reveal_animation/circular_reveal_animation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class Contact extends StatefulWidget {
  @override
  _ContactState createState() => _ContactState();
}

class _ContactState extends State<Contact> with TickerProviderStateMixin {
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
                      margin: EdgeInsets.only(bottom: 1.0),
                      child: Stack(
                        children: <Widget>[
                          _logo(themeProvider, context),
                        ],
                      ),
                    ),
                    flex: 3,
                  ),
                  Flexible(
                      flex: 10,
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
                'GET IN TOUCH!',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              alignment: Alignment.center,
            )
          : Align(
              child: Text(
                'GET IN TOUCH!',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              alignment: Alignment.center,
            ),
    ),
  );
}

Widget _description(
  DarkThemeProvider themeChangeProvider,
  context,
) {
  var size = MediaQuery.of(context).size;
// //  var upcomingEventsData = upcomingEvent.data.attributes;
// //  print(upcomingEventsData.name);
  void call(String number) => launch("tel:$number");

  return Container(
    child: Padding(
      padding: const EdgeInsets.only(left: 15, right: 15),
      child: Container(
        height: size.height / 1,
        width: size.width / 1.1,
        child: Column(
            //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(
                  top: 30, left: 10, right: 10, bottom: 10),
              child: Align(
                child: Text(
                  'ADDRESS',
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      color: Color(0xff3972CF)),
                ),
                alignment: Alignment.topLeft,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Align(
                child: Text(
                  'Research & Development Department, Ajay Kumar Garg Engineering College, Delhi Hapur Bypass, Adhyatmik Nagar, Ghaziabad, Uttar Pradesh 201009',
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
                ),
                alignment: Alignment.topLeft,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  top: 30, left: 10, right: 10, bottom: 10),
              child: Align(
                child: Text(
                  'EMAIL',
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      color: Color(0xff3972CF)),
                ),
                alignment: Alignment.topLeft,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Align(
                child: GestureDetector(
                  onTap: () {
                    Uri _emailLaunchUri = Uri(
                      scheme: 'mailto',
                      path: 'bdcoe@gmail.com',
                    );
                    launch(_emailLaunchUri.toString());
                  },
                  child: Text(
                    'bdcoe@gmail.com',
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
                  ),
                ),
                alignment: Alignment.topLeft,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  top: 30, left: 10, right: 10, bottom: 10),
              child: Align(
                child: Text(
                  'CALL US ON',
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      color: Color(0xff3972CF)),
                ),
                alignment: Alignment.topLeft,
              ),
            ),
            Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
                  child: Align(
                    child: GestureDetector(
                      onTap: () {
                        call("7007769241");
                      },
                      child: Text(
                        '7007769241',
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.w500),
                      ),
                    ),
                    alignment: Alignment.topLeft,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      top: 8, left: 10, right: 10, bottom: 10),
                  child: Align(
                    child: GestureDetector(
                      onTap: () {
                        call("9984508400");
                      },
                      child: Text(
                        '9984508400',
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.w500),
                      ),
                    ),
                    alignment: Alignment.topLeft,
                  ),
                ),
              ],
            ),
              Padding(
              padding: const EdgeInsets.only(
                  top: 30, left: 10, right: 10, bottom: 10),
              child: Align(
                child: Text(
                  'WEBSITE',
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      color: Color(0xff3972CF)),
                ),
                alignment: Alignment.topLeft,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Align(
                child: GestureDetector(
                   onTap: ()  async{
                    const url = 'http://www.bdcoe.co.in/';
  if (await canLaunch(url)) {
    await launch(url);
  } 
                    },
                  child: Text(
                    'bdcoe.co.in',
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
                  ),
                ),
                alignment: Alignment.topLeft,
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

// Widget _optionsScreen(context) {
//   var size = MediaQuery.of(context).size;
//   return Container(
//     margin: EdgeInsets.only(left: 8, right: 8, top: 20),
//     height: MediaQuery.of(context).size.height / 7,
//     width: MediaQuery.of(context).size.width,
//     child: Card(
//       elevation: 0,
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
//       child: Padding(
//           padding: const EdgeInsets.all(12.0),
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//             children: <Widget>[
//               InkWell(
//                 highlightColor: Colors.transparent,
//                 onTap: () {
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                       builder: (context) => AgendaScreen(),
//                     ),
//                   );
//                 },
//                 child: Container(
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.spaceAround,
//                     children: <Widget>[
//                       Image.asset(
//                         "assets/agenda.png",
//                         height: size.height / 30,
//                       ),
//                       Text(
//                         'Agenda',
//                         style: TextStyle(fontSize: 11),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//               InkWell(
//                 highlightColor: Colors.transparent,
//                 onTap: () {
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                       builder: (context) => SpeakersScreenList(),
//                     ),
//                   );
//                 },
//                 child: Container(
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.spaceAround,
//                     children: <Widget>[
//                       Image.asset(
//                         "assets/speaker.png",
//                         height: size.height / 30,
//                       ),
//                       Text('Speakers', style: TextStyle(fontSize: 11)),
//                     ],
//                   ),
//                 ),
//               ),
//               InkWell(
//                 highlightColor: Colors.transparent,
//                 onTap: () {
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                       builder: (context) => Sponsors(),
//                     ),
//                   );
//                 },
//                 child: Container(
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.spaceAround,
//                     children: <Widget>[
//                       Image.asset(
//                         "assets/sponsors.png",
//                         height: size.height / 30,
//                       ),
//                       Text('Sponsors', style: TextStyle(fontSize: 11)),
//                     ],
//                   ),
//                 ),
//               ),
// //              InkWell(
// //                highlightColor: Colors.transparent,
// //                onTap: () {
// //                  Navigator.push(
// //                    context,
// //                    MaterialPageRoute(
// //                      builder: (context) => Team(),
// //                    ),
// //                  );
// //                },
// //                child: Container(
// //                  child: Column(
// //                    mainAxisAlignment: MainAxisAlignment.spaceAround,
// //                    children: <Widget>[
// //                      Image.asset(
// //                        "assets/team.png",
// //                        height: size.height / 30,
// //                      ),
// //                      Text('Team', style: TextStyle(fontSize: 11)),
// //                    ],
// //                  ),
// //                ),
// //              ),
//             ],
//           )),
//     ),

//      );

//   }
