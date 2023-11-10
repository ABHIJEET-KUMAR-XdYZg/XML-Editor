import 'package:flutter/material.dart';

class features extends ChangeNotifier {
  final String id;
  final String title;
  final String feature;
  bool used;

  features({
    required this.id,
    required this.title,
    required this.feature,
    required this.used,
  });

  void toogleSelection() {
    used = !used;
    notifyListeners();
  }

  
}
