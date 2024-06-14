import 'package:flutter/material.dart';

class ObrasScreen extends StatefulWidget {
  const ObrasScreen({Key? key}) : super(key: key);

  @override
  _ObrasScreenState createState() => _ObrasScreenState();
}

class _ObrasScreenState extends State<ObrasScreen>
    with TickerProviderStateMixin {
  // Dados das obras
  final List<Map<String, String>> obras = [
    {
      'title': 'Figura com Chapéu',
      'author': 'Emiliano Caval.',
      'year': '1956',
      'description': 'Descrição:\n É uma explosão de cores e vitalidade, retratando uma figura feminina confiante em seu chapéu característico. ',
      'image': 'assets/images/Obra1.jpg'
    },
    {
      'title': 'Bosque na Primavera',
      'author': 'Eliseu Visconti',
      'year': '1895',
      'description': 'Descrição:\n É uma celebração da exuberância e vitalidade da estação, capturando a beleza efervescente da natureza em tons vibrantes e pinceladas suaves.',
      'image': 'assets/images/Obra2.jpg'
    },
    {
      'title': 'Paisagem',
      'author': 'Tarsila Do Amaral',
      'year': '1929',
      'description': 'Descrição:\n É uma representação icônica do modernismo brasileiro, caracterizada por formas geométricas simplificadas e cores vibrantes.',
      'image': 'assets/images/Obra3.jpg'
    },
    {
      'title': 'Mulher Sentada Iniciando Desenho',
      'author': 'Emiliano Caval.',
      'year': '1961',
      'description': 'Descrição:\n Uma figura feminina imersa na criatividade, cores vibrantes e traços do modernismo brasileiro.',
      'image': 'assets/images/Obra4.jpeg'
    },
    {
      'title': 'Carcará',
      'author': 'Aldemir Martins',
      'year': '1967',
      'description': 'Descrição:\n É uma representação icônica da fauna brasileira, destacando-se pela simplificação das formas e cores vibrantes.',
      'image': 'assets/images/Obra5.jpeg'
    },
    {
      'title': 'Bandeirinhas',
      'author': 'Alfredo Volpi',
      'year': '1950',
      'description': 'Descrição:\n Uma representação marcante das festividades juninas brasileiras, com bandeirinhas coloridas em um estilo geométrico distintivo.',
      'image': 'assets/images/Obra6.jpeg'
    },
    {
      'title': 'Sonoridade da Gamboa do Carmo',
      'author': 'Cicero Dias',
      'year': '1930',
      'description': 'Descrição:\n É uma vibrante representação da vida musical e cultural da Gamboa, com cores intensas e formas dinâmicas',
      'image': 'assets/images/Obra7.jpeg'
    },
    {
      'title': 'Barqueiros',
      'author': 'Antonio Gomide',
      'year': '1936',
      'description': 'Descrição:\n Retrata a vida ribeirinha com cores suaves e formas simplificadas, refletindo a serenidade do ambiente aquático.',
      'image': 'assets/images/Obra8.jpeg'
    },
    {
      'title': 'Itatiaia',
      'author': 'Alberto Da Veiga',
      'year': '1944',
      'description': 'Descrição:\n Uma representação sutil e majestosa da natureza, com cores suaves e pinceladas delicadas.',
      'image': 'assets/images/Obra9.jpeg'
    },
    {
      'title': 'Meninos Com Balões',
      'author': 'Candido Portinari ',
      'year': '1936 ',
      'description': 'Descrição:\n Uma representação encantadora da infância brasileira, com cores expressivas e composição delicada.',
      'image': 'assets/images/Obra10.jpeg'
    },
  ];

  late List<AnimationController> _controllers;

  @override
  void initState() {
    super.initState();
    _controllers = List.generate(obras.length, (index) {
      return AnimationController(
        duration: const Duration(seconds: 1),
        vsync: this,
      );
    });
  }

  void _onCardTap(int index) {
    if (_controllers[index].isCompleted) {
      _controllers[index].reverse();
    } else {
      _controllers[index].forward();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Obras de Arte em Exposição'),
      ),
      body: SingleChildScrollView(
        child: GridView.builder(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 0.75,
          ),
          itemCount: obras.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () => _onCardTap(index),
              child: AnimatedBuilder(
                animation: _controllers[index],
                builder: (context, child) {
                  final isFront = _controllers[index].value < 0.5;
                  final rotationY = isFront
                      ? _controllers[index].value * 3.14
                      : (_controllers[index].value - 1) * 3.14;

                  return Transform(
                    transform: Matrix4.rotationY(rotationY),
                    alignment: Alignment.center,
                    child: isFront
                        ? _buildFrontCard(index)
                        : _buildBackCard(index),
                  );
                },
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildFrontCard(int index) {
    return Card(
      elevation: 4,
      child: Column(
        children: [
          Expanded(
            child: Image.asset(
              obras[index]['image']!,
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Text(
                  obras[index]['title']!,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      obras[index]['author']!,
                      style: const TextStyle(fontSize: 14),
                    ),
                    Text(
                      obras[index]['year']!,
                      style: const TextStyle(fontSize: 14),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBackCard(int index) {
    return Card(
      elevation: 4,
      color: const Color.fromARGB(255, 48, 95, 137),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            obras[index]['description']!,
            style: const TextStyle(color: Colors.white),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    for (var controller in _controllers) {
      controller.dispose();
    }
    super.dispose();
  }
}
