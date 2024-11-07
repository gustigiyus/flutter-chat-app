// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:flutter_chat_firebase/core/extensions/build_context_ext.dart';
import 'package:flutter_chat_firebase/presentations/pages/login_page.dart';
import 'package:google_sign_in/google_sign_in.dart';

class HomePage extends StatefulWidget {
  UserCredential? currentUser;

  HomePage({
    Key? key,
    this.currentUser,
  }) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final FirebaseAuth auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home Page"),
        actions: [
          Text('Chat App'),
          const SizedBox(
            height: 40,
          ),
          IconButton(
            onPressed: () {
              auth.signOut();
              context.pushReplacement(const LoginPage());
            },
            icon: const Icon(
              Icons.logout,
            ),
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.network(widget.currentUser?.user?.photoURL ?? ''),
            const SizedBox(
              height: 40,
            ),
            Text('${widget.currentUser?.user?.email}'),
          ],
        ),
      ),
    );
  }
}
