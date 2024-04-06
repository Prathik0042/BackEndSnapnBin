import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class NewLogData extends StatefulWidget {
  const NewLogData({super.key, required this.user});
  final User user;

  @override
  State<NewLogData> createState() => _NewLogDataState();
}

class _NewLogDataState extends State<NewLogData> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: [
        Text(widget.user.displayName!),
        Text(widget.user.email!),
        Text(widget.user.photoURL!),
      ],
    ));
  }
}
