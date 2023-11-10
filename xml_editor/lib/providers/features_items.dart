import 'package:flutter/material.dart';
import '../modals/features.dart';

class featuresList extends ChangeNotifier {
  final List<features> _featuresitems = [];

  List<features> get featureitems => [..._featuresitems];

  final List<features> _selectedfeatures = [];

  List<features> get selectedfeatures => [..._selectedfeatures];

  void addfeatures(String id) {
    final selecteditem =
        _featuresitems.firstWhere((element) => element.id == id);
    selecteditem.toogleSelection();

    if (selecteditem.used == false) {
      _selectedfeatures.remove(selecteditem);
    } else if (!_selectedfeatures.contains(selecteditem)) {
      _selectedfeatures.add(selecteditem);
    }
    notifyListeners();
  }



  void initializedfeatList(features element) {
    _featuresitems.add(element);
    notifyListeners();
  }

  void clear() {
    _selectedfeatures.clear();
    for (var element in _featuresitems) {
      element.used = false;
    }
    notifyListeners();
  }
}
