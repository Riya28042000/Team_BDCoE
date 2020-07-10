import 'package:bdcoe/navigation/navigation.dart';
import 'package:bdcoe/notifiers/dark.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:circular_reveal_animation/circular_reveal_animation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_offline/flutter_offline.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


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
  Future <bool> MoveToLastScreen(){
   Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
                            BottomNavBar()), (Route<dynamic> route) => false);
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
    
    
  child:
    
     WillPopScope(
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
                      flex: 2,
                    ),
                    Container(
                        height:501, child: _description(context, themeProvider)),
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
                'OUR EVENTS',
                style: GoogleFonts.zillaSlab(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              alignment: Alignment.center,
            )
          : Align(
              child: Text(
                'OUR EVENTS',
                style: GoogleFonts.zillaSlab(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              alignment: Alignment.center,
            ),
    ),
  );
}

Widget _description(context, DarkThemeProvider themeProvider) {
Future gettoDo() async{
       var firestore= Firestore.instance;
       QuerySnapshot qn=  await firestore.collection("activity").getDocuments();
       return qn.documents;
    }
  var size = MediaQuery.of(context).size;

  return Padding(
      padding: const EdgeInsets.only(left: 15, right: 15),
      child: Container(
            height: 501 ,
            width: size.width / 1.1,
            child: FutureBuilder(
      future: gettoDo(),
      builder:( _, snapshot){
      if(snapshot.connectionState== ConnectionState.waiting){
        return  Center(child: SpinKitChasingDots(
  itemBuilder: (BuildContext context, int index) {
    return DecoratedBox(
  decoration: BoxDecoration(
    color: themeProvider.darkTheme ? Colors.white : Colors.black,
  ),
    );
  },
),);
         }
      else{
      return
         Column(
           crossAxisAlignment: CrossAxisAlignment.center,
           children: <Widget>[
             Flexible(
             
       child: new Swiper(
               
               itemBuilder: (BuildContext context, int index) {
                 return Padding(
                   padding: const EdgeInsets.only(left: 10, right: 10),
                   child: new Container(
                     
                     decoration: BoxDecoration(
                       // color: themeProvider.darkTheme
                     color:  themeProvider.darkTheme?Color(0xffc9cbcd):Color(0xff3671a4),
                       // : Color(0xff3972CF),
//                        border: Border(bottom: BorderSide(width: 1.0)),
                       borderRadius: BorderRadius.only(
                         topRight: Radius.circular(15.0),
                         topLeft: Radius.circular(15.0),
                         bottomRight: Radius.circular(15.0),
                         bottomLeft: Radius.circular(15.0),
                       ),
                     ),
                     child: Padding(
                       padding: const EdgeInsets.all(5.0),
                       child: Container(
                         child: GestureDetector(
                             onTap: () async {
                         const url =
                             'http://www.bdcoe.co.in/register';
                         if (await canLaunch(
                             url)) {
                           await launch(url);
                         }
                       },
                         child: Card(
                             clipBehavior: Clip.antiAlias,
                             elevation: 20,
                             // color: themeProvider.darkTheme
                             //   ? Colors.black
                             // : Colors.white,
                             child: Padding(
                               padding: const EdgeInsets.all(20.0),
                               child: Container(
                                 child: Column(
             children: <Widget>[
               AspectRatio(
                 aspectRatio: 65 / 70,
                 child:CachedNetworkImage(
    imageUrl: snapshot.data[index].data['img'],
    progressIndicatorBuilder: (context, url, downloadProgress) => 
      CircularProgressIndicator(value: downloadProgress.progress),
    errorWidget: (context, url, error) => Icon(Icons.error,size: 30,),
    fit: BoxFit.fill,
     ),
               ),
               SizedBox(
                 height: 20,
               ),
               Padding(
                 padding: const EdgeInsets.only(top:8),
                 child: Align(
                   child: Text(
                    snapshot.data[index].data['head'],
                     style: GoogleFonts.zillaSlab(
                         color: themeProvider.darkTheme
                             ? Color(0xff3671a4)
                             : Color(0xff3671a4),
                         fontSize: 16,
                         fontWeight: FontWeight.w500),
                   ),
                   alignment: Alignment.center,
                 ),
               ),
               SizedBox(
                 height: 10,
               ),
               Align(
                 child: Text(
                  snapshot.data[index].data['value'],
                   style: GoogleFonts.zillaSlab(
                       fontSize: 15,
                       fontWeight: FontWeight.w500),
                 ),
                 alignment: Alignment.center,
               ),
               SizedBox(height:10),

                Padding(
                     padding:
                         const EdgeInsets.only(
                             top: 20,
                             bottom: 10,
                             ),
                     child: Align(
                       child: Text(
                         'Tap to register yourself',
                         style: GoogleFonts.zillaSlab(
                             fontSize: 15,
                             fontWeight:
                                 FontWeight.w500,
                                 color:  Color(0xff3671a4)
                                 ),
                       ),
                       alignment: Alignment.center,
                     ),
                   ),
             
             ],
                                 ),
                               ),
                             )),
                       ),
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
           ],
         );
      }
            })));
}
