import 'package:cloud_firestore/cloud_firestore.dart';

class JournalEntryModel
{
  final int id;
  final String title;
  final String content;
  final String date;

  JournalEntryModel({
    required this.id,
    required this.title,
    required this.content,
    required this.date,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'content': content,
      'date': date,
    };
  }
  

  factory JournalEntryModel.fromFireStore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return JournalEntryModel(
      id: data['id'],
      title: data['title'],
      content: data['content'],
      date: data['date'],
    );
  }
}