import 'package:bdcoe/chat/chat.dart';
import 'package:bdcoe/chat/login.dart';
import 'package:bdcoe/chat/preference.dart';
import 'package:bdcoe/modals/user.dart';
import 'package:bdcoe/navigation/navigation.dart';
import 'package:bdcoe/notifiers/dark.dart';
import 'package:circular_reveal_animation/circular_reveal_animation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_offline/flutter_offline.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:url_launcher/url_launcher.dart';

class Contact extends StatefulWidget {
  @override
  _ContactState createState() => _ContactState();
}

class _ContactState extends State<Contact> with TickerProviderStateMixin {
  bool userIsLoggedIn;
  String email;
  String name;
  String chatroomid;
  UserInfo userInfo =UserInfo();

  AnimationController animationController;

  Animation<double> animation;
  bool cirAn = false;
  @override
  void initState() {
    getLoggedInState();
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

  getLoggedInState() async {
    // await HelperFunctions.getUserLoggedInSharedPreference().then((value) {
    //   setState(() {
    //     userIsLoggedIn = value;
    //     print(value);
    //   });
    // });
    // //   HelperFunctions.saveAdminLoggedInSharedPreference(false);
    
    userIsLoggedIn=await HelperFunctions.getUserLoggedInSharedPreference();
      print(userIsLoggedIn);
      name=await HelperFunctions.getUserNameSharedPreference();
      email=await HelperFunctions.getUserEmailSharedPreference();
      chatroomid= await HelperFunctions.getchatroomid();
       if(userIsLoggedIn==true){
        userInfo.email=email;
        userInfo.chatroomid=chatroomid;
        userInfo.name=name;
       
      }
       print(userInfo.name);
       print(userInfo.chatroomid);
      setState(() {   
      });

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
    return  OfflineBuilder(

        debounceDuration: Duration.zero,
        connectivityBuilder: (
            BuildContext context,
            ConnectivityResult connectivity,
            Widget child,
            ) {
          if (connectivity == ConnectivityResult.none) {

            return  WillPopScope(
               onWillPop: MoveToLastScreen,
                          child: Scaffold(
                backgroundColor: Color(0xff3f51b6),
                body: Center(child:Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Center(child: Image.asset("assets/offf.png")),
                      SizedBox(height:10),
                      Text("Check you Internet Connection!",style: GoogleFonts.zillaSlab(color:Colors.white,fontSize: 20),)
                    ],
                ) ,)
              ),
            );
          }
          return child;
        },
    
    
  child:  WillPopScope(
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
                        flex: 12,
                        child: _description(
                          themeProvider,
                          context,
                        )),
                  ],
                ),
              ],
            ),
            backgroundColor: Theme.of(context).backgroundColor,
            floatingActionButton: Padding(
              padding: const EdgeInsets.all(8.0),
              child: FloatingActionButton.extended(
                backgroundColor: themeProvider.darkTheme
                    ? Color(0xFF151515)
                    :Color(0xff3671a4),
                onPressed: () {
                  userIsLoggedIn != null
                      ? userIsLoggedIn
                          ? Navigator.of(context).pushAndRemoveUntil(
                              MaterialPageRoute(
                                  builder: (context) => Chatting(chatroomid: chatroomid,name: name,)),
                              (Route<dynamic> route) => false)
                          : Navigator.of(context).pushAndRemoveUntil(
                              MaterialPageRoute(builder: (context) => Login()),
                              (Route<dynamic> route) => false)
                      : Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(builder: (context) => Login()),
                          (Route<dynamic> route) => false);
                },
                icon: Icon(
                  Icons.chat,
                  color: Colors.white,
                ),
                label: Text(
                  "Talk Now",
                  style: GoogleFonts.zillaSlab(color: Colors.white),
                ),
              ),
            ),
          ),
        ),
      ),
    )
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
                style: GoogleFonts.zillaSlab(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              alignment: Alignment.center,
            )
          : Align(
              child: Text(
                'GET IN TOUCH!',
                style: GoogleFonts.zillaSlab(fontSize: 20, fontWeight: FontWeight.bold),
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
  Future gettoDo() async {
    var firestore = Firestore.instance;
    QuerySnapshot qn = await firestore.collection("phone").getDocuments();
    return qn.documents;
  }

  return Container(
    child: Padding(
      padding: const EdgeInsets.only(left: 15, right: 15),
      child: Container(
          height: size.height / 1,
          width: size.width / 1.1,
          child: FutureBuilder(
              future: gettoDo(),
              builder: (_, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: SpinKitChasingDots(
                      itemBuilder: (BuildContext context, int index) {
                        return DecoratedBox(
                          decoration: BoxDecoration(
                            color: themeChangeProvider.darkTheme
                                ? Colors.white
                                : Colors.black,
                          ),
                        );
                      },
                    ),
                  );
                } else {
                  return Column(
                    //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 30, left: 10, right: 10, bottom: 10),
                        child: Align(
                          child: Text(
                            'ADDRESS',
                            style: GoogleFonts.zillaSlab(
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                                color: Color(0xff3671a4)),
                          ),
                          alignment: Alignment.topLeft,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Align(
                          child: Text(
                            'Research & Development Department, Ajay Kumar Garg Engineering College, Delhi Hapur Bypass, Adhyatmik Nagar, Ghaziabad, Uttar Pradesh 201009',
                            style: GoogleFonts.zillaSlab(
                                fontSize: 15, fontWeight: FontWeight.w500),
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
                            style: GoogleFonts.zillaSlab(
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                                color: Color(0xff3671a4)),
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
                                path: 'contact@bdcoe.co.in',
                              );
                              launch(_emailLaunchUri.toString());
                            },
                            child: Text(
                              'contact@bdcoe.co.in',
                              style: GoogleFonts.zillaSlab(
                                  fontSize: 15, fontWeight: FontWeight.w500),
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
                            style: GoogleFonts.zillaSlab(
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                                color: Color(0xff3671a4)),
                          ),
                          alignment: Alignment.topLeft,
                        ),
                      ),
                      Column(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(
                                top: 10, left: 10, right: 10),
                            child: Align(
                              child: GestureDetector(
                                onTap: () {
                                  call(snapshot.data[0].data['phone1']);
                                },
                                child: Text(
                                  snapshot.data[0].data['phone1'],
                                  style: GoogleFonts.zillaSlab(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w500),
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
                                  call(snapshot.data[0].data['phone2']);
                                },
                                child: Text(
                                  snapshot.data[0].data['phone2'],
                                  style: GoogleFonts.zillaSlab(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w500),
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
                            style: GoogleFonts.zillaSlab(
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                                color: Color(0xff3671a4)),
                          ),
                          alignment: Alignment.topLeft,
                        ),
                      ),
                      Row(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Align(
                              child: GestureDetector(
                                onTap: () async {
                                  const url = 'http://www.bdcoe.co.in/';
                                  if (await canLaunch(url)) {
                                    await launch(url);
                                  }
                                },
                                child: Text(
                                  'bdcoe.co.in',
                                  style: GoogleFonts.zillaSlab(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
                              alignment: Alignment.topLeft,
                            ),
                          ),
                        ],
                      ),
                    ],
                  );
                }
              })),
    ),
  );
}
