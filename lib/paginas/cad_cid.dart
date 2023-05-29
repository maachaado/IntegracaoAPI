import 'package:flutter/material.dart';
import 'package:integracao/api/acesso_api.dart';
import 'package:integracao/model/cidade.dart';
import 'package:integracao/model/pessoa.dart';
import 'package:integracao/util/componentes.dart';

class CadastroCidade extends StatefulWidget {
  const CadastroCidade({super.key});

  @override
  State<CadastroCidade> createState() => _CadastroCidadeState();
}

class _CadastroCidadeState extends State<CadastroCidade> {
  GlobalKey<FormState> formController = GlobalKey<FormState>();
  TextEditingController txtNome = TextEditingController();
  TextEditingController txtUf = TextEditingController();

  @override
  Widget build(BuildContext context) {
   final args = ModalRoute.of(context)?.settings.arguments as Cidade;
    txtNome.text = args.nome;
    txtUf.text = args.uf;

   salvar() async {
      Cidade c =
          Cidade(0, txtNome.text, txtUf.text);
      if (args.id == 0) {
        await AcessoApi().insereCidade(c.toJson());
      } else {
        await AcessoApi().alteraCidade(c.toJson());
      }
     
      Navigator.of(context).pushNamed('/consuCid');
      
   }

    home() {
      Navigator.of(context).pushNamed('/home');
    }

    return Scaffold(
      appBar: Componentes().criaAppBar("Cadastro Cidade", home),
      body: Form(
        key: formController,
        child: Column(
          children: [
            Componentes().criaInputTexto(TextInputType.text, "Nome", txtNome,
                "Informe o nome da Cidade"),
            Componentes().criaInputTexto(TextInputType.text, "UF", txtUf,
                "Informe o Estado da sua Cidade"),
            Componentes().criaBotao(formController, salvar, "Cadastrar")
          ],
        ),
      ),
    );
  }
}
