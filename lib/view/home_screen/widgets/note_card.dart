import 'package:flutter/material.dart';

class NoteCard extends StatelessWidget {
  const NoteCard({super.key});

  @override
  Widget build(BuildContext context) {
    return  Container(
        padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
              color: Colors.amber, borderRadius: BorderRadius.circular(20)),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'data',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),Spacer(),
                  IconButton(onPressed: (){}, icon: Icon(Icons.edit)),
                  IconButton(onPressed: (){}, icon: Icon(Icons.delete)),

                ],
              ),
              Text('data'),
              Row(mainAxisAlignment: MainAxisAlignment.end,
                children: [Text('data'),Icon(Icons.share)],)
              
            ],
          ));
  }
}