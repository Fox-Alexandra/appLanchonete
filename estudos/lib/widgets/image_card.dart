import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:transparent_image/transparent_image.dart';

class ImageCard extends StatelessWidget {
  ImageCard({
    this.title,
    this.image,
    this.onTap,
    this.align = CardAlign.center,
  });

  final String title;
  final String image;
  final Function onTap;
  final CardAlign align;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          height: MediaQuery.of(context).size.width / 2.5,
          width: MediaQuery.of(context).size.width,
          child: Card(
            margin: EdgeInsets.zero,
            semanticContainer: false,
            clipBehavior: Clip.antiAlias,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            elevation: 0,
            child: image != null && image.isNotEmpty
                ? Image.asset(
                    image,
                    fit: BoxFit.cover,
                  )
                : Container(),
          ),
        ),
        GestureDetector(
          onTap: onTap,
          child: Container(
            height: MediaQuery.of(context).size.width / 2.5,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              gradient: RadialGradient(
                radius: 1,
                focalRadius: 1,
                colors: [
                  const Color.fromRGBO(0, 0, 0, 5),
                  const Color.fromRGBO(0, 0, 0, 0),
                ],
                stops: [0.1, 1],
              ),
            ),
            padding: EdgeInsets.all(7),
            child: Column(
              mainAxisAlignment: align.main,
              crossAxisAlignment: align.cross,
              children: <Widget>[
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 26,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class CardAlign {
  const CardAlign (this.main, this.cross);

  final MainAxisAlignment main;
  final CrossAxisAlignment cross;

  static const center = CardAlign(
    MainAxisAlignment.center,
    CrossAxisAlignment.center,
  );

  static const bottomLeft = CardAlign(
    MainAxisAlignment.end,
    CrossAxisAlignment.end,
  );
}
