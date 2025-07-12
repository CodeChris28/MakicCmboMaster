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
        leading: SizedBox(
          height: 36,
          width: 36,
          child: Image.asset('lib/assets/maki_icon.png'),
        ),
        title: Text(maki.name),
        subtitle: Text(maki.description),
      ),
    );
  }
}
