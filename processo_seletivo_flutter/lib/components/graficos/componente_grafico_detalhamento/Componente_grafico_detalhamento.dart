import 'dart:ui';
import 'dart:convert';

import 'package:charts_flutter/flutter.dart' as charts;
import 'package:charts_flutter/flutter.dart';
import 'package:flutter/material.dart';

class ComponenteGraficoDetalhamento extends StatelessWidget {
  final mediaMovelObjetoSelecionado;
  final mediaMovelCasosObjetoSelecionado;
  final totalCasosObjetoSelecionado;
  final totalMortesObjetoSelecionado;
  ComponenteGraficoDetalhamento(
      {this.mediaMovelObjetoSelecionado,
      this.mediaMovelCasosObjetoSelecionado,
      this.totalCasosObjetoSelecionado,
      this.totalMortesObjetoSelecionado});
  @override
  Widget build(BuildContext context) {
    return new charts.PieChart(
        _createSampleData(
          mediaMovelObjetoSelecionado,
          mediaMovelCasosObjetoSelecionado,
          totalCasosObjetoSelecionado,
          totalMortesObjetoSelecionado,
        ),
        animationDuration: Duration(seconds: 4),
        animate: true);
  }

  /// Create one series with sample hard coded data.
  static List<charts.Series<ModelGraficos, int>> _createSampleData(
    final mediaMovelObjetoSelecionado,
    final mediaMovelCasosObjetoSelecionado,
    final totalCasosObjetoSelecionado,
    final totalMortesObjetoSelecionado,
  ) {
    final data = [
      new ModelGraficos(0, mediaMovelObjetoSelecionado, MaterialPalette.black),
      new ModelGraficos(1, mediaMovelCasosObjetoSelecionado,
          MaterialPalette.yellow.shadeDefault),
      new ModelGraficos(
          2, totalCasosObjetoSelecionado, MaterialPalette.blue.shadeDefault),
      new ModelGraficos(
          3, totalMortesObjetoSelecionado, MaterialPalette.red.shadeDefault),
    ];

    return [
      new charts.Series<ModelGraficos, int>(
        id: 'Sales',
        domainFn: (ModelGraficos valor, _) => valor.periodo,
        measureFn: (ModelGraficos valor, _) => valor.valor,
        colorFn: (ModelGraficos valor, _) => valor.color,
        data: data,
      ),
    ];
  }
}

/// Sample linear data type.
class ModelGraficos {
  final periodo;
  final valor;
  final Color color;

  ModelGraficos(this.periodo, this.valor, this.color);
}
