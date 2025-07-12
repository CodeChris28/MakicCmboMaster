import 'package:flutter/material.dart';
import 'package:makicombomaster/models/combo_model.dart';
import 'package:makicombomaster/providers/combo_provider.dart';
import 'package:makicombomaster/providers/maki_provider.dart';
import 'package:provider/provider.dart';

class EditComboScreen extends StatefulWidget {
  final Combo combo;

  const EditComboScreen({super.key, required this.combo});

  @override
  State<EditComboScreen> createState() => _EditComboScreenState();
}

class _EditComboScreenState extends State<EditComboScreen> {
  late TextEditingController _nameController;
  late List<String> selectedMakiIds;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.combo.name);
    selectedMakiIds = List<String>.from(widget.combo.makiIds);
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final makis = context.watch<MakiProvider>().makis;
    final comboProvider = context.read<ComboProvider>();

    return Scaffold(
      appBar: AppBar(title: const Text('Editar Combo')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(labelText: 'Nombre del Combo'),
            ),
            const SizedBox(height: 16),
            const Text('Selecciona los makis:'),
            Expanded(
              child: ListView.builder(
                itemCount: makis.length,
                itemBuilder: (context, index) {
                  final maki = makis[index];
                  final isSelected = selectedMakiIds.contains(maki.id);
                  return CheckboxListTile(
                    title: Text(maki.name),
                    value: isSelected,
                    onChanged: (val) {
                      setState(() {
                        if (val == true) {
                          selectedMakiIds.add(maki.id);
                        } else {
                          selectedMakiIds.remove(maki.id);
                        }
                      });
                    },
                  );
                },
              ),
            ),
            ElevatedButton(
              onPressed: () async {
                final updatedCombo = Combo(
                  id: widget.combo.id,
                  name: _nameController.text.trim(),
                  makiIds: selectedMakiIds,
                  userId: widget.combo.userId,
                );

                await comboProvider.updateCombo(updatedCombo);
                if (mounted) Navigator.pop(context, true);
              },
              child: const Text('Guardar Cambios'),
            )
          ],
        ),
      ),
    );
  }
}
