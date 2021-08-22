import 'dart:ui';
import 'dart:convert';

import 'package:charts_flutter/flutter.dart' as charts;
import 'package:charts_flutter/flutter.dart';
import 'package:flutter/material.dart';

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
  static List<charts.Series<LinearSales, int>> _createSampleData(
      final mediaMovelMortes,
      final mediaMovelCasosConfirmados,
      final totalMortes,
      final totalConfirmados) {
    final graficoDo = [
      new LinearSales(2, totalMortes, MaterialPalette.red.shadeDefault),
      new LinearSales(3, totalConfirmados, MaterialPalette.blue.shadeDefault),
      new LinearSales(4, mediaMovelMortes, MaterialPalette.black),
      new LinearSales(
          5, mediaMovelCasosConfirmados, MaterialPalette.yellow.shadeDefault),
    ];

    return [
      new charts.Series<LinearSales, int>(
        id: 'Sales',
        domainFn: (LinearSales sales, _) => sales.year,
        measureFn: (LinearSales sales, _) => sales.sales,
        colorFn: (LinearSales sales, _) => sales.color,
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

/// Sample linear data type.
class LinearSales {
  final year;
  final sales;
  final color;

  LinearSales(this.year, this.sales, this.color);
}
