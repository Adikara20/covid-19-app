import 'package:covid_19_app/service/service_graphql.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../widget/container_box.dart';
import '../../widget/text_custom.dart';

class DetailsPageUS extends StatefulWidget {
  final String stringState;
  const DetailsPageUS({Key? key, required this.stringState}) : super(key: key);

  @override
  State<DetailsPageUS> createState() => _DetailsPageUSState();
}

class _DetailsPageUSState extends State<DetailsPageUS> {
  var spesificStateUS;
  var population = 0;
  var testCase = 0;
  late TooltipBehavior _tooltipBehavior;

  @override
  void initState() {
    fetchSpesificStateData();
    _tooltipBehavior = TooltipBehavior(enable: true);
    super.initState();
  }

  fetchSpesificStateData() async {
    spesificStateUS = await fetchSpesificStateUS(widget.stringState);
    population = spesificStateUS['result']['population'];
    testCase = spesificStateUS['result']['tests'];
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    var sizeWidth = MediaQuery.of(context).size.width;
    var sizeHeight = MediaQuery.of(context).size.height;

    final List<ChartDataPopulationStateUSTestCase>
        chartDataPopulationStateTest = <ChartDataPopulationStateUSTestCase>[
      ChartDataPopulationStateUSTestCase('Population', population),
      ChartDataPopulationStateUSTestCase('Test Case', testCase),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text("Detail State"),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: spesificStateUS == null
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: ContainerBox(
                        sizeWidth: sizeWidth,
                        sizeHeight: sizeHeight * 0.3,
                        widget: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15.0),
                            image: const DecorationImage(
                              opacity: 0.85,
                              fit: BoxFit.fill,
                              image: AssetImage('assets/images/background.jpg'),
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Column(
                              //crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        const TextCustom(
                                          text:
                                              "Map of the spread of COVID-19\npositive cases\npowered by App Covid-19",
                                          size: 16,
                                          color: Colors.black,
                                        ),
                                        TextCustom(
                                          text:
                                              'at ${spesificStateUS['state']}',
                                          size: 18,
                                          color: Colors.black,
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        const Icon(
                                          Icons.warning_sharp,
                                          size: 40,
                                          color: Colors.red,
                                        ),
                                        const TextCustom(
                                          text:
                                              "Remind others\nto always perform\nhealth protocols.",
                                          size: 16,
                                          color: Colors.black,
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Flexible(
                                flex: 1,
                                fit: FlexFit.tight,
                                child: Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: ContainerBox(
                                    sizeWidth: sizeWidth,
                                    sizeHeight: sizeHeight * 0.3,
                                    widget: Center(
                                      child: SfCircularChart(
                                          margin: const EdgeInsets.all(0),
                                          title: ChartTitle(
                                              text: 'Population with Test Case',
                                              textStyle:
                                                  const TextStyle(fontSize: 11),
                                              alignment: ChartAlignment.center),
                                          legend: Legend(
                                              isVisible: true,
                                              position: LegendPosition.bottom,
                                              orientation: LegendItemOrientation
                                                  .vertical),
                                          tooltipBehavior: _tooltipBehavior,
                                          series: <CircularSeries>[
                                            PieSeries<
                                                    ChartDataPopulationStateUSTestCase,
                                                    String>(
                                                dataSource:
                                                    chartDataPopulationStateTest,
                                                enableTooltip: true,
                                                xValueMapper:
                                                    (ChartDataPopulationStateUSTestCase
                                                                data,
                                                            _) =>
                                                        data.x,
                                                yValueMapper:
                                                    (ChartDataPopulationStateUSTestCase
                                                                data,
                                                            _) =>
                                                        data.y,
                                                dataLabelSettings:
                                                    const DataLabelSettings(
                                                        isVisible: true),
                                                explode: true,
                                                explodeIndex: 1)
                                          ]),
                                    ),
                                  ),
                                ),
                              ),
                              Flexible(
                                flex: 1,
                                fit: FlexFit.tight,
                                child: Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: ContainerBox(
                                    sizeWidth: sizeWidth,
                                    sizeHeight: sizeHeight * 0.3,
                                    widget: Container(
                                      decoration: BoxDecoration(
                                        // color:
                                        //     Color.fromARGB(255, 255, 210, 87),
                                        borderRadius:
                                            BorderRadius.circular(15.0),
                                        image: const DecorationImage(
                                          fit: BoxFit.fill,
                                          opacity: 0.85,
                                          image: AssetImage(
                                              'assets/images/background2.jpg'),
                                        ),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(10.0),
                                        child: SingleChildScrollView(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              const TextCustom(
                                                text: 'Updated Case',
                                                size: 15,
                                                color: Colors.black,
                                              ),
                                              const SizedBox(
                                                height: 5,
                                              ),
                                              TextCustom(
                                                text:
                                                    '${spesificStateUS['result']['cases'].toString()} total cases',
                                                size: 13.5,
                                                color: Colors.black,
                                              ),
                                              TextCustom(
                                                text:
                                                    '${spesificStateUS['result']['deaths'].toString()} total deaths',
                                                size: 13.5,
                                                color: Colors.black,
                                              ),
                                              TextCustom(
                                                text:
                                                    '${spesificStateUS['result']['active'].toString()} active cases',
                                                size: 13.5,
                                                color: Colors.black,
                                              ),
                                              const SizedBox(
                                                height: 4,
                                              ),
                                              TextCustom(
                                                text:
                                                    '${spesificStateUS['result']['casesPerOneMillion'].toString()} cases/one million',
                                                size: 13.5,
                                                color: Colors.black,
                                              ),
                                              TextCustom(
                                                text:
                                                    '${spesificStateUS['result']['deathsPerOneMillion'].toString()} death/one million',
                                                size: 13.5,
                                                color: Colors.black,
                                              ),
                                              TextCustom(
                                                text:
                                                    '${spesificStateUS['result']['testsPerOneMillion'].toString()} test /one million',
                                                size: 13.5,
                                                color: Colors.black,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}

class ChartDataPopulationStateUSTestCase {
  ChartDataPopulationStateUSTestCase(this.x, this.y);
  final String x;
  final int? y;
}
