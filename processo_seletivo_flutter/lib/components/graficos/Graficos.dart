import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:processo_seletivo_flutter/components/componente_diaolog_grafico/Componente_dialog_grafico.dart';
import 'package:processo_seletivo_flutter/components/componente_legenda/Componente_legenda.dart';
import 'package:processo_seletivo_flutter/components/model/model_grafico/Model_grafico.dart';
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

  get dadosRequisicao => null;

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

  static List<charts.Series<ModelGraficos, String>> _createSampleData(
      List dados, List dadosRequisicao) {
    final dadosConfirmados = [
      new ModelGraficos(dados[0]['Confirmed'], 'Confirmados'),
    ];
    final dadosMediaConfirmados = [
      new ModelGraficos(dadosRequisicao[0]['mediaConfirmados'], 'Confirmados'),
    ];
    final dadosDeObitos = [
      new ModelGraficos(dados[0]['Deaths'], 'Mortes'),
    ];
    final dadosMediaMortes = [
      new ModelGraficos(dadosRequisicao[0]['mediaMortes'], 'Mortes'),
    ];

    final dadosDeRecuperados = [
      new ModelGraficos(dados[0]['Recovered'], 'Recuperados'),
    ];

    final dadosMediaDeRecuperados = [
      new ModelGraficos(dadosRequisicao[0]['mediaRecuperados'], 'Recuperados'),
    ];

    return [
      new charts.Series<ModelGraficos, String>(
        id: 'casosConfirmados',
        colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
        domainFn: (ModelGraficos sales, _) => sales.texto,
        measureFn: (ModelGraficos sales, _) => sales.numero,
        data: dadosConfirmados,
      ),
      new charts.Series<ModelGraficos, String>(
        id: 'mediaConfirmados',
        colorFn: (_, __) => charts.MaterialPalette.yellow.shadeDefault,
        domainFn: (ModelGraficos sales, _) => sales.texto,
        measureFn: (ModelGraficos sales, _) => sales.numero,
        data: dadosMediaConfirmados,
      ),
      new charts.Series<ModelGraficos, String>(
        id: 'casosDeObitos',
        colorFn: (_, __) => charts.MaterialPalette.red.shadeDefault,
        domainFn: (ModelGraficos sales, _) => sales.texto,
        measureFn: (ModelGraficos sales, _) => sales.numero,
        data: dadosDeObitos,
      ),
      new charts.Series<ModelGraficos, String>(
        id: 'mediaDeObitos',
        colorFn: (_, __) => charts.MaterialPalette.black,
        domainFn: (ModelGraficos sales, _) => sales.texto,
        measureFn: (ModelGraficos sales, _) => sales.numero,
        data: dadosMediaMortes,
      ),
      new charts.Series<ModelGraficos, String>(
        id: 'casosDeRecuperado',
        colorFn: (_, __) => charts.MaterialPalette.green.shadeDefault,
        domainFn: (ModelGraficos sales, _) => sales.texto,
        measureFn: (ModelGraficos sales, _) => sales.numero,
        data: dadosDeRecuperados,
      ),
      new charts.Series<ModelGraficos, String>(
        id: 'mediaDeRecuperado',
        colorFn: (_, __) => charts.MaterialPalette.deepOrange.shadeDefault,
        domainFn: (ModelGraficos sales, _) => sales.texto,
        measureFn: (ModelGraficos sales, _) => sales.numero,
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
            : GestureDetector(
                onTap: () => showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                          content: ComponenteDialogGrafico(
                        mediaMovelCasosConfirmados: dadosDasRequisicao[0]
                            ['mediaConfirmados'],
                        mediaMovelMortes: dadosDasRequisicao[0]['mediaMortes'],
                        mediaMovelDeRecuperados: dadosDasRequisicao[0]
                            ['mediaRecuperados'],
                        totalConfirmados: dadosDosDias[0]['Confirmed'],
                        totalMortes: dadosDosDias[0]['Deaths'],
                        totalRecuperados: dadosDosDias[0]['Recovered'],
                      ));
                    }),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height / 2,
                      child: new charts.BarChart(
                        _createSampleData(dadosDosDias, dadosDasRequisicao),
                        animate: animate,
                      ),
                    ),
                    ComponentLegenda()
                  ],
                ),
              ));
  }
}
