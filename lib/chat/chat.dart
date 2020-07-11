import 'dart:async';
import 'package:bdcoe/chat/login.dart';
import 'package:bdcoe/chat/preference.dart';
import 'package:bdcoe/modals/database.dart';
import 'package:bdcoe/navigation/navigation.dart';
import 'package:bdcoe/notifiers/dark.dart';
import 'package:circular_reveal_animation/circular_reveal_animation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Chatting extends StatefulWidget {
final String chatroomid;
  final String name;
  Chatting({this.chatroomid, this.name});
  
  @override
  State<StatefulWidget> createState() {
    print(name);
    print(chatroomid);
    return _ChattingState();
  }
}


class _ChattingState extends State<Chatting> with TickerProviderStateMixin {
 
Database databaseMethods = Database();
  Stream chatmessagestream;
 ScrollController _scrollController;
  final messageEditingController = TextEditingController();
  void logout() async {
    HelperFunctions.saveUserLoggedInSharedPreference(false);
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => Login()),
        (Route<dynamic> route) => false);
  }

  AnimationController animationController;
//ScrollController _controller = ScrollController();
  Animation<double> animation;
  bool cirAn = false;
  
  
  @override
  void initState() {
 databaseMethods.getConversationMessages(widget.chatroomid).then((value) {
      setState(() {
        chatmessagestream = value;
      });
    });
  _scrollController = ScrollController();
  
  
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
 
  Widget ChatmessageList() {
    return StreamBuilder(
        stream: chatmessagestream,
        builder: (context, snapshot) {
          return snapshot.hasData
              ? ListView.builder(
              controller: _scrollController,
                        reverse: true,
                        shrinkWrap: true,
                  itemCount: snapshot.data.documents.length,
                  itemBuilder: (context, index) {
                    
                    return MessageTile(
                        message: snapshot.data.documents[index].data["message"],
                        sendByMe:
                            snapshot.data.documents[index].data["sendBy"] ==
                                widget.name,
                          time:  snapshot.data.documents[index].data["time"],
                          hours: snapshot.data.documents[index].data["hours"],
                          min:  snapshot.data.documents[index].data["min"],

                                );
                  })
              : Container();
        });
  }

  sendmessage() {
     _scrollController.animateTo(
            0.0,
            curve: Curves.linear,
            duration: const Duration(milliseconds: 300),
          );
    if (messageEditingController.text.isNotEmpty) {
       
      
      Map<String, dynamic> messagemap = {
        "message": messageEditingController.text,
        "sendBy": widget.name,
        "time": DateTime.now().millisecondsSinceEpoch,
        "hours":DateTime.now().hour,
        "min": DateTime.now().minute,
      };
      databaseMethods.addConversationMessages(widget.chatroomid, messagemap);
      messageEditingController.text = "";
      
  //  Timer(Duration(milliseconds: 500),
  //           () => _controller.jumpTo(_controller.position.maxScrollExtent));
    }
  }
bool isLoading= false;

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
Widget chat(DarkThemeProvider themeProvider){
  return  Container(
     alignment: Alignment.bottomCenter,
 margin: EdgeInsets.only(left:15,right:15,bottom:3,top:2),
  width: MediaQuery
                  .of(context)
                  .size
                  .width,
                 
  child: Row(
    children: [
      Expanded(
        child: Container(
          decoration: BoxDecoration(
            color: themeProvider.darkTheme?Color(0xFF151515):Color(0xfff6fafb),
            borderRadius: BorderRadius.circular(25.0),
            boxShadow: [
              BoxShadow(
                  offset: Offset(0, 3),
                  blurRadius: 5,
                  color: themeProvider.darkTheme?Colors.black:Colors.grey,)
            ],
          ),
          child: Row(
            children: [
             SizedBox(width:2),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left:15),
                  child: TextField(
                       keyboardType: TextInputType.multiline,
                     maxLines: null,
                      style: TextStyle(fontFamily:'Zilla Slab',color: themeProvider.darkTheme?Colors.white:Colors.black,),
                     controller: messageEditingController,
                           cursorColor: themeProvider.darkTheme?Colors.white:Color(0xff00a1e2),
                           textCapitalization: TextCapitalization.sentences,
                           
                    decoration: InputDecoration(
                        hintText: "Type a message...",
                        hintStyle: TextStyle(fontFamily:'Zilla Slab',
                                  color:  themeProvider.darkTheme?Colors.white:Colors.black,
                                  fontSize: 16,
                                ),
                        border: InputBorder.none),
                  ),
                ),
              ),
              IconButton(
                icon: Icon(Icons.send,size:25,color: themeProvider.darkTheme?Colors.white:Color(0xff2479a7),),
                onPressed: () {
                     print(messageEditingController.text);
                          sendmessage();
                },
              ),
             
            ],
          ),
        ),
      ),
     
    ],
  ),
);
}
 
  Widget homeBody(DarkThemeProvider themeProvider) {
 
 
    return WillPopScope(
      onWillPop: MoveToLastScreen,
      child: Container(
        color: themeProvider.darkTheme?Colors.black:Colors.white,
        child: Scaffold(
        backgroundColor: themeProvider.darkTheme?Colors.black:Color(0xffedefef),

          appBar: AppBar(
            elevation: 10,
    title: Text('LET\'S CHAT',style: TextStyle(fontFamily:'Zilla Slab',
        fontSize: 18,
        color:themeProvider.darkTheme?Colors.white:Colors.white,
       

        fontWeight: FontWeight.bold
    ),),
            centerTitle: true,
           backgroundColor: themeProvider.darkTheme?Color(0xff1f1f1f):
            Color(0xff2479a7),
            automaticallyImplyLeading: false,
            actions: <Widget>[
              GestureDetector(
                onTap: () {
                  logout();
                },
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: Icon(Icons.exit_to_app,
                  color:themeProvider.darkTheme?Colors.white:Colors.white,
                  ),
                ),
              )
            ],
          ),
          body: 
    Stack(
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
                        flex: 12,
                        child: 
                        Container(
                  width: double.infinity,
                  height: double.infinity,
                //  color:Theme.of(context).primaryColor,
                  child: new Container(
                    child: new Column(
                      children: <Widget>[
                        Expanded(child: ChatmessageList()),
            
                     chat(themeProvider)   
                   ]
                    )
                  )
        ),
                        ),
                  ],
                ),
              ],
            ),

        ),
      ),
    );

  }
 
}


