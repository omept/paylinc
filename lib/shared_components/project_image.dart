part of shared_components;

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
