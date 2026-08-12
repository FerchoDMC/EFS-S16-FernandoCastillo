import 'package:flutter/material.dart';
import '../models/lugar.dart';
import '../services/db_helper.dart';

class LugaresProvider extends ChangeNotifier {
  final DatabaseHelper _db = DatabaseHelper();
  List<Lugar> _lugares = [];

  List<Lugar> get lugares => _lugares;

  Future<void> cargarLugares() async {
    _lugares = await _db.getLugares();
    notifyListeners();
  }

  Future<void> agregarLugar(Lugar lugar) async {
    final id = await _db.insertLugar(lugar);
    lugar.id = id;
    _lugares.add(lugar);
    notifyListeners();
  }

  Future<void> toggleFavorito(Lugar lugar) async {
    lugar.favorito = !lugar.favorito;
    await _db.updateLugar(lugar);
    notifyListeners();
  }
}
