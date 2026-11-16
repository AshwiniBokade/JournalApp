import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:journal_app/data/journal_model.dart';

class JournalEntryService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  // Add a new journal entry to Firestore
  Future<void> addJournalEntry(JournalEntryModel entry) async {
    try {
      final userId = firebaseAuth.currentUser!.uid;
      if (userId == null) {
        throw Exception("User not logged in");
      } else {
        await _firestore
            .collection('users')
            .doc(userId)
            .collection('journal_entries')
            .add(entry.toMap());
      }
    } catch (e) {
      throw Exception("Failed to add journal entry: $e");
    }
  }

  // Fetch all journal entries for the current user
  Stream<List<JournalEntryModel>> fetchJournalEntries() {
    try 
    {   final userId = firebaseAuth.currentUser!.uid; 
        if (userId == null) {
          throw Exception("User not logged in");
        }
        else
        {
        var _snapshots = _firestore
            .collection('users')
            .doc(userId)
            .collection('journal_entries')
            .snapshots().
            map(
              (snapshot)=> snapshot.docs
                .map((doc) => JournalEntryModel.fromFireStore(doc))
                .toList(),);
        return _snapshots;
        }
      }  
    catch (e) {
      throw Exception("Failed to fetch journal entries: $e");
    }
  }
}
