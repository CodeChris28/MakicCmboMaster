import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:makicombomaster/models/maki_model.dart';


class MakiService {
  final _makisRef = FirebaseFirestore.instance.collection('makis');

  Future<bool> addMaki(Maki maki) async {
    try {
      await _makisRef.doc(maki.id).set(maki.toMap());
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<void> updateMaki(Maki maki) async {
    await _makisRef.doc(maki.id).update(maki.toMap());
  }

  Future<Maki?> getMakiById(String id) async {
    final doc = await _makisRef.doc(id).get();
    if (doc.exists) {
      return Maki.fromMap(doc.id, doc.data() as Map<String, dynamic>);
    }
    return null;
  }

  Future<List<Maki>> getAllMakis() async {
    final snapshot = await _makisRef.get();
    return snapshot.docs
        .map((doc) => Maki.fromMap(doc.id, doc.data()))
        .toList();
  }

  Future<bool> deleteMaki(String id) async {
    try {
      await _makisRef.doc(id).delete();
      return true;
    } catch (e) {
      return false;
    }
  }
}
