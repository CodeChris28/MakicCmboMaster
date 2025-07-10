import 'package:flutter/material.dart';
import 'package:makicombomaster/models/maki_model.dart';
import 'package:makicombomaster/services/maki_service.dart';

class MakiProvider extends ChangeNotifier {
  final _makiService = MakiService();
  List<Maki> _makis = [];

  List<Maki> get makis => _makis;

  Future<void> getAllMakis() async {
    _makis = await _makiService.getAllMakis();
    notifyListeners();
  }

  Future<void> addMaki(Maki maki) async {
    final result = await _makiService.addMaki(maki);
    if (result) {
      _makis.add(maki);
      notifyListeners();
    }
  }

  Future<void> deleteMaki(String id) async {
    final result = await _makiService.deleteMaki(id);
    if (result) {
      _makis = _makis.where((maki) => maki.id != id).toList();
      notifyListeners();
    }
  }
}
