part of dashboard;

class _TeamMember extends StatelessWidget {
  const _TeamMember({
    required this.totalMember,
    required this.onPressedAdd,
    Key? key,
  }) : super(key: key);

  final int totalMember;
  final Function() onPressedAdd;

  @override
  Widget build(BuildContext context) {
    var themeContext = Theme.of(context);
    return Row(
      children: [
        RichText(
          text: TextSpan(
            style: TextStyle(
                fontWeight: FontWeight.bold,
                color: themeContext.colorScheme.onBackground),
            children: [
              const TextSpan(text: "Team Member "),
              TextSpan(
                text: "($totalMember)",
                style: TextStyle(
                  fontWeight: FontWeight.w400,
                  color: themeContext.textTheme.caption?.color,
                ),
              ),
            ],
          ),
        ),
        const Spacer(),
        IconButton(
          onPressed: onPressedAdd,
          icon: const Icon(EvaIcons.plus),
          tooltip: "add member",
        )
      ],
    );
  }
}
