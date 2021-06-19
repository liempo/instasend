import 'profile_type.dart';

class Profile {

  final String name;
  final ProfileType type;

  Profile({
    required this.name,
    required this.type
  });

  Profile.fromMap(Map<String, dynamic> map)
    : this.name = map['name'],
      this.type = map['type'];

  Map<String, dynamic> toMap() {
    return {
      'name': this.name,
      'type': this.type
    };
  }

}