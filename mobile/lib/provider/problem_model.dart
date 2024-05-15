import 'dart:math';

import 'package:flutter/material.dart';
import 'package:mobile/global_variables.dart';
import 'package:mobile/assets/problem_set.dart';

class ProblemModel extends ChangeNotifier {
  // problem filter

  final List<Filter> _filters = [...Filter.values]; // 필터 일단 다 넣고 시작
  get noFilter => _filters.isEmpty;
  void updateFilter(Filter filter) {
    bool isContained = _filters.contains(filter);
    isContained ? _filters.remove(filter) : _filters.add(filter);
    notifyListeners();
  }

  bool isIncludedFilter(Filter filter) {
    return _filters.contains(filter);
  }

  // problem question, answer

  final Item _letter = Item();
  final Item _pronunciation = Item();
  bool drawed = false;

  get letter => _letter.getText();
  get pronunciation => _pronunciation.getText();

  void _drawNewProblem() {
    _pronunciation.hide();
    _letter.hide();

    final String newLetter;
    final String newPronunciation;

    final int targetFilterIndex = Random().nextInt(_filters.length);
    final int targetProblemIndex =
        Random().nextInt(problemSet[_filters[targetFilterIndex]]!.length);

    final Map<String, dynamic> targetProblem =
        problemSet[_filters[targetFilterIndex]]![targetProblemIndex];
    newLetter = targetProblem['letter'];
    newPronunciation = targetProblem['pronunciation'];

    _letter.setText(newLetter);
    _pronunciation.setText(newPronunciation);
  }

  bool drawWithLetter() {
    if (_filters.isNotEmpty) {
      _drawNewProblem();
      _letter.show();
      notifyListeners();
      return true;
    } else {
      return false;
    }
  }

  bool drawWithPronunciation() {
    if (_filters.isNotEmpty) {
      _drawNewProblem();
      _pronunciation.show();
      notifyListeners();
      return true;
    } else {
      return false;
    }
  }

  void showAll() {
    _letter.show();
    _pronunciation.show();
    notifyListeners();
  }
}

class Item {
  bool _isShown = false;
  String _text = '';

  void show() {
    _isShown = true;
  }

  void hide() {
    _isShown = false;
  }

  void setText(String text) {
    _text = text;
  }

  String? getText() {
    return _isShown ? _text : null;
  }
}
