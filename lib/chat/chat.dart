import 'package:bdcoe/chat/login.dart';
import 'package:bdcoe/chat/preference.dart';
import 'package:bdcoe/notifiers/dark.dart';
import 'package:circular_reveal_animation/circular_reveal_animation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Chatting extends StatefulWidget {
  @override
  _ChattingState createState() => _ChattingState();
}

class _ChattingState extends State<Chatting> with TickerProviderStateMixin {
  void logout() async {
    HelperFunctions.saveUserLoggedInSharedPreference(false);
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => Login()),
        (Route<dynamic> route) => false);
  }

  AnimationController animationController;

  Animation<double> animation;
  bool cirAn = false;
  @override
  void initState() {
    super.initState();

    animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 500),
    );
    animation = CurvedAnimation(
      parent: animationController,
      curve: Curves.easeIn,
    );
    animationController.forward();
    setState(() {
      cirAn = true;
    });

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

  Future<bool> MoveToLastScreen() {
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => Login()),
        (Route<dynamic> route) => false);
  }

  Widget homeBody(DarkThemeProvider themeProvider) {
    return WillPopScope(
      onWillPop: MoveToLastScreen,
      child: Container(
        color: Theme.of(context).primaryColor,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor:Theme.of(context).primaryColor,
            automaticallyImplyLeading: false,
            actions: <Widget>[
              GestureDetector(
                onTap: () {
                  logout();
                },
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: Icon(Icons.exit_to_app),
                ),
              )
            ],
          ),
          body: Container(),
        ),
      ),
    );
  }
}
