import 'package:flutter/material.dart';

class TelaDetalhamentoDadosListados extends StatefulWidget {
  final data;
  TelaDetalhamentoDadosListados({this.data});
  @override
  _TelaDetalhamentoDadosListadosState createState() =>
      _TelaDetalhamentoDadosListadosState();
}

class _TelaDetalhamentoDadosListadosState
    extends State<TelaDetalhamentoDadosListados> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.purple[900], title: Text('Detalhamento')),
    );
  }
}
