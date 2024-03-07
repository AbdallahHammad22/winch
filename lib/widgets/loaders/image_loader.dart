import 'package:flutter/material.dart';

class ImageLoader extends StatelessWidget {
  final String url;
  final BorderRadius borderRadius;
  final BoxFit boxFit;
  final Color color;
  const ImageLoader({
    Key key,
    @required this.url,
    this.boxFit = BoxFit.cover,
    this.borderRadius,
    this.color
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: borderRadius ?? BorderRadius.zero,
      child: FadeInImage(
        image: NetworkImage(url),
        fit: boxFit ?? BoxFit.contain,
        placeholder: AssetImage("assets/images/app_logo.jpg"),
        imageErrorBuilder: (context, error,stackTrace){
          return  Center(
            child: Icon(
              Icons.broken_image,
              size: 28,
            ),
          );
        },
      ),
    );
  }
}
