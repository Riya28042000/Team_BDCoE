import 'dart:io';
import 'dart:math';

import 'package:bdcoe/navigation/navigation.dart';
import 'package:bdcoe/notifiers/dark.dart';
import 'package:circular_reveal_animation/circular_reveal_animation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_offline/flutter_offline.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:liquid_progress_indicator/liquid_progress_indicator.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class Recruitment extends StatefulWidget {
  @override
  _Recruitment createState() => _Recruitment();
}

class _Recruitment extends State<Recruitment> with SingleTickerProviderStateMixin{
Future gettoDo() async {
    var firestore = Firestore.instance;
    QuerySnapshot qn = await firestore.collection("recruitment").getDocuments();
    return qn.documents;
  }
   double progres=0;
    AnimationController animationController;
String progressString="0%" ;
  Animation<double> animation;
  bool cirAn = false;
bool downloading =false; 
       bool  logic=true;
      
   @override
  void initState() {
    getUrl();
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
   String url;
  void getUrl() async{
    
 Firestore.instance.collection('recruitment').document('MUc8uOzKbAiDbkstXOvN').get().then((onValue){
   print(onValue.data["pdf"]);
   url =onValue.data["pdf"];
 });
// document.get() => then(function(document) {
//     print(document("pdf"));
// });
  }
 
@override
dispose() {
  animationController.dispose();
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
              themeProvider,context
            ),
          )
        : homeBody(themeProvider,context);
         }
