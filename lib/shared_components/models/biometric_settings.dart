part of models;

class BiometricSettings {
  bool isBiometricAvailable;
  bool isBiometricEnabled;
  bool isApplockEnabled;

  BiometricSettings(
      {required this.isBiometricEnabled,
      required this.isApplockEnabled,
      required this.isBiometricAvailable});

  factory BiometricSettings.fromJson(Map<String, dynamic> json) =>
      BiometricSettings(
          isBiometricAvailable: json["isBiometricAvailable"],
          isBiometricEnabled: json["isBiometricEnabled"],
          isApplockEnabled: json["isApplockEnabled"]);

  Map<String, dynamic> toJson() => {
        "isBiometricAvailable": isBiometricAvailable,
        "isBiometricEnabled": isBiometricEnabled,
        "isApplockEnabled": isApplockEnabled,
      };
}
