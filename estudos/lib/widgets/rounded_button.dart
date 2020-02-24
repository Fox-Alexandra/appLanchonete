import 'package:flutter/material.dart';

/// Widget de botão redondo
///
/// [author: Anderson Pereira Brzezinski]
class RoundedButton extends StatelessWidget {
  RoundedButton({
    this.onPressed,
    this.backgroundColor,
    this.border,
    this.child,
    this.mini = true,
  });

  /// Callback chamado ao pressionar o botão
  final Function onPressed;

  /// Cor de fundo do botão
  final Color backgroundColor;

  /// Borda do botão
  final Border border;

  /// [Widget] mostrado dentro do botão
  final Widget child;

  /// Indica se é um mini botão
  final bool mini;

  @override
  Widget build(BuildContext context) {
    double size = mini ? 44 : 56;

    return InkWell(
      onTap: onPressed,
      borderRadius: BorderRadius.circular(size / 2),
      child: Container(
        height: size,
        width: size,
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(size / 2),
          border: border,
        ),
        child: child,
      ),
    );
  }
}
