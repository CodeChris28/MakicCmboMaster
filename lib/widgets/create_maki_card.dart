import 'package:flutter/material.dart';

class CreateMakiCard extends StatelessWidget {
  final VoidCallback onTap;

  const CreateMakiCard({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        leading: const Icon(Icons.add_circle_outline, color: Colors.teal),
        title: const Text('Crear nuevo maki'),
        onTap: onTap,
      ),
    );
  }
}
