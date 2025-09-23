import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/repositories/AuthRepository.dart';
import 'LoginStateNotifier.dart';
import 'LoginState.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


final firebaseAuthProvider = Provider<FirebaseAuth>((ref) {
  return FirebaseAuth.instance;
});

final firebaseFirestoreProvider = Provider<FirebaseFirestore>((ref) => FirebaseFirestore.instance);

final authRepositoryProvider = Provider<AuthRepository>((ref) {
  final auth = ref.read(firebaseAuthProvider);
  final firestore = ref.read(firebaseFirestoreProvider);
  return AuthRepository(auth, firestore);
});

final loginProvider =
StateNotifierProvider<LoginStateNotifier, LoginState>((ref) {
  final authRepository = ref.read(authRepositoryProvider);
  return LoginStateNotifier(authRepository);
});
