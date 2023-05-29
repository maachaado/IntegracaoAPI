import 'package:flutter/material.dart';
import 'package:integracao/api/acesso_api.dart';
import 'package:integracao/model/cidade.dart';
import 'package:integracao/model/pessoa.dart';
import 'package:integracao/util/componentes.dart';

class ConsultaPessoa extends StatefulWidget {
  const ConsultaPessoa({super.key});

  @override
  State<ConsultaPessoa> createState() => _ConsultaPessoaState();
}

class _ConsultaPessoaState extends State<ConsultaPessoa> {
  GlobalKey<FormState> formController = GlobalKey<FormState>();
  List<Pessoa> lista = [];

listarTodos() async {
    List<Pessoa> pessoas = await AcessoApi().listaPessoas();
    setState(() {
      lista = pessoas;
    });
  }
  
  
    home() {
      Navigator.of(context).pushNamed('/home');
    }

  @override
  void initState() {
    super.initState();
    listarTodos();
  }

  @override
  Widget build(BuildContext context) {
    // irTelaCadastro() {
    //   Navigator.pushNamed(
    //     context,
    //     "/cadastro",
    //     arguments: Pessoa(0, nome, sexo, idade, cidade),
    //   );
    // }

    return Scaffold(
      appBar: Componentes().criaAppBar("Lista de Pessoas", home),
      body: ListView.builder(
        itemCount: lista.length,
        itemBuilder: (context, indice) {
          return Card(
            elevation: 6,
            margin: const EdgeInsets.all(3),
            child: criaItemPessoa(lista[indice], context),
          );
        },
      ),
    );
  }

  criaItemPessoa(Pessoa p, context) {
    return ListTile(
      title: Text('${p.id} - ${p.nome}'),
      subtitle: Text('${p.idade} anos - (${p.sexo}) - ${p.cidade.nome}/${p.cidade.uf}'),
      trailing: FittedBox(
        fit: BoxFit.fill,
        child: Row(
          children: [
            IconButton(
                icon: const Icon(Icons.edit),
                onPressed: () {
                  Navigator.pushNamed(
                    context,
                    "/cadastro",
                    arguments: p,
                  );
                }),
            IconButton(
                icon: const Icon(Icons.delete),
                onPressed: () async {
                  await AcessoApi().excluiCliente(p.id);
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