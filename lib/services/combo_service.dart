import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:makicombomaster/models/combo_model.dart';

class ComboService {
  final _combosRef = FirebaseFirestore.instance.collection('combos');

  Future<bool> addCombo(Combo combo) async {
    try {
      await _combosRef.doc(combo.id).set(combo.toMap());
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<void> updateCombo(Combo combo) async {
    await _combosRef.doc(combo.id).update(combo.toMap());
  }

  Future<Combo?> getComboById(String id) async {
    final doc = await _combosRef.doc(id).get();
    if (doc.exists) {
      return Combo.fromMap(doc.id, doc.data() as Map<String, dynamic>);
    }
    return null;
  }

  Future<List<Combo>> getAllCombos() async {
    final snapshot = await _combosRef.get();
    return snapshot.docs
        .map((doc) => Combo.fromMap(doc.id, doc.data()))
        .toList();
  }

  Future<bool> deleteCombo(String id) async {
    try {
      await _combosRef.doc(id).delete();
      return true;
    } catch (e) {
      return false;
    }
  }
}
