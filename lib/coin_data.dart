import 'dart:convert';
import 'package:http/http.dart' as http;

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

const List<String> cryptoList = ['BTC', 'ETH', 'LTC'];

// const bitcoinAverageUrl = 'https://apiv2.bitcoinaverage.com/indices/global/ticker';

const coinAPIURL = 'https://rest.coinapi.io/v1/exchangerate';
const apiKey = '0D4E35C6-E811-401C-889F-A0130C42E8E3';

class CoinData {
  Future getCoinData(String selectedCurrency) async {
    Map<String, String> cryptoPrices = {};
    for (String crypto in cryptoList) {
      String requestURL =
          '$coinAPIURL/$crypto/$selectedCurrency?apikey=$apiKey';

      http.Response response = await http.get(Uri.parse(requestURL));

      if (response.statusCode == 200) {
        var decodeData = jsonDecode(response.body);
        double price = decodeData['rate'];
        cryptoPrices[crypto] = price.toStringAsFixed(0);
      } else {
        print(response.statusCode);
        throw 'problem with the get result';
      }
    }
    return cryptoPrices;
  }
}
