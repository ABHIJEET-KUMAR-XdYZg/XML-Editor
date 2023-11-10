
import 'package:flutter/material.dart';

class privilages extends ChangeNotifier {
  final String id;
  final String title;
  final String priv;
  bool used;

  privilages({
    required this.id,
    required this.title,
    required this.priv,
    required this.used,
  });

  void toogleSelection() {
    used = !used;
    notifyListeners();
  }
}
