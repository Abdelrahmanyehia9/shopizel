import 'package:flutter/material.dart';

class SavedCard extends StatelessWidget {
  const SavedCard({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title: const Text("Saved Card"),
      ),
      body: const Column(
        mainAxisAlignment: MainAxisAlignment.center,

        children: [
        Center(child: Text("you don't have any saved card right now"))
      ],),
    );
  }
}
