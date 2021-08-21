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
  final List dadosDosDias = [];
  final List dadosDasRequisicao = [];

  DateTime dataHoje = DateTime.now();
  DateTime dataParaCalcularMedia = DateTime.now().subtract(Duration(days: 14));

  obterDadosRequisicao() {
    var dataHojeFormatada = DateFormat("yyyy-MM-dd").format(dataHoje);
    var dataParaCalculoFormatada =
        DateFormat("yyyy-MM-dd").format(dataParaCalcularMedia);
    obterGrafico(http.Client(),
            dataParaCalculoMedia: dataParaCalculoFormatada,
            dataHoje: dataHojeFormatada)
        .then((value) =>
            {adicionaValoresDentroDoArray(value[0]['todosOsDados'], value)});
  }

  adicionaValoresDentroDoArray(List dados, List dadosRequisicao) {
    setState(() {
      dadosDosDias.addAll(dados);
      dadosDasRequisicao.addAll(dadosRequisicao);
      print(dadosDasRequisicao[0]['mediaMortes']);
    });
  }

  static List<charts.Series<DadosGraficos, String>> _createSampleData(
      List dados, List dadosRequisicao) {
    final dadosConfirmados = [
      new DadosGraficos(dados[0]['Confirmed'], 'Confirmados'),
    ];
    final dadosMediaConfirmados = [
      new DadosGraficos(dadosRequisicao[0]['mediaConfirmados'], 'Confirmados'),
    ];
    final dadosDeObitos = [
      new DadosGraficos(dados[0]['Deaths'], 'Mortes'),
    ];
    final dadosMediaMortes = [
      new DadosGraficos(dadosRequisicao[0]['mediaMortes'], 'Mortes'),
    ];

    final dadosDeRecuperados = [
      new DadosGraficos(dados[0]['Recovered'], 'Recuperados'),
    ];

    final dadosMediaDeRecuperados = [
      new DadosGraficos(dadosRequisicao[0]['mediaRecuperados'], 'Recuperados'),
    ];

    return [
      new charts.Series<DadosGraficos, String>(
        id: 'casosConfirmados',
        colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
        domainFn: (DadosGraficos sales, _) => sales.texto,
        measureFn: (DadosGraficos sales, _) => sales.numero,
        data: dadosConfirmados,
      ),
      new charts.Series<DadosGraficos, String>(
        id: 'mediaConfirmados',
        colorFn: (_, __) => charts.MaterialPalette.yellow.shadeDefault,
        domainFn: (DadosGraficos sales, _) => sales.texto,
        measureFn: (DadosGraficos sales, _) => sales.numero,
        data: dadosMediaConfirmados,
      ),
      new charts.Series<DadosGraficos, String>(
        id: 'casosDeObitos',
        colorFn: (_, __) => charts.MaterialPalette.red.shadeDefault,
        domainFn: (DadosGraficos sales, _) => sales.texto,
        measureFn: (DadosGraficos sales, _) => sales.numero,
        data: dadosDeObitos,
      ),
      new charts.Series<DadosGraficos, String>(
        id: 'mediaDeObitos',
        colorFn: (_, __) => charts.MaterialPalette.yellow.shadeDefault,
        domainFn: (DadosGraficos sales, _) => sales.texto,
        measureFn: (DadosGraficos sales, _) => sales.numero,
        data: dadosMediaMortes,
      ),
      new charts.Series<DadosGraficos, String>(
        id: 'casosDeRecuperado',
        colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
        domainFn: (DadosGraficos sales, _) => sales.texto,
        measureFn: (DadosGraficos sales, _) => sales.numero,
        data: dadosDeRecuperados,
      ),
      new charts.Series<DadosGraficos, String>(
        id: 'mediaDeRecuperado',
        colorFn: (_, __) => charts.MaterialPalette.yellow.shadeDefault,
        domainFn: (DadosGraficos sales, _) => sales.texto,
        measureFn: (DadosGraficos sales, _) => sales.numero,
        data: dadosMediaDeRecuperados,
      ),
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
        child: dadosDosDias == null || dadosDosDias.isEmpty
            ? Center(
                child: CircularProgressIndicator(),
              )
            : new charts.BarChart(
                _createSampleData(dadosDosDias, dadosDasRequisicao),
                animate: animate,
              ));
  }
}

class DadosGraficos {
  final numero;
  final texto;

  DadosGraficos(this.numero, this.texto);
}
