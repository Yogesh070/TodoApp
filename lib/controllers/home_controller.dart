import 'package:flutter/foundation.dart';

class HomeCrontroller extends ChangeNotifier {
  bool? _islistLayout = true;
  bool? _isGridLayout = false;

  bool get isListLayout => _islistLayout!;
  bool get isGridLayout => _isGridLayout!;

  List _optionItems = ['Grid View', 'About'];
  List get optionItems => _optionItems;

  void changeLayout() {
    _islistLayout = !_islistLayout!;
    _isGridLayout = !_isGridLayout!;
    if (_islistLayout!) {
      _optionItems.removeAt(0);
      _optionItems.insert(0, 'Grid View');
    } else {
      optionItems.removeAt(0);
      _optionItems.insert(0, 'List View');
    }
    notifyListeners();
  }
}
