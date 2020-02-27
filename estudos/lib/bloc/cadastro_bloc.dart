import 'dart:async';

import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:estudos/models/produto.dart';
import 'package:estudos/widgets/alert.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/subjects.dart';

class CadastroBloc extends BlocBase {
  BehaviorSubject<Map<String, List<Produto>>> listaCadastrado =
      BehaviorSubject.seeded(Map());

  /// instancia o bloc na classe bloc
  static CadastroBloc get getBloc => BlocProvider.getBloc<CadastroBloc>();

  Stream get streamListaCadastrado => listaCadastrado.stream;

  ///retorna o ultimo valor add a stream
  Map<String, List<Produto>> get cadastrado => listaCadastrado.stream.value;

  void saveCadastro(Produto produto, BuildContext context) async {
    Alert alerta = Alert(
      isLoading: true,
      sucess: null,
      message: 'Carregando...',
    );

    try {
      showDialog(
        context: context,
        builder: (context) {
          return alerta;
        },
      ).then((retornado) {});
      await Future.delayed(Duration(milliseconds: 500));
      alerta.isLoading = false;
      alerta.sucess = true;
      alerta.message = 'Cadastrado com sucesso!';
      alerta.controller.notifyListeners();

      /// Condicao para que se um produto ja existir ele cocatenar com o ja existente
      if (cadastrado.containsKey(produto.lanchonete)) {
        cadastrado.addAll({
          produto.lanchonete: cadastrado[produto.lanchonete]..add(produto),
        });
      } else {
        cadastrado.addAll({
          produto.lanchonete: [produto],
        });
      }
    } catch (e) {
      showDialog(
        context: context,
        builder: (context) {
          return alerta;
        },
      ).then((retornado) {});

      await Future.delayed(Duration(milliseconds: 500));
      alerta.isLoading = false;
      alerta.sucess = false;
      alerta.message = 'Falha ao cadastrar!';
      alerta.controller.notifyListeners();
    }
  }

  /// todo bloc precisa de um desse para encerrar a stream quando a tela for destruida
  @override
  void dispose() {
    super.dispose();
    listaCadastrado.close();
  }
}
