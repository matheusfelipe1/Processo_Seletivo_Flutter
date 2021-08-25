import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:processo_seletivo_flutter/components/pages/Tela_detalhamento_dados_listados.dart';

class Lista extends StatefulWidget {
  final List renderizaDados;
  Lista({this.renderizaDados});
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
          var pais =
              widget.renderizaDados[indice]['Country'].replaceAll('z', 's');
          DateTime data =
              DateTime.parse(widget.renderizaDados[indice]['Date'].toString());
          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 6, top: 6),
                  child: GestureDetector(
                    onTap: () => Navigator.of(context).push(MaterialPageRoute(
                        builder: (ctx) => TelaDetalhamentoDadosListados(
                              data: widget.renderizaDados[indice]['Date'],
                            ))),
                    child: ListTile(
                        leading: Icon(Icons.coronavirus),
                        title: Text(pais.toString()),
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
                  ),
                ),
              ),
              Divider(
                color: Colors.black26,
              )
            ],
          );
        });
  }
}
