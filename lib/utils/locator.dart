import 'package:get_it/get_it.dart';

import '/repositories/auth_repository.dart';
import '/repositories/profile_repository.dart';
import '/repositories/shop_repository.dart';
import '/services/nav_service.dart';
import '/services/location_service.dart';

// Objects here share the same instance
// but I prefer to declare it as a different
// locator so it will be easier to read
final repos = GetIt.I;
final services = GetIt.I;

// Call on main.dart before buiding UI
void setupRepositoryLocator() {
  repos.registerLazySingleton(
    () => AuthRepository());
  repos.registerLazySingleton(
    () => ProfileRepository());
  repos.registerLazySingleton(
    () => ShopRepository());
}

// Call on main.dart before building UI
void setupServiceLocator() {
  services.registerLazySingleton(
    () => NavigationService());
  services.registerLazySingleton(
    () => LocationService());
}