import 'package:bdcoe/notifiers/dark.dart';
import 'package:circular_reveal_animation/circular_reveal_animation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {
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
Future <bool> _SaveAndBack(){
           return showDialog(context: context,
           builder: (context)=> AlertDialog(title: Text('Do you want to exit?'),
           actions: <Widget>[
             FlatButton(onPressed:()=>Navigator.pop(context,false), child: Text('No')
             ),
              FlatButton(onPressed:()=>Navigator.pop(context,true), child: Text('Yes'))
           ],
           ));
          
  }
  Widget homeBody(DarkThemeProvider themeProvider) {
    return WillPopScope(
      onWillPop: _SaveAndBack,
          child: Container(
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
                  right: MediaQuery.of(context).size.width / 1.18, //230.0,
//              bottom: MediaQuery.of(context).size.width / 0.68, //40.0,
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        cirAn = true;
                      });
                      themeProvider.darkTheme = !themeProvider.darkTheme;

                      if (animationController.status == AnimationStatus.forward ||
                          animationController.status ==
                              AnimationStatus.completed) {
                        animationController.reset();
                        animationController.forward();
                      } else {
                        animationController.forward();
                      }
                    },
                    child: new Container(
                      height: MediaQuery.of(context).size.height / 5.5,
                      width: MediaQuery.of(context).size.height / 15,
                      decoration: new BoxDecoration(
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(30),
                            bottomRight: Radius.circular(30)),
                        shape: BoxShape.rectangle,
                        color: Theme.of(context).hoverColor,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(
                            left: 14, right: 14, bottom: 28),
                        child: themeProvider.darkTheme
                            ? Image.asset(
                                "assets/bulb_off.png",
                                fit: BoxFit.fitHeight,
                              )
                            : Image.asset(
                                "assets/bulb_on.png",
                                fit: BoxFit.fitHeight,
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
                        flex: 7,
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
                'WELCOME',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              alignment: Alignment.center,
            )
          : Align(
              child: Text(
                'WELCOME',
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

  var size = MediaQuery.of(context).size;
  return Container(
    child: Padding(
      padding: const EdgeInsets.only(left:15,right:15,top:20),
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        elevation: 2,
        // color: Colors.white,
        child: Container(
          height: size.height / 1,
          width: size.width / 1.1,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: Text(
                  'Welcome to',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    'Big Data ',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                  ),
                  SizedBox(
                    width: size.width / 12 / 15,
                  ),
                  Text(
                    "Centre Of Excellence",
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        color: Color(0xff3972CF)),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Container(
                    child: Padding(
                      padding: const EdgeInsets.all(3.0),
                      child: Text(
                  "Big Data Centre of excellence is the research and development centre. At BDCoE, we strive to stimulate interest in Big Data concept and related technologies among the students of the institution. We spear head at technologies like Big Data, Machine learning and Deep learning along with web development and app development. Our belief system includes hereditary learning and constant improvment. We aim at producing competent individuals and doing outsourced projects.",
                maxLines: 12,
                  overflow: TextOverflow.ellipsis,
                //  textAlign: TextAlign.justify,
                ),
                    )),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  GestureDetector(
                    onTap: ()  async{
                    const url = 'https://www.instagram.com/bdcoe/?hl=en';
  if (await canLaunch(url)) {
    await launch(url);
  } 
                    },
                    child: Container(
                        height: size.width / 12,
                        width: size.width / 12,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(40),
                            color: Theme.of(context).buttonColor),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Image.asset(
                            "assets/ins.png",
                          ),
                        )),
                  ),
                           GestureDetector(
                    onTap: ()  async{
                    const url = 'https://www.linkedin.com/school/big-data-centre-of-excellence/about/';
  if (await canLaunch(url)) {
    await launch(url);
  } 
                    },
                    child: Container(
                        height: size.width / 12,
                        width: size.width / 12,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(40),
                            color: Theme.of(context).buttonColor),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Image.asset(
                            "assets/linkdin.png",
                          ),
                        )),
                  ),
                  GestureDetector(
                    onTap: ()  async{
                    const url = 'https://github.com/bdcoe';
  if (await canLaunch(url)) {
    await launch(url);
  } 
                    },
                    child: Container(
                        height: size.width / 12,
                        width: size.width / 12,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(40),
                            color: Theme.of(context).buttonColor),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Image.asset("assets/github.png"),
                        )),
                  ),
                  GestureDetector(
                    onTap: ()  async{
                    const url = 'https://www.facebook.com/bigdatacoe/';
  if (await canLaunch(url)) {
    await launch(url);
  } 
                    },
                    child: Container(
                        height: size.width / 12,
                        width: size.width / 12,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(40),
                            color: Theme.of(context).buttonColor),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Image.asset("assets/facebook.png"),
                        )),
                  ),
                  GestureDetector(
                   onTap: ()  async{
                    const url = 'https://www.youtube.com/channel/UCE-dW0xxvpZq_UWZ9B5jKUA';
  if (await canLaunch(url)) {
    await launch(url);
  } 
                    },
                    child: Container(
                        height: size.width / 12,
                        width: size.width / 12,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(40),
                            color: Theme.of(context).buttonColor),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Image.asset(
                            "assets/youtube.png",
                          ),
                        )),
                  ),
                ],
              )
            ],
          ),
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
