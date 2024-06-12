import 'package:flutter/cupertino.dart';

class FormfeildLabel extends StatelessWidget {
  const FormfeildLabel({super.key, required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 4),
      child: Text(
        label.toUpperCase(),
        style: const TextStyle(fontSize: 13, fontWeight: FontWeight.normal),
        textAlign: TextAlign.center,
      ),
    );
  }
}
