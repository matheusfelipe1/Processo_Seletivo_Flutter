import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';
import 'package:processo_seletivo_flutter/components/model/model_grafico/Model_grafico_mes.dart';

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
  static List<charts.Series<GraficoMes, String>> _createSampleData(
    var variavelA,
    var variavelB,
    String varA,
    String varB,
  ) {
    print(variavelA);
    final data = [
      new GraficoMes(varB, variavelB),
      new GraficoMes(varA, variavelA),
    ];

    return [
      new charts.Series<GraficoMes, String>(
        id: 'Sales',
        colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
        domainFn: (GraficoMes sales, _) => sales.year,
        measureFn: (GraficoMes sales, _) => sales.sales,
        data: data,
      )
    ];
  }
}
