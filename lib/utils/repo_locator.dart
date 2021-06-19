import 'package:get_it/get_it.dart';

import '/repositories/auth_repository.dart';
import '/repositories/profile_repository.dart';

// Initalize all repositories here
// (Only repositories are allowed)
final repos = GetIt.instance;

// Call on main.dart before buiding UI
void setupRepositoryLocator() {
  repos.registerLazySingleton(
    () => AuthRepository());
  repos.registerLazySingleton(
    () => ProfileRepository());
}