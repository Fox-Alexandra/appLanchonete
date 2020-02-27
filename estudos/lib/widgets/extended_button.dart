import 'package:flutter/material.dart';

class ExtendedButton extends StatelessWidget {
  ///Constructor 
  ExtendedButton(
      {this.padding = const EdgeInsets.all(0),
      this.onPressed,
      this.child,
      this.isLoading,
      this.disabled = false});

  ///[Bool] usado para controlar o loadding interno do botão
  final bool isLoading;

  /// [EdgeInsets] com o padding do botão
  final EdgeInsets padding;

  /// [CallBack] chamado ao pressionar o botão
  final Function onPressed;

  /// [Widget] mostrado dentro do botão
  final Widget child;

  ///[Bool] para desabilitar o botão
  final bool disabled;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: MaterialButton(
        onPressed: isLoading || disabled ? () {} : onPressed,
        elevation: 0,
        height: 44,
        color: Theme.of(context).accentColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(22),
        ),
        child: Container(
          width: MediaQuery.of(context).size.width,
          child: Center(child: _buildChild(context)),
        ),
      ),
    );
  }

  Widget _buildChild(BuildContext context) {
    if (isLoading) {
      return Container(
        padding: EdgeInsets.all(8),
        height: 41,
        width: 41,
        child: CircularProgressIndicator(
          backgroundColor: Colors.white,
        ),
      );
    } else {
      return child;
    }
  }
}
