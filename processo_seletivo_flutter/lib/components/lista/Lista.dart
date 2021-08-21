import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Lista extends StatefulWidget {
  final List renderizaDados;
  Lista({required this.renderizaDados});
  @override
  _ListaState createState() => _ListaState();
}

class _ListaState extends State<Lista> {
  @override
  Widget build(BuildContext context) {
    if (widget.renderizaDados == null || widget.renderizaDados.length == 0) {
      return Center(
        child: CircularProgressIndicator(),
      );
    }
    return ListView.builder(
        itemCount: widget.renderizaDados.length == null
            ? 0
            : widget.renderizaDados.length,
        itemBuilder: (BuildContext context, int indice) {
          DateTime data =
              DateTime.parse(widget.renderizaDados[indice]['Date'].toString());
          return Padding(
              padding: const EdgeInsets.all(4.0),
              child: Card(
                child: ListTile(
                    title: Text(
                        widget.renderizaDados[indice]['Country'].toString()),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                            "Mortes: ${widget.renderizaDados[indice]['Deaths'].toString()}"),
                        Text(
                            "Confirmados: ${widget.renderizaDados[indice]['Confirmed'].toString()}"),
                        Text(
                            "Recuperados: ${widget.renderizaDados[indice]['Recovered'].toString()}"),
                      ],
                    ),
                    trailing: Text(DateFormat("dd/MM/yyyy").format(data))),
              ));
        });
  }
}
