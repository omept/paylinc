part of models;

class HeaderItem {
  final String title;
  final VoidCallback onTap;
  final bool isButton;

  HeaderItem({
    required this.title,
    required this.onTap,
    this.isButton = false,
  });
}
