import 'package:flutter/material.dart';
import 'package:integracao/api/acesso_api.dart';
import 'package:integracao/model/cidade.dart';
import 'package:integracao/util/componentes.dart';

class ConsultaCidade extends StatefulWidget {
  const ConsultaCidade({super.key});

  @override
  State<ConsultaCidade> createState() => _ConsultaCidadeState();
}

class _ConsultaCidadeState extends State<ConsultaCidade> {
  GlobalKey<FormState> formController = GlobalKey<FormState>();
  List<Cidade> lista = [];

listarTodos() async {
    List<Cidade> cidades = await AcessoApi().listaCidades();
    setState(() {
      lista = cidades;
    });
  }
  
  @override
  void initState() {
    super.initState();
    listarTodos();
  }

  @override
  Widget build(BuildContext context) {
    irTelaCadastro() {
      Navigator.pushNamed(
        context,
        "/cadCid",
        arguments: Cidade(0, "", ""),
      );
    }

    return Scaffold(
      body: ListView.builder(
        itemCount: lista.length,
        itemBuilder: (context, indice) {
          return Card(
            elevation: 6,
            margin: const EdgeInsets.all(3),
            child: criaItemCidade(lista[indice], context),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: irTelaCadastro,
        child: const Icon(Icons.add),
      ),
    );
  }

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
}