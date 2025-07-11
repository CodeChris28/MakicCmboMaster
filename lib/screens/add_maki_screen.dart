import 'package:flutter/material.dart';
import 'package:makicombomaster/models/maki_model.dart';
import 'package:makicombomaster/widgets/bottom_navigation_bar_widget.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';
import '../providers/maki_provider.dart';

class AddMakiScreen extends StatelessWidget {
  const AddMakiScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final makiProvider = context.watch<MakiProvider>();
    final nameController = TextEditingController();
    final descriptionController = TextEditingController();
    final imageUrlController = TextEditingController();

    return Scaffold(
      appBar: AppBar(title: const Text("Agregar Maki")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: nameController,
              decoration: const InputDecoration(labelText: "Nombre del maki"),
            ),
            TextField(
              controller: descriptionController,
              decoration: const InputDecoration(labelText: "Descripción"),
            ),
            TextField(
              controller: imageUrlController,
              decoration: const InputDecoration(labelText: "URL de imagen"),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                final newMaki = Maki(
                  id: const Uuid().v4(),
                  name: nameController.text,
                  description: descriptionController.text,
                  imageUrl: imageUrlController.text,
                  isUserCreated: true,
                );
                makiProvider.addMaki(newMaki);
                Navigator.pushReplacementNamed(context, 'homeScreen');
                Navigator.pop(context);
              },
              child: const Text("Guardar Maki"),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBarWidget(),
    );
  }
}
