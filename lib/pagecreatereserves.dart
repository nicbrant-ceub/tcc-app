import 'dart:convert' show json;

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'apiintegration.dart';

class CreateReservePage extends StatefulWidget {
  final Map? pedido;

  const CreateReservePage({Key? key, this.pedido}) : super(key: key);

  @override
  State<CreateReservePage> createState() => _CreateReservePageState();
}

class _CreateReservePageState extends State<CreateReservePage> {
  final _form = GlobalKey<FormState>();
  String _quantidade = '1';
  DateTime _datetime = DateTime.now();
  final TimeOfDay _time = const TimeOfDay(hour: 10, minute: 0);
  final TextEditingController _contato = TextEditingController();
  final TextEditingController _nome = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cadastrar reserva'),
      ),
      body: ListView(
        children: [
          Container(
            margin: const EdgeInsets.all(10),
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.white,
            ),
            child: Form(
              key: _form,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Nome:'),
                  TextFormField(
                    controller: _nome,
                  ),
                  const Text('Telefone de contato:'),
                  TextFormField(
                    controller: _contato,
                  ),
                  const Text('Quantidade de pessoas:'),
                  DropdownButton(
                    value: _quantidade,
                    onChanged: (String? value) async {
                      setState(() {
                        _quantidade = value!;
                      });
                    },
                    items: const <DropdownMenuItem<String>>[
                      DropdownMenuItem(
                        value: '1',
                        child: Text('1'),
                      ),
                      DropdownMenuItem(
                        value: '2',
                        child: Text('2'),
                      ),
                      DropdownMenuItem(
                        value: '3',
                        child: Text('3'),
                      ),
                      DropdownMenuItem(
                        value: '4',
                        child: Text('4'),
                      ),
                      DropdownMenuItem(
                        value: '5',
                        child: Text('5'),
                      ),
                      DropdownMenuItem(
                        value: '6',
                        child: Text('6'),
                      ),
                      DropdownMenuItem(
                        value: '7',
                        child: Text('7'),
                      ),
                      DropdownMenuItem(
                        value: '8',
                        child: Text('8'),
                      ),
                      DropdownMenuItem(
                        value: '9',
                        child: Text('9'),
                      ),
                      DropdownMenuItem(
                        value: '10',
                        child: Text('10'),
                      ),
                      DropdownMenuItem(
                        value: '11',
                        child: Text('11'),
                      ),
                      DropdownMenuItem(
                        value: '12',
                        child: Text('12'),
                      ),
                    ],
                  ),
                  const Text('Data Reserva:'),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        DateFormat('dd/MM/yyyy HH:mm')
                            .format(_datetime)
                            .toString(),
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: Colors.red,
                          onPrimary: Colors.white,
                        ),
                        onPressed: () {
                          showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime.now(),
                            lastDate: DateTime(2030),
                          ).then((value) {
                            showTimePicker(context: context, initialTime: _time)
                                .then((val) {
                              if (val != null && value != null) {
                                setState(() {
                                  _datetime = DateTime(
                                    value.year,
                                    value.month,
                                    value.day,
                                    val.hour,
                                    val.minute,
                                  );
                                });
                              }
                            });
                          });
                        },
                        child: const Icon(Icons.date_range),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          minimumSize: Size(
                            MediaQuery.of(context).size.width * 0.70,
                            40,
                          ),
                        ),
                        onPressed: () async {
                          if (_form.currentState!.validate()) {
                            Map? res = await createReserve(
                              context,
                              {
                                'start_date': _datetime.toString(),
                                'name': _nome.text,
                                'contact': _contato.text,
                                'amount': int.parse(_quantidade),
                                'active': true,
                              },
                            );
                            if (res != null) {
                              Navigator.pop(context);
                            }
                          }
                        },
                        child: const Text('Reserva'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
