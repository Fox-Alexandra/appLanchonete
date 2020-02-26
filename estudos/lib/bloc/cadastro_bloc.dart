import 'dart:async';

import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:estudos/models/produto.dart';
import 'package:rxdart/subjects.dart';

class CadastroBloc extends BlocBase {
  BehaviorSubject<Map<String, List<Produto>>> listaCadastrado =
      BehaviorSubject.seeded(Map());

  static CadastroBloc get getBloc => BlocProvider.getBloc<CadastroBloc>();

  Stream get streamListaCadastrado => listaCadastrado.stream;
  Map<String, List<Produto>> get cadastrado => listaCadastrado.stream.value;

  void saveCadastro(Produto produto) {
    if (cadastrado.containsKey(produto.lanchonete)) {
      cadastrado.addAll({
        produto.lanchonete: cadastrado[produto.lanchonete]..add(produto),
      });
    } else {
      cadastrado.addAll({
        produto.lanchonete: [produto],
      });
    }
  }

  @override
  void dispose() {
    super.dispose();
    listaCadastrado.close();
  }
}
