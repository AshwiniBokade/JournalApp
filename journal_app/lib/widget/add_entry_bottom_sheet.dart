import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:journal_app/data/journal_model.dart';

class AddEntryBottomSheet extends StatefulWidget{

  final Function(JournalEntryModel) onSave; 
  const AddEntryBottomSheet({required this.onSave, super.key});

  @override
  State<StatefulWidget> createState() => _AddEntryBottomSheetState(); 
}
class _AddEntryBottomSheetState extends State<AddEntryBottomSheet>{

  TextEditingController titleController = TextEditingController();
  TextEditingController contentController = TextEditingController(); 

  void printAll(){
     print(titleController.text) ;
     print(contentController.text) ; 
  }

  @override
  Widget build(BuildContext context){
    return Container(
      color:Colors.white,
      child: Padding( 
        padding: const EdgeInsets.only(top: 50, bottom: 50, left: 20, right: 20),
        child: Container(
          color:Colors.white,
          child: Column(children: [
            TextField(controller: titleController, decoration: InputDecoration(fillColor: Colors.purple, labelText: "Title", border: OutlineInputBorder()),),
            SizedBox(height: 20,),
            TextField(controller: contentController, decoration: InputDecoration(fillColor: Colors.purple, labelText: "Content", border: OutlineInputBorder()),),
            SizedBox(height: 20,), 

            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              OutlinedButton(onPressed:(){
                Navigator.pop(context);
              }, child: Text('Cancel',style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold))), 
              ElevatedButton(onPressed:(){
                //Save Data
                JournalEntryModel entry = JournalEntryModel(id: 5,title: titleController.text,content: contentController.text, date: DateFormat('dd MMM yyyy').format(DateTime.now()));
                //to update state
                // setState(() {
                //   journalList.add(entry); 
                // });
                widget.onSave(entry); 
                Navigator.pop(context);}, child: Text('Save',style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold))) 
            ],),
            SizedBox(height: 20,),
            Text(titleController.text , style:TextStyle(color: Colors.black,)),
        
          ],),
        ),
      ),
    );
  }
}
  
