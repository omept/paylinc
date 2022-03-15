part of shared_components;

class SearchField extends StatelessWidget {
  SearchField({this.onSearch, Key? key}) : super(key: key);

  final controller = TextEditingController();
  final Function(String value)? onSearch;

  @override
  Widget build(BuildContext context) {
    var themeContext = Theme.of(context);
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        filled: true,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide.none,
        ),
        prefixIcon: const Icon(EvaIcons.search),
        hintText: "search..",
        isDense: true,
        fillColor: themeContext.cardColor,
      ),
      onEditingComplete: () {
        FocusScope.of(context).unfocus();
        if (onSearch != null) onSearch!(controller.text);
      },
      textInputAction: TextInputAction.search,
      style: TextStyle(color: themeContext.textTheme.caption?.color),
    );
  }
}
