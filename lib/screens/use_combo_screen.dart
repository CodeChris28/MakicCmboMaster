import 'package:flutter/material.dart';
import 'package:makicombomaster/models/combo_model.dart';
import 'package:makicombomaster/models/maki_model.dart';
import 'package:makicombomaster/providers/maki_provider.dart';
import 'package:provider/provider.dart';

class UseComboScreen extends StatefulWidget {
  final Combo combo;
  const UseComboScreen({super.key, required this.combo});

  @override
  State<UseComboScreen> createState() => _UseComboScreenState();
}

class _UseComboScreenState extends State<UseComboScreen> {
  late List<Maki> comboMakis;
  final Map<String, int> makiQuantities = {};
  final _totalPiecesController = TextEditingController();

  @override
  void initState() {
    super.initState();
    final makis = context.read<MakiProvider>().makis;
    comboMakis = makis.where((maki) => widget.combo.makiIds.contains(maki.id)).toList();
  }

  void distributePieces(int total) {
    if (comboMakis.isEmpty) return;
    int base = total ~/ comboMakis.length;
    int remainder = total % comboMakis.length;

    setState(() {
      for (int i = 0; i < comboMakis.length; i++) {
        final maki = comboMakis[i];
        int value = base + (i < remainder ? 1 : 0);
        makiQuantities[maki.id] = value;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Usar Combo')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: _totalPiecesController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: 'Cantidad total de piezas'),
              onChanged: (value) {
                final total = int.tryParse(value) ?? 0;
                if (total > 0) {
                  distributePieces(total);
                } else {
                  setState(() {
                    makiQuantities.clear();
                  });
                }
              },
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: comboMakis.length,
                itemBuilder: (context, index) {
                  final maki = comboMakis[index];
                  final quantity = makiQuantities[maki.id] ?? 0;
                  return Card(
                    margin: const EdgeInsets.symmetric(vertical: 6),
                    child: ListTile(
                      leading: Image.asset(
                        'lib/assets/maki_icon.png',
                        width: 40,
                        height: 40,
                      ),
                      title: Text(maki.name),
                      trailing: Text(
                        '$quantity',
                        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _totalPiecesController.dispose();
    super.dispose();
  }
}
