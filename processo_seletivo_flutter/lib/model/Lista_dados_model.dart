class ListaDadosApi {
  final String id;
  final String country;
  final String confirmed;
  final String recovered;
  final String deaths;
  final String date;

  ListaDadosApi(
      {required this.id,
      required this.country,
      required this.confirmed,
      required this.recovered,
      required this.deaths,
      required this.date});

  factory ListaDadosApi.fromJson(Map<String, dynamic> json) {
    return ListaDadosApi(
        id: json['ID'] as String,
        country: json['country;'] as String,
        recovered: json['Recovered'] as String,
        deaths: json['Deaths'] as String,
        date: json['Date'] as String,
        confirmed: json['Confirmed'] as String);
  }
}
