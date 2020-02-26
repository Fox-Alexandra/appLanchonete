import 'package:estudos/bloc/cadastro_bloc.dart';
import 'package:estudos/models/produto.dart';
import 'package:estudos/screens/conteudo_produto.dart';
import 'package:flutter/material.dart';

class ProdutoView extends StatefulWidget {
  @override
  _ProdutoViewState createState() => _ProdutoViewState();
}

class _ProdutoViewState extends State<ProdutoView> {
  List<Widget> _buildList(Map<String, List<Produto>> produtoCadastrado) {
    List<Widget> lista = List<Widget>();

    produtoCadastrado.forEach((key, value) {
      lista.add(
        ListTile(
          title: Text(key),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ConteudoProduto(
                  listaProduto: value,
                  title: key,
                ),
              ),
            );
          },
        ),
      );
    });

    return lista;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: StreamBuilder(
        stream: CadastroBloc.getBloc.streamListaCadastrado,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView(
              children: _buildList(snapshot.data),
            );
          }
          return ListView();
        },
      ),
    );
  }
}
