import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'index.dart';

import 'package:pie_chart/pie_chart.dart';

class Analytics extends StatefulWidget {
  const Analytics({super.key});
  
  @override
  State<Analytics> createState() => _AnalyticsState();
}

class _AnalyticsState extends State<Analytics> {
  
  var box = Hive.box('medication');

  double percentage = 0.97;


  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    Map<String, double> dataMap = {
    "Completed": percentage,
      "Remaining": 100 - percentage,
    };
    
    return Scaffold(
      appBar: AppBar(title: const Text('Analytics'),),
      body: Column( children: [
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Expanded(
                        child:
                        Align(
                          alignment: Alignment.center,
                          child: Text('perfect days streak',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                            softWrap: true,
                          ),
                        )
                      ),
                      Expanded(
                        child:
                        Align(
                          alignment: Alignment.center,
                          child: Text('on time',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                        )
                      ),

                    ]
                  )
                ),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      const Text('${3}d', style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),),
                      Stack(
                        alignment: Alignment.center,
                        children: [
                          PieChart(
                            initialAngleInDegree: 270,
                            dataMap: dataMap,
                            chartType: ChartType.disc,
                            animationDuration: const Duration(milliseconds: 500),
                            chartRadius: MediaQuery.of(context).size.width / 3.2,
                            colorList: [Colors.red.shade300, Colors.green.shade300],
                            legendOptions: const LegendOptions(
                              showLegends: false,
                            ),
                            chartValuesOptions: const ChartValuesOptions(
                              showChartValueBackground: false,
                              showChartValues: false,
                              showChartValuesInPercentage: false,
                            ),
                          ),
                          Text('${percentage*100}%',
                            style: const TextStyle(
                              fontSize: 19,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                )
                
        ],
    )
    );
  }

}