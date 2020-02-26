import 'dart:async';

import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:rxdart/subjects.dart';

class ControleLista extends BlocBase {
  BehaviorSubject<List<String>> lista = BehaviorSubject<List<String>>();

  ///pega um dado da lista
  Stream get streamLista => lista.stream;

  ///Insere um dado na lista
  StreamSink<List<String>> get sinkLista => lista.sink;

  void saveLista(String nome) {
    List<String> addLista = lista.stream.value;
    if (addLista == null) {
      addLista = [];
    }
    addLista.add(nome);
    sinkLista.add(addLista);
  }

  @override
  void dispose() {
    super.dispose();

    lista.close();
  }

}
