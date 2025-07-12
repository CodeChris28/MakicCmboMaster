import 'package:flutter/material.dart';
import 'package:makicombomaster/models/maki_model.dart';
import 'package:makicombomaster/providers/maki_provider.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

class AddMakiScreen extends StatelessWidget {
  const AddMakiScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController nameController = TextEditingController();
    final TextEditingController descriptionController = TextEditingController();

    Future<void> saveMaki() async {
      final maki = Maki(
        id: const Uuid().v4(),
        name: nameController.text,
        description: descriptionController.text,
        imageUrl: null, // sin imagen por ahora
      );

      await context.read<MakiProvider>().addMaki(maki);

      if (context.mounted) {
        Navigator.pushNamedAndRemoveUntil(context, 'makisScreen', (_) => false);
      }
    }

    return Scaffold(
      appBar: AppBar(title: const Text('Nuevo Maki')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const SizedBox(height: 16),
            TextField(
              controller: nameController,
              decoration: const InputDecoration(labelText: 'Nombre del maki'),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: descriptionController,
              decoration: const InputDecoration(labelText: 'Descripción'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: saveMaki,
              child: const Text('Guardar Maki'),
            )
          ],
        ),
      ),
    );
  }
}
