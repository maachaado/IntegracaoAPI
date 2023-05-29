// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:integracao/model/cidade.dart';
import 'package:integracao/model/pessoa.dart';

class Componentes {
  criaAppBar(texto, acao) {
    return AppBar(
      title: criaTexto(texto),
      centerTitle: true,
      actions: <Widget>[
        IconButton(
          icon: const Icon(Icons.home),
          onPressed: acao,
        )
      ],
    );
  }

  criaTexto(texto, [cor]) {
    if (cor != null) {
      return Text(
        texto,
        style: TextStyle(color: cor),
      );
    }
    return Text(texto);
  }

  iconeGrande() {
    return const Icon(
      Icons.maps_home_work_outlined,
      size: 180,
    );
  }

  iconeGrande2() {
    return const Icon(
      Icons.person_add,
      size: 150,
    );
  }

  iconeGrande3() {
    return const Icon(
      Icons.maps_home_work,
      size: 150,
    );
  }

  

  criaInputTexto(tipoTeclado, textoEtiqueta, controlador, msgValidacao) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: TextFormField(
          keyboardType: tipoTeclado,
          decoration: InputDecoration(
            labelText: textoEtiqueta,
            labelStyle: const TextStyle(
              fontSize: 20,
            ),
          ),
          textAlign: TextAlign.left,
          style: const TextStyle(fontSize: 30),
          controller: controlador,
          validator: (value) {
            if (value!.isEmpty) {
              return msgValidacao;
            }
          }),
    );
  }

  criaBotao(controladorFormulario, funcao, titulo) {
    return Row(
      children: [
        Expanded(
          flex: 1,
          child: Container(
            padding: const EdgeInsets.fromLTRB(5, 10, 5, 10),
            height: 60,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Colors.black,
              ),
              onPressed: () {
                if (controladorFormulario.currentState!.validate()) {
                  funcao();
                }
              },
              child: Text(
                titulo,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 30,
                ),
              ),
            ),
          ),
        )
      ],
    );
  }

  criaContainerDados(rua, complemento, bairro, cidade, estado) {
    return Container(
      padding: const EdgeInsets.all(10),
      height: 250,
      width: double.infinity,
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(flex: 1, child: criaTexto(rua, Colors.black)),
            Expanded(flex: 1, child: criaTexto(complemento, Colors.black)),
            Expanded(flex: 1, child: criaTexto(bairro, Colors.black)),
            Expanded(flex: 1, child: criaTexto(cidade, Colors.black)),
            Expanded(flex: 1, child: criaTexto(estado, Colors.black)),
          ],
        ),
      ),
    );
  }

  criaItemPessoa(Pessoa p, context) {
    String sexo = p.sexo == 'M' ? 'Masculino' : 'Feminino';
    return ListTile(
      title: criaTexto('${p.id} - ${p.nome} - ${p.idade} anos - ${p.sexo}'),
      subtitle: criaTexto('${p.cidade.nome} - ${p.cidade.uf}'),
      trailing: FittedBox(
        fit: BoxFit.fill,
        child: Row(
          children: [
            IconButton(
              icon: Icon(Icons.edit),
              onPressed: (() {
              Navigator.pushNamed(context, '/cadastro', arguments: p);
            }
            )
            )
          ],
        ),
      ),
    );
  }

  criaItemCidade(Cidade c) {
   return ListTile(
      title: criaTexto('${c.id} - ${c.nome} - ${c.uf}'),
   );
 }
}
