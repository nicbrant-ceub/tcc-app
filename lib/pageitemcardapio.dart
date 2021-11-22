import 'package:flutter/material.dart';

class PageItemCardapio extends StatefulWidget {
  final Map itemcalendario;

  const PageItemCardapio({Key? key, required this.itemcalendario})
      : super(key: key);

  @override
  State<PageItemCardapio> createState() => _PageItemCardapioState();
}

class _PageItemCardapioState extends State<PageItemCardapio> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.itemcalendario['name'] ?? ''}'),
      ),
      body: Container(
        margin: const EdgeInsets.all(5),
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
        ),
        child: ListView(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 10),
                  child: Text('Preço:'),
                ),
                Row(
                  children: [
                    Flexible(
                      child:
                          Text('R\$ ${widget.itemcalendario['value'] ?? ''}'),
                    ),
                  ],
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 10),
                  child: Text('Descrição:'),
                ),
                Row(
                  children: [
                    Flexible(
                      child:
                          Text('${widget.itemcalendario['description'] ?? ''}'),
                    ),
                  ],
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 10),
                  child: Text('Categoria:'),
                ),
                Row(
                  children: [
                    Flexible(
                      child: Text(
                          '${(widget.itemcalendario['sub_category'] != null ? widget.itemcalendario['sub_category']['name'] : null) ?? ''}'),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
