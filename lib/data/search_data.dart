import 'package:c_app/data/api_data.dart';
import 'package:c_app/models/api_model.dart';
import 'package:flutter/material.dart';

class SearchData extends ChangeNotifier {
  List<ApiModel> initialResults = apiData.coins;
  String textResult = '';

  void getResults(String value) {
    List<ApiModel> searchResults = [];
    if (searchResults == []) {
      searchResults = apiData.coins;
    } else {
      searchResults = apiData.coins.where((element) {
        final result = element.coin.toLowerCase();
        final input = value.toLowerCase();

        return result.contains(input);
      }).toList();
    }
    textResult = value;
    initialResults = searchResults;
    notifyListeners();
  }
}

final searchData = SearchData();
