import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:paylinc/shared_components/models/profile.dart';

class ProfilTile extends StatelessWidget {
  const ProfilTile(
      {required this.data, required this.onPressedNotification, Key? key})
      : super(key: key);

  final Profile data;
  final Function() onPressedNotification;

  @override
  Widget build(BuildContext context) {
    var themeContext = Theme.of(context);
    return ListTile(
      contentPadding: const EdgeInsets.all(0),
      leading: CircleAvatar(backgroundImage: data.photo),
      title: Text(
        data.name,
        style: TextStyle(
            fontSize: 14, color: themeContext.colorScheme.onBackground),
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
      subtitle: Text(
        data.email,
        style: TextStyle(
            fontSize: 12, color: themeContext.textTheme.caption?.color),
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
      trailing: IconButton(
        onPressed: onPressedNotification,
        icon: const Icon(EvaIcons.bellOutline),
        tooltip: "notification",
      ),
    );
  }
}
