import 'package:flutter/material.dart';
import 'package:newbel/Funcionalidades/DatabaseHelper.dart';

class ComentariosScreen extends StatefulWidget {
  final DatabaseHelper dbHelper;

  const ComentariosScreen({super.key, required this.dbHelper});

  @override
  _ComentariosScreenState createState() => _ComentariosScreenState();
}

class _ComentariosScreenState extends State<ComentariosScreen> {
  final _comentarioController = TextEditingController();
  List<Map<String, dynamic>> _comments = [];
  String _userName = '';

  @override
  void initState() {
    super.initState();
    _loadUser();
  }

  void _loadUser() async {
    try {
      final user = await widget.dbHelper.getCurrentUser();
      setState(() {
        _userName = user['nome'] ?? '';
        _loadComments();
      });
    } catch (e) {
      // Handle error
      print("Erro ao carregar usuário: $e");
    }
  }

  void _loadComments() async {
  try {
    final comments = await widget.dbHelper.getComments();
    List<Map<String, dynamic>> mappedComments = [];
    for (var comment in comments) {
      final user = await widget.dbHelper.getUser(comment['matricula']); // Passa apenas a matrícula
      var modifiableComment = Map<String, dynamic>.from(comment); // Cria uma cópia modificável
      modifiableComment['username'] = user['nome']; // Assume 'nome' é o campo do nome do usuário
      mappedComments.add(modifiableComment);
    }
    setState(() {
      _comments = mappedComments;
    });
  } catch (e) {
    print("Erro ao carregar comentários: $e");
  }
}

  void _addComment() async {
    if (_comentarioController.text.isNotEmpty) {
      try {
        await widget.dbHelper.insertComment(_userName, _comentarioController.text);
        _comentarioController.clear();
        _loadComments();
      } catch (e) {
        print("Erro ao adicionar comentário: $e");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 48, 95, 137),
        title: const Text('Comentários', style: TextStyle(color: Colors.white, fontSize: 24)),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: _comments.length,
                itemBuilder: (context, index) {
                  final comment = _comments[index];
                  return ListTile(
                    title: Text(comment['comentario']),
                    //subtitle: Text('Enviado por: ${comment['username']}'),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: TextField(
                controller: _comentarioController,
                decoration: InputDecoration(
                  labelText: 'Digite seu comentário',
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.send),
                    onPressed: _addComment,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
