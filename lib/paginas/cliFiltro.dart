import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:integracao/api/acesso_api.dart';
import 'package:integracao/model/pessoa.dart';
import 'package:integracao/util/componentes.dart';

class ClienteFiltrado extends StatefulWidget {
  const ClienteFiltrado({super.key});

  @override
  State<ClienteFiltrado> createState() => _ClienteFiltradoState();
}

class _ClienteFiltradoState extends State<ClienteFiltrado> {
GlobalKey<FormState> formController = GlobalKey<FormState>();
  TextEditingController txtCidade = TextEditingController();


List<Pessoa> lista = [];

listarTodos() async {
    List<Pessoa> pessoas = await AcessoApi().listaPessoaPorCidades(txtCidade.text);
    setState(() {
      lista = pessoas;
    });
  }

  @override
  Widget build(BuildContext context) {



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
    home() {
      Navigator.of(context).pushNamed('/home');
    }

    return Scaffold(
       appBar:Componentes().criaAppBar("Pesquisa por Cidade", home),
       body:  Form(
        key: formController,
        child: Column(
          children: [
            Componentes().criaInputTexto(TextInputType.text, "Informe o ID da Cidade", txtCidade, 'Não foi possível executar a ação'),
           Componentes().criaBotao(formController, listarTodos, 'PESQUISAR'),
           Expanded(
             child: ListView.builder(
                   itemCount: lista.length,
                   itemBuilder: (context, indice) {
                     return Card(
              elevation: 6,
              margin: const EdgeInsets.all(3),
              child: criaItemPessoa(lista[indice], context),
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
       
       