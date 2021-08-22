import 'dart:ui';
import 'dart:convert';

import 'package:charts_flutter/flutter.dart' as charts;
import 'package:charts_flutter/flutter.dart';
import 'package:flutter/material.dart';

class ComponenteDialogGrafico extends StatefulWidget {
  final mediaMovelMortes;
  final mediaMovelDeRecuperados;
  final mediaMovelCasosConfirmados;
  final totalMortes;
  final totalRecuperados;
  final totalConfirmados;

  ComponenteDialogGrafico(
      {this.mediaMovelMortes,
      this.mediaMovelDeRecuperados,
      this.mediaMovelCasosConfirmados,
      this.totalMortes,
      this.totalRecuperados,
      this.totalConfirmados});

  @override
  _ComponenteDialogGraficoState createState() =>
      _ComponenteDialogGraficoState();
}

class _ComponenteDialogGraficoState extends State<ComponenteDialogGrafico> {
  static List<charts.Series<LinearSales, int>> _createSampleData(
      final mediaMovelMortes,
      final mediaMovelDeRecuperados,
      final mediaMovelCasosConfirmados,
      final totalMortes,
      final totalRecuperados,
      final totalConfirmados) {
    final graficoDo = [
      new LinearSales(1, totalRecuperados, MaterialPalette.green.shadeDefault),
      new LinearSales(2, totalMortes, MaterialPalette.red.shadeDefault),
      new LinearSales(3, totalConfirmados, MaterialPalette.blue.shadeDefault),
      new LinearSales(4, mediaMovelMortes, MaterialPalette.black),
      new LinearSales(
          5, mediaMovelCasosConfirmados, MaterialPalette.yellow.shadeDefault),
      new LinearSales(
          6, mediaMovelDeRecuperados, MaterialPalette.deepOrange.shadeDefault),
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
          Text('Dados Covid-19 bo Brasil hoje'),
          SizedBox(
            height: MediaQuery.of(context).size.height / 2,
            child: new charts.PieChart(
                _createSampleData(
                    widget.mediaMovelMortes,
                    widget.mediaMovelDeRecuperados,
                    widget.mediaMovelCasosConfirmados,
                    widget.totalMortes,
                    widget.totalRecuperados,
                    widget.totalConfirmados),
                animate: true),
          ),
          Text(
            "Total de mortos: ${widget.totalMortes}",
            strutStyle: StrutStyle(fontSize: 50),
          ),
          Text(
            "Total de confirmados: ${widget.totalConfirmados}",
            strutStyle: StrutStyle(fontSize: 50),
          ),
          Text(
            "Total de recuperados: ${widget.totalRecuperados}",
            strutStyle: StrutStyle(fontSize: 50),
          ),
          Text(
            "Media Movel de mortos: ${widget.mediaMovelMortes}",
            strutStyle: StrutStyle(fontSize: 50),
          ),
          Text(
            "Media Movel de casos: ${widget.mediaMovelCasosConfirmados}",
            strutStyle: StrutStyle(fontSize: 50),
          ),
          Text(
            "Media Movel de recuperados: ${widget.mediaMovelDeRecuperados}",
            strutStyle: StrutStyle(fontSize: 50),
          ),
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
