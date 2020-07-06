import 'package:bdcoe/chat/authorize.dart';
import 'package:bdcoe/chat/login.dart';
import 'package:bdcoe/navigation/navigation.dart';
import 'package:bdcoe/notifiers/dark.dart';
import 'package:circular_reveal_animation/circular_reveal_animation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class Register extends StatefulWidget {
  @override
  _Register createState() => _Register();
}

GlobalKey<FormState> validatekey = GlobalKey<FormState>();
final _scaffoldKey = GlobalKey<ScaffoldState>();
AuthMethods authMethods= AuthMethods();
  
   final databaseReference = Firestore.instance;
class _Register extends State<Register> with TickerProviderStateMixin {
  bool validateAndSave() {
    final FormState form = validatekey.currentState;
    if (form.validate()) {
      form.save();
      return true;
    }
    return false;
  }
bool isLoading= false;
 signMeUp(String email, String password) async{

    setState(() {
      isLoading=true;
    });

   await authMethods.signUpwithEmailAndPassword(email, password).then((value){
      // print("${value.userId}"),
      //upload data to firestore
     if(value!=null){
       


        
         
    databaseReference.collection("register")
        .add({
          'name': name,
          'email': email,
    
        }).then((onValue){
                   setState(() {
      isLoading=false;
    });
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
            desc: "Registered Successfully!",
            buttons: [
              DialogButton(
                color: Color(0xff3671a4),
                child: Text(
                  "OK",
                  style: GoogleFonts.zillaSlab(fontSize: 20,color: Colors.white),
                ),
                onPressed: () => Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => Login()),
        (Route<dynamic> route) => false)
              )
            ],
          ).show();
        }).catchError((onError){
          
        });
    //print(ref.documentID);
      
    //  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>UserAd()));
     
     }
     else{
           Alert(
            context: context,
            
            type: AlertType.error,
            title: "ERROR",
            style:AlertStyle(
      animationType: AnimationType.fromTop,
      backgroundColor: Theme.of(context).cardColor,
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
            desc: "Already Registered!",
            buttons: [
              DialogButton(
                color: Color(0xff3671a4),
                child: Text(
                  "OK",
                  style: GoogleFonts.zillaSlab(fontSize: 20,color: Colors.white),
                ),
                onPressed: () => Navigator.of(context).pop()
              )
            ],
          ).show();
setState(() {
      isLoading=false;
    });
     }
     
    });


  }
   String email;
    String name;
    String password;
    String confirm;
    bool passwordVisible = true;
    bool pass = true;
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
    return isLoading?Container(
      color: themeProvider.darkTheme?Colors.black:Colors.white,
      child: Center(child: SpinKitChasingDots(
                      itemBuilder: (BuildContext context, int index) {
                        return DecoratedBox(
                          decoration: BoxDecoration(
                            color: themeProvider.darkTheme
                                ? Colors.white
                                : Colors.black,
                          ),
                        );
                      },
                    ),),):WillPopScope(
      onWillPop: MoveToLastScreen,
      child: Container(
        color: Theme.of(context).primaryColor,
        child: SafeArea(
          child: Scaffold(
         //  resizeToAvoidBottomInset:false,
            key: _scaffoldKey,
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
                        flex: 15,
                        child: _description(
                          context,
                          themeProvider,
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

  Widget _description(context, DarkThemeProvider themeProvider) {
   

    _displaySnackBar(BuildContext context, String a) {
      final snackBar = SnackBar(
        content: Text(a,style: GoogleFonts.zillaSlab(color:themeProvider.darkTheme
                                    ? Colors.black
                                    : Colors.white,fontWeight: FontWeight.bold) ,textAlign: TextAlign.center),
        backgroundColor: themeProvider.darkTheme
                                    ? Colors.white
                                    : Colors.black,
      );
      _scaffoldKey.currentState.showSnackBar(snackBar);
    }

    var size = MediaQuery.of(context).size;

    return Container(
      child: Padding(
        padding: const EdgeInsets.only(left: 15, right: 15),
        child: Container(
          height: size.height / 1,
          width: size.width / 1.1,
          child: Center(
              child: Padding(
            padding: const EdgeInsets.only(left:20,right: 20),
            child: Padding(
              padding: const EdgeInsets.only(left:10,right:10,bottom:10),
              child: Form(
                key: validatekey,
                child: SingleChildScrollView(
                                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        
                        Container(
    child: Container(
      margin: EdgeInsets.all(8),
      height: size.height / 8,
      width: size.width / 2,
      child: themeProvider.darkTheme
          ? Align(
              child: Text(
                    'REGISTER',
                    style: GoogleFonts.zillaSlab(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              alignment: Alignment.center,
            )
          : Align(
              child: Text(
                    'REGISTER',
                    style: GoogleFonts.zillaSlab(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              alignment: Alignment.center,
            ),
    ),
  ),
                       
                       Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10.0),
                          child: TextFormField(
                            style: GoogleFonts.zillaSlab(
                                //  color: Colors.white,
                                ),
                            validator: (value) {
                              if (value == null) {
                                return "Enter Username";
                              } else
                                return null;
                            },
                            //
                            cursorColor: themeProvider.darkTheme
                                ? Colors.white
                                : Colors.black,
                            keyboardType: TextInputType.text,
                            textCapitalization: TextCapitalization.words,
                            decoration: InputDecoration(
                              // fillColor: Color(0xffefb168),
                              hintText: "Name",
                              alignLabelWithHint: true,
                              labelText: "Name",
                              hintStyle: GoogleFonts.zillaSlab(
                                  color: themeProvider.darkTheme
                    ? Colors.white
                    : Colors.black,fontWeight: FontWeight.bold),
                              labelStyle: GoogleFonts.zillaSlab(
                                  color: themeProvider.darkTheme
                    ? Color(0xff3671a4)
                    : Color(0xff3671a4),fontWeight: FontWeight.bold),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                  color: themeProvider.darkTheme
                      ? Colors.white
                      : Colors.black,
                  style: BorderStyle.solid,
                  width: 2),
                                borderRadius: BorderRadius.circular(15.0),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                   color: themeProvider.darkTheme
                      ? Colors.white
                      : Colors.black,
                  style: BorderStyle.solid,
                  width: 2),
                                borderRadius: BorderRadius.circular(25.0),
                              ),
                            ),
                            onSaved: (value) {
                              name = value;
                            },
                          ),
                        ),
                       SizedBox(height:15),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10.0),
                          child: TextFormField(
                            style: GoogleFonts.zillaSlab(
                                //  color: Colors.white,
                                ),
                            validator: (value) {
                              if (value == null) {
                                return "Enter Username";
                              } else
                                return null;
                            },
                            //
                            cursorColor: themeProvider.darkTheme
                                ? Colors.white
                                : Colors.black,
                            keyboardType: TextInputType.emailAddress,
                            decoration: InputDecoration(
                              // fillColor: Color(0xffefb168),
                              hintText: "Email",
                              alignLabelWithHint: true,
                              labelText: "Email",
                              hintStyle: GoogleFonts.zillaSlab(
                                  color: themeProvider.darkTheme
                    ? Colors.white
                    : Colors.black,fontWeight: FontWeight.bold),
                              labelStyle: GoogleFonts.zillaSlab(
                                  color: themeProvider.darkTheme
                    ? Color(0xff3671a4)
                    : Color(0xff3671a4),fontWeight: FontWeight.bold),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                  color: themeProvider.darkTheme
                      ? Colors.white
                      : Colors.black,
                  style: BorderStyle.solid,
                  width: 2),
                                borderRadius: BorderRadius.circular(15.0),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                   color: themeProvider.darkTheme
                      ? Colors.white
                      : Colors.black,
                  style: BorderStyle.solid,
                  width: 2),
                                borderRadius: BorderRadius.circular(25.0),
                              ),
                            ),
                            onSaved: (value) {
                              email = value;
                            },
                          ),
                        ),
        
                        SizedBox(height:15),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10.0),
                          child: TextFormField(
                            style: GoogleFonts.zillaSlab(
                                //color: Colors.white,
                                ),
                            validator: (value) {
                              if (value == null) {
                                return "Enter Password";
                              } else
                                return null;
                            },
                            keyboardType: TextInputType.text,
                            cursorColor: themeProvider.darkTheme
                                ? Colors.white
                                : Colors.black,
                            obscureText: passwordVisible,
                            decoration: InputDecoration(
                              // fillColor: Color(0xffefb168),
                                 enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                  color: themeProvider.darkTheme
                      ? Colors.white
                      : Colors.black,
                  style: BorderStyle.solid,
                  width: 2),
                                borderRadius: BorderRadius.circular(15.0),
                              ),
                              hintText: "Password",
                              alignLabelWithHint: true,
                              labelText: "Password",
                              hintStyle: GoogleFonts.zillaSlab(
                                  color: themeProvider.darkTheme
                    ? Colors.white
                    : Colors.black,fontWeight: FontWeight.bold),
                              labelStyle: GoogleFonts.zillaSlab(
                                  color: themeProvider.darkTheme
                    ?Color(0xff3671a4)
                    : Color(0xff3671a4),fontWeight: FontWeight.bold),
                              //     hintStyle: GoogleFonts.aBeeZee(color:Colors.grey),
                              suffixIcon: IconButton(
                                icon: Icon(
                                  // Based on passwordVisible state choose the icon

                                  passwordVisible
                    ? Icons.visibility_off
                    : Icons.visibility,
                                  color: themeProvider.darkTheme
                    ? Colors.white
                    : Colors.black,
                                ),
                                onPressed: () {
                                  // Update the state i.e. toogle the state of passwordVisible variable
                                  setState(() {
                  passwordVisible = !passwordVisible;
                                  });
                                },
                              ),
                              //labelStyle: GoogleFonts.zillaSlab(color:Colors.white),
                         
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                  color: themeProvider.darkTheme
                      ? Colors.white
                      : Colors.black,
                  style: BorderStyle.solid,
                  width: 2),
                                borderRadius: BorderRadius.circular(25.0),
                              ),
                            ),
                            onSaved: (value) {
                              password = value;
                            },
                          ),
                        ),
                          
                       SizedBox(height:15),
                         Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10.0),
                          child: TextFormField(
                            style: GoogleFonts.zillaSlab(
                                //color: Colors.white,
                                ),
                            validator: (value) {
                              if (value == null) {
                                return "Enter Password";
                              } else
                                return null;
                            },
                            keyboardType: TextInputType.text,
                            cursorColor: themeProvider.darkTheme
                                ? Colors.white
                                : Colors.black,
                            obscureText: pass,
                            decoration: InputDecoration(
                              // fillColor: Color(0xffefb168),
                                 enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                  color: themeProvider.darkTheme
                      ? Colors.white
                      : Colors.black,
                  style: BorderStyle.solid,
                  width: 2),
                                borderRadius: BorderRadius.circular(15.0),
                              ),
                              hintText: "Confirm Password",
                              alignLabelWithHint: true,
                              labelText: "Confirm Password",
                              hintStyle: GoogleFonts.zillaSlab(
                                  color: themeProvider.darkTheme
                    ? Colors.white
                    : Colors.black,fontWeight: FontWeight.bold),
                              labelStyle: GoogleFonts.zillaSlab(
                                  color: themeProvider.darkTheme
                    ?Color(0xff3671a4)
                    : Color(0xff3671a4),fontWeight: FontWeight.bold),
                              //     hintStyle: GoogleFonts.aBeeZee(color:Colors.grey),
                              suffixIcon: IconButton(
                                icon: Icon(
                                  // Based on passwordVisible state choose the icon

                                  pass
                    ? Icons.visibility_off
                    : Icons.visibility,
                                  color: themeProvider.darkTheme
                    ? Colors.white
                    : Colors.black,
                                ),
                                onPressed: () {
                                  // Update the state i.e. toogle the state of passwordVisible variable
                                  setState(() {
                  pass = !pass;
                                  });
                                },
                              ),
                              //labelStyle: GoogleFonts.zillaSlab(color:Colors.white),
                         
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                  color: themeProvider.darkTheme
                      ? Colors.white
                      : Colors.black,
                  style: BorderStyle.solid,
                  width: 2),
                                borderRadius: BorderRadius.circular(25.0),
                              ),
                            ),
                            onSaved: (value) {
                              confirm = value;
                            },
                          ),
                        ),
          //  Padding(
          //    padding: EdgeInsets.only(
          //    bottom: MediaQuery.of(context).viewInsets.bottom)),
                        SizedBox(
                          height: 10,
                        ),
                        GestureDetector(
                          onTap: () {
                            print(email);
                            validatekey.currentState.save();
                             if(name?.isEmpty??true) 
                              {
                                 {  _displaySnackBar(context, "Please enter your Name");
                              
                                }
                              }

                            else if (email?.isEmpty ?? true) {
                              _displaySnackBar(context, "Please enter your Email");
                            } else if (!RegExp(
                  r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                .hasMatch(email))
                              _displaySnackBar(context, "Please Fill valid Email");
                            else if (password?.isEmpty ?? true)
                              _displaySnackBar(
                                  context, "Please enter your Password");
                            else
                              if(confirm?.isEmpty??true) 
                              {
                                 {  _displaySnackBar(context, "Enter Confirm Password");
                              
                                }
                              }
                               else  
                        if(password.compareTo(confirm)!=0){
                               _displaySnackBar(context, "Entered Password's don't match.");
                        }
                         else
                       if(password.length<8)
                        _displaySnackBar(context, "Password must be atleast 8 characters long");
                        else{
                          signMeUp(email,password);
                        }
                          },

                          child: Card(
                            color: themeProvider.darkTheme?Color(0xff3671a4):Color(0xff3671a4),
                              clipBehavior: Clip.antiAlias,
                              child: Container(
                                  width: MediaQuery.of(context).size.width / 1.5,
                                  child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Icon(Icons.person_add,color: Colors.white,),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "Register",
                          style: GoogleFonts.zillaSlab(
                            color: Colors.white,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                                  ))),
                        ),
                        /*RaisedButton(
                                  onPressed: () {
                                    loginFunction();
                                  },
                                  child: Text("Login"),
                                )*/
                      
                      SizedBox(height:5),
                     
//  Navigator.of(context).pushAndRemoveUntil(
//         MaterialPageRoute(builder: (context) => Forgot()),
//         (Route<dynamic> route) => false);
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
   
           Padding(
             padding: const EdgeInsets.only(top:8,bottom:8),
             child: Align(alignment: Alignment.bottomRight,child: Text('Already have an account?',style:GoogleFonts.zillaSlab(fontWeight: FontWeight.bold)),),
           ),
           GestureDetector(
             onTap: (){
            Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => Login()),
        (Route<dynamic> route) => false);

             },
             child:  Padding(
             padding: const EdgeInsets.only(top:8,bottom:8),
             child: Align(alignment: Alignment.bottomRight,child: Text(' Click Here',style:GoogleFonts.zillaSlab(fontWeight: FontWeight.bold,color: Color(0xff3671a4))),),
           ),
           )
            
              ],
            )
            
                      ],
                    ),
                ),
              ),
            ),
          )),
        ),
      ),
    );
  }
}

