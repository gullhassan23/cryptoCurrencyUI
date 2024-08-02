import 'package:cached_network_image/cached_network_image.dart';
import 'package:cryptocurrency/Model/chart_data_model.dart';
import 'package:cryptocurrency/Model/fetchcoins/data_model.dart';
import 'package:cryptocurrency/Views/CoinDetailScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class CoinListWidget extends StatelessWidget {
  final List<DataModel> coins;
  const CoinListWidget({
    Key? key,
    this.coins = const [],
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var coinUrl =
        "https://raw.githubusercontent.com/spothq/cryptocurrency-icons/master/128/color/";

    return SafeArea(
        child: Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            "Crypto Currency",
            style: TextStyle(fontSize: 30, color: Colors.white),
          ),
        ),
        SizedBox(
          height: 8.0,
        ),
        Expanded(
          child: ListView.builder(
              itemExtent: 160.0,
              itemCount: coins.length,
              itemBuilder: (context, index) {
                List<ChartData> data = [
                  ChartData(
                      coins[index].quoteModel.usdModel.percentChange_90d, 2160),
                  ChartData(
                      coins[index].quoteModel.usdModel.percentChange_60d, 1440),
                  ChartData(
                      coins[index].quoteModel.usdModel.percentChange_30d, 720),
                  ChartData(
                      coins[index].quoteModel.usdModel.percentChange_24h, 24),
                  ChartData(
                      coins[index].quoteModel.usdModel.percentChange_1h, 1),
                ];
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => Coindetailscreen(
                                  coins: coins[index],
                                )));
                  },
                  child: Container(
                    height: 160.0,
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(vertical: 4.0),
                    margin:
                        EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Color.fromRGBO(0, 0, 0, 0.6)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          padding: EdgeInsets.only(left: 16),
                          width: 96.0,
                          child: Column(
                            children: [
                              SizedBox(
                                height: 8.0,
                              ),
                              Container(
                                height: 50,
                                width: 50,
                                child: CachedNetworkImage(
                                  imageUrl:
                                      ((coinUrl + coins[index].symbol + ".png")
                                          .toLowerCase()),
                                  placeholder: (context, url) =>
                                      CircularProgressIndicator(),
                                  errorWidget: (context, url, error) =>
                                      SvgPicture.asset(
                                          'assets/images/dollar.svg'),
                                ),
                              ),
                              SizedBox(
                                height: 4,
                              ),
                              Text(
                                coins[index].symbol,
                                style: TextStyle(
                                    color: Colors.white, fontSize: 12),
                              ),
                              SizedBox(
                                height: 4,
                              ),
                              Text(
                                "\$" +
                                    coins[index]
                                        .quoteModel
                                        .usdModel
                                        .price
                                        .toStringAsFixed(2),
                                style: TextStyle(
                                    color: Colors.white, fontSize: 12),
                              )
                            ],
                          ),
                        ),
                        Expanded(
                            child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                                child: Container(
                              padding: EdgeInsets.only(left: 16),
                              height: 96,
                              width: double.infinity,
                              child: SfCartesianChart(
                                plotAreaBorderWidth: 0,
                                primaryXAxis: CategoryAxis(
                                  isVisible: false,
                                ),
                                primaryYAxis: CategoryAxis(
                                  isVisible: false,
                                ),
                                legend: Legend(isVisible: false),
                                tooltipBehavior: TooltipBehavior(enable: false),
                                series: [
                                  LineSeries<ChartData, String>(
                                    dataSource: data,
                                    xValueMapper: (ChartData data, _) =>
                                        data.year.toString(),
                                    yValueMapper: (ChartData data, _) =>
                                        data.value,
                                  )
                                ],
                              ),
                            )),
                            Container(
                              padding: EdgeInsets.all(4.0),
                              margin: EdgeInsets.only(right: 16.0),
                              alignment: Alignment.center,
                              width: 72,
                              height: 36,
                              decoration: BoxDecoration(
                                  color: coins[index]
                                              .quoteModel
                                              .usdModel
                                              .percentChange_7d >=
                                          0
                                      ? Colors.green
                                      : Colors.red,
                                  borderRadius: BorderRadius.circular(16)),
                              child: Text(
                                coins[index]
                                        .quoteModel
                                        .usdModel
                                        .percentChange_7d
                                        .toStringAsFixed(2) +
                                    "%",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                            )
                          ],
                        ))
                      ],
                    ),
                  ),
                );
              }),
        )
      ],
    ));
  }
}
