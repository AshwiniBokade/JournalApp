import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:journal_app/providers/auth_pprovider.dart';
import 'package:journal_app/screens/journal_homescreen.dart';
import 'package:journal_app/screens/login_screen.dart';

class AuthWrapper extends ConsumerWidget {
  const new({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authStateProvider);
    return authState.when(
      data: (user) => user != null ? const JournalHomeScreen() : LoginScreen(),
      error: (err, stack) =>
          Scaffold(body: Center(child: Text("Something went wrong! $err"))),
      loading: () =>
          const Scaffold(body: Center(child: CircularProgressIndicator())),
    );
  }
}
