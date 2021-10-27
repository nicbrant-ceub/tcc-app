import 'package:flutter/material.dart';
import 'dart:convert' show json;

class PedidoPage extends StatefulWidget {
  final Map? pedido;

  const PedidoPage({Key? key, this.pedido}) : super(key: key);

  @override
  State<PedidoPage> createState() => _PedidoPageState();
}

class _PedidoPageState extends State<PedidoPage> {
  final String _titulo = 'Adicionar';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text('${_titulo + ' '}Pedidos'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
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
