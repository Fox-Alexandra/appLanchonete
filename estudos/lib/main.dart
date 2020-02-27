import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:estudos/screens/cadastro.dart';
import 'package:estudos/screens/menu.dart';
import 'package:estudos/screens/lanchonete_view.dart';
import 'package:estudos/bloc/cadastro_bloc.dart';
import 'package:estudos/widgets/rounded_button.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      child: MaterialApp(
        title: 'Controle De Fluxo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: MyHomePage(title: 'Tela Inicial'),
      ),

      /// instanciando todos os blocs que serao utilizados no app
      blocs: [
        Bloc((i) => CadastroBloc()),
      ],
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  ///Criado uma global key para controle de estado do scaffold
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).requestFocus(new FocusNode()),
      child: Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          backgroundColor: Colors.lightGreen,
          title: Text(widget.title),
          leading: RoundedButton(
            onPressed: () => _scaffoldKey.currentState.openDrawer(),
            child: Icon(
              Icons.menu,
              color: Colors.white,
            ),
            mini: false,
          ),
        ),
        drawer: Menu(),
        body:
            LanchoneteView(), // This trailing comma makes auto-formatting nicer for build methods.
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => Cadastro(),
            ),
          ),
        ),
      ),
    );
  }
}
