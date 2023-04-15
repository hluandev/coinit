import 'dart:convert';

import 'package:c_app/models/api_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ApiData extends ChangeNotifier {
  List<ApiModel> coins = [];

  late Future future = getCoins();
  Future getCoins() async {
    final reponse = await http.get(
      Uri.https('api.coincap.io', "v2/assets"),
    );

    final jsonData = jsonDecode(reponse.body);

    for (final eachCoin in jsonData['data']) {
      final coin = ApiModel(
        coin: eachCoin['name'],
        price: eachCoin['priceUsd'],
      );

      coins.add(coin);
      notifyListeners();
    }
  }
}

final apiData = ApiData();
