part of shared_components;

class Header extends StatelessWidget {
  final TodayText todayText;
  final bool showSearch;
  const Header({Key? key, required this.todayText, this.showSearch = false})
      : super(key: key);
  // final todayText = const TodayText();
  // final expanded = Expanded(child: SearchField());

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        todayText,
        SizedBox(width: kSpacing),
        showSearch ? Expanded(child: SearchField()) : Container(),
      ],
    );
  }
}
