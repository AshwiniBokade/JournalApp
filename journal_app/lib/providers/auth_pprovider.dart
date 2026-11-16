import 'package:firebase_auth/firebase_auth.dart';
import 'package:journal_app/Services/auth_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final authServiceProvider = Provider<AuthService>((ref)=>AuthService(ref));

final authStateProvider = StreamProvider<User?>((ref) => FirebaseAuth.instance.authStateChanges());