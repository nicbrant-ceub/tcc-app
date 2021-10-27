import 'package:flutter/material.dart';
import 'pageaddpedido.dart';
import 'dart:convert' show json;

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('Pedidos'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const PedidoPage()),
          );
        },
        child: const Icon(Icons.add),
      ),
      body: FutureBuilder(builder: (context, snapshot) {
        List mesas = [];
        if (snapshot.hasData) mesas = json.decode(snapshot.data.toString());
        return ListView(
          children: mesas
              .map(
                (e) => Container(
                  child: e['title'],
                ),
              )
              .toList(),
        );
      }),
    );
  }
}
