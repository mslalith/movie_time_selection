import 'package:flutter/material.dart' show ChangeNotifier, ScrollController;

class ScrollProvider extends ChangeNotifier {
  ScrollController _scrollController;
  ScrollController get controller => _scrollController;

  ScrollProvider() {
    _scrollController = ScrollController();
    _scrollController.addListener(notifyListeners);
  }

  double get scrollOffset =>
      _scrollController.hasClients ? _scrollController.offset : 0.0;
}
