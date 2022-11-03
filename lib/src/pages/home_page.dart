import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController dollarController = TextEditingController();
  TextEditingController euroController = TextEditingController();
  TextEditingController realController = TextEditingController();
  double dollarCotacao = 0.0;
  double euroCotacao = 0.0;
  double real = 0.0;
  double dollarTotal = 0.0;
  double euroTotal = 0.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amber,
        title: const Text('Conversor de moedas'),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (c) {
              return AlertDialog(
                title: const Center(
                  child: Text(
                    'Adicionar cotação',
                  ),
                ),
                content: SingleChildScrollView(
                  child: Column(
                    children: [
                      TextField(
                        controller: dollarController,
                        decoration: const InputDecoration(
                          label: Text('Dollar'),
                        ),
                      ),
                      TextField(
                        controller: euroController,
                        decoration: const InputDecoration(
                          label: Text('Euro'),
                        ),
                      ),
                      const SizedBox(height: 25.0),
                      ElevatedButton(
                        onPressed: () {
                          setState(() {
                            dollarCotacao =
                                double.tryParse(dollarController.text)!;
                            euroCotacao = double.tryParse(euroController.text)!;
                          });
                          Navigator.pop(context);
                        },
                        child: const Text('ADICIONAR'),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
        child: const Icon(
          Icons.currency_exchange_rounded,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Center(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text('Dólar Hoje: ${dollarCotacao.toStringAsFixed(2)}'),
                  Text('Euro Hoje: ${euroCotacao.toStringAsFixed(2)}'),
                ],
              ),
              const SizedBox(height: 25.0),
              const Text('SEU SALDO: '),
              const SizedBox(height: 25.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text('Dólares: ${dollarTotal.toStringAsFixed(2)}'),
                  Text('Euros: ${euroTotal.toStringAsFixed(2)}'),
                ],
              ),
              const SizedBox(height: 25.0),
              TextField(
                controller: realController,
                onChanged: (value) {
                  setState(() {
                    if (realController.text.isNotEmpty) {
                      dollarTotal =
                          double.tryParse(realController.text)! * dollarCotacao;
                      euroTotal =
                          double.tryParse(realController.text)! * euroCotacao;
                    }
                  });
                },
                decoration: const InputDecoration(
                  label: Text('Real'),
                  prefix: Text('R\$ '),
                ),
              ),
              const SizedBox(height: 25.0),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    dollarController.clear();
                    euroController.clear();
                    realController.clear();
                    dollarTotal = 0.0;
                    euroTotal = 0.0;
                  });
                },
                style: const ButtonStyle().copyWith(
                  backgroundColor: MaterialStateProperty.all(
                    Colors.amber,
                  ),
                ),
                child: const Text(
                  'LIMPAR',
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
