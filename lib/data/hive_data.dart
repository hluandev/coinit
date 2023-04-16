import 'package:c_app/models/api_model.dart';
import 'package:hive/hive.dart';

class HiveData {
  final myBox = Hive.box('coin_database');

  void saveUserInputValueForTotal(List<double> total) {
    myBox.put('userInputValueForTotal', total);
  }

  List<double> readUserInputValueForTotal() {
    return myBox.get('userInputValueForTotal') ??
        List.generate(100, (index) => 0);
  }

  void saveUserInput(List<double> userInputValue) {
    myBox.put('userInputValue', userInputValue);
    print(myBox.get('userInputValue'));
  }

  List<double> readUserInput() {
    return myBox.get('userInputValue') ?? List.generate(100, (index) => 0);
  }

  void saveTotal(double totalPrice) {
    myBox.put('total', totalPrice);
  }

  double readTotal() {
    return myBox.get('total') ?? 0;
  }

  void saveData(List<ApiModel> apiModel) {
    List<List<dynamic>> hiveApiModel = [];
    for (final value in apiModel) {
      List<dynamic> hiveModel = [
        value.coin,
        value.price,
      ];
      hiveApiModel.add(hiveModel);
    }

    myBox.put('coinList', hiveApiModel);
  }

  List<ApiModel> readData() {
    List savedHive = myBox.get('coinList') ?? [];
    List<ApiModel> apiModel = [];

    for (var i = 0; i < savedHive.length; i++) {
      String coin = savedHive[i][0];
      double price = savedHive[i][1];

      ApiModel api = ApiModel(
        coin: coin,
        price: price,
      );

      apiModel.add(api);
    }

    return apiModel;
  }
}

final hvData = HiveData();
