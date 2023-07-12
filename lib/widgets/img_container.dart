import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class ImageContainer extends StatelessWidget {
  final String url;

  const ImageContainer({Key? key, required this.url}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    url.contains('.svg');
    return url.contains('.svg')
        ? SvgPicture.network(
            url,
            placeholderBuilder: (context) => Container(
              child: CircularProgressIndicator.adaptive(),
            ),
            width: 50,
            height: 50,
          )
        : Image.network(
            url,
            width: 50,
            height: 50,
          );
  }
}
