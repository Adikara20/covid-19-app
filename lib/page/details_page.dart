import 'package:flutter/material.dart';

import '../service/service_graphql.dart';
import '../widget/container_box.dart';
import '../widget/text_custom.dart';

import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:syncfusion_flutter_charts/sparkcharts.dart';

class DetailsPage extends StatefulWidget {
  final String country;
  final String filterby;
  const DetailsPage({Key? key, required this.country, required this.filterby})
      : super(key: key);

  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  var spesificCountry;
  var population = 0;
  var tests = 0;
  var cases = 0;
  var todayCases = 0;
  var deaths = 0;
  var todayDeaths = 0;
  var recovered = 0;
  var active = 0;
  var critical = 0;

  var spesificCountry2;
  var population2 = 0;
  var tests2 = 0;
  var cases2 = 0;
  var todayCases2 = 0;
  var deaths2 = 0;
  var todayDeaths2 = 0;
  var recovered2 = 0;
  var active2 = 0;
  var critical2 = 0;

  late TooltipBehavior _tooltipBehavior;

  @override
  void initState() {
    fetchSpesific();
    _tooltipBehavior = TooltipBehavior(enable: true);
    super.initState();
  }

  fetchSpesific() async {
    spesificCountry = await fetchSpesificCountry(widget.country, "twoDaysAgo");
    population = spesificCountry['result']['population'];
    tests = spesificCountry['result']['tests'];
    cases = spesificCountry['result']['cases'];
    todayCases = spesificCountry['result']['todayCases'];
    deaths = spesificCountry['result']['deaths'];
    todayDeaths = spesificCountry['result']['todayDeaths'];
    recovered = spesificCountry['result']['recovered'];
    active = spesificCountry['result']['active'];
    critical = spesificCountry['result']['critical'];

    spesificCountry2 = await fetchSpesificCountry(widget.country, "yesterday");
    population2 = spesificCountry2['result']['population'];
    tests2 = spesificCountry2['result']['tests'];
    cases2 = spesificCountry2['result']['cases'];
    todayCases2 = spesificCountry2['result']['todayCases'];
    deaths2 = spesificCountry2['result']['deaths'];
    todayDeaths2 = spesificCountry2['result']['todayDeaths'];
    recovered2 = spesificCountry2['result']['recovered'];
    active2 = spesificCountry2['result']['active'];
    critical2 = spesificCountry2['result']['critical'];

    setState(() {});
    // setState(() {
    //   covidCountries;
    // });
    //Future.delayed(const Duration(seconds: 1)).then((value) => setState(() {}));
  }

