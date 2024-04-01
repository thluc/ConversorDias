import 'package:flutter/material.dart';

void main() async {
  runApp(MaterialApp(
    home: const MyWidget(),
    theme: ThemeData(
      hintColor: Colors.black,
      primaryColor: Colors.white,
      inputDecorationTheme: const InputDecorationTheme(
        enabledBorder: 
          OutlineInputBorder(borderSide: BorderSide(color: Colors.black)),
        focusedBorder: 
          OutlineInputBorder(borderSide: BorderSide(color: Colors.black)),
        hintStyle: TextStyle(color: Colors.black))),
  ));
}

class MyWidget extends StatefulWidget{
  const MyWidget({super.key});

  @override
  State<MyWidget> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  final anoController = TextEditingController();
  final mesController = TextEditingController();
  final diaController = TextEditingController();

  String _mensagem = "";

  GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  int ano = 0;
  int mes = 0;
  int dia = 0;

  _diaMesAnoParaDias() {
    setState(() {
      ano = int.parse(anoController.text);
      mes = int.parse(mesController.text);
      dia = int.parse(diaController.text);

      DateTime hoje = DateTime.now();

      int dias = ((hoje.year - ano) * 365) + (hoje.month * 30) + dia;
      _mensagem = "Você tem ${dias.toString()} dia(s)";
      anoController.clear();
      mesController.clear();
      diaController.clear();
    });
  }

  void _limpaCampos() {
    anoController.clear();
    mesController.clear();
    diaController.clear();
    setState(() {
      _mensagem = "Informe os seus dados";
      _formkey = GlobalKey<FormState>();
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("Ano/Mês/Dia para Dias"),
        backgroundColor: Colors.grey,
        centerTitle: true,
        actions: <Widget>[
          IconButton(onPressed:  _limpaCampos, icon: const Icon(Icons.refresh))
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(10),
        child: Form(
          key: _formkey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Icon(
                Icons.date_range, 
                size: 150,
                color: Colors.black,
              ),
              construirTextField("Ano", "Ano: ", anoController, "Erro"),
              const Divider(),
              construirTextField("Mês", "Mês: ", mesController, "Erro"),
              const Divider(),
              construirTextField("Dia", "Dia: ", diaController, "Erro"),
              Padding(
                padding: const EdgeInsets.all(10),
                child: ElevatedButton(
                  onPressed: () {
                    if (_formkey.currentState!.validate()) {
                      _diaMesAnoParaDias();
                    }
                  },
                  child: const Text( 
                    "Converter",
                    style: TextStyle(fontSize: 30, color: Colors.black), 
                  ),
                )),
              Center(child: Text(
                _mensagem,
                style: const TextStyle(
                  color: Colors.red,
                  fontWeight: FontWeight.bold,
                  fontStyle: FontStyle.italic,
                  fontSize: 30),
                ),
              ),
            ],
          )),
      ),
    );
  }
}

Widget construirTextField(String text, String prefixo, TextEditingController c,
    String mensagemErro) {
  return TextFormField(
    validator: (value) {
      if(value!.isEmpty) {
        return mensagemErro;
      } else {
        return null;
      }
    },
    controller: c,
    decoration: InputDecoration(
      labelText: text,
      labelStyle: const TextStyle(color: Colors.black),
      border: const OutlineInputBorder(),
      prefixText: prefixo),
    style: const TextStyle(color: Colors.black),
  );
}