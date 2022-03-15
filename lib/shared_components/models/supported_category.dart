part of models;

class SupportedCategory {
  final String title;
  final String value;
  SupportedCategory({
    required this.title,
    required this.value,
  });

  SupportedCategory copyWith({
    String? title,
    String? value,
  }) {
    return SupportedCategory(
      title: title ?? this.title,
      value: value ?? this.value,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'value': value,
    };
  }

  factory SupportedCategory.fromMap(Map<String, dynamic> map) {
    return SupportedCategory(
      title: map['title'].toString(),
      value: map['value'].toString(),
    );
  }

  String toJson() => json.encode(toMap());

  factory SupportedCategory.fromJson(String source) =>
      SupportedCategory.fromMap(json.decode(source));

  @override
  String toString() => 'SupportedCategory(title: $title, value: $value)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is SupportedCategory &&
        other.title == title &&
        other.value == value;
  }

  @override
  int get hashCode => title.hashCode ^ value.hashCode;
}
