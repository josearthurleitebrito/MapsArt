import 'package:flutter/material.dart';
import 'package:newbel/Cadastro/Login/Inicio.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'App',
      home: InicioScreen(), 
    );
  }
}