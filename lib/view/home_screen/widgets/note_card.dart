import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class NoteCard extends StatefulWidget {
  NoteCard(
      {super.key,
      this.ondelete,
      required this.title,
      required this.des,
      required this.date});
  final String title;
  final String des;
  final String date;

  final void Function()? ondelete;

  @override
  State<NoteCard> createState() => _NoteCardState();
}

class _NoteCardState extends State<NoteCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
            color: Colors.amber, borderRadius: BorderRadius.circular(20)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  widget.title,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
                Spacer(),
                IconButton(onPressed: () {}, icon: Icon(Icons.edit)),
                IconButton(onPressed:widget.ondelete, icon: Icon(Icons.delete)),
              ],
            ),
            
            Text(widget.title),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [Text(widget.date), Icon(Icons.share)],
            )
          ],
        ));  
  }
}
