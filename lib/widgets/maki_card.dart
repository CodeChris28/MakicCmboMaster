import 'package:flutter/material.dart';
import 'package:makicombomaster/models/maki_model.dart';

class MakiCard extends StatelessWidget {
  final Maki maki;

  const MakiCard({super.key, required this.maki});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        leading: maki.imageUrl != null && maki.imageUrl!.isNotEmpty
            ? ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.network(
                  maki.imageUrl!,
                  width: 50,
                  height: 50,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) => const Icon(Icons.image_not_supported),
                ),
              )
            : const Icon(Icons.rice_bowl),
        title: Text(maki.name),
        subtitle: Text(maki.description),
      ),
    );
  }
}
