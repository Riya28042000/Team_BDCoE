import 'package:bdcoe/Scrollglow/scroll.dart';
import 'package:bdcoe/navigation/navigation.dart';
import 'package:bdcoe/notifiers/dark.dart';
import 'package:bdcoe/notifiers/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
void main() {
// To display application in potrait mode only
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) { runApp(MyApp());
    // runApp(MaterialApp(
    //   //Root widget of our App
      
    //   home: BottomNavBar(),
    //   debugShowCheckedModeBanner: false,
    // ));
  });
}
class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  DarkThemeProvider themeChangeProvider = new DarkThemeProvider();

  @override
  void initState() {
    super.initState();
    getCurrentAppTheme();
  }

  void getCurrentAppTheme() async {
    themeChangeProvider.darkTheme =
        await themeChangeProvider.bdcoe.getTheme();
  }

  @override
  Widget build(BuildContext context) {
     
    return MultiProvider(
           providers: [
        ChangeNotifierProvider(
          create: (_)=> themeChangeProvider, )
      ],
      child: Consumer<DarkThemeProvider>(
        builder: (BuildContext context, value, Widget child) {
        
          return MaterialApp(
            builder: (context, child) {
        //Remove Scroll Glow from our App
        return ScrollConfiguration(
          behavior: MyBehavior(),
          child: child,
        );
      },
      title: 'BDCoE',
            debugShowCheckedModeBanner: false,
            theme: Styles.themeData(themeChangeProvider.darkTheme, context),
            
            home: BottomNavBar()
          );
            },
          ),
        
      );
    
  }
}