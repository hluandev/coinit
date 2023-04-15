import 'package:c_app/data/add_and_remove_coin.dart';
import 'package:c_app/data/hive_data.dart';
import 'package:flutter/material.dart';

class CalTotalData extends ChangeNotifier {
  List<double> total = List.generate(100, (index) => 0);

  double totalPrice = 0;

  void hiveTotalData() {
    if (hvData.readTotal() != 0) {
      totalPrice = hvData.readTotal();
    }
  }

  void calTotal(String value, int index) {
    double userInput = double.tryParse(value) ?? 0;
    double userPrice =
        userInput * double.parse(addAndRemoveCoin.coinsOnScreen[index].price);
    total[index] = userPrice;

    double sum = 0;
    for (var i = 0; i < total.length; i++) {
      sum = sum + total[i];
      totalPrice = sum;
      hvData.saveTotal(totalPrice);
      notifyListeners();
    }
  }

  void removeInput(int index) {
    total[index] = 0;
    total.removeAt(index);
    total.add(0);
    double sum = 0;
    for (var i = 0; i < total.length; i++) {
      sum = sum + total[i];
      totalPrice = sum;
      hvData.saveTotal(totalPrice);
      notifyListeners();
    }
  }
}

final calTotal = CalTotalData();
