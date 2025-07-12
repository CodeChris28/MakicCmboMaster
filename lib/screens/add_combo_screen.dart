import 'package:flutter/material.dart';
import 'package:makicombomaster/models/combo_model.dart';
import 'package:makicombomaster/models/maki_model.dart';
import 'package:makicombomaster/widgets/create_maki_card.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';
import '../providers/combo_provider.dart';
import '../providers/maki_provider.dart';

class AddComboScreen extends StatelessWidget {
  const AddComboScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController comboNameController = TextEditingController();
    final MakiProvider makiProvider = context.watch<MakiProvider>();
    final ComboProvider comboProvider = context.read<ComboProvider>();

    final List<Maki> allMakis = makiProvider.makis;
    final List<String> selectedMakiIds = [];

    return Scaffold(
      appBar: AppBar(title: const Text("Crear Combo")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: comboNameController,
              decoration: const InputDecoration(labelText: "Nombre del Combo"),
            ),
            const SizedBox(height: 10),
            const Text("Selecciona los makis:"),
            Expanded(
              child: ListView(
                children: [
                  CreateMakiCard(
                    onTap: () {
                      Navigator.pushNamed(context, 'addMakiScreen');
                    },
                  ),
                  ...allMakis.map((maki) {
                    return StatefulBuilder(
                      builder: (context, setState) {
                        final selected = selectedMakiIds.contains(maki.id);
                        return CheckboxListTile(
                          title: Text(maki.name),
                          value: selected,
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
                    );
                  }).toList(),
                ],
              ),
            ),
            ElevatedButton(
              onPressed: () {
                final combo = Combo(
                  id: const Uuid().v4(),
                  name: comboNameController.text,
                  makiIds: selectedMakiIds,
                  userId: 'test_user', // luego reemplaza por el UID real
                );
                comboProvider.addCombo(combo);
                Navigator.pushNamedAndRemoveUntil(
                  context,
                  'homeScreen',
                  (route) => false,
                );
              },
              child: const Text("Guardar Combo"),
            ),
          ],
        ),
      ),
    );
  }
}
