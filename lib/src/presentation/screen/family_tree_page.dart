import 'package:flutter/material.dart';

class FamilyTreeMain extends StatefulWidget {
  const FamilyTreeMain({super.key});

  @override
  State<FamilyTreeMain> createState() => _FamilyTreeMainState();
}

class _FamilyTreeMainState extends State<FamilyTreeMain> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.red,
      body: Center(
        child: Container(
          child: Text("Login Page"),
        ),
      ),
    );
  }
}


