import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:intl/intl.dart';
import 'package:noteapp/utils/appsections.dart';

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
  //step 2
  var box = Hive.box(Appsections.NOTEBOX);
  List notekeys = []; //to store keys

  @override
  void initState() {
    notekeys = box.keys.toList();

    setState(() {}); //to set initial vallu
    // TODO: implement initState
    super.initState();
  }

  @override
    Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: ListView.separated(
            padding: EdgeInsets.all(10),
            itemBuilder: (context, index) {

              var currentnot=box.get(notekeys[index]);
              return NoteCard(
              noteColor: Dummydb
                  .noteColors[(currentnot)['ColorIndex']],
              // from dummy db to notecard
              title: currentnot['title'],
              des: currentnot['des'],   
              date: currentnot['date'],
              ondelete: () {
                setState(() {
               box.delete(notekeys[index]);
               notekeys = box.keys.toList();
               

                });
              },
              onedit: () {
                //controller is single
                selectedIndex = currentnot['ColorIndex'];
            
                titlecontroller.text = currentnot['title'];
                descontroller.text = currentnot['des'];
                datecontroller.text = currentnot['date'];        
                //OR
                //  titlecontroller =TextEditingController(text: Dummydb.notlist[index]['title'] );
                //  titlecontroller =TextEditingController(text: Dummydb.notlist[index]['title'] );
                //  titlecontroller =TextEditingController(text: Dummydb.notlist[index]['title'] );
                customBttomSheet(context, isedit: true, itemindex: index);
              },
            );
            },
            separatorBuilder: (context, index) => SizedBox(
                  height: 10,
                ),
            itemCount: notekeys.length),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            selectedIndex = 0;

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
                    readOnly: true,
                    decoration: InputDecoration(
                      
                      suffixIcon: IconButton( onPressed: () async{ 
                       var date=  await showDatePicker(context: context, firstDate:DateTime(2000), lastDate: DateTime.now());
                       if (date!=null) {
                         String showdate= DateFormat('dd/MM/yyyy').format(date);
                         datecontroller.text=showdate;
                       }
                       }, icon: Icon(Icons.calendar_month),),
                      
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
                                ? box.put(notekeys[itemindex!], {'title': titlecontroller.text,
                                   'des': descontroller.text,
                                   'date': datecontroller.text,
                                    'ColorIndex': selectedIndex
                                    })
                                 //Dummydb.notlist[itemindex!] = {
                                  //  'title': titlecontroller.text,
                                  //  'des': descontroller.text,
                                  //  'date': datecontroller.text,
                                  //   'ColorIndex': selectedIndex
                                //  }
                                : box.add({
                                    'title': titlecontroller.text,
                                    'des': descontroller.text,
                                    'date': datecontroller.text,
                                    'ColorIndex': selectedIndex
                                  }); //step 3

                            notekeys = box.keys.toList();
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
