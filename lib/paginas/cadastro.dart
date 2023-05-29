import 'package:flutter/material.dart';
import 'package:integracao/api/acesso_api.dart';
import 'package:integracao/model/cidade.dart';
import 'package:integracao/model/pessoa.dart';
import 'package:integracao/util/combo_cidade.dart';
import 'package:integracao/util/componentes.dart';
import 'package:integracao/util/radio_sexo.dart';

class Cadastro extends StatefulWidget {
  const Cadastro({super.key});

  @override
  State<Cadastro> createState() => _CadastroState();
}

class _CadastroState extends State<Cadastro> {
  GlobalKey<FormState> formController = GlobalKey<FormState>();
  TextEditingController txtNome = TextEditingController();
  TextEditingController txtSexo = TextEditingController(text: 'M');
  TextEditingController txtIdade = TextEditingController();
  TextEditingController txtCidade = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // cadastrar() {
    //   Pessoa p = Pessoa(0, txtNome.text, txtSexo.text, int.parse(txtIdade.text),
    //       Cidade(int.parse(txtCidade.text), '', ''));
    //   AcessoApi().inserePessoa(p.toJson());
    //   Navigator.of(context).pushNamed('/consulta');
    // }

    dynamic args = {};
    if (ModalRoute.of(context)?.settings.arguments != null) {
      args = ModalRoute.of(context)?.settings.arguments as Pessoa;
      if (args.id > -1) {
        Cidade s = args.cidade as Cidade;
        txtNome.text = args.nome;
        txtIdade.text = '${args.idade}';
        txtCidade.text = '${s.id}';
        txtSexo.text = args.sexo;
      }
    }


    cadastrar() async {
      if (args is Pessoa) {
        Pessoa c = Pessoa(
            args.id,
            txtNome.text,
            txtSexo.text,
            int.parse(txtIdade.text),
            Cidade(int.parse(txtCidade.text), "", ""));
        await AcessoApi().alteraCliente(c.toJson(), '${c.id}');
    
      Navigator.of(context).pushNamed('/consulta');
          
       
      } else {
        Pessoa c = Pessoa(
            0,
            txtNome.text,
            txtSexo.text,
            int.parse(txtIdade.text),
            Cidade(int.parse(txtCidade.text), "", ""));
        await AcessoApi().inserePessoa(c.toJson());
       

       Navigator.of(context).pushNamed('/consulta');
      }
    }

    home() {
      Navigator.of(context).pushNamed('/home');
    }

    return Scaffold(
      appBar: Componentes().criaAppBar("Cadastro Pessoa", home),
      body: Form(
        key: formController,
        child: Column(
          children: [
            Componentes().criaInputTexto(
                TextInputType.text, "Nome", txtNome, "Informe seu nome"),
            Componentes().criaInputTexto(
                TextInputType.number, "Idade", txtIdade, "Informe sua idade"),
            Center(child: RadioSexo(controller: txtSexo)),
            Center(child: ComboCidade(controller: txtCidade)),
            Componentes().criaBotao(formController, cadastrar, "Cadastrar")
          ],
        ),
      ),
    );
  }
}
