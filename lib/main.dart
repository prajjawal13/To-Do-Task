import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../page/home_page.dart';
import '../provider/todos.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  static final String title = 'Todo Task App';

  @override
  Widget build(BuildContext context) => ChangeNotifierProvider(
        create: (context) => TodosProvider(),
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: title,
          theme: ThemeData(
            primarySwatch: Colors.pink,
            scaffoldBackgroundColor: Color(0xFFf6f5ee),
          ),     
          home: AnimatedSplashScreen(
            splash: Column(
              children: [
                 Icon(
                 Icons.note, 
                 size: 100,
              color: Color.fromARGB(255, 75, 10, 228),
               ),
                Text(MyApp.title,style: TextStyle(fontSize: 24,fontWeight: FontWeight.bold),
                )
              ],
            ), nextScreen: HomePage(),
            splashIconSize: 150,
            duration: 4000,
            splashTransition: SplashTransition.slideTransition,
            ),
        ),
  );
    
}