class MessageTile extends StatelessWidget {
  final String message;
  final bool sendByMe;
  final int time;
  final int hours;
  final int min;
  MessageTile({@required this.message, @required this.sendByMe,@required this.time,@required this.hours,@required this.min});


  @override
  Widget build(BuildContext context) {
    String len= '$min';
    len=len.length==1?"0"+"$len":len;
    print(len);
    final themeProvider = Provider.of<DarkThemeProvider>(context);
    return Container(
      padding: EdgeInsets.only(
          top: 8,
          bottom: 8,
          left: sendByMe ? 0 : 18,
          right: sendByMe ? 18 : 0),
      alignment: sendByMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: sendByMe
            ? EdgeInsets.only(left: 90)
            : EdgeInsets.only(right: 90),
        padding: EdgeInsets.only(
            top: 17, bottom: 17, left: 20, right: 20),
        decoration: BoxDecoration(
            borderRadius: sendByMe ? BorderRadius.only(
                topLeft: Radius.circular(12),
                topRight: Radius.circular(12),
                bottomLeft: Radius.circular(12),
                bottomRight: Radius.circular(3)
            ) :
            BorderRadius.only(
        topLeft: Radius.circular(12),
          topRight: Radius.circular(12),
          bottomRight: Radius.circular(12),
          bottomLeft: Radius.circular(3)
          ),
       color: sendByMe?(themeProvider.darkTheme?Color(0xff1f1f1f):Color(0xff2479a7)):(themeProvider.darkTheme?Color(0xff3671a4):Color(0xffdbdede)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            Text(message,
                textAlign: TextAlign.start,
                style: TextStyle(fontFamily:'Zilla Slab',
                color: sendByMe?(themeProvider.darkTheme?Colors.white:Colors.white):(themeProvider.darkTheme?Colors.white:Colors.black),
                fontSize: 16,
              //  fontWeight: FontWeight.bold
                )),
                Padding(
                  padding: const EdgeInsets.only(top:2),
                  child: Text('$hours:$len',textAlign: TextAlign.right, style: TextStyle(fontFamily:'Zilla Slab',
                color: sendByMe?(themeProvider.darkTheme?Colors.white:Colors.white):(themeProvider.darkTheme?Colors.white:Colors.black),
                fontSize: 11,)),
                )
          ],
        ),
      ),
    );
  }
}