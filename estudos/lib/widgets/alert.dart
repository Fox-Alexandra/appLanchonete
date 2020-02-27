import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter/animation.dart';
import 'package:sweetalert/src/cancel.dart';
import 'package:sweetalert/src/success.dart';

class Alert extends StatefulWidget {
  String message;
  bool sucess;
  bool isLoading;
  List<Widget> actions;
  AnimationController closeController;
  AnimationController controller;
  Animation<double> animation;

  Alert({this.message, this.sucess, this.isLoading, this.actions});
  @override
  createState() => Alerta();
}

class Alerta extends State<Alert> with TickerProviderStateMixin {
  ///Inicializacao do estado
  @override
  initState() {
    super.initState();

    widget.controller = AnimationController(
        duration: const Duration(milliseconds: 500), vsync: this);
    widget.closeController = AnimationController(
        duration: const Duration(milliseconds: 00), vsync: this);
    widget.animation =
        CurvedAnimation(parent: widget.controller, curve: Curves.easeIn);
    widget.controller.addListener(() {
      widget.controller.forward();
      setState(() {});
    });

    widget.closeController.addListener(() {
      Navigator.pop(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget icon = widget.sucess == null
        ? Container()
        : widget.sucess
            ? Container(
                padding: EdgeInsets.only(top: 35, right: 55),
                height: 120,
                child: new SuccessView(),
              )
            : Container(
                padding: EdgeInsets.only(top: 35, right: 55),
                height: 120,
                child: new CancelView());

    Widget body = Container(
      height: 165,
      width: 18,
      child: Stack(
        children: <Widget>[
          AnimatedOpacity(
            opacity: widget.isLoading ? 1.0 : 0.0,
            duration: Duration(milliseconds: 500),
            child: Container(
              padding: EdgeInsets.only(top: 53),
              child: Column(
                children: [
                  SpinKitFadingCircle(
                    color: Colors.grey,
                    size: 60.0,
                  ),
                  Padding(padding: EdgeInsets.only(top: 15)),
                  Expanded(
                    child: Text(
                      widget.message,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          FadeTransition(
            opacity: widget.animation,
            child: Container(
              child: Column(
                children: [
                  icon,
                  Expanded(
                    child: Text(
                      widget.message,
                      style: TextStyle(fontSize: 20),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );

    if (widget.isLoading) {
      return AlertDialog(
        content: body,
        actions: widget.actions ?? <Widget>[],
      );
    } else {
      return AlertDialog(
        contentPadding: EdgeInsets.only(top: 0, bottom: 0, right: 45, left: 45),
        backgroundColor: Colors.white,
        content: body,
        actions: widget.actions ??
            <Widget>[
              MaterialButton(
                color: Theme.of(context).colorScheme.primary,
                hoverElevation: 10,
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('Ok'),
              ),
            ],
      );
    }
  }
}
