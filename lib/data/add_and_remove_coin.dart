import 'dart:async';

import 'package:c_app/data/hive_data.dart';
import 'package:c_app/data/search_data.dart';
import 'package:c_app/models/api_model.dart';
import 'package:flutter/material.dart';

class AddAndRemoveCoin extends ChangeNotifier {
  List<ApiModel> coinsOnScreen = [];

  late Timer time;

  void hiveCoinData() {
    if (hvData.readData().isNotEmpty) {
      coinsOnScreen = hvData.readData();
    }
  }

  void addCoin(int index) {
    coinsOnScreen.add(
      ApiModel(
          coin: searchData.initialResults[index].coin,
          price: searchData.initialResults[index].price),
    );
    hvData.saveData(coinsOnScreen);
    notifyListeners();
  }

  updateCoin() {
    for (var i = 0; i < coinsOnScreen.length; i++) {
      for (var u = 0; u < 100; u++) {
        if (coinsOnScreen[i].coin ==
            ApiModel(
              coin: searchData.initialResults[u].coin,
              price: searchData.initialResults[u].price,
            ).coin) {
          coinsOnScreen[i].price = ApiModel(
            coin: searchData.initialResults[u].coin,
            price: searchData.initialResults[u].price,
          ).price;
        }
        hvData.saveData(coinsOnScreen);
        notifyListeners();
      }
    }
  }

  void removeCoin(int index) {
    coinsOnScreen.removeAt(index);
    hvData.saveData(coinsOnScreen);
    notifyListeners();
  }
}

final addAndRemoveCoin = AddAndRemoveCoin();
