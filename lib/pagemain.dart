import 'package:flutter/material.dart';
import 'pageaddpedido.dart';
import 'apiintegration.dart';
import 'package:intl/intl.dart';
import 'dart:convert' show json;

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _selecteditem = 0;
  List pedidos = [];
  List pedidosClone = [];
  List contas = [];
  var newSeats = '0';
  var listdropdown = [
    const DropdownMenuItem(
      value: '1',
      child: Text('1'),
    ),
    const DropdownMenuItem(
      value: '2',
      child: Text('2'),
    ),
    const DropdownMenuItem(
      value: '3',
      child: Text('3'),
    ),
    const DropdownMenuItem(
      value: '4',
      child: Text('4'),
    ),
    const DropdownMenuItem(
      value: '5',
      child: Text('5'),
    ),
    const DropdownMenuItem(
      value: '6',
      child: Text('6'),
    ),
    const DropdownMenuItem(
      value: '7',
      child: Text('7'),
    ),
    const DropdownMenuItem(
      value: '8',
      child: Text('8'),
    ),
    const DropdownMenuItem(
      value: '9',
      child: Text('9'),
    ),
    const DropdownMenuItem(
      value: '10',
      child: Text('10'),
    ),
    const DropdownMenuItem(
      value: '11',
      child: Text('11'),
    ),
    const DropdownMenuItem(
      value: '12',
      child: Text('12'),
    ),
  ];
  @override
  Widget build(BuildContext context) {
    Future _getMesas = getMesas(context);
    Future _getContas = getContas(context);
    Future _getPedidos = getPedidos(context);
    Widget? _floatingbuttom() {
      if (_selecteditem == 1 &&
          user != null &&
          user!['role']['name'] != 'ROLE_KITCHEN') {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (user!['role']['name'] != 'ROLE_ADMIM')
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 5),
                child: FloatingActionButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const PedidoPage()),
                    );
                  },
                  child: const Icon(Icons.add_shopping_cart),
                ),
              ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 5),
              child: FloatingActionButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const PedidoPage()),
                  );
                },
                child: const Icon(Icons.add),
              ),
            ),
          ],
        );
      } else if (_selecteditem == 2 &&
          user != null &&
          user!['role']['name'] != 'ROLE_ADMIM') {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (user!['role']['name'] != 'ROLE_ADMIM')
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 5),
                child: FloatingActionButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const PedidoPage()),
                    );
                  },
                  child: const Icon(Icons.add_shopping_cart),
                ),
              ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 5),
              child: FloatingActionButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const PedidoPage()),
                  );
                },
                child: const Icon(Icons.add_box_rounded),
              ),
            ),
          ],
        );
      } else if (user != null && user!['role']['name'] != 'ROLE_ADMIM') {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 5),
          child: FloatingActionButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const PedidoPage()),
              );
            },
            child: const Icon(Icons.add_shopping_cart),
          ),
        );
      }
      return null;
    }

    final bottomNavigationBarBody = [
      if (user == null || user!['role']['name'] != 'ROLE_KITCHEN')
        RefreshIndicator(
          child: ListView(
            children: [
              FutureBuilder(
                future: _getContas,
                builder: (context, snapshot) {
                  if (snapshot.hasData &&
                      snapshot.connectionState == ConnectionState.done) {
                    var a = json.decode(snapshot.data.toString());
                    if (contas.isEmpty) {
                      contas = a;
                    }

                    return Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(
                            0,
                            0,
                            0,
                            100,
                          ),
                          child: ExpansionPanelList(
                            expansionCallback:
                                (int index, bool isExpanded) async {
                              contas[index]['order_item'] =
                                  await getOrderItemsByBill(
                                      context, contas[index]['id']);
                              setState(
                                () {
                                  contas[index]['ready'] = !isExpanded;
                                },
                              );
                            },
                            children: contas.map((e) {
                              // print(e);
                              List<Widget> botao = [
                                ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    minimumSize: Size(
                                      MediaQuery.of(context).size.width * 0.8,
                                      40,
                                    ),
                                  ),
                                  onPressed: () async {
                                    var res = await closeBill(context, e['id']);
                                    if (res != null) {
                                      setState(() => contas.clear());
                                      _getContas = getContas(context);
                                    }
                                  },
                                  child: const Text('Fechar conta'),
                                ),
                              ];
                              return ExpansionPanel(
                                  headerBuilder:
                                      (BuildContext context, bool isExpanded) {
                                    return Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10),
                                      child: Row(
                                        children: [
                                          Expanded(
                                            flex: 3,
                                            child: Text(
                                                'Mesa: ${e['table']['number']}'),
                                          ),
                                          Expanded(
                                            child: Text(
                                                'Total: ${e['total_value']}'),
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                  body: Container(
                                    color: Colors.black26,
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 20,
                                      vertical: 10,
                                    ),
                                    child: Column(
                                      children: (e['order_item'] ?? [])
                                              .map<Widget>(
                                                (iten) => Container(
                                                  margin:
                                                      const EdgeInsets.fromLTRB(
                                                    0,
                                                    0,
                                                    0,
                                                    10,
                                                  ),
                                                  decoration:
                                                      const BoxDecoration(
                                                    border: Border(
                                                      bottom: BorderSide(
                                                        color: Colors.black,
                                                      ),
                                                    ),
                                                  ),
                                                  child: Column(
                                                    children: [
                                                      Row(
                                                        children: [
                                                          Expanded(
                                                            flex: 5,
                                                            child: Text(
                                                                '${iten['item']['name']}'),
                                                          ),
                                                          Expanded(
                                                            child: Text(
                                                                '${iten['quantity']}'),
                                                          ),
                                                        ],
                                                      ),
                                                      if (iten['description'] !=
                                                          '')
                                                        Row(
                                                          children: const [
                                                            Text(
                                                                '    Descrição:')
                                                          ],
                                                        ),
                                                      if (iten['description'] !=
                                                          '')
                                                        Row(
                                                          children: [
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .symmetric(
                                                                horizontal: 25,
                                                              ),
                                                              child: Flexible(
                                                                child: Text(
                                                                    '${iten['description']}'),
                                                              ),
                                                            ),
                                                          ],
                                                        )
                                                    ],
                                                  ),
                                                ),
                                              )
                                              .toList() +
                                          botao,
                                    ),
                                  ),
                                  isExpanded: e['ready'] ?? false);
                            }).toList(),
                          ),
                        ),
                      ],
                    );
                  }
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                },
              )
            ],
          ),
          onRefresh: () {
            return Future.delayed(
              const Duration(seconds: 1),
              () {
                _getContas = getContas(context);
                setState(() {
                  contas.clear();
                });
              },
            );
          },
        ),
      RefreshIndicator(
        child: ListView(
          children: [
            FutureBuilder(
              future: _getPedidos,
              builder: (context, snapshot) {
                if (snapshot.hasData &&
                    snapshot.connectionState == ConnectionState.done) {
                  pedidos = json.decode(snapshot.data.toString());
                  pedidos = pedidos
                      .where(
                        (e) => (e['delivered'] == false),
                      )
                      .toList();
                  if (pedidosClone.isEmpty) {
                    pedidos = pedidos.map((element) {
                      element['isExpanded'] = false;
                      return element;
                    }).toList();
                    pedidosClone = pedidos;
                  }
                }
                // print(pedidos);
                return Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(
                        0,
                        0,
                        0,
                        100,
                      ),
                      child: ExpansionPanelList(
                        expansionCallback: (int index, bool isExpanded) {
                          setState(
                            () {
                              getOrderItems(
                                context,
                                pedidosClone[index]['id'],
                              ).then(
                                (value) => pedidosClone[index]['order_item'] =
                                    value ?? [],
                              );
                              pedidosClone[index]['isExpanded'] = !isExpanded;
                            },
                          );
                        },
                        children: pedidosClone.map((e) {
                          List<Widget> botao = [
                            if (!e['ready'])
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  minimumSize: Size(
                                    MediaQuery.of(context).size.width * 0.8,
                                    40,
                                  ),
                                ),
                                onPressed: () async {
                                  var res = await putPedidos(context, e);
                                  if (res != null) {
                                    setState(() => pedidosClone.clear());
                                    _getPedidos = getPedidos(context);
                                  }
                                },
                                child: const Text('Pronto'),
                              ),
                            if (e['ready'] && !(e['delivered'] ?? false))
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  minimumSize: Size(
                                    MediaQuery.of(context).size.width * 0.8,
                                    40,
                                  ),
                                ),
                                onPressed: () async {
                                  var res = await putPedidos(context, e, true);
                                  if (res != null) {
                                    setState(() => pedidosClone.clear());
                                    _getPedidos = getPedidos(context);
                                  }
                                },
                                child: const Text('Entregue'),
                              ),
                          ];
                          return ExpansionPanel(
                            headerBuilder:
                                (BuildContext context, bool isExpanded) {
                              return Container(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                child: Row(
                                  children: [
                                    Expanded(
                                      flex: 2,
                                      child: Text(
                                          'Mesa: ${e['bill']['table']['number']}'),
                                    ),
                                    if (e['ready'])
                                      const Expanded(
                                        flex: 2,
                                        child: Text('Pronto'),
                                      ),
                                    if (!e['ready'])
                                      const Expanded(
                                        flex: 2,
                                        child: Text('Em preparo'),
                                      ),
                                    Expanded(
                                      child: Text(
                                        DateFormat('dd/MM HH:mm').format(
                                          DateTime.parse(
                                            e['created_at'],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                            body: Container(
                              color: Colors.black26,
                              padding: const EdgeInsets.symmetric(
                                horizontal: 20,
                                vertical: 10,
                              ),
                              child: Column(
                                children: (e['order_item'] ?? [])
                                        .map<Widget>(
                                          (iten) => Container(
                                            margin: const EdgeInsets.fromLTRB(
                                              0,
                                              0,
                                              0,
                                              10,
                                            ),
                                            decoration: const BoxDecoration(
                                              border: Border(
                                                bottom: BorderSide(
                                                  color: Colors.black,
                                                ),
                                              ),
                                            ),
                                            child: Column(
                                              children: [
                                                Row(
                                                  children: [
                                                    Expanded(
                                                      flex: 5,
                                                      child: Text(
                                                          '${iten['item']['name']}'),
                                                    ),
                                                    Expanded(
                                                      child: Text(
                                                          '${iten['quantity']}'),
                                                    ),
                                                  ],
                                                ),
                                                if (iten['description'] != '')
                                                  Row(
                                                    children: const [
                                                      Text('    Descrição:')
                                                    ],
                                                  ),
                                                if (iten['description'] != '')
                                                  Row(
                                                    children: [
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .symmetric(
                                                          horizontal: 25,
                                                        ),
                                                        child: Flexible(
                                                          child: Text(
                                                              '${iten['description']}'),
                                                        ),
                                                      ),
                                                    ],
                                                  )
                                              ],
                                            ),
                                          ),
                                        )
                                        .toList() +
                                    botao,
                              ),
                            ),
                            isExpanded: e['isExpanded'] ?? false,
                          );
                        }).toList(),
                      ),
                    ),
                  ],
                );
              },
            ),
          ],
        ),
        onRefresh: () {
          return Future.delayed(
            const Duration(seconds: 1),
            () {
              _getPedidos = getPedidos(context);
              setState(() {
                pedidosClone.clear();
              });
            },
          );
        },
      ),
      if (user == null || user!['role']['name'] != 'ROLE_KITCHEN')
        FutureBuilder(
          future: _getMesas,
          builder: (context, snapshot) {
            List mesas = [];
            if (snapshot.hasData &&
                snapshot.connectionState == ConnectionState.done) {
              mesas = json.decode(snapshot.data.toString());
              // mesas = mesas.where((mesa) => mesa['busy'] == false).toList();
              // print(mesas);
              return ListView(
                children: mesas.map((e) {
                  if (e['active']) {
                    return Container(
                      margin: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 5,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: TextButton(
                        onLongPress: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              newSeats = e['seats'].toString();
                              return AlertDialog(
                                title: Text('Editar mesa: ${e['number']}'),
                                content: Row(
                                  children: [
                                    const Expanded(
                                      flex: 1,
                                      child: Text('Lugares:'),
                                    ),
                                    Expanded(
                                      flex: 2,
                                      child: DropdownButton<String>(
                                          value: newSeats,
                                          onChanged: (Object? value) async {
                                            var res = await putMesas(
                                                context, e, value.toString());
                                            if (res != null) {
                                              Navigator.of(context,
                                                      rootNavigator: true)
                                                  .pop('dialog');
                                              _getMesas = getMesas(context);
                                              setState(() {});
                                            }
                                          },
                                          alignment: Alignment.center,
                                          items: listdropdown),
                                    ),
                                  ],
                                ),
                              );
                            },
                          );
                        },
                        onPressed: () {
                          if (!e['busy']) {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: Text(
                                      'Deseja marcar a mesa ${e['number']} como ocupada?'),
                                  content: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      ElevatedButton(
                                        onPressed: () async {
                                          var res =
                                              await createContas(context, e);
                                          if (res != null) {
                                            _getMesas = getMesas(context);
                                            Navigator.of(context,
                                                    rootNavigator: true)
                                                .pop('dialog');
                                            setState(() {
                                              mesas = [];
                                            });
                                          }
                                        },
                                        child: const Text('Sim'),
                                        style: ElevatedButton.styleFrom(
                                          minimumSize: Size(
                                            MediaQuery.of(context).size.width *
                                                0.80,
                                            40,
                                          ),
                                          primary: Colors.red,
                                          onPrimary: Colors.white,
                                        ),
                                      ),
                                      ElevatedButton(
                                        onPressed: () {
                                          Navigator.of(context,
                                                  rootNavigator: true)
                                              .pop('dialog');
                                        },
                                        child: const Text('Não'),
                                        style: ElevatedButton.styleFrom(
                                          minimumSize: Size(
                                            MediaQuery.of(context).size.width *
                                                0.80,
                                            40,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            );
                          }
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: Row(
                            children: [
                              Expanded(
                                flex: 2,
                                child: Text('Mesa: ${e['number']}'),
                              ),
                              Expanded(
                                flex: 2,
                                child: Text('Lugares: ${e['seats']}'),
                              ),
                              Expanded(
                                child: Column(
                                  children: [
                                    Icon(
                                      e['busy']
                                          ? Icons.flatware_outlined
                                          : Icons.food_bank_outlined,
                                      size: 30,
                                    ),
                                    Text(e['busy'] ? 'Ocupada' : 'Livre'),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  }
                  return Row();
                }).toList(),
              );
            }
            return const Center(
              child: CircularProgressIndicator(),
            );
          },
        ),
    ];
    final bottomNavigationBarItem = [
      const BottomNavigationBarItem(
        icon: Icon(Icons.account_balance_wallet_sharp),
        label: 'Contas',
      ),
      const BottomNavigationBarItem(
        icon: Icon(Icons.add_reaction_sharp),
        label: 'Pedidos',
      ),
      const BottomNavigationBarItem(
        icon: Icon(Icons.table_chart_outlined),
        label: 'Mesas',
      ),
    ];
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Row(
          children: [
            Expanded(
              flex: 5,
              child: Container(
                alignment: Alignment.centerLeft,
                child: Image.asset(
                  'images/logo.png',
                  height: 40,
                ),
              ),
            ),
            Expanded(
              child: Container(
                alignment: Alignment.centerRight,
                child: IconButton(
                  onPressed: () {
                    processLogout(context);
                  },
                  icon: const Icon(
                    Icons.exit_to_app,
                    size: 30,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: _floatingbuttom(),
      body: bottomNavigationBarBody[_selecteditem],
      bottomNavigationBar:
          user == null || user!['role']['name'] != 'ROLE_KITCHEN'
              ? BottomNavigationBar(
                  currentIndex: _selecteditem,
                  onTap: (e) {
                    setState(() {
                      _selecteditem = e;
                    });
                  },
                  items: bottomNavigationBarItem,
                )
              : Row(),
    );
  }
}
