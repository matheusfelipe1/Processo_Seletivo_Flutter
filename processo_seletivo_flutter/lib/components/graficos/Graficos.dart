import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class Grafico extends StatefulWidget {
  const Grafico({Key? key}) : super(key: key);

  @override
  _GraficoState createState() => _GraficoState();
}

class _GraficoState extends State<Grafico> {
  @override
  Widget build(BuildContext context) {
    return ListView(children: [
      Center(
        child: Container(
            height: MediaQuery.of(context).size.height / 2,
            width: MediaQuery.of(context).size.width,
            child: Padding(
              padding: const EdgeInsets.only(top: 12.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      CircularPercentIndicator(
                        animation: true,
                        animationDuration: 2500,
                        radius: 140.0,
                        lineWidth: 16.0,
                        percent: 1.0,
                        center: Text("100%"),
                        progressColor: Colors.green,
                      ),
                      CircularPercentIndicator(
                        animation: true,
                        animationDuration: 2500,
                        radius: 140.0,
                        lineWidth: 16.0,
                        percent: 1.0,
                        center: Text("100%"),
                        progressColor: Colors.red,
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      CircularPercentIndicator(
                        animation: true,
                        animationDuration: 2500,
                        radius: 140.0,
                        lineWidth: 16.0,
                        percent: 1.0,
                        center: Text("100%"),
                        progressColor: Colors.blue,
                      ),
                      CircularPercentIndicator(
                        animation: true,
                        animationDuration: 2500,
                        radius: 140.0,
                        lineWidth: 16.0,
                        percent: 1.0,
                        center: Text("100%"),
                        progressColor: Colors.yellow,
                      ),
                    ],
                  ),
                ],
              ),
            )),
      ),
    ]);
  }
}
