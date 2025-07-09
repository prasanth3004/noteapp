import 'package:flutter/material.dart';
import 'package:noteapp/view/detail_screen/detail_screen.dart';
import 'package:noteapp/view/dummydb.dart';
import 'package:noteapp/view/home_screen/widgets/note_card.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController titlecontroller = TextEditingController();
  TextEditingController descontroller = TextEditingController();
  TextEditingController datecontroller = TextEditingController();
  int selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: ListView.separated(
            padding: EdgeInsets.all(10),
            itemBuilder: (context, index) => InkWell(
              onTap: () =>Navigator.push( context,MaterialPageRoute(builder: (context) => DetailScreen(title: Dummydb.notlist[index]['title'], des: Dummydb.notlist[index]['des'], date: Dummydb.notlist[index]['date'], detailColor: Dummydb.noteColors[Dummydb.notlist[index]['ColorIndex']],),)) ,
              child: NoteCard(
                 noteColor:Dummydb.noteColors[Dummydb.notlist[index]['ColorIndex']],
              // from dummy db to notecard
                    title: Dummydb.notlist[index]['title'],
                    des: Dummydb.notlist[index]['des'],
                    date: Dummydb.notlist[index]['date'],
                    ondelete: () {
                      setState(() {
                        Dummydb.notlist.removeAt(index);
                      });
                    },
                    onedit: () {
                      //controller is single
                      selectedIndex=Dummydb.notlist[index]['ColorIndex'];
              
                      titlecontroller.text = Dummydb.notlist[index]['title'];
                      descontroller.text = Dummydb.notlist[index]['des'];
                      datecontroller.text = Dummydb.notlist[index]['date'];
                      //OR
                      //  titlecontroller =TextEditingController(text: Dummydb.notlist[index]['title'] );
                      //  titlecontroller =TextEditingController(text: Dummydb.notlist[index]['title'] );
                      //  titlecontroller =TextEditingController(text: Dummydb.notlist[index]['title'] );
                      customBttomSheet(context, isedit: true, itemindex: index);
                    },
                    
                  ),
            ),
            separatorBuilder: (context, index) => SizedBox(
                  height: 10,
                ),
            itemCount: Dummydb.notlist.length),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
           selectedIndex=0;

            titlecontroller
                .clear(); // to clear controller before opening bottoum sheet
            descontroller.clear();
            datecontroller.clear();

            customBttomSheet(context);
          },
          child: Icon(Icons.add),
        ),
      ),
    );
  }

//refatoring the methord//extract  methord
  Future<dynamic> customBttomSheet(BuildContext context,
      {bool isedit = false, int? itemindex}) {
    return showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (context) {
          return Padding(
            padding: EdgeInsets.all(10),
            child: Padding(
              padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context)
                      .viewInsets
                      .bottom), //kannunna vare pading kodukkuka

              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextField(
                    controller: titlecontroller,
                    decoration: InputDecoration(
                      labelText: 'Title',
                      border: OutlineInputBorder(
                          borderSide: BorderSide(),
                          borderRadius: BorderRadius.circular(15)),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextField(
                    controller: descontroller,
                    maxLines: 5,
                    decoration: InputDecoration(
                      labelText: 'Description',
                      border: OutlineInputBorder(
                          borderSide: BorderSide(
                              // width: 1,
                              ),
                          borderRadius: BorderRadius.circular(15)),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextField(
                    controller: datecontroller,
                    decoration: InputDecoration(
                      labelText: 'Date',
                      border: OutlineInputBorder(
                          borderSide: BorderSide(),
                          borderRadius: BorderRadius.circular(15)),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  //build color section
                  StatefulBuilder(
                    builder: (context, SetColorState) => Row(
                      children: List.generate(
                          Dummydb.noteColors.length,
                          (index) => Expanded(
                                child: InkWell(
                                  child: Container(
                                    margin: EdgeInsets.symmetric(horizontal: 5),
                                    height: 50,
                                    width: 40,
                                    decoration: BoxDecoration(
                                      color: Dummydb.noteColors[index],
                                      borderRadius: BorderRadius.circular(10),
                                      border: selectedIndex == index
                                          ? Border.all()
                                          : null,
                                    ),
                                  ),
                                  onTap: () {
                                    selectedIndex = index;
                                    SetColorState(
                                      () {},
                                    );
                                  },
                                ),
                              )),
                    ),
                  ),

                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: InkWell(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              height: 40,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                color: Colors.red,
                              ),
                              child: Center(child: Text('cancel')),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Expanded(
                        child: InkWell(
                          onTap: () {
                            isedit
                                ? Dummydb.notlist[itemindex!] = {
                                    'title': titlecontroller.text,
                                    'des': descontroller.text,
                                    'date': datecontroller.text ,
                                     'ColorIndex': selectedIndex
                                  }
                                : Dummydb.notlist.add({
                                    'title': titlecontroller.text,
                                    'des': descontroller.text,
                                    'date': datecontroller.text,
                                    'ColorIndex': selectedIndex
                                  });
                            setState(() {});

                            Navigator.pop(context);
                          },
                          child: Container(
                            height: 40,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: Colors.green,
                            ),
                            child:
                                Center(child: Text(isedit ? 'Update' : 'save')),
                          ),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          );
        });
  }
}
