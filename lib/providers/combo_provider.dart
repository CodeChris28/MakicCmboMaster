import 'package:flutter/material.dart';
import 'package:makicombomaster/models/combo_model.dart';
import '../services/combo_service.dart';

class ComboProvider extends ChangeNotifier {
  final _comboService = ComboService();
  List<Combo> _combos = [];

  List<Combo> get combos => _combos;

  Future<void> getAllCombos() async {
    _combos = await _comboService.getAllCombos();
    notifyListeners();
  }

  Future<void> addCombo(Combo combo) async {
    final result = await _comboService.addCombo(combo);
    if (result) {
      _combos.add(combo);
      notifyListeners();
    }
  }

  Future<void> deleteCombo(String id) async {
    final result = await _comboService.deleteCombo(id);
    if (result) {
      _combos = _combos.where((combo) => combo.id != id).toList();
      notifyListeners();
    }
  }
}
