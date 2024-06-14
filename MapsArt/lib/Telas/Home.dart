import 'package:flutter/material.dart';
import 'package:newbel/Cadastro/Login/Inicio.dart';
import 'package:newbel/Telas/Barra/Configuracao.dart';
import 'package:newbel/Telas/Obras.dart';
import 'package:newbel/Telas/Mapa.dart';
import 'package:newbel/Telas/Agenda.dart';
import 'package:newbel/Telas/Comentarios.dart';
import 'package:newbel/Funcionalidades/DatabaseHelper.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  late DatabaseHelper _dbHelper;
  String _userName = '';
  String _userMatricula = '';

  @override
  void initState() {
    super.initState();
    _dbHelper = DatabaseHelper();
    _loadUser(); // Carrega os dados do usuário ao iniciar o aplicativo
  }

  void _loadUser() async {
    try {
      final user = await _dbHelper.getCurrentUser();
      setState(() {
        _userName = user['nome'] ?? 'Usuário';
        _userMatricula = user['matricula'] ?? '0000000';
      });
    } catch (e) {
      print("Erro ao carregar usuário: $e");
    }
  }

  int _selectedIndex = 0;

  static final List<Widget> _widgetOptions = <Widget>[
    const ObrasScreen(),
    const MapaScreen(),
    const AgendaScreen(),
    ComentariosScreen(dbHelper: DatabaseHelper()),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _showLogoutDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Sair da conta'),
          content: const Text('Você tem certeza que deseja sair?'),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancelar'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Sair'),
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (context) => const InicioScreen()),
                  (Route<dynamic> route) => false,
                );
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 48, 95, 137),
        title: const Text(
          'MapsArt - Unifor',
          style: TextStyle(
            color: Colors.white,
            fontSize: 24,
          ),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      drawer: Drawer(
        child: Column(
          children: <Widget>[
            DrawerHeader(
              decoration: const BoxDecoration(
                color: Colors.blue,
              ),
              child: Row(
                children: <Widget>[
                  const Icon(Icons.account_circle, size: 80, color: Colors.white),
                  const SizedBox(width: 20),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          _userName,
                          style: const TextStyle(
                            fontSize: 18,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          _userMatricula,
                          style: const TextStyle(
                            fontSize: 15,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView(
                padding: EdgeInsets.zero,
                children: <Widget>[
                  ListTile(
                    leading: const Icon(Icons.settings),
                    title: const Text('Configurações'),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ConfigScreen(dbHelper: _dbHelper),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
            ListTile(
              leading: const Icon(Icons.logout, color: Colors.red),
              title: const Text(
                'Sair da conta',
                style: TextStyle(color: Colors.red),
              ),
              onTap: _showLogoutDialog,
            ),
          ],
        ),
      ),
      body: _widgetOptions.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.insert_photo),
            label: 'Obras',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.map),
            label: 'Mapa',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_today),
            label: 'Agenda',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.comment),
            label: 'Comentários',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blue, // Cor dos ícones selecionados
        unselectedItemColor: Colors.blue, // Cor dos ícones não selecionados
        onTap: _onItemTapped,
      ),
    );
  }
}