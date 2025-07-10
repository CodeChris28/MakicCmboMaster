import 'package:flutter/material.dart';
import 'package:makicombomaster/models/combo_model.dart';


class ComboCard extends StatelessWidget {
  final Combo combo;

  const ComboCard({super.key, required this.combo});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        title: Text(combo.name),
        subtitle: Text('${combo.makiIds.length} makis'),
        trailing: const Icon(Icons.arrow_forward_ios_rounded),
        onTap: () {
          // Aquí puedes navegar a la pantalla de uso del combo
          // Navigator.pushNamed(context, '/use-combo', arguments: combo);
        },
      ),
    );
  }
}
