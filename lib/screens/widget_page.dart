import 'package:flutter/material.dart';

class WidgetPage extends StatelessWidget {
  const WidgetPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Widget Page")),
      body: const Center(
        child: Text("Aquí pots afegir els teus widgets!"),
      ),
    );
  }
}
