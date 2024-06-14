import 'package:flutter/material.dart';

class MapaScreen extends StatelessWidget {
  const MapaScreen({super.key});

  void _showArtworkDialog(BuildContext context, String imageUrl, String title, String author, String year) {
    showGeneralDialog(
      context: context,
      barrierLabel: "Barrier",
      barrierDismissible: true,
      barrierColor: Colors.black.withOpacity(0.5),
      transitionDuration: const Duration(milliseconds: 300),
      pageBuilder: (context, __, ___) {
        return Center(
          child: Material(
            type: MaterialType.transparency,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              padding: const EdgeInsets.all(16),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.asset(imageUrl),
                  const SizedBox(height: 10),
                  Text(
                    title,
                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                  const SizedBox(height: 5),
                  Text(author),
                  const SizedBox(height: 5),
                  Text(year),
                ],
              ),
            ),
          ),
        );
      },
      transitionBuilder: (context, anim1, anim2, child) {
        return SlideTransition(
          position: Tween(
            begin: const Offset(0, 1),
            end: Offset.zero,
          ).animate(anim1),
          child: child,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          //FOTO DO MAPA
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/MapaNormal.jpeg'),
                fit: BoxFit.cover,
              ),
            ),
          ),

          // BOTÕES DAS OBRAS
          Positioned(
            bottom: 30,
            left: 42,
            child: _buildArtworkButton(
              context,
              'assets/images/Obra1.jpg',
              'Figura com Chapéu',
              'Emiliano Di Cavalcanti',
              '1956',
            ),
          ),
          Positioned(
            bottom: 135,
            left: 50,
            child: _buildArtworkButton(
              context,
              'assets/images/Obra2.jpg',
              'Bosque na Primavera',
              'Eliseu Visconti',
              '1895',
            ),
          ),
          Positioned(
            bottom: 200,
            left: 45,
            child: _buildArtworkButton(
              context,
              'assets/images/Obra3.jpg',
              'Paisagem',
              'Paisagem',
              '1929',
            ),
          ),
          Positioned(
            bottom: 300,
            left: 45,
            child: _buildArtworkButton(
              context,
              'assets/images/Obra4.jpeg',
              'Mulher Sentada Iniciando Desenho',
              'Emiliano Di Cavalcanti',
              '1961',
            ),
          ),
          Positioned(
            bottom: 400,
            left: 50,
            child: _buildArtworkButton(
              context,
              'assets/images/Obra5.jpeg',
              'Carcará',
              'Aldemir Martins',
              '1967',
            ),
          ),
          Positioned(
            bottom: 480,
            left: 50,
            child: _buildArtworkButton(
              context,
              'assets/images/Obra6.jpeg',
              'Bandeirinhas',
              'Alfredo Volpi',
              'Década de 1950',
            ),
          ),
          Positioned(
            bottom: 435,
            left: 150,
            child: _buildArtworkButton(
              context,
              'assets/images/Obra7.jpeg',
              'Sonoridade da Gamboa do Carmo',
              'Cicero Dias',
              '1930',
            ),
          ),
          Positioned(
            bottom: 245,
            left: 140,
            child: _buildArtworkButton(
              context,
              'assets/images/Obra8.jpeg',
              'Barqueiros',
              'Antonio Gomide',
              '1936',
            ),
          ),
          Positioned(
            bottom: 70,
            left: 125,
            child: _buildArtworkButton(
              context,
              'assets/images/Obra9.jpeg',
              'Itatiaia',
              'Alberto Da Veiga Guignard',
              '1944',
            ),
          ),
          Positioned(
            bottom: 15,
            left: 122,
            child: _buildArtworkButton(
              context,
              'assets/images/Obra10.jpeg',
              'Meninos Com Balões',
              'Candido Portinari',
              '1936',
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildArtworkButton(BuildContext context, String imageUrl, String title, String author, String year) {
    return CircleAvatar(
      radius: 30,
      backgroundColor: Colors.transparent,
      child: OutlinedButton(
        onPressed: () {
          _showArtworkDialog(context, imageUrl, title, author, year);
        },
        style: OutlinedButton.styleFrom(
          shape: const CircleBorder(),
          side: const BorderSide(width: 2.0, color: Colors.blue),
        ),
        child: const SizedBox(
          width: 5,
          height: 5,
        ),
      ),
    );
  }
}
