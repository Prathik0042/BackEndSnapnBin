// ignore_for_file: no_leading_underscores_for_local_identifiers, avoid_print

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sign_in_button/sign_in_button.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  User? _user;

  @override
  void initState() {
    super.initState();
    _auth.authStateChanges().listen((event) {
      if (event != null) {
        _user = event;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
        backgroundColor: Colors.amber[300],
      ),
      body: (_user != null) ? _userInfo() : _googleSignInButton(),
    );
  }

  Widget _googleSignInButton() {
    return Center(
      child: SizedBox(
        height: 50,
        child: SignInButton(
          Buttons.google,
          text: "Sign up with Google",
          onPressed: _handleGoogleSignIn,
        ),
      ),
    );
  }

  void _handleGoogleSignIn() async {
    try {
      GoogleAuthProvider _googleAuthProvider = GoogleAuthProvider();
      UserCredential userCredential =
          await _auth.signInWithProvider(_googleAuthProvider);
      setState(() {
        _user = userCredential.user;
      });
      String? userProfile = _user?.photoURL!;
      String? userEmail = _user?.email!;
      String? userName = _user?.displayName!;
      print(userName);
      print(userEmail);
      print(userProfile);
    } catch (error) {
      print(error);
    }
  }

  // This is not required
  Widget _userInfo() {
    return SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  image: NetworkImage(_user!.photoURL!),
                ),
              ),
            ),
            Text(_user!.email!),
            Text(_user!.displayName ?? ""),
            MaterialButton(
              color: Colors.red,
              onPressed: _auth.signOut,
              child: const Text('Sign out'),
            )
          ],
        ));
  }
}
