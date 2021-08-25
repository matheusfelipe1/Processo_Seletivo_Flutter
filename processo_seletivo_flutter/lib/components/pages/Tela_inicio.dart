import 'dart:math';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:processo_seletivo_flutter/services/Service_tela_inicio.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class TelaInicio extends StatefulWidget {
  @override
  _TelaInicioState createState() => _TelaInicioState();
}

class _TelaInicioState extends State<TelaInicio> {
  String latitude;
  String longitude;

  requisicao() async {
    var position = await Geolocator()
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    setState(() {
      latitude = position.latitude.toString();
      longitude = position.longitude.toString();
    });

    await obterTelaInicio(http.Client(),
            latitude: latitude, longitude: longitude)
        .then((value) => print(value));
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    this.requisicao();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          leading: Icon(Icons.coronavirus),
          title: Text("Processo Seletivo Mobilus"),
          backgroundColor: Colors.blue[900]),
    );
  }
}
