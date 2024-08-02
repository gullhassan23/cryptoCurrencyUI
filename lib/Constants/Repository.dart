

import 'package:cryptocurrency/Model/fetchcoins/big_data_model.dart';
import 'package:dio/dio.dart';

class Repository {
  static String uri = "https://pro-api.coinmarketcap.com/v1/";

  final String apiKey = "c94a4ac3-9758-44ec-9195-9cff9c582a1a";

  var currencyListAPI = "${uri}cryptocurrency/listings/latest";
  Dio dio = Dio();
  Future<BigDataModel> getCoins() async {
    try {
      dio.options.headers['x-CMC_PRO_API_KEY'] = apiKey;
      Response response = await dio.get(currencyListAPI);
      print(response.data);
      return BigDataModel.fromJson(response.data);
    } catch (error, stackTrace) {
      print("exception $error, $stackTrace");

      return BigDataModel.withError("error");
    }
  }
}
