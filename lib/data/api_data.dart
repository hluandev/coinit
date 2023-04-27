import 'dart:convert';

import 'package:c_app/models/api_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ApiData extends ChangeNotifier {
  List<ApiModel> coins = [];

  // Get coin information from API

  Future getCoins() async {
    coins.clear();
    final response = await http.get(
      Uri.https('api.coincap.io', "v2/assets"),
    );

    final jsonData = jsonDecode(response.body);

    for (final eachCoin in jsonData['data']) {
      final coin = ApiModel(
        coin: eachCoin['name'],
        price: double.parse(
          eachCoin['priceUsd'],
        ),
        percent24h: eachCoin['changePercent24Hr'],
        symbol: eachCoin['symbol'],
      );

      coins.add(coin);
      notifyListeners();
    }
  }
}

final apiData = ApiData();