Future<bool> MoveToLastScreen() {
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => BottomNavBar()),
        (Route<dynamic> route) => false);
  }
  Future<bool> MoveTo() {
 
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => Recruitment()),
        (Route<dynamic> route) => false);
        
  }
  Widget homeBody(DarkThemeProvider themeProvider,context) {
     var size = MediaQuery.of(context).size;
     print('$progressString');
 return   OfflineBuilder(

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
    
    
  child:
 
 
  downloading? WillPopScope(
   onWillPop: MoveTo,
    child: Container(
      color:Theme.of(context).primaryColor,
      child: SafeArea(
              child: Scaffold(
        backgroundColor: Theme.of(context).backgroundColor,
         body:Stack(
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
                     flex:12,
                                        child: Center(
     child: Container(
       child: SizedBox(
         width: 100,
         height: 100,
        
         child: LiquidCircularProgressIndicator(
       value: progres, 
       valueColor: AlwaysStoppedAnimation(Color(0xff3671a4)),
       backgroundColor: Theme.of(context).cardColor,
       direction: Axis.vertical, 
       
       center:  Text('$progressString',
                                style: TextStyle(color: themeProvider.darkTheme?Colors.white:
                                Colors.blue[200]),
                              ),
),
       ),
     ),
),
                   ),
                  ],
                ),
              ],
         )
         ),
      ),
    ),
 ) :WillPopScope(
       onWillPop: MoveToLastScreen,
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
                          child: _logo(themeProvider, context),
                        ),
                        flex: 3,
                      ),
                      Flexible(
                          flex: 12,
                          child: Container(
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
                            color: themeProvider.darkTheme
                                ? Colors.white
                                : Colors.black,
                          ),
                        );
                      },
                    ),
                  );
                } else {
                  return SingleChildScrollView(
                                      child: Column(
                      //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 30, left: 10, right: 10, bottom: 10),
                          child: Align(
                            child: Text(
                              'PHASE-1',
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
                              padding:  const EdgeInsets.only(
                                  top: 10, left: 10, right: 10),
                              child: Align(
                                child: Text(
                    snapshot.data[0].data['Phase1'],
                                  style: GoogleFonts.zillaSlab(
                                      fontSize: 15, fontWeight: FontWeight.w500),
                                ),
                                alignment: Alignment.topLeft,
                              ),
                            ),
                            GestureDetector(
                              onTap: ()async{
              setState(() {
         downloading=true; 
         logic=false;
        });
        Directory dir = await getExternalStorageDirectory();
          Dio dio = Dio();
         
          final RegExp regex = RegExp('([^?/]*\.(pdf))');
           final String fileName = regex.stringMatch('BigDataSamplePaper');
          await new Directory(dir.path.toString() + "/BDCoE").create(recursive: true).then((data){
            print("file created");
          });
          print("riyaa");
          print(dir.path.toString());
  dio.download(url ,"${dir.path.toString()}" + "/BDCOE" + "Sample Synopsis.pdf", onReceiveProgress: (rec, total){
 

        print("rec:${rec}");
      print("total:${total}");
  //    pop(downloading, progresString);
  //     setState(() {
  //    //   downloading = true;
        progressString = ((rec / total) * 100).toStringAsFixed(0) + "%";
        print(progressString);
        progres= (rec / total);
  // });
  setState(() {
    
  });
          
  }
  ).then((onValue){
  
  if(onValue.statusCode==200){
    progressString="0%";
    progres=0.0;
     Alert(
            context: context,
            
            type: AlertType.success,
            title: "SUCCESS",
            style:AlertStyle(
              backgroundColor: Theme.of(context).cardColor,
      animationType: AnimationType.fromTop,
      isCloseButton: false,
      isOverlayTapDismiss: false,
      descStyle: GoogleFonts.zillaSlab(fontSize: 18),
      animationDuration: Duration(milliseconds: 400),
      alertBorder: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(0.0),
        side: BorderSide(
         // color: Colors.grey,
        ),
      ),
      titleStyle: GoogleFonts.zillaSlab(
        fontWeight: FontWeight.bold,
       color: Theme.of(context).textSelectionColor
      ),
    ),
            desc: "Your File is downloaded in Android/data/com.example.bdcoe/files",
            buttons: [
              DialogButton(
                color: Color(0xff3671a4),
                child: Text(
                  "OK",
                  style: GoogleFonts.zillaSlab(fontSize: 20,color: Colors.white),
                ),
                onPressed: () {
                   setState(() {
     downloading =false;
      });
                
                  Navigator.of(context).pop();
                }
              )
            ],
          ).show();
  }else{
    progressString="0%";
    
progres=0.0;
       Alert(
            context: context,
            
            type: AlertType.error,
            title: "ERROR",
            style:AlertStyle(
              backgroundColor: Theme.of(context).cardColor,
      animationType: AnimationType.fromTop,
      isCloseButton: false,
      isOverlayTapDismiss: false,
      descStyle: GoogleFonts.zillaSlab(fontSize: 18),
      animationDuration: Duration(milliseconds: 400),
      alertBorder: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(0.0),
        side: BorderSide(
         // color: Colors.grey,
        ),
      ),
      titleStyle: GoogleFonts.zillaSlab(
        fontWeight: FontWeight.bold,
       color: Theme.of(context).textSelectionColor
      ),
    ),
            desc: "Some error occured. Try Again!",
            buttons: [
              DialogButton(
                color: Color(0xff3671a4),
                child: Text(
                  "OK",
                  style: GoogleFonts.zillaSlab(fontSize: 20,color: Colors.white),
                ),
                onPressed: () {
                   setState(() {
     downloading =false;
      });
                
                  Navigator.of(context).pop();
                }
              )
            ],
          ).show();
  }
 
  } 
  ).catchError((onError){
 progressString="0%";
 progres=0;
       Alert(
            context: context,
            
            type: AlertType.error,
            title: "ERROR",
            style:AlertStyle(
              backgroundColor: Theme.of(context).cardColor,
      animationType: AnimationType.fromTop,
      isCloseButton: false,
      isOverlayTapDismiss: false,
      descStyle: GoogleFonts.zillaSlab(fontSize: 18),
      animationDuration: Duration(milliseconds: 400),
      alertBorder: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(0.0),
        side: BorderSide(
         // color: Colors.grey,
        ),
      ),
      titleStyle: GoogleFonts.zillaSlab(
        fontWeight: FontWeight.bold,
       color: Theme.of(context).textSelectionColor
      ),
    ),
            desc: "Check Your Internet Connection!",
            buttons: [
              DialogButton(
                color: Color(0xff3671a4),
                child: Text(
                  "OK",
                  style: GoogleFonts.zillaSlab(fontSize: 20,color: Colors.white),
                ),
                onPressed: () {
                   setState(() {
     downloading =false;
      });
          Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => Recruitment()),
        (Route<dynamic> route) => false);
                }
              )
            ],
          ).show();
  });
  
            // setState(() {
            //  progressindicatorvariable=false; 
            //  logic=true;
            // });
        //     setState(() {
        //    downloading=false;
        //   progresString = 'completed';
        // });           
                             },
                              child:    Padding(
                              padding: const EdgeInsets.only(
                                  top: 8, left: 10, right: 10, bottom: 10),
                              child: Align(
                                child: Text(
                                  'Click here to download previous year sample paper.',
                                  style: GoogleFonts.zillaSlab(
                                      fontSize: 15,
                                       color: Color(0xff3671a4),
                                      fontWeight: FontWeight.w500),
                                ),
                                alignment: Alignment.topLeft,
                              ),
                            ),
                            )
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 30, left: 10, right: 10, bottom: 10),
                          child: Align(
                            child: Text(
                              'PHASE-2',
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
                               snapshot.data[0].data['Phase2'],
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
                              'PHASE-3',
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
                               snapshot.data[0].data['Phase3'],
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
                              'PHASE-4',
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
                               snapshot.data[0].data['Phase4'],
                              style: GoogleFonts.zillaSlab(
                                  fontSize: 15, fontWeight: FontWeight.w500),
                            ),
                            alignment: Alignment.topLeft,
                          ),
                        ),
                      ],
                    ),
                  );
                }
              })),
    ),
  ),
                          
                          ),
                
              ],
            ),
          ],
        ),
        backgroundColor: Theme.of(context).backgroundColor,
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
                'RECRUITMENTS',
                style: GoogleFonts.zillaSlab(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              alignment: Alignment.center,
            )
          : Align(
              child: Text(
                'RECRUITMENTS',
                style: GoogleFonts.zillaSlab(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              alignment: Alignment.center,
            ),
    ),
  );
}


 


