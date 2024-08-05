import 'package:flutter/material.dart';
import 'package:noteapp/view/home_screen/widgets/note_card.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.separated(
          padding: EdgeInsets.all(10),
          itemBuilder: (context, index) => NoteCard(),
          separatorBuilder: (context, index) => SizedBox(
                height: 10,
              ),
          itemCount: 10),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
              isScrollControlled: true,
              context: context,
              builder: (context) {
                return Column(
               
                  children: [
                    TextField(
                      decoration: InputDecoration(),
                    ),
                    TextField()
                  ],
                );
              });
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
