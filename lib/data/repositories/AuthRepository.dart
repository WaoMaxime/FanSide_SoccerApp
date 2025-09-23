import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AuthRepository {
  final FirebaseAuth _auth;
  final FirebaseFirestore _firestore;

  AuthRepository(this._auth, this._firestore);

  Stream<User?> get authStateChanges => _auth.authStateChanges();

  Future<User?> signInWithEmail(String email, String password) async {
    final credential = await _auth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    return credential.user;
  }

  Future<User?> signUpWithEmail(String email, String password) async {
    final credential = await _auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    final user = credential.user;
    if (user != null) {
      await _createUserProfile(user);
    }
    return user;
  }

  Future<void> signOut() async {
    await _auth.signOut();
  }

  Future<void> _createUserProfile(User user) async {
    final userDoc = _firestore.collection('users').doc(user.uid);
    await userDoc.set({
      'email': user.email,
      'createdAt': FieldValue.serverTimestamp(),
      'username': user.email!.split('@')[0],
    });
  }
}
