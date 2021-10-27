import 'dart:async';
import 'dart:core';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' show json;
import 'pageitemcardapio.dart';

class PageCardapio extends StatefulWidget {
  final bool signed;
  const PageCardapio({Key? key, this.signed = false}) : super(key: key);

  @override
  State<PageCardapio> createState() => _PageCardapioState();
}

class _PageCardapioState extends State<PageCardapio> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cardapio'),
      ),
      body: Container(
        padding: const EdgeInsets.all(5),
        child: ListView(
          children: [
            FutureBuilder(
              builder: (context, snapshot) {
                var a = [
                  {
                    'title': 'produto 1',
                    'price': 100,
                  },
                  {
                    'title': 'produto 2',
                    'price': 100,
                  }
                ];
                if (snapshot.hasData) a = json.decode(snapshot.data.toString());
                return SizedBox(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  child: GridView.count(
                    crossAxisCount: 2,
                    children: a
                        .map(
                          (e) => CalendarioItem(itemCalendario: e),
                        )
                        .toList(),
                  ),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}

class CalendarioItem extends StatelessWidget {
  final Map itemCalendario;

  const CalendarioItem({Key? key, required this.itemCalendario})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => PageItemCardapio(
              itemcalendario: itemCalendario,
            ),
          ),
        );
      },
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Container(
          width: MediaQuery.of(context).size.width,
          decoration: const BoxDecoration(
            color: Colors.white,
          ),
          child: Column(
            children: [
              Image.network(
                itemCalendario['image_url'] ?? '',
                alignment: Alignment.center,
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.16,
                fit: BoxFit.fitWidth,
                errorBuilder: (con, err, ten) {
                  return Icon(
                    Icons.error,
                    size: MediaQuery.of(context).size.height * 0.16,
                    color: Colors.grey,
                  );
                },
              ),
              Flexible(
                child: Text(
                  '${itemCalendario['title'] ?? ''}',
                  style: const TextStyle(
                    color: Colors.black,
                  ),
                ),
              ),
              Flexible(
                child: Text(
                  'R\$ ${itemCalendario['price'] ?? ''}',
                  style: const TextStyle(
                    color: Colors.black,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
