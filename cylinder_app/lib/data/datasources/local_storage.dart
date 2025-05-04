import 'package:cylinder_app/data/models/cylinder_model.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class LocalStorage {
  static const String CYLINDERS_KEY = 'cylinders';
  final SharedPreferences _prefs;

  LocalStorage(this._prefs);

  Future<void> saveCylinders(List<Cylinder> cylinders) async {
    final String data = json.encode(
      cylinders.map((c) => c.toJson()).toList(),
    );
    await _prefs.setString(CYLINDERS_KEY, data);
  }

  Future<List<Cylinder>> getCylinders() async {
    final String? data = _prefs.getString(CYLINDERS_KEY);
    if (data == null) return [];
    
    final List<dynamic> jsonList = json.decode(data);
    return jsonList.map((json) => Cylinder.fromJson(json)).toList();
  }
}
