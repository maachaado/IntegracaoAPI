import 'package:flutter/material.dart';
import 'package:integracao/paginas/cad_cid.dart';
import 'package:integracao/paginas/cadastro.dart';
import 'package:integracao/paginas/cidFiltro.dart';
import 'package:integracao/paginas/cliFiltro.dart';
import 'package:integracao/paginas/consulCid.dart';
import 'package:integracao/paginas/consulta.dart';
import 'package:integracao/paginas/home.dart';
import 'package:integracao/util/tema.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: Tema().criaTema(),
      initialRoute: '/home',
      routes: {
        '/home': (context) => const Home(),
        '/consulta': (context) => const ConsultaPessoa(),
        '/cadastro': (context) => const Cadastro(),
        '/cadCid': (context) => const CadastroCidade(),
        '/consuCid': (context) => const ConsultaCidade(),
        '/cliFiltro':(context) => const ClienteFiltrado(),       
        '/cidFiltro': (context) => const CidadeFiltrada(),
        
      },
    );
  }
}
