import 'package:flutter/material.dart';
import '../modals/privilages.dart';

class privilagesList extends ChangeNotifier {
  final List<privilages> _privilegeitems = [];
  List<privilages> get items => [..._privilegeitems];

  List<privilages> _selectedPrivileges = [];

  List<privilages> get selectedPrivileges => [..._selectedPrivileges];

  void addPrivilages(String id) {
    final privilage = _privilegeitems.firstWhere((element) => element.id == id);
    privilage.toogleSelection();
    _selectedPrivileges =
        _privilegeitems.where((element) => element.used == true).toList();
    notifyListeners();
  }

  void intialize(privilages element) {
    _privilegeitems.add(element);
    notifyListeners();
  }

  void clear() {
    _selectedPrivileges.clear();

    for (var element in _privilegeitems) {
      element.used = false;
    }

    notifyListeners();
  }
}
