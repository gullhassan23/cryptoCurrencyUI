import 'package:cached_network_image/cached_network_image.dart';
import 'package:cryptocurrency/Model/chart_data_model.dart';
import 'package:cryptocurrency/widgets/SliverWiget.dart';
import 'package:cryptocurrency/widgets/ToggleButton.dart';
import 'package:flutter/material.dart';
import 'dart:math';
import 'package:cryptocurrency/Model/fetchcoins/data_model.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class Coindetailscreen extends StatefulWidget {
  final DataModel coins;

  const Coindetailscreen({
    Key? key,
    required this.coins,
  }) : super(key: key);

  @override
  State<Coindetailscreen> createState() => _CoindetailscreenState();
}

class _CoindetailscreenState extends State<Coindetailscreen> {
  List<bool> select = [true, false, false, false, false];
  @override
  Widget build(BuildContext context) {
    Random random = Random();
    int next(int min, int max) => random.nextInt(max - min);
    var coinIconUrl =
        "https://raw.githubusercontent.com/spothq/cryptocurrency-icons/master/128/color/";
    var coinPrice = widget.coins.quoteModel.usdModel;
    DateTime parseDate = new DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'")
        .parse(coinPrice.lastUpdated);
    var inputDate = DateTime.parse(parseDate.toString());
    var outputFormat = DateFormat('MM/dd/yyyy hh:mm a');
    var outputDate = outputFormat.format(inputDate);

    List<ChartData> data = [
      ChartData(next(1, 1000), 1),
      ChartData(next(1, 1000), 2),
      ChartData(next(1, 1000), 3),
      ChartData(next(1, 1000), 4),
      ChartData(next(1, 1000), 5),
      ChartData(next(1, 1000), 6),
      ChartData(next(1, 1000), 7),
      ChartData(next(1, 1000), 8),
      ChartData(next(1, 1000), 9),
      ChartData(next(1, 1000), 10),
      ChartData(next(1, 1000), 11),
      ChartData(next(1, 1000), 12),
      ChartData(next(1, 1000), 13),
      ChartData(next(1, 1000), 14),
      ChartData(next(1, 1000), 15),
      ChartData(next(1, 1000), 16),
      ChartData(next(1, 1000), 17),
      ChartData(next(1, 1000), 18),
      ChartData(next(1, 1000), 19),
      ChartData(next(1, 1000), 20),
    ];
    return Scaffold(
      backgroundColor: Color.fromRGBO(11, 12, 54, 1),
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(36)),
              pinned: true,
              snap: true,
              floating: true,
              expandedHeight: 280.0,
              flexibleSpace: FlexibleSpaceBar(
                title: Container(
                  margin: EdgeInsets.symmetric(vertical: 8),
                  padding: EdgeInsets.fromLTRB(16, 24, 4.4, 0),
                  width: double.infinity,
                  height: 56,
                  child: ListTile(
                    leading: Container(
                      height: 40,
                      width: 40,
                      child: Container(
                        height: 50,
                        width: 50,
                        child: CachedNetworkImage(
                          imageUrl:
                              ((coinIconUrl + widget.coins.symbol + ".png")
                                  .toLowerCase()),
                          placeholder: (context, url) =>
                              CircularProgressIndicator(),
                          errorWidget: (context, url, error) =>
                              SvgPicture.asset('assets/images/dollar.svg'),
                        ),
                      ),
                    ),
                    title: Text(
                      widget.coins.name +
                          " " +
                          widget.coins.symbol +
                          " #" +
                          widget.coins.cmcRank.toString(),
                      style: TextStyle(color: Colors.black),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
                background: Image.asset(
                  "assets/images/3.png",
                  fit: BoxFit.cover,
                ),
              )),
          SliverPersistentHeader(
              pinned: true,
              delegate: SliverAppBarDelegate(
                maxHeight: 360.0,
                minHeight: 360.0,
                child: Padding(
                  padding: EdgeInsets.only(top: 32),
                  child: Column(
                    children: [
                      Text(
                        "\$" +
                            widget.coins.quoteModel.usdModel.price
                                .toStringAsFixed(2),
                        style: TextStyle(color: Colors.white, fontSize: 30),
                      ),
                      Text(
                        outputDate,
                        style: TextStyle(
                            fontFamily: "Roboto",
                            fontSize: 18,
                            color: Colors.grey),
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
                        ],
                      )),
                      SizedBox(
                        height: 8,
                      ),
                      ToggleButtons(
                        borderRadius: BorderRadius.circular(8),
                        borderColor: Colors.indigoAccent,
                        color: Colors.white,
                        fillColor: Colors.green,
                        selectedColor: Colors.white,
                        selectedBorderColor: Colors.indigoAccent,
                        children: [
                          ToggleButtonWidget(name: "Today"),
                          ToggleButtonWidget(name: "1W"),
                          ToggleButtonWidget(name: "1M"),
                          ToggleButtonWidget(name: "3M"),
                          ToggleButtonWidget(name: "6M")
                        ],
                        isSelected: select,
                        onPressed: (int newIndex) {
                          setState(() {
                            for (int i = 0; i < select.length; i++) {
                              if (i == newIndex) {
                                select[i] = true;
                              } else {
                                select[i] = false;
                              }
                            }
                          });
                        },
                      )
                    ],
                  ),
                ),
              )),
          SliverToBoxAdapter(
            child: Container(
              height: 600,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    height: 400,
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(horizontal: 24, vertical: 8),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Circulating Supply:",
                              style: TextStyle(color: Colors.white),
                            ),
                            Text(
                              widget.coins.circulatingSupply.toString(),
                              style:
                                  TextStyle(color: Colors.white, fontSize: 20),
                            )
                          ],
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Max Supply",
                              style: TextStyle(color: Colors.white),
                            ),
                            Text(
                              widget.coins.maxSupply.toString(),
                              style:
                                  TextStyle(color: Colors.white, fontSize: 20),
                            )
                          ],
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Market pairs",
                              style: TextStyle(color: Colors.white),
                            ),
                            Text(
                              widget.coins.numMarketPairs.toString(),
                              style:
                                  TextStyle(color: Colors.white, fontSize: 20),
                            )
                          ],
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Market Caps",
                              style: TextStyle(color: Colors.white),
                            ),
                            Text(
                              widget.coins.quoteModel.usdModel.marketCap
                                  .toString(),
                              style:
                                  TextStyle(color: Colors.white, fontSize: 20),
                            )
                          ],
                        ),
                        SizedBox(
                          height: 120,
                        ),
                        Text(
                          "Code-hsn",
                          style: TextStyle(color: Colors.lightGreen),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
