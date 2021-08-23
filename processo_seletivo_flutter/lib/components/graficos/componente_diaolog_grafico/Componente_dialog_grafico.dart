import 'dart:ui';
import 'dart:convert';

import 'package:charts_flutter/flutter.dart' as charts;
import 'package:charts_flutter/flutter.dart';
import 'package:flutter/material.dart';
import 'package:processo_seletivo_flutter/components/model/model_grafico/Model_grafico_Linear.dart';

class ComponenteDialogGrafico extends StatefulWidget {
  final mediaMovelMortes;
  final mediaMovelCasosConfirmados;
  final totalMortes;
  final totalConfirmados;

  ComponenteDialogGrafico(
      {this.mediaMovelMortes,
      this.mediaMovelCasosConfirmados,
      this.totalMortes,
      this.totalConfirmados});

  @override
  _ComponenteDialogGraficoState createState() =>
      _ComponenteDialogGraficoState();
}

class _ComponenteDialogGraficoState extends State<ComponenteDialogGrafico> {
  static List<charts.Series<LinearGrafico, int>> _createSampleData(
      final mediaMovelMortes,
      final mediaMovelCasosConfirmados,
      final totalMortes,
      final totalConfirmados) {
    final graficoDo = [
      new LinearGrafico(2, totalMortes, MaterialPalette.red.shadeDefault),
      new LinearGrafico(3, totalConfirmados, MaterialPalette.blue.shadeDefault),
      new LinearGrafico(4, mediaMovelMortes, MaterialPalette.black),
      new LinearGrafico(
          5, mediaMovelCasosConfirmados, MaterialPalette.yellow.shadeDefault),
    ];

    return [
      new charts.Series<LinearGrafico, int>(
        id: 'Sales',
        domainFn: (LinearGrafico sales, _) => sales.year,
        measureFn: (LinearGrafico sales, _) => sales.sales,
        colorFn: (LinearGrafico sales, _) => sales.color,
        data: graficoDo,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height / 2,
            child: new charts.PieChart(
                _createSampleData(
                    widget.mediaMovelMortes,
                    widget.mediaMovelCasosConfirmados,
                    widget.totalMortes,
                    widget.totalConfirmados),
                animate: true),
          )
        ],
      ),
    );
  }
}
