import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:newbel/Funcionalidades/DatabaseHelper.dart';
import 'package:newbel/Cadastro/Login/Cadastro.dart';
import 'package:newbel/Telas/Home.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _matriculaController = TextEditingController();
  final _senhaController = TextEditingController();
  final DatabaseHelper _dbHelper = DatabaseHelper();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 48, 95, 137),
        title: const Text('Login', style: TextStyle(color: Colors.white, fontSize: 24)),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const SizedBox(height: 0),
                Image.asset('assets/images/MapsArt.png', width: 350, height: 300, fit: BoxFit.cover),
                const SizedBox(height: 20),
                _buildTextField(_matriculaController, 'Matrícula', keyboardType: TextInputType.number),
                const SizedBox(height: 20),
                _buildTextField(_senhaController, 'Senha', obscureText: true),
                const SizedBox(height: 20),
                _buildLoginButton(),
                const SizedBox(height: 10),
                GestureDetector(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const CadastroScreen()));
                  },
                  child: RichText(
                    text: const TextSpan(
                      children: [
                        TextSpan(text: 'Ainda não tem conta? ', style: TextStyle(color: Colors.black)),
                        TextSpan(text: 'Cadastre-se aqui', style: TextStyle(color: Colors.blue)),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String labelText, {bool obscureText = false, TextInputType keyboardType = TextInputType.text}) {
    return Container(
      width: 300,
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(labelText: labelText, border: InputBorder.none),
        obscureText: obscureText,
        keyboardType: keyboardType,
        inputFormatters: keyboardType == TextInputType.number ? <TextInputFormatter>[FilteringTextInputFormatter.digitsOnly] : null,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Por favor, insira sua $labelText.';
          }
          return null;
        },
      ),
    );
  }

  Widget _buildLoginButton() {
  return ElevatedButton(
    onPressed: () async {
      if (_formKey.currentState!.validate()) {
        final matricula = _matriculaController.text;
        final senha = _senhaController.text;

        try {
          final user = await _dbHelper.getUser(matricula); // Use apenas a matrícula
          if (user.isNotEmpty && user['senha'] == senha) {
            Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (context) => const MainScreen()),
              (Route<dynamic> route) => false,
            );
          } else {
            _showErrorDialog('Matrícula ou senha incorreta.');
          }
        } catch (e) {
          _showErrorDialog('Erro ao realizar login. Tente novamente.');
        }
      }
    },
    style: ElevatedButton.styleFrom(
      minimumSize: const Size(250, 60),
      backgroundColor: const Color.fromARGB(255, 48, 95, 137),
      shadowColor: Colors.black,
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
    ),
    child: const Text('Login', style: TextStyle(color: Colors.white)),
  );
}

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Erro'),
          content: Text(message),
          actions: <Widget>[
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
