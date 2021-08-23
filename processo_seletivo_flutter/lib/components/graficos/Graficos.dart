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
  List dados = [];

  var morte;
  var confirmados;
  var morteMedia;
  var confirmadoMedia;
  DateTime dataHoje = DateTime.now();
  DateTime dataParaCalcularMedia = DateTime.now().subtract(Duration(days: 15));

  get mortes => null;

  obterDadosRequisicao() {
    var dataHojeFormatada = DateFormat("yyyy-MM-dd").format(dataHoje);
    var dataParaCalculoFormatada =
        DateFormat("yyyy-MM-dd").format(dataParaCalcularMedia);

    obterGrafico(http.Client(),
            dataParaCalculoMedia: dataParaCalculoFormatada,
            dataHoje: dataHojeFormatada)
        .then((value) => {adicionaValoresDentroDasVariavel(value)});
  }

  adicionaValoresDentroDasVariavel(var dadosApi) {
    setState(() {
      confirmados = dadosApi["totalNovosCasos"];
      morte = dadosApi["totalMortes"];
      confirmadoMedia = dadosApi["mediaMovelConfirmados"];
      morteMedia = dadosApi["mediaMovelMortes"];
    });
  }

  static List<charts.Series<ModelGraficos, String>> _createSampleData(
    var confirmados,
    var morte,
    var confirmadoMedia,
    var morteMedia,
  ) {
    final dadosConfirmados = [
      new ModelGraficos(confirmados, 'Confirmados'),
    ];
    final dadosMediaConfirmados = [
      new ModelGraficos(confirmadoMedia, 'Confirmados'),
    ];
    final dadosDeObitos = [
      new ModelGraficos(morte, 'Mortes'),
    ];
    final dadosMediaMortes = [
      new ModelGraficos(morteMedia, 'Mortes'),
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
    return morte == null ||
            confirmados == null ||
            morteMedia == null ||
            confirmadoMedia == null
        ? Center(
            child: CircularProgressIndicator(),
          )
        : Padding(
            padding: const EdgeInsets.all(15.0),
            child: GestureDetector(
              onTap: () => showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    NumberFormat formatter = NumberFormat("00.00");

                    return GestureDetector(
                        onTap: () => Navigator.of(context).pop(),
                        child: AlertDialog(
                            title: Text('Dados Covid-19 bo Brasil hoje'),
                            content: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Text("Total de mortos: "),
                                    Text(
                                      "$morte",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    )
                                  ],
                                ),
                                Row(
                                  children: [
                                    Text(
                                      "Total de confirmados: ",
                                    ),
                                    Text(
                                      "$confirmados",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    )
                                  ],
                                ),
                                Row(
                                  children: [
                                    Text(
                                      "Media Movel de mortos: ",
                                    ),
                                    Text(
                                      "${formatter.format(morteMedia)}",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    )
                                  ],
                                ),
                                Row(
                                  children: [
                                    Text(
                                      "Media Movel de casos: ",
                                    ),
                                    Text(
                                      "${formatter.format(confirmadoMedia)}",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    )
                                  ],
                                ),
                              ],
                            ),
                            actions: [
                              ComponenteDialogGrafico(
                                mediaMovelCasosConfirmados: confirmadoMedia,
                                mediaMovelMortes: morteMedia,
                                totalConfirmados: confirmados,
                                totalMortes: morte,
                              ),
                            ]));
                  }),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Center(
                    child: Text('Relatório de hoje',
                        style: TextStyle(fontWeight: FontWeight.bold)),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height / 2,
                    child: new charts.BarChart(
                      _createSampleData(
                        confirmados,
                        morte,
                        confirmadoMedia,
                        morteMedia,
                      ),
                      animate: animate,
                    ),
                  ),
                  ComponentLegenda()
                ],
              ),
            ));
  }
}
