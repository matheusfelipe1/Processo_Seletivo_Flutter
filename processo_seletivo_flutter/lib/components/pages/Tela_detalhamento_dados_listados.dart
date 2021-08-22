import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

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
  void initState() {
    // TODO: implement initState
    super.initState();
    DateTime data = DateTime.parse(widget.data);
    var data2 = DateFormat("yyyy-MM-dd").format(data);
    print(data2);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.purple[900], title: Text('Detalhamento')),
    );
  }
}
