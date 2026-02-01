import 'package:flutter/material.dart';

class RootScreen extends StatefulWidget {
  const RootScreen({super.key,});

  @override
  State<RootScreen> createState() => _RootScreenState();
}

class _RootScreenState extends State<RootScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.red,
      body: Center(child: Container(child: Text("Login Page"))),
    );
  }
}
