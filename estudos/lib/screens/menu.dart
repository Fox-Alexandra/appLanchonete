import 'package:estudos/main.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'cadastro.dart';

class Menu extends StatefulWidget {
  @override
  _MenuState createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 558,
      width: 282,
      decoration: BoxDecoration(
        color: Colors.lightGreen,
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(12),
          bottomRight: Radius.circular(12),
        ),
      ),
      child: Column(
        children: <Widget>[
          Container(
            alignment: Alignment.centerRight,
            child: GestureDetector(
              onTap: () => Navigator.of(context).pop(),
              child: Container(
                height: 46,
                width: 46,
                alignment: Alignment.center,
                child: Icon(Icons.close),
              ),
            ),
          ),
          ListTile(
            contentPadding: EdgeInsets.only(left: 25),
            onTap: () {
              Navigator.of(context).pop();
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => MyApp(),
                ),
              );
            },
            leading: Icon(
              FontAwesomeIcons.home,
              color: Colors.white,
            ),
            title: Text(
              'Tela Inicial',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
              ),
            ),
          ),
          ListTile(
            contentPadding: EdgeInsets.only(left: 25),
            onTap: () {
              Navigator.of(context).pop();
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Cadastro(),
                ),
              );
            },
            leading: Icon(
              FontAwesomeIcons.edit,
              color: Colors.white,
            ),
            title: Text(
              'Cadastro',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
