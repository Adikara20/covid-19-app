String allCountryQueries = """query countries {
                countries {
                    country
                    countryInfo {
                        _id
                        lat
                        long
                        flag
                        iso3
                        iso2
                    }
                    continent
                    result {
                        population
                        tests
                        cases
                        todayCases
                        deaths
                        todayDeaths
                        recovered
                        active
                        critical
                        casesPerOneMillion
                        deathsPerOneMillion
                        testsPerOneMillion
                        activePerOneMillion
                        recoveredPerOneMillion
                        criticalPerOneMillion
                        updated
                    }
                }
            
          }""";

String stringSpesificCountryQueries(String country, String filterby) {
  var queriesString = """query country {
                  country(name: "$country", filterBy: $filterby) {
                    country
                    countryInfo {
                      _id
                      lat
                      long
                      flag
                      iso2
                      iso3
                    }
                    continent
                    result {
                      population
                      tests
                      cases
                      todayCases
                      deaths
                      todayDeaths
                      recovered
                      active
                      critical
                      casesPerOneMillion
                      deathsPerOneMillion
                      testsPerOneMillion
                      activePerOneMillion
                      recoveredPerOneMillion
                      criticalPerOneMillion
                      updated
                    }
                  }
                }
              """;
  return queriesString;
}

String stringCountryWithMostCases = """ query countries {
    countries(sortBy: cases) {
        country
        continent
        result {
            active
            cases
            todayCases
            deathsPerOneMillion
            updated
        }
    }
}
""";

String stringCountryWithMostDeaths = """ query countries {
    countries(sortBy: deaths) {
        country
        continent
        result {
            active
            deaths
            todayDeaths
            deathsPerOneMillion
            updated
        }
    }
} 
""";

String stringAllStateUS = """ query states {
    states {
        state
        result {
            population
            active
            tests
            cases
            todayCases
            deaths
            todayDeaths
            casesPerOneMillion
            deathsPerOneMillion
            testsPerOneMillion
            updated
        }
    }
}""";

String stringSpesificStateUS(String stateUS) {
  var tempStateUS = """ query state {
    state(name: "$stateUS") {
        state
        result {
            population
            active
            tests
            cases
            todayCases
            deaths
            todayDeaths
            casesPerOneMillion
            deathsPerOneMillion
            testsPerOneMillion
            updated
        }
    }
} 
  """;
  return tempStateUS;
}
