import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ListaDetalhamento extends StatefulWidget {
  final List dados;
  ListaDetalhamento({this.dados});
  @override
  _ListaDetalhamentoState createState() => _ListaDetalhamentoState();
}

class _ListaDetalhamentoState extends State<ListaDetalhamento> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: widget.dados.map((e) {
        DateTime data = DateTime.parse(e["Date"].toString());
        return new Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Card(
              child: ListTile(
                title: Text(e["Country"].toString().replaceAll("z", "s")),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Novas mortes neste dia: ${e["newDeaths"]}"),
                    Text("Total de mortes neste dia: ${e["Deaths"]}"),
                    Text("Novos casos neste dia: ${e["newCases"]}"),
                    Text("Total de casos neste dia: ${e["Confirmed"]}"),
                  ],
                ),
                trailing: Text(DateFormat("dd-MM-yyyy").format(data)),
              ),
            )
          ],
        );
      }).toList(),
    );
  }
}
