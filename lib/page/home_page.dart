import 'package:covid_19_app/page/sub_page/main_page_US_only.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

import '../model/queries.dart';
import '../service/service_graphql.dart';
import 'details_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<dynamic> covidCountries = [];
  String sortyBy = 'Alphabet';

  var items = [
    'Alphabet',
    'Cases',
    'Death',
  ];

  @override
  void initState() {
    fetchAll();
    super.initState();
  }

  fetchAll() async {
    covidCountries = await fetchAllData();
    Future.delayed(const Duration(seconds: 1)).then((value) => setState(() {}));
  }

  fetchCountriesCases() async {
    covidCountries = await fetchDataByCases();
    Future.delayed(const Duration(seconds: 1)).then((value) => setState(() {}));
  }

  fetchCountriesDeaths() async {
    covidCountries = await fetchDataByDeaths();
    Future.delayed(const Duration(seconds: 1)).then((value) => setState(() {}));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Covid - 19 Data"),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: covidCountries.isEmpty
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        const Text("Sort by "),
                        DropdownButton(
                          value: sortyBy,
                          icon: const Icon(Icons.keyboard_arrow_down),
                          items: items.map((String items) {
                            return DropdownMenuItem(
                              value: items,
                              child: Text(
                                items,
                                style: const TextStyle(
                                  color: Colors.amber,
                                ),
                              ),
                            );
                          }).toList(),
                          onChanged: (String? newValue) {
                            setState(() {
                              sortyBy = newValue!;
                            });
                            if (sortyBy == 'Alphabet') {
                              covidCountries = [];
                              fetchAll();
                            } else if (sortyBy == 'Cases') {
                              covidCountries = [];
                              fetchCountriesCases();
                            } else {
                              covidCountries = [];
                              fetchCountriesDeaths();
                            }
                          },
                        ),
                      ],
                    ),
                    Expanded(
                      child: ListView.builder(
                          itemCount: covidCountries.length,
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () {
                                // fetchSpesificCountry(
                                //     covidCountries[index]['country'], "yesterday");
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => covidCountries[index]
                                                ['country'] ==
                                            "USA"
                                        ? MainPageUS()
                                        : DetailsPage(
                                            country: covidCountries[index]
                                                ['country'],
                                            filterby: "yesterday",
                                          ),
                                  ),
                                );
                              },
                              child: Card(
                                child: ListTile(
                                  leading: sortyBy == "Alphabet"
                                      ? CircleAvatar(
                                          backgroundImage: NetworkImage(
                                            covidCountries[index]['countryInfo']
                                                ['flag'],
                                          ),
                                        )
                                      : Text((index + 1).toString()),
                                  title: Text(covidCountries[index]['country']),
                                  subtitle:
                                      Text(covidCountries[index]['continent']),
                                  trailing: sortyBy != "Death"
                                      ? RichText(
                                          text: TextSpan(
                                            text: 'Total Cases\n',
                                            style: DefaultTextStyle.of(context)
                                                .style,
                                            children: <TextSpan>[
                                              TextSpan(
                                                text: covidCountries[index]
                                                        ['result']['cases']
                                                    .toString(),
                                                style: const TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.red),
                                              ),
                                            ],
                                          ),
                                        )
                                      : RichText(
                                          text: TextSpan(
                                            text: 'Total Deaths\n',
                                            style: DefaultTextStyle.of(context)
                                                .style,
                                            children: <TextSpan>[
                                              TextSpan(
                                                text: covidCountries[index]
                                                        ['result']['deaths']
                                                    .toString(),
                                                style: const TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.red),
                                              ),
                                            ],
                                          ),
                                        ),
                                ),
                              ),
                            );
                          }),
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}
