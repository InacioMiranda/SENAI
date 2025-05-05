import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Quiz Matemática',
      home: QuizPage(),
    );
  }
}

class QuizPage extends StatefulWidget {
  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  int perguntaAtual = 0;
  int acertos = 0;
  bool respondeu = false;
  String mensagemResultado = '';

  final List<Map<String, dynamic>> perguntas = [
    {
      'pergunta': '1- Quanto é 6x3?',
      'respostas': {
        'A': '18',
        'B': '12',
        'C': '32',
        'D': '16',
      },
      'correta': 'A',
    },
    {
      'pergunta': '2- Quanto é 7x6?',
      'respostas': {
        'A': '32',
        'B': '48',
        'C': '42',
        'D': '32',
      },
      'correta': 'C',
    },
    {
      'pergunta': '2- Quanto é 4+3×2?',
      'respostas': {
        'A': '12',
        'B': '7',
        'C': '14',
        'D': '450',
      },
      'correta': 'C',
    },
    {
      'pergunta': '4- Quanto é 3x8-6?',
      'respostas': {
        'A': '18',
        'B': '6',
        'C': '24',
        'D': '16',
      },
      'correta': 'A',
    },
    {
      'pergunta': '5- Quanto é 3x3-2(8-6)?',
      'respostas': {
        'A': '1',
        'B': '14',
        'C': '8',
        'D': '5',
      },
      'correta': 'D',
    },
    {
      'pergunta': '6- Qual é a Raiz de 82?',
      'respostas': {
        'A': '12',
        'B': '6',
        'C': '9',
        'D': '10',
      },
      'correta': 'C',
    },
    {
      'pergunta': '7- Um triângulo isósceles é aquele que:',
      'respostas': {
        'A': 'Tem todos os lados iguais',
        'B': 'Todos os lados diferentes',
        'C': 'Não tem 3 lados',
        'D': 'Tem dois lados iguais',
      },
      'correta': 'D',
    },
    {
      'pergunta': '8- Um triângulo escaleno é aquele que:',
      'respostas': {
        'A': 'Tem todos os lados iguais',
        'B': 'Todos os lados diferentes',
        'C': 'Não tem 3 lados',
        'D': 'Tem dois lados iguais',
      },
      'correta': 'B',
    },
    {
      'pergunta': '9- Como é medido a área de um cubo?',
      'respostas': {
        'A': 'Multiplicando a área de uma de suas faces por 6',
        'B': 'É impossível medir a área de um cubo',
        'C': 'Multiplicando a área de uma das faces pela sua metragem cúbica',
        'D': 'multiplicando as arestas de uma face e as multiplicando por 6',
      },
      'correta': 'A',
    },
    {
      'pergunta': '10- Quando é utilizado bhaskara?',
      'respostas': {
        'A': 'Medir a área de um cubo',
        'B': 'Resolver equações de segundo grau',
        'C': 'Criação de gráficos',
        'D': 'Criação de mapas',
      },
      'correta': 'B',
    },
  ];

  void verificarResposta(String respostaSelecionada) {
    if (respondeu) return;

    setState(() {
      respondeu = true;

      if (respostaSelecionada == perguntas[perguntaAtual]['correta']) {
        acertos++;
      }

      if (perguntaAtual == perguntas.length - 1) {
        double percentual = (acertos / perguntas.length) * 100;
        mensagemResultado =
            'Você acertou $acertos de ${perguntas.length} pergunta(s).\n'
            'Porcentagem de acerto: ${percentual.toStringAsFixed(1)}%';
      }
    });
  }

  void proximaPergunta() {
    if (perguntaAtual < perguntas.length - 1) {
      setState(() {
        perguntaAtual++;
        respondeu = false;
      });
    }
  }

  void reiniciarQuiz() {
    setState(() {
      perguntaAtual = 0;
      acertos = 0;
      respondeu = false;
      mensagemResultado = '';
    });
  }

  Widget botaoResposta(String letra, String texto) {
    return ElevatedButton(
      onPressed: () => verificarResposta(letra),
      child: Text('$letra - $texto'),
    );
  }

  @override
  Widget build(BuildContext context) {
    final pergunta = perguntas[perguntaAtual];

    return Scaffold(
      appBar: AppBar(
        title: Text('Quiz Matemática'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                pergunta['pergunta'],
                style: TextStyle(fontSize: 24),
              ),
              const SizedBox(height: 20),
              ...pergunta['respostas'].entries.map(
                (entrada) => botaoResposta(entrada.key, entrada.value),
              ),
              const SizedBox(height: 30),
              if (respondeu && perguntaAtual < perguntas.length - 1)
                ElevatedButton(
                  onPressed: proximaPergunta,
                  child: Text('Próxima Pergunta'),
                ),
              if (respondeu && perguntaAtual == perguntas.length - 1) ...[
                Text(
                  mensagemResultado,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: reiniciarQuiz,
                  child: Text('Reiniciar Quiz'),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
