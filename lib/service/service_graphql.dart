import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

import '../model/queries.dart';

Future<List> fetchAllData() async {
  List<dynamic> tempCountries = [];
  HttpLink link = HttpLink("https://covid19-graphql.netlify.app/");
  GraphQLClient qlClient = GraphQLClient(
    link: link,
    cache: GraphQLCache(
      store: HiveStore(),
    ),
  );
  QueryResult queryResult = await qlClient.query(
    QueryOptions(
      document: gql(
        allCountryQueries,
      ),
    ),
  );
  tempCountries = queryResult.data!['countries'];
  return tempCountries;
}

fetchSpesificCountry(String country, String filter) async {
  var tempSpesificCountry;
  HttpLink link = HttpLink("https://covid19-graphql.netlify.app/");
  GraphQLClient qlClient = GraphQLClient(
    link: link,
    cache: GraphQLCache(
      store: HiveStore(),
    ),
  );
  QueryResult queryResult = await qlClient.query(
    QueryOptions(
      document: gql(
        stringSpesificCountryQueries(country, filter),
      ),
    ),
  );
  tempSpesificCountry = queryResult.data!['country'];
  return tempSpesificCountry;
}

Future<List> fetchDataByCases() async {
  List<dynamic> tempCountriesByCases = [];
  HttpLink link = HttpLink("https://covid19-graphql.netlify.app/");
  GraphQLClient qlClient = GraphQLClient(
    link: link,
    cache: GraphQLCache(
      store: HiveStore(),
    ),
  );
  QueryResult queryResult = await qlClient.query(
    QueryOptions(
      document: gql(
        stringCountryWithMostCases,
      ),
    ),
  );
  tempCountriesByCases = queryResult.data!['countries'];
  return tempCountriesByCases;
}

Future<List> fetchDataByDeaths() async {
  List<dynamic> tempCountriesByDeaths = [];
  HttpLink link = HttpLink("https://covid19-graphql.netlify.app/");
  GraphQLClient qlClient = GraphQLClient(
    link: link,
    cache: GraphQLCache(
      store: HiveStore(),
    ),
  );
  QueryResult queryResult = await qlClient.query(
    QueryOptions(
      document: gql(
        stringCountryWithMostDeaths,
      ),
    ),
  );
  tempCountriesByDeaths = queryResult.data!['countries'];
  return tempCountriesByDeaths;
}

Future<List> fetchStateUS() async {
  List<dynamic> tempStateUS = [];
  HttpLink link = HttpLink("https://covid19-graphql.netlify.app/");
  GraphQLClient qlClient = GraphQLClient(
    link: link,
    cache: GraphQLCache(
      store: HiveStore(),
    ),
  );
  QueryResult queryResult = await qlClient.query(
    QueryOptions(
      document: gql(
        stringAllStateUS,
      ),
    ),
  );
  tempStateUS = queryResult.data!['states'];
  return tempStateUS;
}

fetchSpesificStateUS(String state) async {
  var tempSpesificState;
  HttpLink link = HttpLink("https://covid19-graphql.netlify.app/");
  GraphQLClient qlClient = GraphQLClient(
    link: link,
    cache: GraphQLCache(
      store: HiveStore(),
    ),
  );
  QueryResult queryResult = await qlClient.query(
    QueryOptions(
      document: gql(
        stringSpesificStateUS(state),
      ),
    ),
  );
  tempSpesificState = queryResult.data!['state'];
  return tempSpesificState;
}
