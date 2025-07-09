import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';

class NoteCard extends StatelessWidget {
  NoteCard(
      {super.key,
      this.ondelete,
      required this.title,
      required this.des,
      required this.date,
      this.onedit, required this.noteColor});
  final String title;
  final String des;
  final String date;
  final Color noteColor;

  final void Function()? ondelete;
  final void Function()? onedit;

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
            color: noteColor, borderRadius: BorderRadius.circular(20)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  title,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
                Spacer(),
                IconButton(
                    onPressed: onedit,
                    icon: Icon(
                      Icons.edit,
                    )),
                IconButton(onPressed: ondelete, icon: Icon(Icons.delete)),
              ],
            ),
            Text(
              des,
              maxLines: 4,
              style: TextStyle(overflow: TextOverflow.ellipsis),
            ),
            Row(mainAxisAlignment: MainAxisAlignment.end, children: [
              Text(date),
              IconButton(
                  onPressed: () {
                    SharePlus.instance.share(ShareParams(
                        text: "$title \n $des \n$date"));
                  },
                  icon: Icon(Icons.share))
            ])
          ],
        ));
  }
}
