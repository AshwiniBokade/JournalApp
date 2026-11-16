import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:journal_app/Services/journal_entry_service.dart';
import 'package:journal_app/data/journal_model.dart';

//final journalEntryServiceProvider = Provider<JournalEntryService>((ref)=>JournalEntryService(ref));
final journalEntryServiceProvider = Provider<JournalEntryService>((ref){
  return JournalEntryService();
});


final journalEntryStateProvider = StreamProvider<List<JournalEntryModel>?>((ref) {
  final journalEntryService = ref.watch(journalEntryServiceProvider);
  return journalEntryService.fetchJournalEntries();
});