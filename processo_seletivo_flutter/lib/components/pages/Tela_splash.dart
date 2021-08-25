import 'package:flutter/material.dart';

class TelaSplash extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(seconds: 2), () {
      Navigator.pushNamed(context, 'bottom');
    });
    return Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: [
            Color(0xFF14273d),
            Color(0xFF17a2b8),
          ])),
      child:
          Center(child: Icon(Icons.coronavirus, color: Colors.white, size: 75)),
    );
  }
}
