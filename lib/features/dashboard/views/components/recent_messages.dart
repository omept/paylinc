part of dashboard;

class _RecentMessages extends StatelessWidget {
  const _RecentMessages({
    required this.onPressedMore,
    Key? key,
  }) : super(key: key);

  final Function() onPressedMore;

  @override
  Widget build(BuildContext context) {
    var primaryColor = Theme.of(context).primaryColor;
    return Row(
      children: [
        Icon(EvaIcons.messageCircle, color: primaryColor),
        const SizedBox(width: 10),
        Text(
          "Recent Messages",
          style: TextStyle(color: primaryColor),
        ),
        const Spacer(),
        IconButton(
          onPressed: onPressedMore,
          icon: const Icon(EvaIcons.moreVertical),
          tooltip: "more",
        )
      ],
    );
  }
}
