import 'package:http/http.dart' as http;
import 'dart:convert';

const coinAPIKey = 'B88528B4-D3F5-4E94-80F9-5F16B60AA3D4';
const coinAPIUrl = 'https://rest.coinapi.io/v1/exchangerate';
// https://rest.coinapi.io/v1/exchangerate/BTC/USD?apikey=B88528B4-D3F5-4E94-80F9-5F16B60AA3D4

const cryptoCompareAPIKey =
    '1b49cfc9075c413b4be0532c564346e5ed252e69364366711d1f2eca330d4387';
const cryptoCompareURL = 'https://min-api.cryptocompare.com/data/price';
const cryptoFullURL =
    'https://min-api.cryptocompare.com/data/price?fsym=BTC&tsyms=USD&api_key=1b49cfc9075c413b4be0532c564346e5ed252e69364366711d1f2eca330d4387';

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
  String cryptoCurrency = 'BTC';
  String moneyCurrency = 'USD';

  getCoinData(url) async {
    http.Response response = await http.get(url);

    if (response.statusCode == 200) {
      String data = response.body;
      return jsonDecode(data);
    } else {
      print(response.statusCode);
    }
  }
}
