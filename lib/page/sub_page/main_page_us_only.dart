import 'package:covid_19_app/model/queries.dart';
import 'package:covid_19_app/service/service_graphql.dart';
import 'package:flutter/material.dart';

import 'details_page_us.dart';

class MainPageUS extends StatefulWidget {
  const MainPageUS({Key? key}) : super(key: key);

  @override
  State<MainPageUS> createState() => _MainPageUSState();
}

class _MainPageUSState extends State<MainPageUS> {
  List<dynamic> covidStatesUS = [];

  @override
  void initState() {
    fetchAllUS();
    super.initState();
  }

  fetchAllUS() async {
    covidStatesUS = await fetchStateUS();
    Future.delayed(const Duration(seconds: 1)).then((value) => setState(() {}));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("State in USA"),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: covidStatesUS.isEmpty
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : ListView.builder(
                  itemCount: covidStatesUS.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => DetailsPageUS(
                              stringState: covidStatesUS[index]['state'],
                            ),
                          ),
                        );
                      },
                      child: Card(
                        child: ListTile(
                          title: Text(covidStatesUS[index]['state']),
                          subtitle: const Text('USA'),
                          trailing: RichText(
                            text: TextSpan(
                              text: 'Total Cases\n',
                              style: DefaultTextStyle.of(context).style,
                              children: <TextSpan>[
                                TextSpan(
                                  text: covidStatesUS[index]['result']['cases']
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
                  },
                ),
        ),
      ),
    );
  }
}
