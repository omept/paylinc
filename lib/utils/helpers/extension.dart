part of app_helpers;

extension TaskTypeExtension on TaskType {
  Color getColor() {
    switch (this) {
      case TaskType.bank:
        return Colors.lightBlue;
      case TaskType.card:
        return Colors.amber[700]!;
      default:
        return Colors.lightBlue;
    }
  }

  String toStringValue() {
    switch (this) {
      case TaskType.card:
        return "Card";
      case TaskType.bank:
        return "Bank";
      default:
        return "";
    }
  }
}
