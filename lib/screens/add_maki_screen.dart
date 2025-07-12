import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:makicombomaster/models/maki_model.dart';
import 'package:makicombomaster/providers/maki_provider.dart';
import 'package:provider/provider.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:uuid/uuid.dart';

class AddMakiScreen extends StatefulWidget {
  const AddMakiScreen({super.key});

  @override
  State<AddMakiScreen> createState() => _AddMakiScreenState();
}

class _AddMakiScreenState extends State<AddMakiScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  File? _image;
  bool _isUploading = false;

  Future<void> pickImage() async {
    final picked = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (picked != null) {
      setState(() {
        _image = File(picked.path);
      });
    }
  }

  Future<String?> uploadImage(File imageFile) async {
    try {
      final ref = FirebaseStorage.instance
          .ref()
          .child('makis')
          .child('${const Uuid().v4()}.jpg');
      await ref.putFile(imageFile);
      return await ref.getDownloadURL();
    } catch (e) {
      return null;
    }
  }

  Future<void> saveMaki() async {
    setState(() {
      _isUploading = true;
    });

    String? imageUrl;
    if (_image != null) {
      imageUrl = await uploadImage(_image!);
    }

    final maki = Maki(
      id: const Uuid().v4(),
      name: nameController.text,
      description: descriptionController.text,
      imageUrl: imageUrl,
    );

    await context.read<MakiProvider>().addMaki(maki);

    if (mounted) {
      Navigator.pushNamedAndRemoveUntil(context, 'makisScreen', (_) => false);
    }

    setState(() {
      _isUploading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Nuevo Maki')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            GestureDetector(
              onTap: pickImage,
              child: _image == null
                  ? Container(
                      width: 120,
                      height: 120,
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Icon(Icons.camera_alt_outlined),
                    )
                  : ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.file(_image!, width: 120, height: 120, fit: BoxFit.cover),
                    ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: nameController,
              decoration: const InputDecoration(labelText: 'Nombre del maki'),
            ),
            TextField(
              controller: descriptionController,
              decoration: const InputDecoration(labelText: 'Descripción'),
            ),
            const SizedBox(height: 20),
            _isUploading
                ? const CircularProgressIndicator()
                : ElevatedButton(
                    onPressed: saveMaki,
                    child: const Text('Guardar Maki'),
                  )
          ],
        ),
      ),
    );
  }
}
