import 'package:scanner/core/models/freezed_models.dart';

abstract class IAuthRepository {
  // Todo: Add Auth request class signitures (interfaces) here.
  // Future<User> login(String email, String password);
}

abstract class IHomeRepository {
  Future<void> addScannedItem(ScannedItem item);
  Future<List<ScannedItem>> getScannedItems();
}
