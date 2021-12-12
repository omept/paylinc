import 'package:flutter/material.dart';
import 'package:paylinc/constants/app_constants.dart';

class ProjetImage extends StatelessWidget {
  const ProjetImage({required this.image, Key? key}) : super(key: key);

  final ImageProvider image;

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      backgroundImage: image,
      radius: 20,
      backgroundColor: kWhiteTextColor,
    );
  }
}
