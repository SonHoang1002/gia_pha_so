import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Home Screen",
            style: TextStyle(color: Colors.white, fontSize: 24),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pushNamed(context, '/family-tree');
            },
            child: const Text("Gia pha của bạn"),
          ),
        ],
      ),
    );
  }
}
