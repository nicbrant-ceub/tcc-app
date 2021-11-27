import 'package:flutter/material.dart';
import 'dart:convert' show json;

import 'package:tccrestaurante/apiintegration.dart';

class PedidoPage extends StatefulWidget {
  final Map? pedido;

  const PedidoPage({Key? key, this.pedido}) : super(key: key);

  @override
  State<PedidoPage> createState() => _PedidoPageState();
}

class _PedidoPageState extends State<PedidoPage> {
  String _mesa = '';
  List<Map> listPedidos = [
    {
      'id': null,
      'quantity': 1,
      'description': '',
      'value': 0,
    }
  ];
  List<DropdownMenuItem<String>> listdropdown = [
    const DropdownMenuItem(
      value: null,
      child: Text('Selecione um Item'),
    ),
  ];
  List<DropdownMenuItem<String>> listdropdownMesas = [
    const DropdownMenuItem(
      value: '',
      child: Text('Selecione uma mesa'),
    ),
  ];
  // ignore: prefer_typing_uninitialized_variables
  late Future<String?> _chamada;
  late Future<String?> _chamada2;
  late List itens;
  @override
  void initState() {
    _chamada = getItens(context);
    _chamada2 = getMesas(context);
    _chamada2.then((value) {
      List itens = json.decode(value.toString());
      itens = itens.where((mesa) => mesa['busy'] == true).toList();
      listdropdownMesas += itens
          .map<DropdownMenuItem<String>>(
            (i) => DropdownMenuItem(
              value: i['id'],
              child: Text('${i['number']}'),
            ),
          )
          .toList();
    });
    _chamada.then((value) {
      itens = json.decode(value.toString());
      listdropdown += itens
          .map<DropdownMenuItem<String>>(
            (i) => DropdownMenuItem(
              value: i['id'],
              child: Text('${i['name']}'),
            ),
          )
          .toList();
    });
    super.initState();
  }

  final String _titulo = 'Adicionar';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${_titulo + ' '}Pedidos'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            listPedidos.add({
              'id': null,
              'quantity': 1,
              'description': '',
              'value': 0,
            });
          });
        },
        child: const Icon(Icons.add),
      ),
      body: FutureBuilder(
        future: _chamada,
        builder: (context, snapshot) {
          if (snapshot.hasData &&
              snapshot.connectionState == ConnectionState.done) {
            List<Widget> selecionapedido = [
              Container(
                alignment: Alignment.center,
                color: Colors.white,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('Mesa: '),
                    DropdownButton<String>(
                        value: _mesa,
                        onChanged: (Object? value) {
                          setState(() => _mesa = value.toString());
                        },
                        alignment: Alignment.center,
                        items: listdropdownMesas),
                  ],
                ),
              ),
            ];
            List<Widget> enviapedido = [
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 50,
                ),
                child: ElevatedButton(
                  onPressed: () async {
                    if (_mesa != '') {
                      var res = await createOrder(context, listPedidos, _mesa);
                      if (res != null) Navigator.pop(context);
                    } else {
                      ScaffoldMessenger.of(context)
                        ..removeCurrentSnackBar()
                        ..showSnackBar(
                          const SnackBar(
                            content: Text('Por favor selecione uma mesa'),
                          ),
                        );
                    }
                  },
                  child: const Text('Confirmar pedido'),
                ),
              ),
            ];
            return ListView(
              children: selecionapedido +
                  listPedidos
                      .map<Widget>(
                        (e) => Container(
                          color: Colors.white,
                          width: MediaQuery.of(context).size.width,
                          padding: const EdgeInsets.all(10),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    flex: 3,
                                    child: DropdownButton<String>(
                                        value: e['id'],
                                        onChanged: (Object? value) {
                                          setState(() {
                                            e['value'] = itens
                                                .where((element) =>
                                                    element['id'] == value)
                                                .first['value'];
                                            e['id'] = value;
                                          });
                                        },
                                        alignment: Alignment.center,
                                        items: listdropdown),
                                  ),
                                  Expanded(
                                    flex: 2,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        ElevatedButton(
                                          onPressed: () {
                                            if (e['quantity'] > 0) {
                                              setState(() => e['quantity']--);
                                            }
                                          },
                                          child: const Icon(Icons.remove),
                                        ),
                                        Text(' ${e['quantity']} '),
                                        ElevatedButton(
                                          onPressed: () {
                                            setState(() => e['quantity']++);
                                          },
                                          child: const Icon(Icons.add),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                children: const [
                                  Text('Observação:'),
                                ],
                              ),
                              Row(
                                children: [
                                  Expanded(
                                    child: TextField(
                                      maxLines: 4,
                                      decoration: const InputDecoration(
                                        border: UnderlineInputBorder(),
                                        focusedBorder: UnderlineInputBorder(),
                                        hintText: "Ex: sem cebola\nao ponto...",
                                      ),
                                      onChanged: (value) {
                                        setState(
                                            () => e['description'] = value);
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      )
                      .toList() +
                  enviapedido,
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
