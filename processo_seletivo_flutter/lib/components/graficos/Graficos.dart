import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:processo_seletivo_flutter/services/Services_graficos.dart';

class Grafico extends StatefulWidget {
  @override
  _GraficoTimeSeriesChartState createState() => _GraficoTimeSeriesChartState();
}

class _GraficoTimeSeriesChartState extends State<Grafico> {
  final List<charts.Series> seriesList = [];
  final bool animate = true;

  DateTime dataHoje = DateTime.now();
  DateTime dataParaCalcularMedia = DateTime.now().subtract(Duration(days: 14));

  void obterDadosRequisicao() {
    var dataHojeFormatada = DateFormat("yyyy-MM-dd").format(dataHoje);
    var dataParaCalculoFormatada =
        DateFormat("yyyy-MM-dd").format(dataParaCalcularMedia);
    obterGrafico(http.Client(),
        dataParaCalculoMedia: dataParaCalculoFormatada,
        dataHoje: dataHojeFormatada);
  }

  static List<charts.Series<DadosGraficos, DateTime>> _createSampleData() {
    final data = [
      new DadosGraficos(new DateTime.now().subtract(Duration(days: 14)), 150),
    ];
    final data2 = [
      new DadosGraficos(new DateTime.now().subtract(Duration(days: 14)), 600),
    ];

    return [
      new charts.Series<DadosGraficos, DateTime>(
        id: 'Sales',
        colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
        domainFn: (DadosGraficos sales, _) => sales.time,
        measureFn: (DadosGraficos sales, _) => sales.sales,
        data: data,
      ),
      new charts.Series<DadosGraficos, DateTime>(
        id: 'Sales',
        colorFn: (_, __) => charts.MaterialPalette.red.shadeDefault,
        domainFn: (DadosGraficos sales, _) => sales.time,
        measureFn: (DadosGraficos sales, _) => sales.sales,
        data: data2,
      )
    ];
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    this.obterDadosRequisicao();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: new charts.TimeSeriesChart(
        _createSampleData(),
        animate: animate,
        dateTimeFactory: const charts.LocalDateTimeFactory(),
      ),
    );
  }
}

class DadosGraficos {
  final DateTime time;
  final int sales;

  DadosGraficos(this.time, this.sales);
}
