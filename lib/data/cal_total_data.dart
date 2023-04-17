import 'package:c_app/data/add_and_remove_coin.dart';
import 'package:c_app/data/hive_data.dart';
import 'package:flutter/material.dart';

class CalTotalData extends ChangeNotifier {
  List<double> total = List.generate(100, (index) => 0);
  List<double> userInputValue = List.generate(100, (index) => 0);
  double totalPrice = 0;

  void hiveUserInputValueForTotal() {
    if (hvData.readUserInputValueForTotal() !=
        List.generate(100, (index) => 0)) {
      total = hvData.readUserInputValueForTotal();
    }
  }

  void hiveTotalData() {
    if (hvData.readTotal() != 0) {
      totalPrice = hvData.readTotal();
    }
  }

  void hiveUserInputValue() {
    if (hvData.readUserInput() != List.generate(100, (index) => 0)) {
      userInputValue = hvData.readUserInput();
    }
  }

  void calTotal(String value, int index) {
    double userInput = double.tryParse(value) ?? 0;
    double userPrice = userInput * addAndRemoveCoin.coinsOnScreen[index].price;
    total[index] = userPrice;
    userInputValue[index] = userInput;
    hvData.saveUserInputValueForTotal(total);
    hvData.saveUserInput(userInputValue);
    notifyListeners();

    double sum = 0;
    for (var i = 0; i < total.length; i++) {
      sum = sum + total[i];
      totalPrice = sum;
      hvData.saveTotal(totalPrice);
      notifyListeners();
    }
  }

  void updateTotal() {
    double sum = 0;
    for (var i = 0; i < addAndRemoveCoin.coinsOnScreen.length; i++) {
      double userPrice =
          userInputValue[i] * addAndRemoveCoin.coinsOnScreen[i].price;
      total[i] = userPrice;
      hvData.saveUserInputValueForTotal(total);
      hvData.saveUserInput(userInputValue);

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
    hvData.saveUserInputValueForTotal(total);

    userInputValue.removeAt(index);
    userInputValue.add(0);

    hvData.saveUserInput(userInputValue);
    notifyListeners();
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
