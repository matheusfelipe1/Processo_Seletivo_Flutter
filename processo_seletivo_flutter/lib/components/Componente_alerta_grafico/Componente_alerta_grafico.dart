import 'package:flutter/material.dart';
import 'package:processo_seletivo_flutter/components/componente_diaolog_grafico/Componente_dialog_grafico.dart';

class ComponenteAlertaGrafico extends StatefulWidget {
  var confirmadoMedia;
  var morteMedia;
  var morteMediaFormat;
  var confirmadoMediaFormat;
  var confirmados;
  var morte;
  ComponenteAlertaGrafico(
      {this.confirmadoMedia,
      this.morteMedia,
      this.confirmados,
      this.morte,
      this.morteMediaFormat,
      this.confirmadoMediaFormat});
  @override
  _ComponenteAlertaGraficoState createState() =>
      _ComponenteAlertaGraficoState();
}

class _ComponenteAlertaGraficoState extends State<ComponenteAlertaGrafico> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        title: Text('Dados Covid-19 bo Brasil hoje'),
        content: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Wrap(
              direction: Axis.horizontal,
              children: [
                Text("Total de mortos: "),
                Text(
                  "${widget.morte}",
                  style: TextStyle(fontWeight: FontWeight.bold),
                )
              ],
            ),
            Wrap(
              direction: Axis.horizontal,
              children: [
                Text(
                  "Total de confirmados: ",
                ),
                Text(
                  "${widget.confirmados}",
                  style: TextStyle(fontWeight: FontWeight.bold),
                )
              ],
            ),
            Wrap(
              direction: Axis.horizontal,
              children: [
                Text(
                  "Media Movel de mortos: ",
                ),
                Text(
                  "${widget.morteMediaFormat}",
                  style: TextStyle(fontWeight: FontWeight.bold),
                )
              ],
            ),
            Wrap(
              direction: Axis.horizontal,
              children: [
                Text(
                  "Media Movel de casos: ",
                ),
                Text(
                  "${widget.confirmadoMediaFormat}",
                  style: TextStyle(fontWeight: FontWeight.bold),
                )
              ],
            ),
          ],
        ),
        actions: [
          ComponenteDialogGrafico(
            mediaMovelCasosConfirmados: widget.confirmadoMedia,
            mediaMovelMortes: widget.morteMedia,
            totalConfirmados: widget.confirmados,
            totalMortes: widget.morte,
          ),
        ]);
  }
}
