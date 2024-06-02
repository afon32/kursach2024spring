import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:postgres/postgres.dart';
import 'package:sql_test_app/pages/buys/month_buys.dart';
import 'package:sql_test_app/pages/home_page/home_page.dart';
import 'package:sql_test_app/utils/utils.dart';
import 'package:sql_test_app/widgets/app_bar.dart';
import 'package:sql_test_app/widgets/buy_info.dart';

class UserBuysPageController extends GetxController {
  int buyerID = 0;
  bool isDownload = false;
  String familyMembersList = '';
  var args;
  bool isGroup = false;
  List buyPosts = [];
  List<double> buys = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0];
  var maxBuy = 0.0;
  Future getBuys() async {
    final conn = await Connection.open(
        Endpoint(
            host: '94.198.220.56',
            port: 5430,
            database: 'afon32kursach',
            username: 'postgres',
            password: 'afanas228'),
        settings: const ConnectionSettings(sslMode: SslMode.disable));
    print('after conn');
    Result result;
    if (isGroup) {
      final resul = await conn.execute(
          "SELECT family_member_id FROM Family WHERE (family_owner_id = $buyerID)");
      print(resul);
      familyMembersList = '$buyerID';
      if (resul.length > 0) {
        for (List member in resul) {
          familyMembersList = '$familyMembersList, ${member[0]}';
        }
      }
      print(familyMembersList);

      result = await conn.execute(
          "SELECT buy_id, buy_date, buy_price, buy_category_id FROM Buy WHERE (buy_buyer_id IN ($familyMembersList))");
    } else {
      result = await conn.execute(
          "SELECT buy_id, buy_date, buy_price, buy_category_id FROM Buy WHERE (buy_buyer_id = $buyerID)");
    }
    buyPosts = result;
    conn.close();
    buys = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0];
    maxBuy = 0.0;
    print('after query');
    print(buyPosts);

    for (List buy in buyPosts) {
      String month = '${buy[1].toString()[5]}${buy[1].toString()[6]}';
      print(month);
      if (month[0] == '0') {
        month = month[1];
      }
      print(month);
      buys[int.parse(month) - 1] += buy[2];
      print(buys);
      if (buys[int.parse(month) - 1] > maxBuy) {
        maxBuy = buys[int.parse(month) - 1];
      }
    }
    print(maxBuy);
    isDownload = true;
  }

  List<int>? showToolTipp(index) {
    List<int> forToolTip = [];

    if (buys[index] == 0) {
      forToolTip = [1];
    } else {
      forToolTip = [0];
    }
    return forToolTip;
  }

  Widget sss(context, prop) {
    if (!prop) {
      return const Center(
          child: CircularProgressIndicator(
        color: Colors.green,
      ));
    } else {
      return SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(10.0),
          child: Container(
            height: MediaQuery.of(context).size.height * 0.87,
            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.circular(10.0),
              border: Border.all(color: Colors.black),
            ),
            child: Padding(
                padding: EdgeInsets.all(5.0),
                child: Column(
                  children: [
                     Container(
                          height: MediaQuery.of(context).size.height * 0.03,
                          child: Center(
                            child: Text('Статистика за год',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontFamily: 'Times New Roman',
                                    fontSize: 20.0)),
                          ),
                        ),
                    Padding(
                        padding: EdgeInsets.all(10.0),
                        child: Container(
                            child: Container(
                                height:
                                    MediaQuery.of(context).size.height * 0.45,
                                color: Color.fromARGB(255, 73, 76, 83),
                                child: Padding(
                                  padding: EdgeInsets.all(10.0),
                                  child: BarChart(
                                    BarChartData(
                                      alignment: BarChartAlignment.spaceAround,
                                      maxY: maxBuy + maxBuy/8,
                                      // barTouchData: BarTouchData(enabled: false),
                                      barTouchData: BarTouchData(
                                        touchCallback: (FlTouchEvent event,
                                            barTouchResponse) {
                                          if (barTouchResponse != null &&
                                              barTouchResponse.spot != null &&
                                              event is FlTapUpEvent) {
                                            final index = barTouchResponse
                                                .spot!.touchedBarGroupIndex;
                                            List args = [
                                              index + 1,
                                              buyerID,
                                              isGroup
                                            ];
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      const MonthBuys(),
                                                  settings: RouteSettings(
                                                      arguments: args)),
                                            );
                                          }
                                        },
                                      ),
                                      titlesData: FlTitlesData(
                                        show: true,
                                        rightTitles: AxisTitles(
                                            sideTitles:
                                                SideTitles(showTitles: false)),
                                        // leftTitles: AxisTitles(
                                        //     sideTitles:
                                        //         SideTitles(showTitles: true)),
                                        topTitles: AxisTitles(
                                            sideTitles:
                                                SideTitles(showTitles: false)),
                                        bottomTitles: AxisTitles(
                                          sideTitles: SideTitles(
                                            showTitles: true,
                                            getTitlesWidget:
                                                (double value, TitleMeta meta) {
                                              const style = TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 10,
                                              );
                                              Widget text;
                                              switch (value.toInt()) {
                                                case 0:
                                                  text =
                                                      Text('Jan', style: style);
                                                  break;
                                                case 1:
                                                  text =
                                                      Text('Feb', style: style);
                                                  break;
                                                case 2:
                                                  text =
                                                      Text('Mar', style: style);
                                                  break;
                                                case 3:
                                                  text =
                                                      Text('Apr', style: style);
                                                  break;
                                                case 4:
                                                  text =
                                                      Text('May', style: style);
                                                  break;
                                                case 5:
                                                  text =
                                                      Text('Jun', style: style);
                                                  break;
                                                case 6:
                                                  text =
                                                      Text('Jul', style: style);
                                                  break;
                                                case 7:
                                                  text =
                                                      Text('Aug', style: style);
                                                  break;
                                                case 8:
                                                  text =
                                                      Text('Sep', style: style);
                                                  break;
                                                case 9:
                                                  text =
                                                      Text('Oct', style: style);
                                                  break;
                                                case 10:
                                                  text =
                                                      Text('Nov', style: style);
                                                  break;
                                                case 11:
                                                  text =
                                                      Text('Dec', style: style);
                                                  break;

                                                default:
                                                  text = Text('', style: style);
                                                  break;
                                              }
                                              return SideTitleWidget(
                                                axisSide: meta.axisSide,
                                                space: 12.0,
                                                child: text,
                                              );
                                            },
                                            reservedSize: 40,
                                          ),
                                        ),
                                        // leftTitles: AxisTitles(
                                        //   sideTitles: SideTitles(
                                        //     showTitles: true,
                                        //     getTitlesWidget: (double value, TitleMeta meta) {
                                        //       const style = TextStyle(
                                        //         color: Colors.black,
                                        //         fontWeight: FontWeight.bold,
                                        //         fontSize: 14,
                                        //       );
                                        //       if (value == 0) {
                                        //         return Text('0', style: style);
                                        //       } else if (value % 5 == 0) {
                                        //         return Text('${value.toInt()}', style: style);
                                        //       }
                                        //       return Text('', style: style);
                                        //     },
                                        //     reservedSize: 40,
                                        //   ),
                                        // ),
                                      ),
                                      // borderData: FlBorderData(
                                      //   show: false,
                                      // ),
                                      barGroups: [
                                        BarChartGroupData(
                                          x: 0,
                                          barRods: [
                                            BarChartRodData(
                                                toY: buys[0],
                                                color: Colors.green,
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.04)
                                          ],
                                          showingTooltipIndicators:
                                              showToolTipp(0),
                                        ),
                                        BarChartGroupData(
                                          x: 1,
                                          barRods: [
                                            BarChartRodData(
                                                toY: buys[1],
                                                color: Colors.green,
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.04)
                                          ],
                                          showingTooltipIndicators:
                                              showToolTipp(1),
                                        ),
                                        BarChartGroupData(
                                          x: 2,
                                          barRods: [
                                            BarChartRodData(
                                                toY: buys[2],
                                                color: Colors.green,
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.04)
                                          ],
                                          showingTooltipIndicators:
                                              showToolTipp(2),
                                        ),
                                        BarChartGroupData(
                                          x: 3,
                                          barRods: [
                                            BarChartRodData(
                                                toY: buys[3],
                                                color: Colors.green,
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.04)
                                          ],
                                          showingTooltipIndicators:
                                              showToolTipp(3),
                                        ),
                                        BarChartGroupData(
                                          x: 4,
                                          barRods: [
                                            BarChartRodData(
                                                toY: buys[4],
                                                color: Colors.green,
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.04)
                                          ],
                                          showingTooltipIndicators:
                                              showToolTipp(4),
                                        ),
                                        BarChartGroupData(
                                          x: 5,
                                          barRods: [
                                            BarChartRodData(
                                                toY: buys[5],
                                                color: Colors.green,
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.04)
                                          ],
                                          showingTooltipIndicators:
                                              showToolTipp(5),
                                        ),
                                        BarChartGroupData(
                                          x: 6,
                                          barRods: [
                                            BarChartRodData(
                                                toY: buys[6],
                                                color: Colors.green,
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.04)
                                          ],
                                          showingTooltipIndicators:
                                              showToolTipp(6),
                                        ),
                                        BarChartGroupData(
                                          x: 7,
                                          barRods: [
                                            BarChartRodData(
                                                toY: buys[7],
                                                color: Colors.green,
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.04)
                                          ],
                                          showingTooltipIndicators:
                                              showToolTipp(7),
                                        ),
                                        BarChartGroupData(
                                          x: 8,
                                          barRods: [
                                            BarChartRodData(
                                                toY: buys[8],
                                                color: Colors.green,
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.04)
                                          ],
                                          showingTooltipIndicators:
                                              showToolTipp(8),
                                        ),
                                        BarChartGroupData(
                                          x: 9,
                                          barRods: [
                                            BarChartRodData(
                                                toY: buys[9],
                                                color: Colors.green,
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.04)
                                          ],
                                          showingTooltipIndicators:
                                              showToolTipp(9),
                                        ),
                                        BarChartGroupData(
                                          x: 10,
                                          barRods: [
                                            BarChartRodData(
                                                toY: buys[10],
                                                color: Colors.green,
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.04)
                                          ],
                                          showingTooltipIndicators:
                                              showToolTipp(10),
                                        ),
                                        BarChartGroupData(
                                          x: 11,
                                          barRods: [
                                            BarChartRodData(
                                                toY: buys[11],
                                                color: Colors.green,
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.04)
                                          ],
                                          showingTooltipIndicators:
                                              showToolTipp(11),
                                        ),
                                      ],
                                    ),
                                  ),
                                )))),
                    Column(children: [
                      Container(
                          height: MediaQuery.of(context).size.height * 0.03,
                          child: Center(
                            child: Text('Расходы',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontFamily: 'Times New Roman',
                                    fontSize: 20.0)),
                          ),
                        ),
                      Container(
                          height: MediaQuery.of(context).size.height * 0.32,
                          child: Scrollbar(
                            child: ListView.builder(
                                itemCount: buyPosts.length,
                                itemBuilder: (context, index) {
                                  return Padding(
                                    padding: EdgeInsets.all(5.0),
                                    child: InkWell(
                                      child: Container(
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(5.0),
                                            color: Colors.green),
                                        height: Utils.categorySize,
                                        child: Padding(
                                          padding: EdgeInsets.all(5.0),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Row(children: [Text('₽ '),Text(buyPosts[index][2]
                                                  .toString()),],),
                                              
                                              Text(buyPosts[index][1]
                                                  .toString()
                                                  .substring(5, 16))
                                            ],
                                          ),
                                        ),
                                      ),
                                      onTap: () {
                                        showBuyInfo(
                                            context, buyPosts[index][0]);
                                      },
                                    ),
                                  );
                                }),
                          ))
                    ])
                  ],
                )),
          ),
        ),
      );
    }
  }

  Widget buyPage(context) {
    args = ModalRoute.of(context)!.settings.arguments;
    buyerID = args[0] as int;
    isGroup = args[1];
    print(buyerID);
    return Scaffold(
        backgroundColor: Color.fromARGB(255, 73, 76, 83),
        appBar: appBar(context),
        body: sss(context, isDownload));
  }
}
