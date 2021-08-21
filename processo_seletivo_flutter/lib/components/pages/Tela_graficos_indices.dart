import 'package:flutter/material.dart';

class TelaGraficosIndices extends StatefulWidget {
  const TelaGraficosIndices({Key? key}) : super(key: key);

  @override
  _TelaGraficosIndicesState createState() => _TelaGraficosIndicesState();
}

class _TelaGraficosIndicesState extends State<TelaGraficosIndices> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            leading: Icon(Icons.coronavirus),
            title: Text('Covid-19 no Brasil'),
            backgroundColor: Colors.purple[900]));
  }
}