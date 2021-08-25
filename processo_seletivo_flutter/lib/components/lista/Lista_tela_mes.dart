import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ListaTelaMes extends StatefulWidget {
  final List lista;
  ListaTelaMes({this.lista});
  @override
  _ListaTelaMesState createState() => _ListaTelaMesState();
}

class _ListaTelaMesState extends State<ListaTelaMes> {
  @override
  Widget build(BuildContext context) {
    print(widget.lista);
    return Container(
        child: Column(
      children: widget.lista.map((e) {
        DateTime data = DateTime.parse(e["Date"].toString());
        return new Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Card(
                child: ListTile(
                    leading: Icon(Icons.coronavirus),
                    title: Text(e["Country"].toString().replaceAll('z', 's')),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Mortes: ${e["Deaths"].toString()}"),
                        Text("Confirmados: ${e["Confirmed"].toString()}"),
                        Text("Recuperados: ${e["Recovered"].toString()}"),
                        Text("Ativos: ${e["Active"].toString()}"),
                      ],
                    ),
                    trailing: Text(DateFormat("dd/MM/yyyy").format(data)))),
          ],
        );
      }).toList(),
    ));
  }
}
