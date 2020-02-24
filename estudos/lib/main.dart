import 'package:estudos/bloc/produtos_bloc.dart';
import 'package:estudos/screens/menu.dart';
import 'package:estudos/widgets/rounded_button.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

ControleLista blocLista = ControleLista();

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Controle De Fluxo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Home'),
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
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  List<Widget> _buildList(List<String> entrada) {
    List<Widget> aux = List<Widget>();
    entrada.forEach((item) {
      aux.add(ListTile(title: Text(item)));
    });
    return aux;
  }

  void _incrementCounter() {
    setState(() {
      blocLista.saveLista('nome');
    });
  }

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
        body: StreamBuilder(
          stream: blocLista.streamLista,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView(
                children: _buildList(snapshot.data),
              );
            }
            return ListView();
          },
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: _incrementCounter,
          tooltip: 'Increment',
          child: Icon(Icons.add),
        ), // This trailing comma makes auto-formatting nicer for build methods.
      ),
    );
  }
}
