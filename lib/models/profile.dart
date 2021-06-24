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
      this.type = map['type'];

  Map<String, dynamic> toMap() {
    return {
      'firstName': this.firstName,
      'lastName': this.lastName,
      'type': this.type
    };
  }

}

enum ProfileType {
  STANDARD,
  BUSINESS,
  RIDER
}

extension ProfileTypeExtension on ProfileType {
  String toBetterString() =>
    toString().substring(
       toString().indexOf('.') + 1
    ).capitalize();
}