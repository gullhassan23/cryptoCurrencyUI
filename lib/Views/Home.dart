
import 'package:cryptocurrency/Constants/Repository.dart';
import 'package:cryptocurrency/Model/fetchcoins/big_data_model.dart';
import 'package:cryptocurrency/widgets/CoinList.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late Future<BigDataModel> _futureCoins;
  late Repository repository;

  @override
  void initState() {
    repository = Repository();
    _futureCoins = repository.getCoins();
    print(_futureCoins);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF040C23),
      body: FutureBuilder<BigDataModel>(
          future: _futureCoins,
          builder: (ctx, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasData) {
                var coindata = snapshot.data!.dataModel;
                return CoinListWidget(coins: coindata);
              } else if (snapshot.hasError) {
                return Center(
                  child: Text("${snapshot.error}"),
                );
              }
            }
            return Center(
              child: CircularProgressIndicator(),
            );
          }),
    );
  }
}
