import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:journal_app/data/data.dart';
import 'package:journal_app/providers/auth_pprovider.dart';
import 'package:journal_app/providers/journal_entry_provider.dart';
import 'package:journal_app/screens/login_screen.dart';
import 'package:journal_app/widget/add_entry_bottom_sheet.dart';
import 'package:journal_app/widget/journal_card_widget.dart';

class JournalHomeScreen extends ConsumerStatefulWidget {
  const JournalHomeScreen({super.key});

  @override
  ConsumerState<JournalHomeScreen> createState() => _JournalHomeScreenState();
}

class _JournalHomeScreenState extends ConsumerState<JournalHomeScreen> {
  @override
  Widget build(BuildContext context) {
    final entriesValue = ref.watch(journalEntryStateProvider);

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
        actions: [
          IconButton(
            onPressed: () async {
              final shouldLogout = await showDialog<bool>(
                context: context,
                builder: (dialogContext) => AlertDialog(
                  title: const Text('Log out?'),
                  content: const Text('Are you sure you want to log out?'),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(dialogContext, false),
                      child: const Text('Cancel'),
                    ),
                    TextButton(
                      onPressed: () => Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(
                          builder: (context) => LoginScreen(),
                        ),
                        (route) => false,
                      ),
                      child: const Text('Log out'),
                    ),
                  ],
                ),
              );

              if (shouldLogout == true && context.mounted) {
                try {
                  await ref.read(authServiceProvider).logoutUser();
                } catch (error) {
                  if (context.mounted) {
                    ScaffoldMessenger.of(
                      context,
                    ).showSnackBar(SnackBar(content: Text(error.toString())));
                  }
                }
              }
            },
            icon: const Icon(Icons.logout, color: Colors.white),
          ),
        ],
      ),
      body: entriesValue.when(
        data: (journalList) {
          if (journalList == null || journalList.isEmpty) {
            return const Center(
              child: Text('No journal entries found.'),
            );
          } else {
            return ListView.builder(
              itemCount: journalList.length,
              itemBuilder: (context, index) {
                return Journal_Enter_Card(entry: journalList[index]);
              },
            );
          }
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stackTrace) => Center(
          child: Text('Error fetching journal entries: $error'),
        ),
      ),
      // body: ListView.builder(
      //   itemCount: journalList.length,
      //   itemBuilder: (context, index) {
      //     return Journal_Enter_Card(entry: journalList[index]);
      //   },
      // ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
            ),
            builder: (context) {
              return AddEntryBottomSheet(
                onSave: (entry) {
                  // call api to save the entry
                  try{
                    ref.read(journalEntryServiceProvider).addJournalEntry(entry);
                    //Navigator.pop(context);
                  } catch (error) {
                    if (context.mounted) {
                      ScaffoldMessenger.of(
                        context,
                      ).showSnackBar(SnackBar(content: Text("Failed to save journal entry: ${error.toString()}")));
                    }
                  }
                  // setState(() {
                  //   journalList.add(entry);
                  // });
                },
              );
            },
          );
        },
        backgroundColor: const Color.fromARGB(255, 125, 103, 95),
        focusColor: Colors.brown,
        hoverColor: Colors.cyanAccent,
        child: Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}
