import 'package:estudos/models/produto.dart';
import 'package:estudos/screens/cadastro.dart';
import 'package:flutter/material.dart';
import 'package:estudos/bloc/cadastro_bloc.dart';

class ConteudoProduto extends StatefulWidget {
  final List<Produto> listaProduto;
  final String title;
  ConteudoProduto({this.listaProduto, this.title});

  @override
  _ConteudoProdutoState createState() => _ConteudoProdutoState();
}

class _ConteudoProdutoState extends State<ConteudoProduto> {
  List<Widget> _buildList() {
    /// Retorna um valor map(lista) da lista produto
    return widget.listaProduto.map((value) {
      return Container(
        height: 120,
        padding: EdgeInsets.only(top: 35),
        child: InputDecorator(
          decoration: InputDecoration(
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                  color: Theme.of(context).colorScheme.surface, width: 1),
            ),
          ),
          child: ListTile(
            /// Ao clicar nesse item da lista poder ir para tela de cadastro e alterar seu valor
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Cadastro(
                    produto: value,
                  ),
                ),
              );
            },
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
            ),
          ),
        ),
      );
    }).toList();

    /// Transforma o map em uma lista
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
