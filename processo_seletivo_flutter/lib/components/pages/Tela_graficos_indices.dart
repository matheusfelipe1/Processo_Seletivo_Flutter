import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:processo_seletivo_flutter/components/graficos/Graficos.dart';

class TelaGraficosIndices extends StatefulWidget {
  @override
  _TelaGraficosIndicesState createState() => _TelaGraficosIndicesState();
}

class _TelaGraficosIndicesState extends State<TelaGraficosIndices> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            leading: Icon(Icons.coronavirus),
            title: Text('Processo Seletivo Mobilus'),
            backgroundColor: Colors.purple[900]),
        body: Grafico());
  }
}
