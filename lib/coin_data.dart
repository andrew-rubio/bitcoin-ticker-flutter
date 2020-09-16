import 'package:http/http.dart' as http;
import 'dart:convert'; // for jsonDecode

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

const coinAPIUrl = 'https://rest.coinapi.io/v1/exchangerate';
const apiKey = '2FB5BBE2-7B85-4CE6-BB70-A2FDFAB0B42F';

class CoinData {
  Future getCoinData(String selectedCurrency) async {
    // create map for crypto currency and its rate
    Map<String, String> cryptoMap = {};

    for (String crypto in cryptoList) {
      String requestURL =
          '$coinAPIUrl/$crypto/$selectedCurrency?apikey=$apiKey';

      http.Response response = await http.get(requestURL);

      if (response.statusCode == 200) {
        var decodedData = jsonDecode(response.body);
        double lastPrice = decodedData['rate'];
        // assign rate to crypto in map
        cryptoMap[crypto] = lastPrice.toStringAsFixed(0);
      } else {
        print(response.statusCode);
        throw 'Problem with the get request';
      }
    }
    return cryptoMap;
  }
}
