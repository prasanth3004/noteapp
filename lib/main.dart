import 'package:flutter/material.dart';

import 'package:hive_flutter/adapters.dart';
import 'package:noteapp/utils/appsections.dart';
import 'package:noteapp/view/splash_screen/splash_screen.dart';

void main(List<String> args) async{
//step1
  await Hive.initFlutter(); 
  var box=await Hive.openBox(Appsections.NOTEBOX) ; 
  runApp(MyApp());
}
class MyApp extends StatelessWidget { 
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}