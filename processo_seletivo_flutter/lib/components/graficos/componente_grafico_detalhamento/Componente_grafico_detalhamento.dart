import 'dart:ui';
import 'dart:convert';

import 'package:charts_flutter/flutter.dart' as charts;
import 'package:charts_flutter/flutter.dart';
import 'package:flutter/material.dart';
import 'package:processo_seletivo_flutter/components/model/model_grafico/Model_grafico_detalhamento.dart';

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
  static List<charts.Series<ModelGraficosDetalhamento, int>> _createSampleData(
    final mediaMovelObjetoSelecionado,
    final mediaMovelCasosObjetoSelecionado,
    final totalCasosObjetoSelecionado,
    final totalMortesObjetoSelecionado,
  ) {
    final data = [
      new ModelGraficosDetalhamento(
          0, mediaMovelObjetoSelecionado, MaterialPalette.black),
      new ModelGraficosDetalhamento(1, mediaMovelCasosObjetoSelecionado,
          MaterialPalette.yellow.shadeDefault),
      new ModelGraficosDetalhamento(
          2, totalCasosObjetoSelecionado, MaterialPalette.blue.shadeDefault),
      new ModelGraficosDetalhamento(
          3, totalMortesObjetoSelecionado, MaterialPalette.red.shadeDefault),
    ];

    return [
      new charts.Series<ModelGraficosDetalhamento, int>(
        id: 'Sales',
        domainFn: (ModelGraficosDetalhamento valor, _) => valor.periodo,
        measureFn: (ModelGraficosDetalhamento valor, _) => valor.valor,
        colorFn: (ModelGraficosDetalhamento valor, _) => valor.color,
        data: data,
      ),
    ];
  }
}

/// Sample linear data type.
