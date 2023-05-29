import 'package:flutter/material.dart';
import 'package:integracao/api/acesso_api.dart';
import 'package:integracao/model/cidade.dart';
import 'package:integracao/util/componentes.dart';

class CidadeFiltrada extends StatefulWidget {
  const CidadeFiltrada({super.key});

  @override
  State<CidadeFiltrada> createState() => _CidadeFiltradaState();
}

class _CidadeFiltradaState extends State<CidadeFiltrada> {
  GlobalKey<FormState> formController = GlobalKey<FormState>();
  TextEditingController txtUf = TextEditingController();


List<Cidade> lista = [];

listarTodos() async {
    List<Cidade> cidades = await AcessoApi().listaCidadePorUf(txtUf.text);
    setState(() {
      lista = cidades;
    });
  }

  @override
  Widget build(BuildContext context) {

criaItemCidade(Cidade c, context) {
    return ListTile(
      title: Text('${c.id} - ${c.nome}'),
      subtitle: Text(c.uf), 
      trailing: FittedBox(
        fit: BoxFit.fill,
        child: Row(
          children: [
            IconButton(
                icon: const Icon(Icons.edit),
                onPressed: () {
                  Navigator.pushNamed(
                    context,
                    "/cadCid",
                    arguments: c,
                  );
                }),
            IconButton(
                icon: const Icon(Icons.delete),
                onPressed: () async {
                  await AcessoApi().excluiCidade(c.id);
                  setState(() {
                    listarTodos();
                  });
                }),
          ],
        ),
      ),
    );
  }


    home() {
      Navigator.of(context).pushNamed('/home');
    }

    return Scaffold(
      appBar: Componentes().criaAppBar("Pesquisa por UF", home),
      body: Form(
        key: formController,
        child: Column(
          children: [
           Componentes().criaInputTexto(TextInputType.text, "Informe o UF da Cidade", txtUf, 'Não foi possível executar a ação'),
           Componentes().criaBotao(formController, listarTodos, 'PESQUISAR'),
           Expanded(
             child: ListView.builder(
                   itemCount: lista.length,
                   itemBuilder: (context, indice) {
                     return Card(
              elevation: 6,
              margin: const EdgeInsets.all(3),
              child: criaItemCidade(lista[indice], context),
                     );
                   },
                 ),
           ),
          ],
        ),
      ),
    );
    }
    }




      