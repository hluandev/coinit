import 'dart:async';

import 'package:c_app/data/api_data.dart';
import 'package:c_app/data/cal_total_data.dart';
import 'package:c_app/data/hive_data.dart';
import 'package:c_app/data/search_data.dart';
import 'package:c_app/models/api_model.dart';
import 'package:flutter/material.dart';

class AddAndRemoveCoin extends ChangeNotifier {
  List<ApiModel> coinsOnScreen = [];
  bool shownBottom = false;

  late Timer time;

  // Check local data

  void hiveCoinData() {
    if (hvData.readData().isNotEmpty) {
      coinsOnScreen = hvData.readData();
    }
  }

  //Add coins to a coinOnScreen list

  void addCoin(int index) {
    coinsOnScreen.add(
      ApiModel(
        coin: searchData.initialResults[index].coin,
        price: searchData.initialResults[index].price,
        percent24h: searchData.initialResults[index].percent24h,
        symbol: searchData.initialResults[index].symbol,
      ),
    );
    hvData.saveData(coinsOnScreen);
    notifyListeners();
  }

  //Update coins every 10s

  Future updateCoin() async {
    if (shownBottom == false) {
      await apiData.getCoins();
      for (var i = 0; i < coinsOnScreen.length; i++) {
        for (var u = 0; u < coinsOnScreen.length; u++) {
          if (coinsOnScreen[i].coin ==
              ApiModel(
                      coin: searchData.initialResults[u].coin,
                      price: searchData.initialResults[u].price,
                      percent24h: searchData.initialResults[u].percent24h,
                      symbol: searchData.initialResults[u].symbol)
                  .coin) {
            coinsOnScreen[i].price = ApiModel(
              coin: searchData.initialResults[u].coin,
              price: searchData.initialResults[u].price,
              percent24h: searchData.initialResults[u].percent24h,
              symbol: searchData.initialResults[u].symbol,
            ).price;
          }
          calTotal.updateTotal();
          hvData.saveData(coinsOnScreen);
          notifyListeners();
        }
      }
    } else {
      return;
    }
  }

  //Remove coin from coinOnScreen list

  void removeCoin(int index) {
    coinsOnScreen.removeAt(index);
    hvData.saveData(coinsOnScreen);
    notifyListeners();
  }
}

final addAndRemoveCoin = AddAndRemoveCoin();
