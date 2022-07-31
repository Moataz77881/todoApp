import 'package:flutter/material.dart';
import 'package:todo_app/myThemeData.dart';
import 'package:todo_app/ui/home/homeScreen.dart';


class myApp extends StatelessWidget {
  const myApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: myThemeData.lightTheme,
      routes:{
        homeScreen.routName : (BuildContext)=> homeScreen()
      },
      initialRoute: homeScreen.routName,
    );
  }
}
