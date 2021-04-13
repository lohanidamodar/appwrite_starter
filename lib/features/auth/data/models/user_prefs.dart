import 'dart:convert';

class UserPrefs {
  final int buildNumber;
  final bool introSeen;
  final DateTime lastLoggedIn;
  final String deviceId;
  UserPrefs({
    this.buildNumber,
    this.introSeen,
    this.lastLoggedIn,
    this.deviceId,
  });

  UserPrefs copyWith({
    int buildNumber,
    bool introSeen,
    DateTime lastLoggedIn,
    String deviceId,
  }) {
    return UserPrefs(
      buildNumber: buildNumber ?? this.buildNumber,
      introSeen: introSeen ?? this.introSeen,
      lastLoggedIn: lastLoggedIn ?? this.lastLoggedIn,
      deviceId: deviceId ?? this.deviceId,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'buildNumber': buildNumber,
      'introSeen': introSeen,
      'lastLoggedIn': lastLoggedIn.millisecondsSinceEpoch,
      'deviceId': deviceId,
    };
  }

  factory UserPrefs.fromMap(Map<String, dynamic> map) {
    return UserPrefs(
      buildNumber: map['buildNumber'],
      introSeen: map['introSeen'],
      lastLoggedIn: DateTime.fromMillisecondsSinceEpoch(map['lastLoggedIn']),
      deviceId: map['deviceId'],
    );
  }

  String toJson() => json.encode(toMap());

  factory UserPrefs.fromJson(String source) => UserPrefs.fromMap(json.decode(source));

  @override
  String toString() {
    return 'UserPrefs(buildNumber: $buildNumber, introSeen: $introSeen, lastLoggedIn: $lastLoggedIn, deviceId: $deviceId)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is UserPrefs &&
      other.buildNumber == buildNumber &&
      other.introSeen == introSeen &&
      other.lastLoggedIn == lastLoggedIn &&
      other.deviceId == deviceId;
  }

  @override
  int get hashCode {
    return buildNumber.hashCode ^
      introSeen.hashCode ^
      lastLoggedIn.hashCode ^
      deviceId.hashCode;
  }
}
