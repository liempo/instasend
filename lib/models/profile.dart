import '/utils/string_extension.dart';

class Profile {

  final String firstName;
  final String lastName;
  final ProfileType type;

  Profile({
    required this.firstName,
    required this.lastName,
    required this.type
  });

  Profile.fromMap(Map<String, dynamic> map)
    : this.firstName = map['firstName'],
      this.lastName = map['lastName'],
      this.type = ProfileTypeExtension
        .fromBetterString(map["type"]);

  Map<String, dynamic> toMap() {
    return {
      'firstName': this.firstName,
      'lastName': this.lastName,
      'type': this.type.toBetterString()
    };
  }

}

enum ProfileType {
  standard,
  business,
  rider
}

extension ProfileTypeExtension on ProfileType {

  String toBetterString() =>
    toString().substring(
       toString().indexOf('.') + 1
    ).capitalize();

  static ProfileType fromBetterString(String text) {
    for (var type in ProfileType.values)
      if (type.toBetterString() == text)
        return type;
    throw Exception("$text not found");
  }

}