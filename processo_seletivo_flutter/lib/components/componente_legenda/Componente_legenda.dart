import 'package:flutter/material.dart';

class ComponentLegenda extends StatelessWidget {
  Widget RenderizaLegendas(
    String textoLegenda,
    String textoLegendaMedia,
    Color legenda,
    Color legendaMedia,
  ) {
    return Container(
      margin: EdgeInsets.only(top: 5, bottom: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            child: Row(
              children: [
                SizedBox(
                  height: 20,
                  width: 20,
                  child: Container(
                    color: legenda,
                  ),
                ),
                Container(
                  child: Text(textoLegenda),
                  margin: EdgeInsets.only(left: 7, right: 15),
                ),
              ],
            ),
          ),
          Container(
            child: Row(
              children: [
                SizedBox(
                  height: 20,
                  width: 20,
                  child: Container(
                    color: legendaMedia,
                  ),
                ),
                Container(
                  child: Text(textoLegendaMedia),
                  margin: EdgeInsets.only(left: 7),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            RenderizaLegendas('Confirmados', 'Media Móvel Confirmados',
                Colors.blue, Colors.yellow),
            RenderizaLegendas(
                'Mortes', 'Media Móvel Mortes ', Colors.red, Colors.black),
            RenderizaLegendas('Recuperados', 'Media Móvel Recuperados',
                Colors.green, Colors.deepOrange),
          ],
        ),
      ),
    ));
  }
}
