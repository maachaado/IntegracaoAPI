import 'dart:convert';

import 'package:http/http.dart';
import 'package:integracao/model/cidade.dart';
import 'package:integracao/model/pessoa.dart';

class AcessoApi {
  Future<List<Pessoa>> listaPessoas() async {
    String url = 'http://localhost:8080/cliente';
    Response resposta = await get(Uri.parse(url));
    String jsonFormatoUft8 = (utf8.decode(resposta.bodyBytes));
    Iterable l = json.decode(jsonFormatoUft8);
    List<Pessoa> pessoas = List<Pessoa>.from(l.map((p) => Pessoa.fromJson(p)));
    return pessoas;
  }

  Future<List<Cidade>> listaCidades() async {
    String url = 'http://localhost:8080/cidade/lista';
    Response resposta = await get(Uri.parse(url));
    String jsonFormatoUft8 = (utf8.decode(resposta.bodyBytes));
    Iterable l = json.decode(jsonFormatoUft8);
    List<Cidade> cidades = List<Cidade>.from(l.map((c) => Cidade.fromJson(c)));
    return cidades;
  }

  Future<void> inserePessoa(Map<String, dynamic> pessoa) async {
    String url = 'http://localhost:8080/cliente';
    Map<String, String> headers = {
      'Content-type': 'application/json; charset=UTF-8'
    };
    await post(Uri.parse(url), headers: headers, body: json.encode(pessoa));
  }

  Future<void> insereCidade(Map<String, dynamic> cidade) async {
    String url = 'http://localhost:8080/cidade';
    Map<String, String> headers = {
      'Content-type': 'application/json; charset=UTF-8'
    };
    await post(Uri.parse(url), headers: headers, body: json.encode(cidade));
  }

  Future<void> alteraCidade(Map<String, dynamic> cidade) async {
    String url = "http://localhost:8080/cidade";
    Map<String, String> headers = {
      "Content-Type": "application/json; charset=UTF-8"
    };
    await put(Uri.parse(url), headers: headers, body: jsonEncode(cidade));
  }

Future<void> alteraCliente(Map<String, dynamic> cliente, String id) async {
    String url = "http://localhost:8080/cliente?id=${id}";
    Map<String, String> headers = {
      "Content-Type": "application/json; charset=UTF-8"
    };
    await put(Uri.parse(url), headers: headers, body: jsonEncode(cliente));
  }

Future<void> excluiCidade(int id) async {
    String url = "http://localhost:8080/cidade/$id";
    await delete(Uri.parse(url));
  }

  Future<void> excluiCliente(int id) async {
    String url = "http://localhost:8080/cliente/$id";
    await delete(Uri.parse(url));
  }

  Future<List<Pessoa>> listaPessoaPorCidades(String cidade) async {
    String url = 'http://localhost:8080/cliente/buscacidade/$cidade';

    Response resposta = await get(Uri.parse(url));
    String jsonFormatoUft8 = (utf8.decode(resposta.bodyBytes));
    Iterable l = json.decode(jsonFormatoUft8);
    List<Pessoa> pessoas = List<Pessoa>.from(l.map((p) => Pessoa.fromJson(p)));
    return pessoas;
  }
  Future<List<Cidade>> listaCidadePorUf(String uf) async {
    String url = 'http://localhost:8080/cidade/buscauf/$uf';
    Response resposta = await get(Uri.parse(url));
    String jsonFormatoUft8 = (utf8.decode(resposta.bodyBytes));
            print(jsonFormatoUft8);
    Iterable l = json.decode(jsonFormatoUft8);
    List<Cidade> cidades = List<Cidade>.from(l.map((c) => Cidade.fromJson(c)));
    return cidades;
  }


}
