import 'package:flutter/material.dart';
import 'package:makicombomaster/models/combo_model.dart';
import 'package:makicombomaster/providers/combo_provider.dart';
import 'package:makicombomaster/providers/maki_provider.dart';
import 'package:makicombomaster/screens/edit_combo_screen.dart';
import 'package:makicombomaster/screens/use_combo_screen.dart';
import 'package:provider/provider.dart';

class ComboDetailScreen extends StatelessWidget {
  final Combo combo;

  const ComboDetailScreen({super.key, required this.combo});

  @override
  Widget build(BuildContext context) {
    final makiProvider = context.watch<MakiProvider>();
    final comboProvider = context.read<ComboProvider>();

    final comboMakis = makiProvider.makis
        .where((maki) => combo.makiIds.contains(maki.id))
        .toList();

    return Scaffold(
      appBar: AppBar(title: Text(combo.name)),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton.icon(
                  onPressed: () async {
                    final updated = await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => EditComboScreen(combo: combo),
                      ),
                    );

                    if (updated == true && context.mounted) {
                      await comboProvider.getAllCombos();
                      final refreshedCombo = comboProvider.combos.firstWhere(
                        (c) => c.id == combo.id,
                      );
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (_) =>
                              ComboDetailScreen(combo: refreshedCombo),
                        ),
                      );
                    }
                  },
                  icon: const Icon(Icons.edit),
                  label: const Text('Editar'),
                ),
                ElevatedButton.icon(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => UseComboScreen(combo: combo),
                      ),
                    );
                  },
                  icon: const Icon(Icons.play_arrow),
                  label: const Text('Usar'),
                ),
              ],
            ),
            const SizedBox(height: 20),
            const Text(
              'Makis en este combo:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            Expanded(
              child: ListView.builder(
                itemCount: comboMakis.length,
                itemBuilder: (context, index) {
                  final maki = comboMakis[index];
                  return Card(
                    margin: const EdgeInsets.symmetric(vertical: 6),
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: ListTile(
                      leading: Image.asset(
                        'lib/assets/maki_icon.png',
                        width: 40,
                        height: 40,
                      ),
                      title: Text(maki.name),
                      subtitle: Text(maki.description),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 10),
            Center(
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.redAccent,
                ),
                onPressed: () async {
                  final confirmed = await showDialog<bool>(
                    context: context,
                    builder: (ctx) => AlertDialog(
                      title: const Text('¿Eliminar combo?'),
                      content: const Text(
                        '¿Estás seguro de eliminar este combo?',
                      ),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.of(ctx).pop(false),
                          child: const Text('Cancelar'),
                        ),
                        TextButton(
                          onPressed: () => Navigator.of(ctx).pop(true),
                          child: const Text('Eliminar'),
                        ),
                      ],
                    ),
                  );

                  if (confirmed == true) {
                    await comboProvider.deleteCombo(combo.id);
                    if (context.mounted) {
                      Navigator.pop(context);
                    }
                  }
                },
                icon: const Icon(Icons.delete_outline),
                label: const Text('Eliminar Combo'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
