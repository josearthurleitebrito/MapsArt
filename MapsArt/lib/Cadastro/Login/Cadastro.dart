import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:newbel/Funcionalidades/Animacao.dart';
import 'package:newbel/Cadastro/Login/Login.dart';
import 'package:newbel/Funcionalidades/DatabaseHelper.dart';

class CadastroScreen extends StatefulWidget {
  const CadastroScreen({super.key});

  @override
  _CadastroScreenState createState() => _CadastroScreenState();
}

class _CadastroScreenState extends State<CadastroScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nomeController = TextEditingController();
  final _emailController = TextEditingController();
  final _senhaController = TextEditingController();
  final _matriculaController = TextEditingController();
  final DatabaseHelper _dbHelper = DatabaseHelper();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 48, 95, 137),
        title: const Text('Cadastro', style: TextStyle(color: Colors.white, fontSize: 24)),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                const SizedBox(height: 0),
                Image.asset('assets/images/MapsArt.png', width: 350, height: 300, fit: BoxFit.cover),
                const SizedBox(height: 20),
                _buildTextField(_nomeController, 'Nome'),
                const SizedBox(height: 20),
                _buildTextField(_emailController, 'Email', keyboardType: TextInputType.emailAddress),
                const SizedBox(height: 20),
                _buildTextField(_matriculaController, 'Matrícula', keyboardType: TextInputType.number),
                const SizedBox(height: 20),
                _buildTextField(_senhaController, 'Senha', obscureText: true, keyboardType: TextInputType.number),
                const SizedBox(height: 20),
                _buildCadastrarButton(),
                const SizedBox(height: 10),
                GestureDetector(
                  onTap: () {
                    Navigator.push(context, CustomPageRoute.createRoute(LoginScreen()));
                  },
                  child: RichText(
                    text: const TextSpan(
                      children: [
                        TextSpan(text: 'Já Possuo Login, ', style: TextStyle(color: Colors.black)),
                        TextSpan(text: 'Clique Aqui', style: TextStyle(color: Colors.blue)),
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

  Widget _buildTextField(TextEditingController controller, String labelText,
      {bool obscureText = false, TextInputType keyboardType = TextInputType.text}) {
    return Container(
      width: 300,
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(10.0)),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(labelText: labelText, border: InputBorder.none),
        obscureText: obscureText,
        keyboardType: keyboardType,
        inputFormatters: keyboardType == TextInputType.number ? <TextInputFormatter>[FilteringTextInputFormatter.digitsOnly] : null,
        validator: (value) {
          if (value!.isEmpty) {
            return 'Por favor, insira seu $labelText.';
          }
          return null;
        },
      ),
    );
  }

  Widget _buildCadastrarButton() {
    return ElevatedButton(
      onPressed: () async {
        if (_formKey.currentState!.validate()) {
          final user = {
            'nome': _nomeController.text,
            'email': _emailController.text,
            'matricula': _matriculaController.text,
            'senha': _senhaController.text,
          };

          await _dbHelper.insertUser(user);

          _nomeController.clear();
          _emailController.clear();
          _matriculaController.clear();
          _senhaController.clear();

          Navigator.pushReplacement(context, CustomPageRoute.createRoute(LoginScreen()));
        }
      },
      style: ElevatedButton.styleFrom(
        minimumSize: const Size(250, 60),
        backgroundColor: const Color.fromARGB(255, 48, 95, 137),
        shadowColor: Colors.black,
        elevation: 3,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      ),
      child: const Text('Cadastrar', style: TextStyle(color: Colors.white)),
    );
  }
}
