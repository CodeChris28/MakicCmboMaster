// lib/widgets/create_combo_card.dart
import 'package:flutter/material.dart';

class CreateComboCard extends StatelessWidget {
  final VoidCallback onTap;

  const CreateComboCard({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: onTap, // Usa el callback para la acción
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
          child: Row(
            children: [
              // Un icono representativo de "agregar" o "nuevo"
              const Icon(Icons.add_circle_outline, size: 28, color: Colors.deepOrange),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  'Crear Nuevo Combo',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600, color: Colors.deepOrange),
                ),
              ),
              // Puedes quitar el icono de flecha si no lo quieres aquí
              const Icon(Icons.arrow_forward_ios_rounded, size: 16, color: Colors.deepOrange),
            ],
          ),
        ),
      ),
    );
  }
}