  @override
  Widget build(BuildContext context) {
    var sizeWidth = MediaQuery.of(context).size.width;
    var sizeHeight = MediaQuery.of(context).size.height;

    final List<ChartDataPopulationTestCase> chartDataPopulationTest =
        <ChartDataPopulationTestCase>[
      ChartDataPopulationTestCase('Population', population),
      ChartDataPopulationTestCase('Test Case', tests),
    ];

    final List<ChartDatatodayCases> chartDatatodayCases = <ChartDatatodayCases>[
      ChartDatatodayCases('two Days Ago', todayCases),
      ChartDatatodayCases('yesterday', todayCases),
    ];

    final List<ChartDatatodayDeath> chartDatatodayDeath = <ChartDatatodayDeath>[
      ChartDatatodayDeath('two Days Ago', todayDeaths2),
      ChartDatatodayDeath('yesterday', todayDeaths),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text("Details Data"),
      ),
      body: SafeArea(
        child: spesificCountry == null
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
                          padding: const EdgeInsets.all(10.0),
                          child: Column(
                            //crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Image(
                                    alignment: Alignment.topCenter,
                                    width: sizeWidth * 0.2,
                                    image: NetworkImage(
                                      spesificCountry['countryInfo']['flag'],
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 14,
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      const TextCustom(
                                        text:
                                            "Map of the spread of COVID-19\npositive cases\npowered by App Covid-19",
                                        size: 16,
                                        color: Colors.black,
                                      ),
                                      TextCustom(
                                        text:
                                            'at ${spesificCountry['country']}',
                                        size: 18,
                                        color: Colors.black,
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      const Icon(
                                        Icons.warning_sharp,
                                        size: 48,
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
                    child: SingleChildScrollView(
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
                                                    ChartDataPopulationTestCase,
                                                    String>(
                                                dataSource:
                                                    chartDataPopulationTest,
                                                enableTooltip: true,
                                                xValueMapper:
                                                    (ChartDataPopulationTestCase
                                                                data,
                                                            _) =>
                                                        data.x,
                                                yValueMapper:
                                                    (ChartDataPopulationTestCase
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
                                                    '${cases.toString()} total cases',
                                                size: 13.5,
                                                color: Colors.black,
                                              ),
                                              TextCustom(
                                                text:
                                                    '${deaths.toString()} total deaths',
                                                size: 13.5,
                                                color: Colors.black,
                                              ),
                                              TextCustom(
                                                text:
                                                    '${recovered.toString()} recovered',
                                                size: 13.5,
                                                color: Colors.black,
                                              ),
                                              TextCustom(
                                                text:
                                                    '${active.toString()} active cases',
                                                size: 13.5,
                                                color: Colors.black,
                                              ),
                                              const SizedBox(
                                                height: 4,
                                              ),
                                              TextCustom(
                                                text:
                                                    '${spesificCountry['result']['casesPerOneMillion'].toString()} cases/one million',
                                                size: 13.5,
                                                color: Colors.black,
                                              ),
                                              TextCustom(
                                                text:
                                                    '${spesificCountry['result']['deathsPerOneMillion'].toString()} death/one million',
                                                size: 13.5,
                                                color: Colors.black,
                                              ),
                                              TextCustom(
                                                text:
                                                    '${spesificCountry['result']['testsPerOneMillion'].toString()} test /one million',
                                                size: 13.5,
                                                color: Colors.black,
                                              ),
                                              TextCustom(
                                                text:
                                                    '${spesificCountry['result']['activePerOneMillion'].toString()} active/one million',
                                                size: 13.5,
                                                color: Colors.black,
                                              ),
                                              TextCustom(
                                                text:
                                                    '${spesificCountry['result']['recoveredPerOneMillion'].toString()} recivered/one million',
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
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: ContainerBox(
                              sizeWidth: sizeWidth,
                              sizeHeight: sizeHeight * 0.6,
                              widget: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: SingleChildScrollView(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const TextCustom(
                                        text: 'Visualization',
                                        size: 18,
                                        color: Colors.black,
                                      ),
                                      const SizedBox(
                                        height: 8,
                                      ),
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Flexible(
                                            flex: 1,
                                            fit: FlexFit.tight,
                                            child: SfCartesianChart(
                                              title: ChartTitle(
                                                  text: 'Data Today Cases',
                                                  textStyle: const TextStyle(
                                                      fontSize: 12),
                                                  alignment:
                                                      ChartAlignment.near),
                                              primaryXAxis: CategoryAxis(),
                                              series: <CartesianSeries>[
                                                ColumnSeries<
                                                        ChartDatatodayCases,
                                                        String>(
                                                    dataSource:
                                                        chartDatatodayCases,
                                                    xValueMapper:
                                                        (ChartDatatodayCases
                                                                    data,
                                                                _) =>
                                                            data.x,
                                                    yValueMapper:
                                                        (ChartDatatodayCases
                                                                    data,
                                                                _) =>
                                                            data.y),
                                              ],
                                            ),
                                          ),
                                          const SizedBox(
                                            width: 8,
                                          ),
                                          Flexible(
                                            flex: 1,
                                            fit: FlexFit.tight,
                                            child: SfCartesianChart(
                                              title: ChartTitle(
                                                  text: 'Data Today Deaths',
                                                  textStyle: const TextStyle(
                                                      fontSize: 12),
                                                  alignment:
                                                      ChartAlignment.near),
                                              primaryXAxis: CategoryAxis(),
                                              series: <CartesianSeries>[
                                                ColumnSeries<
                                                        ChartDatatodayDeath,
                                                        String>(
                                                    dataSource:
                                                        chartDatatodayDeath,
                                                    xValueMapper:
                                                        (ChartDatatodayDeath
                                                                    data,
                                                                _) =>
                                                            data.x,
                                                    yValueMapper:
                                                        (ChartDatatodayDeath
                                                                    data,
                                                                _) =>
                                                            data.y),
                                              ],
                                            ),
                                          ),
                                          // const TextCustom(
                                          //   text: 'Notes :',
                                          //   size: 14,
                                          //   color: Colors.black,
                                          // ),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}

class ChartDataPopulationTestCase {
  ChartDataPopulationTestCase(this.x, this.y);
  final String x;
  final int? y;
}

class ChartDatatodayCases {
  ChartDatatodayCases(this.x, this.y);
  final String x;
  final int? y;
}

class ChartDatatodayDeath {
  ChartDatatodayDeath(this.x, this.y);
  final String x;
  final int? y;
}
