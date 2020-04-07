import 'package:http/http.dart' as http;
import 'dart:convert';

const coinApiURL = 'https://rest.coinapi.io/v1/exchangerate/';
const header = {'X-CoinAPI-Key': 'C6E64239-8FD6-4C2B-A5D2-78304F49C681'};

const List<String> currenciesList = [
  'AUD',
  'BRL',
  'CAD',
  'CNY',
  'EUR',
  'GBP',
  'HKD',
  'IDR',
  'ILS',
  'INR',
  'JPY',
  'MXN',
  'NOK',
  'NZD',
  'PLN',
  'RON',
  'RUB',
  'SEK',
  'SGD',
  'USD',
  'ZAR'
];

const List<String> cryptoList = [
  'BTC',
  'ETH',
  'LTC',
];

class CoinData {

  Future<String> getCoinData(String currency, String coin) async {
    String rate;
    http.Response response = await http.get(
      '$coinApiURL/$coin/$currency',
      headers: header,
    );

    if (response.statusCode == 200) {
      String data = response.body;

      var coinData = jsonDecode(data);

      if(coinData != null){
        rate = coinData['rate'] ?? '?';
      }
      else{
        rate = '?';
      }

    } else {
      rate = '?';
    }

    return rate;
  }
}
