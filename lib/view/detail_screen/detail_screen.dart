
import 'package:flutter/material.dart';

class DetailScreen extends StatelessWidget {
   DetailScreen({super.key, required this.title, required this.des, required this.date, required this.detailColor});
  final String title;
  final String des;
  final String date;
  final Color detailColor;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: detailColor,
      appBar: AppBar(title:Text(title),),
    );
  }
}