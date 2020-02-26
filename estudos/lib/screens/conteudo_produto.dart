import 'package:estudos/bloc/cadastro_bloc.dart';
import 'package:estudos/models/produto.dart';
import 'package:flutter/material.dart';

class ConteudoProduto extends StatefulWidget {
  final List<Produto> listaProduto;
  final String title;
  ConteudoProduto({this.listaProduto, this.title});

  @override
  _ConteudoProdutoState createState() => _ConteudoProdutoState();
}

class _ConteudoProdutoState extends State<ConteudoProduto> {
  List<Widget> _buildList() {
    return widget.listaProduto.map((value) {
      return Container(
        height: 120,
        padding: EdgeInsets.only(top: 35),
        color: Colors.yellow,
        child: ListTile(
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text(
              value.mercadoria,
              style: TextStyle(fontSize: 20),
            ),
            Padding(
              padding: EdgeInsets.only(left: 40),
            ),
            Text(
              '${value.qnt}',
              style: TextStyle(fontSize: 20),
            ),
          ],
        )),
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightGreen,
        title: Text(widget.title),
      ),
      body: Container(
        child: ListView(
          children: _buildList(),
        ),
      ),
    );
  }
}
