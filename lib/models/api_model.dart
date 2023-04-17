class ApiModel {
  final String coin;
  double price;
  final String percent24h;
  final String symbol;

  ApiModel({
    required this.coin,
    required this.price,
    required this.percent24h,
    required this.symbol,
  });
}
