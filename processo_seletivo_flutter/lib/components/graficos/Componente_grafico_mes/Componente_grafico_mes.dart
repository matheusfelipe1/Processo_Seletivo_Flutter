import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';

class ComponenteGraficoMes extends StatelessWidget {
  final variavelA;
  String textA;
  String textB;
  final variavelB;
  ComponenteGraficoMes(
      {this.variavelA, this.variavelB, this.textA, this.textB});
  @override
  Widget build(BuildContext context) {
    return new charts.BarChart(
      _createSampleData(variavelA, variavelB, textA, textB),
      animationDuration: Duration(seconds: 5),
      animate: true,
    );
  }

  /// Create one series with sample hard coded data.
  static List<charts.Series<OrdinalSales, String>> _createSampleData(
    var variavelA,
    var variavelB,
    String varA,
    String varB,
  ) {
    print(variavelA);
    final data = [
      new OrdinalSales(varB, variavelB),
      new OrdinalSales(varA, variavelA),
    ];

    return [
      new charts.Series<OrdinalSales, String>(
        id: 'Sales',
        colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
        domainFn: (OrdinalSales sales, _) => sales.year,
        measureFn: (OrdinalSales sales, _) => sales.sales,
        data: data,
      )
    ];
  }
}

/// Sample ordinal data type.
class OrdinalSales {
  final String year;
  final int sales;

  OrdinalSales(this.year, this.sales);
}
