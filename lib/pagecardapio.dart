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
                var a = [];
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
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          children: [
            Image.network(
              itemCalendario['image_url'],
              width: MediaQuery.of(context).size.width * 0.45,
            ),
            Flexible(
              child: Text('${itemCalendario['title']}'),
            ),
            Flexible(
              child: Text('${itemCalendario['price']}'),
            ),
          ],
        ),
      ),
    );
  }
}
