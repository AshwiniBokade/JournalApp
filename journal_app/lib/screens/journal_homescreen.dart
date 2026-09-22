import 'package:flutter/material.dart';
import 'package:journal_app/data/data.dart';
import 'package:journal_app/widget/add_entry_bottom_sheet.dart';
import 'package:journal_app/widget/journal_card_widget.dart';

class JournalHomeScreen extends StatefulWidget {
  const JournalHomeScreen({super.key}); 

  @override
  State<JournalHomeScreen> createState() => _JournalHomeScreenState();
}

class _JournalHomeScreenState extends State<JournalHomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.brown,
        title: const Text(
          'Journal App',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
      ),
      body: ListView.builder(
        itemCount: journalList.length,
        itemBuilder: (context, index){
          return Journal_Enter_Card(
            entry: journalList[index],
          );
        } 
      ),
      floatingActionButton: FloatingActionButton(onPressed: (){
        showModalBottomSheet(
          context: context,
          isScrollControlled: true,
          shape:RoundedRectangleBorder(
           borderRadius: BorderRadius.vertical(top:Radius.circular(20)),
          ),
          builder:(context){
            return AddEntryBottomSheet(
              onSave: (entry){ 
                 setState(() {
                  journalList.add(entry); 
                });
              },
            );
            },
            );
          }, 
      backgroundColor: const Color.fromARGB(255, 125, 103, 95), focusColor: Colors.brown,hoverColor: Colors.cyanAccent, child: Icon(Icons.add, color: Colors.white,),),  
    );
  }
}
