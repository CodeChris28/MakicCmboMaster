import 'package:flutter/material.dart';
import 'package:makicombomaster/models/combo_model.dart';
import 'package:material_symbols_icons/material_symbols_icons.dart';

class ComboCard extends StatelessWidget {
  final Combo combo;

  const ComboCard({super.key, required this.combo});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: () {
          // Aquí puedes navegar a la pantalla de uso del combo
          // Navigator.pushNamed(context, '/use-combo', arguments: combo);
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
          child: Row(
            children: [
              const Icon(Icons.ramen_dining, size: 28, color: Colors.deepOrange),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  combo.name,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600),
                ),
              ),
              Row(
                children: [
                  Container(height: 30, child: Image.asset('assets/maki_icon.png')),
                  Text(
                    'x${combo.makiIds.length}',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.w500,
                          color: Colors.grey[700],
                        ),
                  ),
                ],
              ),
              const SizedBox(width: 8),
              const Icon(Icons.arrow_forward_ios_rounded, size: 16, color: Colors.grey),
            ],
          ),
        ),
      ),
    );
  }
}
