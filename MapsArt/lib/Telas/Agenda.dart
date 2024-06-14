import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class AgendaScreen extends StatelessWidget {
  const AgendaScreen({super.key});

  Future<void> _launchURL(String url) async {
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url));
    } else {
      throw 'Não pôde abrir a URL: $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          // QUADRADO
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 48, 95, 137),
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                // IMAGEM DA EXPOSIÇÃO
                Container(
                  width: double.infinity,
                  height: 150,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    image: const DecorationImage(
                      image:
                          AssetImage('assets/images/CentelhasEmMovimento.jpg'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(height: 20),

                // NOME DA EXPOSIÇÃO
                const Text(
                  'Centelhas em Movimento - Coleção Igor Queiroz Barroso',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),

                // DESCRIÇÃO DA EXPOSIÇÃO
                const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.info, color: Colors.white),
                        SizedBox(width: 4),
                        Flexible(
                          child: Text(
                            'Descrição:',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 4),
                    Text(
                      'A exposição apresenta cerca de 190 obras de mais de 55 artistas, destacando a arte moderna brasileira desde os anos 1910 até hoje.',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),

                // DATA DA EXPOSIÇÃO
                const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.date_range, color: Colors.white),
                        SizedBox(width: 4),
                        Text(
                          'Fim da Exposição:',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 4),
                    Text(
                      '30 de Agosto',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),

                // HORÁRIO DA EXPOSIÇÃO
                const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.access_time, color: Colors.white),
                        SizedBox(width: 4),
                        Text(
                          'Horário de Funcionamento:',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 4),
                    Text(
                      'Terças a Sextas - 9h às 19h;\nSábados e Domingos - 12h às 18h.',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),

                // CURADORES DA EXPOSIÇÃO
                const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.person, color: Colors.white),
                        SizedBox(width: 4),
                        Text(
                          'Curadores:',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 4),
                    Text(
                      'Igor Queiroz Barroso, Maria Silva',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),

                // LOCALIZAÇÃO DA EXPOSIÇÃO
                const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.location_on, color: Colors.white),
                        SizedBox(width: 4),
                        Flexible(
                          child: Text(
                            'Localização:',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 4),
                    Text(
                      'Espaço Cultural Unifor (Av. Washington Soares, 1321, Edson Queiroz, Fortaleza-CE)',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),

                // MAIS INFORMAÇÕES
                ElevatedButton(
                  onPressed: () => _launchURL(
                      'https://www.unifor.br/web/guest/espaco-cultural-unifor/em-cartaz'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.blue,
                  ),
                  child: const Text('Mais Informações'),
                ),
                const SizedBox(height: 20),

                // CONTATO
                const Text(
                  'Contato:',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),

                // TELEFONE
                const Row(
                  children: [
                    Icon(Icons.phone, color: Colors.white),
                    SizedBox(width: 4),
                    Text(
                      'Telefone: ',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      '(85) 3477.3319',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),

                // EMAIL
                const Row(
                  children: [
                    Icon(Icons.email, color: Colors.white),
                    SizedBox(width: 4),
                    Text(
                      'Email: ',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'espacocultural@unifor.br',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),

                // REDES SOCIAIS
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    IconButton(
                      icon: const Icon(Icons.web_rounded, color: Colors.white),
                      onPressed: () => _launchURL('https://unifor.br/?utm_source=search&utm_medium=CPL&utm_campaign=CPS241&utm_term=pos_graduacao_especializacao_em_psicanalise_e_suas_extensoes&utm_content=AD01'),
                    ),
                    IconButton(
                      icon: const Icon(Icons.facebook, color: Colors.white),
                      onPressed: () => _launchURL('https://www.facebook.com/profile.php?id=100090115594241'),
                    ),
                    IconButton(
                      icon: const Icon(Icons.alternate_email_outlined, color: Colors.white),
                      onPressed: 
                      () => _launchURL('https://www.instagram.com/uniforcomunica'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
