class ExchangeRate {
  String baseCurrency;
  String exchangeCurrency;
  double rate;
  DateTime updatedAt;

  ExchangeRate({
    this.baseCurrency,
    this.exchangeCurrency,
    this.rate,
    this.updatedAt,
  });

  ExchangeRate.fromJson(Map<String, dynamic> json) {
    baseCurrency = json['base_currency'];
    exchangeCurrency = json['exchange_currency'];
    rate = json['rate'];
    updatedAt = DateTime.parse(json['updated_at']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['base_currency'] = this.baseCurrency;
    data['exchange_currency'] = this.exchangeCurrency;
    data['rate'] = this.rate;
    data['updated_at'] = this.updatedAt.toString();
    return data;
  }
}
