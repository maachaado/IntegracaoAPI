import 'package:flutter/material.dart';
import 'package:integracao/model/cidade.dart';
import 'package:integracao/util/componentes.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  GlobalKey<FormState> formController = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    home() {
      Navigator.of(context).pushNamed('/home');
    }

    cadastro() {
      Navigator.of(context).pushNamed('/cadastro');
    }

    consulta() {
      Navigator.of(context).pushNamed('/consulta');
    }

    cadastroCid() {
      Navigator.of(context).pushNamed('/cadCid', arguments: Cidade(0, "", ""));

    }

    consuCid() {
      Navigator.of(context).pushNamed('/consuCid');
    }

    consuCliFiltro(){     
      Navigator.of(context).pushNamed('/cliFiltro');
    }

    consuCidFiltro(){
      Navigator.of(context).pushNamed('/cidFiltro');
    }


    return Scaffold(
      appBar: Componentes().criaAppBar('Utilização API', home),
      body: Form(
        key: formController,
        child: Column(
          children: [
            Componentes().iconeGrande2(),
            Componentes()
                .criaBotao(formController, cadastro, 'Cadastro Pessoa'),
            Componentes()
                .criaBotao(formController, consulta, 'Consulta Pessoa'),
                Componentes().criaBotao(formController, consuCliFiltro, "Consulta Pessoa por Cidade"),
                Componentes().iconeGrande3(),
            Componentes()
                .criaBotao(formController, cadastroCid, "Cadastro Cidade"),
            Componentes().criaBotao(formController, consuCid, 'Consulta Cidade'),
            Componentes().criaBotao(formController, consuCidFiltro, 'Consulta Cidade por UF')
          ],
        ),
      ),
    );
  }
}
