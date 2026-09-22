
import 'package:flutter/material.dart';
import 'package:journal_app/data/journal_model.dart';

class Journal_Enter_Card extends StatelessWidget{
  final JournalEntryModel entry;
  const Journal_Enter_Card({required this.entry, super.key});

  @override
  Widget build(BuildContext constext){
    return Card(
      color:const Color.fromARGB(255, 236, 215, 221),
      margin: EdgeInsets.all(10), 
      elevation: 4,
      child:Padding(
        padding: EdgeInsetsGeometry.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
          Text(entry.title, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 10,),
          Text(entry.content, style:TextStyle(fontSize: 14, fontWeight: FontWeight.normal)),
          const SizedBox(height: 0,),
          Text(entry.date), 
        ],),
      )
    );
  } 
}