import 'package:flutter/material.dart';
import 'package:newbel/Funcionalidades/Animacao.dart';
import 'Cadastro.dart';
import 'Login.dart';

class InicioScreen extends StatefulWidget {
  const InicioScreen({super.key});

  @override
  _InicioScreenState createState() => _InicioScreenState();
}

class _InicioScreenState extends State<InicioScreen> {
  bool _isVisible = false;

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 500), () {
      setState(() {
        _isVisible = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 48, 95, 137),
        title: const Text(
          'Unifor',
          style: TextStyle(
            color: Colors.white,
            fontSize: 24,
          ),
        ),
      ),
      backgroundColor: Colors.white,
      body: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          AnimatedPositioned(
            duration: const Duration(seconds: 1),
            curve: Curves.easeInOut,
            top: _isVisible ? 0.0 : 300.0, 
            left: 0,
            right: 0,
            child: AnimatedOpacity(
              opacity: _isVisible ? 1.0 : 0.0,
              duration: const Duration(seconds: 1),
              child: Image.asset(
                'assets/images/MapsArt.png',
                width: double.infinity, 
                height: MediaQuery.of(context).size.width * 0.92, 
                fit: BoxFit.contain, 
              ),
            ),
          ),
          AnimatedPositioned(
            duration: const Duration(seconds: 1),
            curve: Curves.easeInOut,
            top: _isVisible ? MediaQuery.of(context).size.width * 0.85 + 40 : 600, 
            left: 0,
            right: 0,
            child: AnimatedOpacity(
              opacity: _isVisible ? 1.0 : 0.0,
              duration: const Duration(seconds: 1),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  const Text('Bem Vindo, o que você deseja?'),
                  const SizedBox(height: 10),
                  buildButton(context, 'Fazer Login', LoginScreen()),
                  const SizedBox(height: 10),
                  const Text('Ou'),
                  const SizedBox(height: 10),
                  buildButton(context, 'Fazer Cadastro', const CadastroScreen()),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  //LÓGICA DO BOTÃO
  ElevatedButton buildButton(BuildContext context, String text, Widget screen) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        minimumSize: const Size(250, 60),
        backgroundColor: const Color.fromARGB(255, 48, 95, 137),
        shadowColor: Colors.black,
        elevation: 3,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
      onPressed: () {
        Navigator.push(
          context,
          CustomPageRoute.createRoute(screen),
        );
      },
      child: Text(
        text,
        style: const TextStyle(color: Colors.white),
      ),
    );
  }
}


